--[[

v1.02 esp lib
@nulare on discord

ESPLib.new<GroupBehaviour> -> ESPGroup

ESPGroup:SetGroupContainer(<Folder | Model>)
ESPGroup:Add(entity) -> entity
ESPGroup:Unadd(entity)
ESPGroup:Toggle(boolean | nil)
ESPGroup:Step()
ESPGroup:Destroy()

<Color3> Accent
<function> GroupBehaviour.ValidateEntry(entry)
<function> GroupBehaviour.FetchEntryName(entry)
<function> GroupBehaviour.TraverseEntry(entry)
<function> GroupBehaviour.MeasureEntry(entry)
<function> GroupBehaviour.IsLocalEntry(entry)
{Flag} GroupBehaviour.Flags

<function> Flag -> boolean | string

Games Unite Testing Place
local espGroup = ESPLib.new{
    TraverseEntry = function(entry)
        return entry:FindFirstChild('Accessories')
    end,

    FetchEntryName = function(_entry)
        return 'Enemy'
    end,
}

espGroup:SetGroupContainer(workspace.Playermodels)

pcall(function()
    while true do
        espGroup:Step()

        wait(1/240)
    end
end)

espGroup:Destroy()

Zombie Attack
local zombies = ESPLib.new{Accent = RED}
zombies:SetGroupContainer(workspace.enemies)

pcall(function()
    while true do
        zombies:Step()

        wait(1/240)
    end
end)

zombies:Destroy()

]]

ESPLib = {}
ESPLib.__index = ESPLib

RED = Color3.new(1, 0, 0)
GREEN = Color3.new(0, 1, 0)
BLUE = Color3.new(0, 0, 1)
YELLOW = Color3.new(1, 1, 0)
CYAN = Color3.new(0, 1, 1)
PINK = Color3.new(1, 0, 1)
WHITE = Color3.new(1, 1, 1)
BLACK = Color3.new(0, 0, 0)

ESP_FONTSIZE = 7 -- works great with ProggyClean
DEFAULT_PARTS_SIZING = {
    Head = Vector3.new(2, 1, 1),

    Torso = Vector3.new(2, 2, 1),
    ['Left Arm'] = Vector3.new(1, 2, 1),
    ['Right Arm'] = Vector3.new(1, 2, 1),
    ['Left Leg'] = Vector3.new(1, 2, 1),
    ['Right Leg'] = Vector3.new(1, 2, 1),

    UpperTorso = Vector3.new(2, 1, 1),
    LowerTorso = Vector3.new(2, 1, 1),
    LeftUpperArm = Vector3.new(1, 1, 1),
    LeftLowerArm = Vector3.new(1, 1, 1),
    LeftHand = Vector3.new(0.3, 0.3, 1),
    RightUpperArm = Vector3.new(1, 1, 1),
    RightLowerArm = Vector3.new(1, 1, 1),
    RightHand = Vector3.new(0.3, 0.3, 1),
    LeftUpperLeg = Vector3.new(1, 1, 1),
    LeftLowerLeg = Vector3.new(1, 1, 1),
    LeftFoot = Vector3.new(0.3, 0.3, 1),
    RightUpperLeg = Vector3.new(1, 1, 1),
    RightLowerLeg = Vector3.new(1, 1, 1),
    RightFoot = Vector3.new(0.3, 0.3, 1),
}

local myCamera = workspace.CurrentCamera

local function vec3Magnitude(vec1, vec2)
    local dx = vec2.x - vec1.x
    local dy = vec2.y - vec1.y
    local dz = vec2.z - vec1.z

    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

local function destroyAllDrawings(drawingsTable)
    for _, drawing in pairs(drawingsTable) do
        drawing:Remove()
    end
end

local function undrawAll(drawingsTable)
    for _, drawing in pairs(drawingsTable) do
        drawing.Visible = false
    end
end

function ESPLib.new(groupBehaviour)
    local self = setmetatable({}, ESPLib)

    self._objects = {}
    self._objectContainer = nil
    self._objectContainerLength = -1
    self._containerLastUpdate = 0
    self._running = true
    
    self._gb_accent = groupBehaviour.Accent or WHITE
    self._gb_validateEntry = groupBehaviour.ValidateEntry or nil
    self._gb_fetchEntryName = groupBehaviour.FetchEntryName or nil
    self._gb_traverseEntry = groupBehaviour.TraverseEntry or nil
    self._gb_measureEntry = groupBehaviour.MeasureEntry or nil
    self._gb_isEntryLocal = groupBehaviour.IsEntryLocal or nil
    self._gb_flags = groupBehaviour.Flags or nil

    return self
end

function ESPLib._IsBasePart(part)
    return part.ClassName:lower():find('part') ~= nil
end

function ESPLib:_GetTextBounds(str)
    return #str * ESP_FONTSIZE, ESP_FONTSIZE
end

function ESPLib:_DistanceFromLocal(root)
    if not self._IsBasePart(root) then
        root = root:FindFirstChildOfClass('Part') or root:FindFirstChildOfClass('MeshPart')
    end

    if root == nil then
        return 0
    end

    return vec3Magnitude(myCamera.Position, root.Position)
end

function ESPLib:_BoundingBox(instance)
    local minX, minY = 9999, 9999
    local maxX, maxY = 0, 0

    local children = self._IsBasePart(instance) and {instance} or instance:GetChildren()
    local allVisible = true
    for _, child in pairs(children) do
        local childName = child.Name

        if self._IsBasePart(child) then
            local childOrigin = child.Position
            local childSize = DEFAULT_PARTS_SIZING[childName] ~= nil and DEFAULT_PARTS_SIZING[childName] or (self._gb_measureEntry and self._gb_measureEntry(instance) or Vector3(1, 1, 1))

            local primaryScreenPos, primaryOnScreen = WorldToScreen(Vector3(childOrigin.x + childSize.x / 2, childOrigin.y + childSize.y / 2, childOrigin.z + childSize.z / 2))
            if not primaryOnScreen then
                allVisible = false
            else
                local secondaryScreenPos, secondaryOnScreen = WorldToScreen(Vector3(childOrigin.x - childSize.x / 2, childOrigin.y - childSize.y / 2, childOrigin.z - childSize.z / 2))
                if not secondaryOnScreen then
                    allVisible = false
                else
                    minX = math.min(minX, primaryScreenPos.x, secondaryScreenPos.x)
                    minY = math.min(minY, primaryScreenPos.y, secondaryScreenPos.y)

                    maxX = math.max(maxX, primaryScreenPos.x, secondaryScreenPos.x)
                    maxY = math.max(maxY, primaryScreenPos.y, secondaryScreenPos.y)
                end
            end
        elseif child.ClassName == 'Model' or child.ClassName == 'Folder' then
            local _, childMinX, childMinY, childWidth, childHeight = self:_BoundingBox(child)

            minX = math.min(minX, childMinX)
            minY = math.min(minY, childMinY)

            maxX = math.max(maxX, childMinX + childWidth)
            maxY = math.max(maxY, childMinY + childHeight)
        end
    end

    return allVisible, minX, minY, maxX - minX, maxY - minY
end

function ESPLib:Toggle(state)
    self._running = type(state) == 'boolean' and state or not self._running
end

function ESPLib:SetGroupContainer(container)
    self._objectContainer = container
end

function ESPLib:Add(entry)
    -- meta objects
    local espBbox = Drawing.new('Square')
    espBbox.Thickness = 1
    espBbox.Filled = false
    local espBboxOutlineInner = Drawing.new('Square')
    espBboxOutlineInner.Thickness = 1
    espBboxOutlineInner.Filled = false
    local espBboxOutlineOuter = Drawing.new('Square')
    espBboxOutlineOuter.Thickness = 1
    espBboxOutlineOuter.Filled = false

    local espSnapline = Drawing.new('Line')
    espSnapline.Thickness = 1

    local espName = Drawing.new('Text')
    espName.Outline = true
    local espDistance = Drawing.new('Text')
    espDistance.Outline = true

    local espFlags = {}
    if self._gb_flags then
        for _, _ in pairs(self._gb_flags) do
            local flagText = Drawing.new('Text')
            flagText.Outline = true
            flagText.Color = Color3(1, 1, 1)

            table.insert(espFlags, flagText)
        end
    end

    self._objects[entry] = {
        ['class'] = entry.ClassName,
        ['_drawings'] = { espBbox, espBboxOutlineInner, espBboxOutlineOuter, espName, espDistance, espSnapline, unpack(espFlags) }
    }

    return entry
end

function ESPLib:Unadd(entry)
    if self._objects[entry] then
        destroyAllDrawings(self._objects[entry]['_drawings'])

        self._objects[entry] = nil
    end
end

function ESPLib:Step()
    -- refresh container
    local now = os.clock()
    if self._objectContainer and now - self._containerLastUpdate > 1 then
        local children = self._objectContainer:GetChildren()
        if #children ~= self._objectContainerLength then
            for child, _ in pairs(self._objects) do
                self:Unadd(child)
            end
    
            self._objectContainerLength = #children
            for _, child in pairs(children) do
                self:Add(child)
            end
        end
    
        self._containerLastUpdate = now
    end

    -- draw all entries
    for root, entryData in pairs(self._objects) do
        local drawings = entryData['_drawings']

        -- does the entry exist?
        local shouldDraw = self._running
        if root == nil then
            self:Unadd(root)

            shouldDraw = false
        end

        -- is our entry a local player?
        if shouldDraw and self._gb_isEntryLocal then
            shouldDraw = not self._gb_isEntryLocal(root)
        end

        -- is it even valid?
        if shouldDraw and self._gb_validateEntry then
            shouldDraw = self._gb_validateEntry(root)
        end

        -- point to our entry model
        local entryModel = self._gb_traverseEntry and self._gb_traverseEntry(root) or root

        -- draw graphics
        local onScreen, bboxLeft, bboxTop, bboxWidth, bboxHeight = false, 0, 0, 0, 0
        if shouldDraw and entryModel then
            onScreen, bboxLeft, bboxTop, bboxWidth, bboxHeight = self:_BoundingBox(entryModel)
        end

        if onScreen and shouldDraw then
            local rootName = tostring(root.Name)
            if self._gb_fetchEntryName then
                rootName = self._gb_fetchEntryName(root)
            end

            -- draw bbox
            local espBbox = drawings[1]
            local espBboxOutlineInner = drawings[2]
            local espBboxOutlineOuter = drawings[3]

            espBboxOutlineInner.Position = Vector2(bboxLeft + 1, bboxTop + 1)
            espBboxOutlineInner.Size = Vector2(bboxWidth - 2, bboxHeight - 2)
            espBboxOutlineInner.Color = BLACK
            espBboxOutlineInner.Visible = true

            espBboxOutlineOuter.Position = Vector2(bboxLeft - 1, bboxTop - 1)
            espBboxOutlineOuter.Size = Vector2(bboxWidth + 2, bboxHeight + 2)
            espBboxOutlineOuter.Color = BLACK
            espBboxOutlineOuter.Visible = true

            espBbox.Position = Vector2(bboxLeft, bboxTop)
            espBbox.Size = Vector2(bboxWidth, bboxHeight)
            espBbox.Color = self._gb_accent
            espBbox.Visible = true

            -- draw name
            local espName = drawings[4]
            local nameSizeX, nameSizeY = self:_GetTextBounds(rootName)

            espName.Position = Vector2(bboxLeft - nameSizeX / 2 + bboxWidth / 2, bboxTop - nameSizeY - 6)
            espName.Color = WHITE
            espName.Text = rootName
            espName.Visible = true

            -- draw distance
            local espDistance = drawings[5]
            local distance = math.floor(self:_DistanceFromLocal(entryModel))
            local distanceString = '[' .. tostring(distance) .. 'm]'
            local distanceSizeX, distanceSizeY = self:_GetTextBounds(distanceString) 

            espDistance.Position = Vector2(bboxLeft - distanceSizeX / 2 + bboxWidth / 2, bboxTop + bboxHeight + 2)
            espDistance.Color = WHITE
            espDistance.Text = distanceString
            espDistance.Visible = true

            -- draw snapline
            local espSnapline = drawings[6]
            espSnapline.From = Vector2(0, 0)
            espSnapline.To = Vector2(bboxLeft + bboxWidth / 2, bboxTop)
            espSnapline.Color = self._gb_accent
            espSnapline.Visible = true

            -- draw user flags
            if self._gb_flags then
                local flagEntryY = 0
                local _, flagHeight = self:_GetTextBounds('')

                local i = 0
                for flagName, flagFunc in pairs(self._gb_flags) do
                    i = i + 1

                    local espFlag = drawings[6 + i]
                    local flagValue = flagFunc(root)
                    if flagValue == true then
                        flagValue = '*' .. flagName .. '*'
                    elseif flagValue == false or flagValue == '' then
                        flagValue = nil
                    elseif flagValue ~= nil then
                        flagValue = tostring(flagValue)
                    end

                    if flagValue then
                        espFlag.Position = Vector2(bboxLeft + bboxWidth + 2, bboxTop + flagEntryY)
                        espFlag.Text = flagValue
                        espFlag.Visible = true

                        flagEntryY = flagEntryY + flagHeight + 4
                    else
                        espFlag.Visible = false
                    end
                end
            end
        elseif root ~= nil then
            undrawAll(drawings)
        end
    end
end

function ESPLib:Destroy()
    self:Toggle(false)
    for entry, _ in pairs(self._objects) do
        self:Unadd(entry)
    end
end
