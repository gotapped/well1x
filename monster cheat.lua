if not LPH_OBFUSCATED then
	LPH_JIT = function(Function) return Function end
	LPH_JIT_MAX = function(Function) return Function end
	LPH_NO_VIRTUALIZE = function(Function) return Function end
      LPH_NO_UPVALUES = function(Function) return function(...) return Function(...) end end
	LPH_ENCSTR = function(String) return String end
	LPH_ENCNUM = function(Number) return Number end
	LPH_CRASH = function() return rconsoleprint("DEBUG: CLIENT CALLED CRASH") end
	--
	LRM_IsUserPremium = true
	LRM_LinkedDiscordID = "Developer"
	LRM_ScriptName = "ScriptName"
	LRM_TotalExecutions = 0
	LRM_SecondsLeft = 999999
	LRM_UserNote = "UserNote"

	if not getgenv then
		getgenv = function() return _G end
	end

	if not cloneref then
		cloneref = function(Reference) return Reference end
	end

	if not loadfile then
		loadfile = function(...) return ... end
	end

	if not readfile then
		readfile = function(...) return ... end
	end

	if not request then
		request = function(...) return ... end
	end

	if not clonefunction then
		clonefunction = function(f) return f end
	end

	if not newcclosure then
		newcclosure = function(...) return ... end
	end

	if not hookfunction then
		hookfunction = function() end
	end

	if not getrenv then
		getrenv = function() return {} end
	end
end 

local Start       = tick();
local Executor    = identifyexecutor()

writefile("LogFile.txt", "Iridescent loading started...\n")

local function Log(txt)
	appendfile("LogFile.txt", txt.. " | "..tostring(tick() - Start));
	appendfile("LogFile.txt", "\n");
end;

--// FALLEN anticheat Bypass!!!
LPH_JIT_MAX(function()
	if game.PlaceId ~= 17574618959 then --// I need this region to be completely cut off from everythning else soooo
		local Players = cloneref(game:GetService("Players"))
		local Client = Players.LocalPlayer; 

		local Character = Client.Character; 
		local Humanoid = Character and Character:WaitForChild("Humanoid");

		if not Humanoid then 
			Client:Kick("Please load the script when you are spawned in.") 
			return 
		end;

		local DeepSearchTable;
		DeepSearchTable = LPH_NO_VIRTUALIZE(function(Table, TargetValue, MaxDepth, CurrentPath, Visited, Results)
			if MaxDepth <= 0 or type(Table) ~= "table" then 
				return; 
			end;
			Visited = Visited or {};
			Results = Results or {};
			CurrentPath = CurrentPath or "";

			if Visited[Table] then 
				return;
			end;
			Visited[Table] = true;

			for Key, Value in pairs(Table) do
				local Path = CurrentPath .. "[" .. tostring(Key) .. "]"

				if Value == TargetValue then
					table.insert(Results, {
						Path = Path,
						Parent = Table,
						Key = Key,
						Value = Value
					});
				elseif type(Value) == "table" then
					DeepSearchTable(Value, TargetValue, MaxDepth - 1, Path, Visited, Results)
				end;
			end;
			return Results
		end);

		local BypassCheck1 = false
		local BypassCheck2 = false 

		Log("Loading Bypass #1...")
		for Index, Table in getgc(true) do 
			if type(Table) ~= "table" then
				continue
			end; 
			if typeof(rawget(Table, 1)) == "Instance" and rawget(Table, 1).Name == "Remotes" then 
				local BanTable = rawget(Table, 4);

				setmetatable(BanTable, { 
					__index = function() end,
					__newindex = function(...) 
                                    --[[local ArgumentString = "Ban Table #1 Changed";
                                    local Args = {...};

                                    for Index, Value in Args[3] do 
                                          ArgumentString = ArgumentString .. tostring(Index) .. " = "..tostring(Value).."\n"
                                    end; 
                                    
                                    Log(ArgumentString)]]
					end
				});
				BypassCheck1 = true
			end;
		end;

		if not BypassCheck1 then 
			Client:Kick("Failed to load. 0x01");
			return
		end;
		Log("Bypass #1 Loaded.")
		Log("Loading Bypass #2...")

		for Index, Table in getgc(true) do 
			if type(Table) ~= "table" then 
				continue 
			end; 
			if rawget(Table, 1) == Character and rawget(Table, 2) == Humanoid and #Table == 9 then 
				local BanTable_1 = rawget(Table, 8);
				local BanTable_2 = rawget(Table, 5);

				setmetatable(BanTable_1, {
					__index = function() end,
					__newindex = function(...) 
                                    --[[local ArgumentString = "Ban Table #2 Changed";
                                    local Args = {...};

                                    for Index, Value in Args[3] do 
                                          ArgumentString = ArgumentString .. tostring(Index) .. " = "..tostring(Value).."\n"
                                    end; 
                                    
                                    Log(ArgumentString)]]
					end;
				});

				setmetatable(BanTable_2, {
					__index = function() end,
					__newindex = function(...) 
                                    --[[local ArgumentString = "Ban Table #3 Changed";
                                    local Args = {...};

                                    for Index, Value in Args[3] do 
                                          ArgumentString = ArgumentString .. tostring(Index) .. " = "..tostring(Value).."\n"
                                    end; 
                                    
                                    Log(ArgumentString)]]
					end;
				});

				BanTable_2 = nil;
				BypassCheck2 = true
			end;
		end;

		if not BypassCheck2 then 
			Client:Kick("Failed to load. 0x02");
			return
		else 
			print("init ez ez")
		end; 

		Log("Loaded Bypass #2..")

		for _, Function in getgc(false) do 
			if type(Function) ~= "function" then 
				continue 
			end; 
			if not islclosure(Function) then 
				continue 
			end; 
			if isexecutorclosure(Function) then 
				continue 
			end; 

			local Info = debug.getinfo(Function);

			if Info.source:find("AssetContainer") then 
				local Name = Info.name; 
				local Protos = debug.getprotos(Function);

				local Upvalues = debug.getupvalues(Function);

				if Protos[1] then 
					local Proto = debug.getproto(Function, 1)
					local Constants = debug.getconstants(Proto);

					if Constants[2] == "SurfaceGui" then  --// HIGHLIGHTS, BB GUI
						hookfunction(debug.getproto(Function, 1), LPH_NO_UPVALUES(function(...) 
							return
						end));

						--print("ESP DTC:", Proto)
					end;

					if table.find(Constants, "Foundation") then --// XRAY, TOUCH COLLISIONS
						hookfunction(debug.getproto(Function, 1), LPH_NO_UPVALUES(function(...) 
							return
						end));
						--print("XRAY DTC:", Proto)
					end;

					if table.find(Constants, "LocalAmmo") and table.find(Constants, "Equipped") then  --// VM ATTRIBUTES
						hookfunction(debug.getproto(Function, 1), LPH_NO_UPVALUES(function(...) 
							return
						end));
						--print("Attr DTC:", Proto)
					end;

					if table.find(Constants, "WalkSpeed") then --// Walk Speed
						hookfunction(debug.getproto(Function, 1), LPH_NO_UPVALUES(function() 
							return
						end));
						--print("Walkspeed DTC:", Proto)
					end;
				end;

                        --[[
                        local FOVResults = DeepSearchTable(Upvalues, "FieldOfView", 10, "", {}, {}, Function)
                        local WalkspeedResults  = DeepSearchTable(Upvalues, 18.01, 11, "", {}, {}, Function)
                        local BrightnessResults = DeepSearchTable(Upvalues, 2.001, 11, "", {}, {}, Function)
                        local HazeResults = DeepSearchTable(Upvalues, 2.079, 11, "", {}, {}, Function)

                        local AdornmentResults = DeepSearchTable(Upvalues, "PVAdornment", 11, "", {}, {}, Function)
                        local OutdoorResults = DeepSearchTable(Upvalues, "OutdoorAmbient", 10, "", {}, {}, Function);

                        if AdornmentResults then 
                              for I, Result in AdornmentResults do 
                                    if Result.Parent then 
                                          for Index, Value in Result.Parent do 
                                                if Value == "PVAdornment" or Value == "HandleAdornment" then 
                                                      --// Chams bypass
                                                      Result.Parent[Index] = "PartAdornment";
                                                      --print("Part adornment DTC:", Result.Parent)
                                                end;
                                          end;
                                    end;
                              end;
                        end;

                        if OutdoorResults then 
                              for I, Result in OutdoorResults do 
                                    if Result.Parent then 
                                          for Index, Value in Result.Parent do 
                                                if Value == "OutdoorAmbient" then 
                                                      --// Ambient Detection 1
                                                      Result.Parent[Index] = "ColorShift_Bottom";
                                                      --print("Ambient DTC:", Result.Parent)
                                                end;
                                          end;
                                    end;
                              end;
                        end;

                        if BrightnessResults then 
                              for BrighnessIndex, Result in BrightnessResults do 
                              local Parent = Result.Parent; 
                                    if Parent then 
                                          for Index, Value in Result.Parent do 
                                                if Value == 2.001 then 
                                                      --// Brightness detection
                                                      Result.Parent[Index] = 100
                                                      --print("Brightness DTC:", Result.Parent)
                                                end;

                                                if Value == 2.079 then 
                                                      --// Haze detection 1
                                                      Result.Parent[Index] = -0.1;
                                                      --print("Haze DTC:", Result.Parent)
                                                end;
                                          end;
                                    end;
                              end;	
                        end;

                        if FOVResults then 
                              for FOVIndex, FOVResult in FOVResults do 
                                    if FOVResult and type(FOVResult.Parent) == "table" then 
                                          for Index, Value in FOVResult.Parent do 
                                                if Value == 104 or Value == 105 then
                                                      --// FOV detection
                                                      FOVResult.Parent[Index] = 121
                                                      --print("FOV DTC:", FOVResult.Parent)
                                                end;
                                          end;
                                    end;
                              end;
                        end;

                        if WalkspeedResults then 
                              for WalkspeedIndex, Result in WalkspeedResults do 
                                    local Parent = Result.Parent; 
                                    if Parent and type(Parent) == "table" then 
                                          for Index, Value in Result.Parent do 
                                                if Value == 18.01 then 
                                                      --// Walkspeed detection
                                                      Result.Parent[Index] = 50;
                                                      --print("WalkSpeed DTC:", Result.Parent)
                                                end;
                                          end;
                                    end;
                              end;
                        end;

                        if HazeResults then 
                              for Index, Result in HazeResults do 
                                    local Parent = Result.Parent; 
                                    if Parent then 
                                          for Index, Value in Result.Parent do 
                                                if Value == 2.079 then 
                                                      --// Haze detection 2
                                                      Result.Parent[Index] = -0.1;
                                                      --print("Haze DTC:", Result.Parent)
                                                end;
                                          end;
                                    end;
                              end;	
                        end;
                        ]]
			end;
		end;

		Log("All bypassed loaded!")
	end
end)();

if (not game:IsLoaded()) then
      game.Loaded:Wait();
end;

task.wait(3); -- mainstreamed, why are we waiting?

local LoaderLaunched = false;

local Game = "Universal";
local HookingEnabled = true;
local Name = "Iridescent";

local Directory = "Iridescent";
local ConfigsFolder = Directory.."/Configs";
local DumpsFolder = Directory.."/Dumps";
local ImagesFolder = Directory.."/Images";
local DebugFolder = Directory.."/Debug";
local Fonts = {};
local ImageDirectory = "https://raw.githubusercontent.com/mainstreamed/clones/refs/heads/main/iridescent/";

--#region Folders
makefolder(Directory);
makefolder(ConfigsFolder);
makefolder(DumpsFolder);
makefolder(ImagesFolder);
makefolder(DebugFolder);
Log("Loaded folders..")
--#endregion Folders

-- for the custom derek images ( obfuscation gets fucked )
local CustomImageOverwrite = loadstring(game:HttpGet('https://raw.githubusercontent.com/mainstreamed/clones/refs/heads/main/iridescent/customAssets.lua'))();

local RequestImage = LPH_NO_VIRTUALIZE(function(Name)

      -- image overwrite
      if (CustomImageOverwrite[Name]) then
            writefile(ImagesFolder.."/"..Name..".png", crypt.base64.decode(CustomImageOverwrite[Name]));
            return;
      end


	local URL = ImageDirectory..Name..".png";
	local Request = request({
		Url = URL,
		Method = "GET",
		Headers = {
			["content-type"] = "application/json"
		}
	});

	if Request.StatusCode == 200 then
		writefile(ImagesFolder.."/"..Name..".png", Request.Body)
		Log("Successfully requested image: "..Name)
	else
		Log("Failed to request image: "..Name)
	end;
end);

--// Images, Fonts
LPH_NO_VIRTUALIZE(function()
	--// Font
	Font = getcustomasset and setreadonly(Font, false) or Font;
	if getcustomasset then 
		function Font:Register(Name, Weight, Style, Asset)
			if not isfile(Asset.Id) then
				writefile(Asset.Id, Asset.Font);
			end;

			local Data = {
				name = Name,
				faces = {
					{
						name = "Regular",
						weight = Weight,
						style = Style,
						assetId = getcustomasset(Asset.Id);
					}
				};
			};

			writefile(Name .. ".font", cloneref(game.GetService(game, "HttpService")):JSONEncode(Data));
			return getcustomasset(Name .. ".font");
		end;

		function Font:GetRegistry(Name)
			if isfile(Name .. ".font") then
				return getcustomasset(Name .. ".font");
			end;
		end;
	end;

	Font = getcustomasset and setreadonly(Font, true) or Font;

	local function RegisterFont(Name, Weight, Style, Asset)
		if getcustomasset then 
			return Font.new(Font:Register(Name, Weight, Style, Asset));
		else 
			return Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold);
		end;
	end;

	local MinecraftBase64 = "AAEAAAANAIAAAwBQRFNJRwAAAAEAAQX0AAAACEdERUYDBAAkAAEF/AAAAChPUy8y1NZFSAAAANwAAABgY21hcNZo3swAAQp8AAAIOGdhc3AAAAADAAEF7AAAAAhnbHlmEGqBuwAAGjgAANTQaGVhZAZHGCYAAPpgAAAANmhoZWERQQ7WAAAZ9AAAACRobXR4Ywj7gAAA+pgAAAtUbG9jYQEl1TwAAO8IAAALWG1heHAC4wA8AAAaGAAAACBuYW1lomnC7QABBiQAAARWcG9zdN5ON9IAAAE8AAAYuAADBGEBkAAFAAQDAAMAAAABgAMAAwAAAAMAAEwBMgAAAAAEAAAAAAAAAKAAAL9AAGB7AAAAAAAAAABGU1RSAEAAIPsCCQADAAAACoD9wAAAAf8AAAAAB4AJAAAAACAAAQACAAAAAAAAAJgATAAAAAAAAAAAAAAAAAAAAAAAAAAAAtUAAAABAAIAAwAEAAUABgAHAAgACQAKAAsADAANAA4ADwAQABEAEgATABQAFQAWABcAGAAZABoAGwAcAB0AHgAfACAAIQAiACMAJAAlACYAJwAoACkAKgArACwALQAuAC8AMAAxADIAMwA0ADUANgA3ADgAOQA6ADsAPAA9AD4APwBAAEEAQgBDAEQARQBGAEcASABJAEoASwBMAE0ATgBPAFAAUQBSAFMAVABVAFYAVwBYAFkAWgBbAFwAXQBeAF8AYABhAKMAhACFAL0AlgDoAIYAjgCLAJ0AqQCkAIoA2gCDAJMA8gDzAI0AlwCIAMMA3gDxAJ4AqgD1APQA9gCiAK0AyQDHAK4AYgBjAJAAZADLAGUAyADKAM8AzADNAM4A6QBmANMA0ADRAK8AZwDwAJEA1gDUANUAaADrAO0AiQBqAGkAawBtAGwAbgCgAG8AcQBwAHIAcwB1AHQAdgB3AOoAeAB6AHkAewB9AHwAuAChAH8AfgCAAIEA7ADuALoBAgEDAQQBBQEGAQcA/QD+AQgBCQEKAQsA/wEAAQwBDQEOAQEBDwEQAREBEgETARQBFQEWARcBGAEZARoA+AD5ARsBHAEdAR4BHwEgASEBIgEjASQBJQEmAScBKAEpASoA+gDXASsBLAEtAS4BLwEwATEBMgEzATQBNQE2ATcBOAE5AOIA4wE6ATsBPAE9AT4BPwFAAUEBQgFDAUQBRQFGAUcBSACwALEBSQFKAUsBTAFNAU4BTwFQAVEBUgD7APwA5ADlAVMBVAFVAVYBVwFYAVkBWgFbAVwBXQFeAV8BYAFhAWIBYwFkAWUBZgFnAWgAuwFpAWoBawFsAOYA5wFtAW4BbwFwAKYBcQFyAXMBdAF1AXYBdwF4AXkBegF7AXwBfQF+AX8BgAGBAYIBgwGEAYUBhgGHAYgBiQGKANgA4QGLAYwBjQDbANwA3QDgANkA3wGOAY8BkAGRAZIBkwGUAZUBlgGXAZgBmQGaAZsBnAGdAZ4BnwGgAaEBogGjAaQBpQGmAacBqAGpAaoBqwGsAa0BrgGvAbABsQGyAJ8BswG0AbUBtgG3AbgBuQG6AbsBvAG9Ab4BvwHAAcEBwgHDAcQBxQHGAccByACbAckBygHLAcwBzQHOAc8B0AHRAdIB0wHUAdUB1gHXAdgB2QHaAdsB3AHdAd4B3wHgAeEB4gHjAeQB5QHmAecB6AHpAeoB6wHsAe0B7gHvAfAB8QHyAfMB9AH1AfYB9wH4AfkB+gH7AfwB/QH+Af8CAAIBAgICAwIEAgUCBgIHAggCCQIKAgsCDAINAg4CDwIQAhECEgITAhQCFQIWAhcCGAIZAhoCGwIcAh0CHgIfAiACIQIiAiMCJAIlAiYCJwIoAikCKgIrAiwCLQIuAi8CMAIxAjICMwI0AjUCNgI3AjgCOQI6AjsCPAI9Aj4CPwJAAkECQgJDAkQCRQJGAkcCSAJJAkoCSwJMAk0CTgJPAlACUQJSAlMCVAJVAlYCVwJYAlkCWgJbAlwCXQJeAl8CYAJhAmICYwJkAmUCZgJnAmgCaQJqAmsCbAJtAm4CbwJwAnECcgJzAnQCdQJ2AncCeAJ5AnoCewJ8An0CfgJ/AoACgQKCAoMChAKFAoYChwKIAokCigC2ALcAxAKLALQAtQDFAowAggDCAIcCjQCrAMYCjgKPApACkQC+AL8AvAKSApMClAKVApYClwKYApkCmgKbApwCnQKeAp8CoAKhAqICowKkAqUCpgKnAqgCqQKqAqsCrAKtAq4CrwKwAIwCsQKyArMCtAK1ArYCtwK4ArkCugK7ArwCvQK+Ar8CwALBAsICwwLEAsUCxgLHAsgCyQLKAssAqAClAJIAnALMAKcAjwCUAJUCzQLOAs8C0ALRAtIC0wLUAtUC1gLXAtgC2QLaAtsC3ALdAt4AwADBB0FtYWNyb24HYW1hY3JvbgZBYnJldmUGYWJyZXZlB0FvZ29uZWsHYW9nb25lawtDY2lyY3VtZmxleAtjY2lyY3VtZmxleARDZG90BGNkb3QGRGNhcm9uBmRjYXJvbgZEY3JvYXQHRW1hY3JvbgdlbWFjcm9uBkVicmV2ZQZlYnJldmUERWRvdARlZG90B0VvZ29uZWsHZW9nb25lawZFY2Fyb24GZWNhcm9uC0djaXJjdW1mbGV4C2djaXJjdW1mbGV4BEdkb3QEZ2RvdAhHY2VkaWxsYQhnY2VkaWxsYQtIY2lyY3VtZmxleAtoY2lyY3VtZmxleARIYmFyBGhiYXIGSXRpbGRlBml0aWxkZQdJbWFjcm9uB2ltYWNyb24GSWJyZXZlBmlicmV2ZQdJb2dvbmVrB2lvZ29uZWsCSUoCaWoLSmNpcmN1bWZsZXgLamNpcmN1bWZsZXgIS2NlZGlsbGEIa2NlZGlsbGEMa2dyZWVubGFuZGljBkxhY3V0ZQZsYWN1dGUITGNlZGlsbGEIbGNlZGlsbGEGTGNhcm9uBmxjYXJvbgRMZG90BGxkb3QGTmFjdXRlBm5hY3V0ZQhOY2VkaWxsYQhuY2VkaWxsYQZOY2Fyb24GbmNhcm9uC25hcG9zdHJvcGhlA0VuZwNlbmcHT21hY3JvbgdvbWFjcm9uBk9icmV2ZQZvYnJldmUJT2RibGFjdXRlCW9kYmxhY3V0ZQZSYWN1dGUGcmFjdXRlCFJjZWRpbGxhCHJjZWRpbGxhBlJjYXJvbgZyY2Fyb24GU2FjdXRlBnNhY3V0ZQtTY2lyY3VtZmxleAtzY2lyY3VtZmxleAhUY2VkaWxsYQh0Y2VkaWxsYQZUY2Fyb24GdGNhcm9uBFRiYXIEdGJhcgZVdGlsZGUGdXRpbGRlB1VtYWNyb24HdW1hY3JvbgZVYnJldmUGdWJyZXZlBVVyaW5nBXVyaW5nCVVkYmxhY3V0ZQl1ZGJsYWN1dGUHVW9nb25lawd1b2dvbmVrC1djaXJjdW1mbGV4C3djaXJjdW1mbGV4C1ljaXJjdW1mbGV4C3ljaXJjdW1mbGV4BlphY3V0ZQZ6YWN1dGUEWmRvdAR6ZG90BWxvbmdzB0J0b3BiYXIHYnRvcGJhcgVTY2h3YQdac3Ryb2tlB3pzdHJva2UDRXpoB0dzdHJva2UHZ3N0cm9rZQZHY2Fyb24GZ2Nhcm9uBktjYXJvbgZrY2Fyb24HT29nb25lawdvb2dvbmVrCEV6aGNhcm9uCGV6aGNhcm9uCkFyaW5nYWN1dGUKYXJpbmdhY3V0ZQdBRWFjdXRlB2FlYWN1dGULT3NsYXNoYWN1dGULb3NsYXNoYWN1dGUMU2NvbW1hYWNjZW50DHNjb21tYWFjY2VudAtUY29tbWFiZWxvdwt0Y29tbWFiZWxvdwhkb3RsZXNzagVzY2h3YQNlemgQZmlyc3R0b25lY2hpbmVzZRFzZWNvbmR0b25lY2hpbmVzZRFmb3VydGh0b25lY2hpbmVzZRBudW1lcmFsc2lnbmdyZWVrFW51bWVyYWxzaWdubG93ZXJncmVlaw1xdWVzdGlvbmdyZWVrBXRvbm9zDmRpYWx5dGlrYXRvbm9zCkFscGhhdG9ub3MJYW5vdGVsZWlhDEVwc2lsb250b25vcwhFdGF0b25vcwlJb3RhdG9ub3MMT21pY3JvbnRvbm9zDFVwc2lsb250b25vcwpPbWVnYXRvbm9zEWlvdGFkaWVyZXNpc3Rvbm9zBUFscGhhBEJldGEFR2FtbWEKRGVsdGFncmVlawdFcHNpbG9uBFpldGEDRXRhBVRoZXRhBElvdGEFS2FwcGEGTGFtYmRhAk11Ak51AlhpB09taWNyb24CUGkDUmhvBVNpZ21hA1RhdQdVcHNpbG9uA1BoaQNDaGkDUHNpDElvdGFkaWVyZXNpcw9VcHNpbG9uZGllcmVzaXMKYWxwaGF0b25vcwxlcHNpbG9udG9ub3MIZXRhdG9ub3MJaW90YXRvbm9zFHVwc2lsb25kaWVyZXNpc3Rvbm9zBWFscGhhBGJldGEFZ2FtbWEFZGVsdGEHZXBzaWxvbgR6ZXRhA2V0YQV0aGV0YQRpb3RhBWthcHBhBmxhbWJkYQdtdWdyZWVrAm51AnhpB29taWNyb24DcmhvBnNpZ21hMQVzaWdtYQN0YXUHdXBzaWxvbgNwaGkDY2hpA3BzaQVvbWVnYQxpb3RhZGllcmVzaXMPdXBzaWxvbmRpZXJlc2lzDG9taWNyb250b25vcwx1cHNpbG9udG9ub3MKb21lZ2F0b25vcwd1bmkwM0Q3B3VuaTA0MDAJYWZpaTEwMDIzCWFmaWkxMDA1MQlhZmlpMTAwNTIJYWZpaTEwMDUzCWFmaWkxMDA1NAlhZmlpMTAwNTUJYWZpaTEwMDU2CWFmaWkxMDA1NwlhZmlpMTAwNTgJYWZpaTEwMDU5CWFmaWkxMDA2MAlhZmlpMTAwNjEHdW5pMDQwRAlhZmlpMTAwNjIJYWZpaTEwMTQ1CUFjeXJpbGxpYwlhZmlpMTAwMTgJYWZpaTEwMDE5CWFmaWkxMDAyMAlhZmlpMTAwMjEJYWZpaTEwMDIyCWFmaWkxMDAyNAlhZmlpMTAwMjUJYWZpaTEwMDI2CWFmaWkxMDAyNwlhZmlpMTAwMjgJYWZpaTEwMDI5CWFmaWkxMDAzMAlhZmlpMTAwMzEJYWZpaTEwMDMyCWFmaWkxMDAzMwlhZmlpMTAwMzQJYWZpaTEwMDM1CWFmaWkxMDAzNglhZmlpMTAwMzcJYWZpaTEwMDM4CWFmaWkxMDAzOQlhZmlpMTAwNDAJYWZpaTEwMDQxCWFmaWkxMDA0MglhZmlpMTAwNDMJYWZpaTEwMDQ0CWFmaWkxMDA0NQlhZmlpMTAwNDYJYWZpaTEwMDQ3CWFmaWkxMDA0OAlhZmlpMTAwNDkJYWN5cmlsbGljCWFmaWkxMDA2NglhZmlpMTAwNjcJYWZpaTEwMDY4CWFmaWkxMDA2OQlhZmlpMTAwNzAJYWZpaTEwMDcyCWFmaWkxMDA3MwlhZmlpMTAwNzQJYWZpaTEwMDc1CWFmaWkxMDA3NglhZmlpMTAwNzcJYWZpaTEwMDc4CWFmaWkxMDA3OQlhZmlpMTAwODAJYWZpaTEwMDgxCWFmaWkxMDA4MglhZmlpMTAwODMJYWZpaTEwMDg0CWFmaWkxMDA4NQlhZmlpMTAwODYJYWZpaTEwMDg3CWFmaWkxMDA4OAlhZmlpMTAwODkJYWZpaTEwMDkwCWFmaWkxMDA5MQlhZmlpMTAwOTIJYWZpaTEwMDkzCWFmaWkxMDA5NAlhZmlpMTAwOTUJYWZpaTEwMDk2CWFmaWkxMDA5Nwd1bmkwNDUwCWFmaWkxMDA3MQlhZmlpMTAwOTkJYWZpaTEwMTAwCWFmaWkxMDEwMQlhZmlpMTAxMDIJYWZpaTEwMTAzCWFmaWkxMDEwNAlhZmlpMTAxMDUJYWZpaTEwMTA2CWFmaWkxMDEwNwlhZmlpMTAxMDgJYWZpaTEwMTA5B3VuaTA0NUQJYWZpaTEwMTEwCWFmaWkxMDE5MwlhZmlpMTAxNDYJYWZpaTEwMTk0CWFmaWkxMDE0NwlhZmlpMTAxOTUJYWZpaTEwMTQ4CWFmaWkxMDE5Ngd1bmkwNDhBB3VuaTA0OEIHdW5pMDQ4Qwd1bmkwNDhEB3VuaTA0OEUHdW5pMDQ4RglhZmlpMTAwNTAJYWZpaTEwMDk4EUdoZXN0cm9rZWN5cmlsbGljEWdoZXN0cm9rZWN5cmlsbGljFFpoZWRlc2NlbmRlcmN5cmlsbGljFHpoZWRlc2NlbmRlcmN5cmlsbGljE1plZGVzY2VuZGVyY3lyaWxsaWMTemVkZXNjZW5kZXJjeXJpbGxpYxNLYWRlc2NlbmRlcmN5cmlsbGljE2thZGVzY2VuZGVyY3lyaWxsaWMYS2F2ZXJ0aWNhbHN0cm9rZWN5cmlsbGljGGthdmVydGljYWxzdHJva2VjeXJpbGxpYxFLYWJhc2hraXJjeXJpbGxpYxFrYWJhc2hraXJjeXJpbGxpYxNFbmRlc2NlbmRlcmN5cmlsbGljE2VuZGVzY2VuZGVyY3lyaWxsaWMTRXNkZXNjZW5kZXJjeXJpbGxpYxNlc2Rlc2NlbmRlcmN5cmlsbGljEVVzdHJhaWdodGN5cmlsbGljEXVzdHJhaWdodGN5cmlsbGljF1VzdHJhaWdodHN0cm9rZWN5cmlsbGljF3VzdHJhaWdodHN0cm9rZWN5cmlsbGljE0hhZGVzY2VuZGVyY3lyaWxsaWMTaGFkZXNjZW5kZXJjeXJpbGxpYxRDaGVkZXNjZW5kZXJjeXJpbGxpYxRjaGVkZXNjZW5kZXJjeXJpbGxpYxlDaGV2ZXJ0aWNhbHN0cm9rZWN5cmlsbGljGWNoZXZlcnRpY2Fsc3Ryb2tlY3lyaWxsaWMMU2hoYWN5cmlsbGljDHNoaGFjeXJpbGxpYxBwYWxvY2hrYWN5cmlsbGljEFpoZWJyZXZlY3lyaWxsaWMQemhlYnJldmVjeXJpbGxpYwd1bmkwNEM1B3VuaTA0QzYORW5ob29rY3lyaWxsaWMOZW5ob29rY3lyaWxsaWMHdW5pMDRDOQd1bmkwNENBB3VuaTA0Q0QHdW5pMDRDRQd1bmkwNENGEUFkaWVyZXNpc2N5cmlsbGljEWFkaWVyZXNpc2N5cmlsbGljC0FpZWN5cmlsbGljC2FpZWN5cmlsbGljDVNjaHdhY3lyaWxsaWMJYWZpaTEwODQ2D0ltYWNyb25jeXJpbGxpYw9pbWFjcm9uY3lyaWxsaWMRSWRpZXJlc2lzY3lyaWxsaWMRaWRpZXJlc2lzY3lyaWxsaWMRT2RpZXJlc2lzY3lyaWxsaWMRb2RpZXJlc2lzY3lyaWxsaWMPT2JhcnJlZGN5cmlsbGljD29iYXJyZWRjeXJpbGxpYwd1bmkwNEVDB3VuaTA0RUQPVW1hY3JvbmN5cmlsbGljD3VtYWNyb25jeXJpbGxpYxFVZGllcmVzaXNjeXJpbGxpYxF1ZGllcmVzaXNjeXJpbGxpYwZXZ3JhdmUGd2dyYXZlBldhY3V0ZQZ3YWN1dGUJV2RpZXJlc2lzCXdkaWVyZXNpcwd1bmkxRTlFBllncmF2ZQZ5Z3JhdmURcXVvdGVsZWZ0cmV2ZXJzZWQHdW5pMjAxRgd1bmkyMDIzBm1pbnV0ZQZzZWNvbmQNcHJpbWVyZXZlcnNlZAd1bmkyMDM2DHplcm9zdXBlcmlvcgd1bmkyMDcxDGZvdXJzdXBlcmlvcgxmaXZlc3VwZXJpb3ILc2l4c3VwZXJpb3INc2V2ZW5zdXBlcmlvcg1laWdodHN1cGVyaW9yDG5pbmVzdXBlcmlvcgx6ZXJvaW5mZXJpb3ILb25laW5mZXJpb3ILdHdvaW5mZXJpb3INdGhyZWVpbmZlcmlvcgxmb3VyaW5mZXJpb3IMZml2ZWluZmVyaW9yC3NpeGluZmVyaW9yDXNldmVuaW5mZXJpb3INZWlnaHRpbmZlcmlvcgxuaW5laW5mZXJpb3IDd29uBEV1cm8HdW5pMjBBRQd1bmkyMEIxB3VuaTIwQjQHdW5pMjBCOAd1bmkyMEI5B3VuaTIwQkEJYWZpaTYxMjQ4CWFmaWk2MTI4OQlhZmlpNjEzNTIHdW5pMjExNwd1bmkyMTIwCWVzdGltYXRlZAd1bmkyMTUwB3VuaTIxNTEHdW5pMjE1MghvbmV0aGlyZAl0d290aGlyZHMHdW5pMjE1NQd1bmkyMTU2B3VuaTIxNTcHdW5pMjE1OAd1bmkyMTU5B3VuaTIxNUEJb25lZWlnaHRoDHRocmVlZWlnaHRocwtmaXZlZWlnaHRocwxzZXZlbmVpZ2h0aHMJYXJyb3dsZWZ0B2Fycm93dXAKYXJyb3dyaWdodAlhcnJv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wMDAwMABgP6AwAGA/oDAwMDAwMDAwAAAAAQAAAPAA8AJwAADAAkADQARAAARETMRFTUhETMRATUzFSU1MxXAAkDA/cDA/oDABIADAP0AwMADAPxABIDAwMDAwAAABAAAA8ADwAnAAAMACQANABEAABERMxEVNSERMxEBNTMVNTUzFcACQMD9wMDABIADAP0AwMADAPxABIDAwMDAwAAAAAAFAAADwAPACcAAAwAJAA0AEQAVAAARETMRFTUhETMRATUzFTM1MxUlNTMVwAJAwP0AwMDA/oDABIADAP0AwMADAPxABIDAwMDAwMDAAAAAAAQAAAPAA8AJAAADAAkADQARAAARETMRFTUhETMRATUzFTM1MxXAAkDA/QDAwMAEgAMA/QDAwAMA/EAEgMDAwMAAAAAABQAAAwADwAnAAAMABwAPABMAFwAAETUhFQERMxEBNSE1IREzEQE1MxU1NTMVAwD9AMACQP3AAkDA/cDAwAMAwMACQAJA/cD+gMDAAkD8QASAwMDAwMAAAAMAAAMAA8AJAAADAAcAEwAAAREzEQE1IRUBETMRMxUjFSEVIREDAMD9wAGA/QDAwMACQP3ABUABgP6AAYDAwPxABgD9wMDAwP6AAAADAAADAAPAB4AAAwAHAA8AABE1IRUBETMRATUhNSERMxEDAP0AwAJA/cACQMADAMDAAkACQP3A/oDAwAJA/EAAAwAAA8ADwAqAAAsADwATAAARETMVITUzESMRIRERNSEVATUhFcACQMDA/cACQP3AAkADwASAwMD7gAMA/QAEgMDAAYDAwAAABAAAA8ADwAkAAAMADQARABUAABE1MxUVNSE1ITUhNTMRATUhFQE1IRXAAkD9wAJAwP0AAkD9wAJABIDAwMDAwMDA/QADAMDAAYDAwAAAAAACAAADwAPACoAACwATAAARETMVITUzESMRIRERETMVMzUzEcACQMDA/cDAwMADwASAwMD7gAMA/QAEgAJAwMD9wAAAAAQAAAPAA8AJwAADAA0AEQAZAAARNTMVFTUhNSE1ITUzEQE1IRUBETMVMzUzEcACQP3AAkDA/QACQP3AwMDABIDAwMDAwMDA/QADAMDAAYABgMDA/oAAAAADAAACQAPACQAABQARABUAAAERMxUzFQERMxUhNTMRIxEhERE1IRUCQMDA/EDAAkDAwP3AAkAC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AAAAAAADAAADAAPAB4AABwALAA8AABERMxEhFSERAREzEQE1IRXAAkD9wAJAwP0AAkADAAPA/oDA/oACQAGA/oABgMDAAAAAAAQAAAMAA8AHgAADAAcACwAPAAABETMRATUhFSURMxERNSEVAwDA/QACQP0AwAMAAwABgP6AAYDAwMABgP6AAYDAwAAAAwAAA8ADwAeAAAMABwAPAAATNSEVJREzESERITUhFSMRwAGA/cDAAYD+gAMAwAPAwMDAAkD9wAJAwMD9wAAAAAEAAAPAA8AHgAAHAAABESE1IRUhEQGA/oADwP6AA8ADAMDA/QAAAAADAAADwAPAB4AAAwAHAAsAABM1IRUlETMRIREzEcACQP0AwAJAwAPAwMDAAwD9AAMA/QAAAwAAAwADwAeAAAMABwAVAAABETMRIREzERMRIzUzESEVIxEzFSMRAwDA/EDAwMDAAYDAwMAFQAGA/oACQP3A/cABgMACQMD+gMD+gAAAAAAJAAADAAPAB4AAAwAHAAsADwATABcAGwAfACMAABERMxEhETMRATUzFTM1MxUlNTMVJTUzFTM1MxUlNTMVITUzFcACQMD9AMDAwP6AwP6AwMDA/QDAAkDAAwABgP6AAYD+gAGAwMDAwMDAwMDAwMDAwMDAwMAAAAADAAADAAPAB4AAAwAPABMAABERMxETESM1MxEzETMVIxETETMRwMDAwMDAwMDABUACQP3A/cABgMACQP3AwP6AAkACQP3AAAAFAAADwAPAB4AAAwAHAAsADwATAAATNTMVMzUzFSURMxEhETMRIREzEcDAwMD+gMD9wMACQMADwMDAwMDAAYD+gAMA/QADAP0AAAAAAwAAA8ACQAkAAAMABwALAAATETMRATUzFTM1MxXAwP6AwMDAA8ADwPxABIDAwMDAAAAAAAUAAAPAA8AJAAADAAcACwAPABMAABM1IRUlETMRIREzEQE1MxUzNTMVwAJA/QDAAkDA/QDAwMADwMDAwAMA/QADAP0AA8DAwMDAAAAEAAADwAPAB4AAAwAHAAsADwAAEzUhFSURMxEhETMRATUhFcACQP0AwAJAwP0AAkADwMDAwAJA/cACQP3AAkDAwAAAAAQAAAPAA8AJwAADAAcACwAPAAATNSEVJREzESERMxEBETMRwAJA/QDAAkDA/cDAA8DAwMADAP0AAwD9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AADDrAAAxEAAAMTIAADFYAAAxggAAMacAADHOAAAx9gAAMhwAADIyAAAySAAAMl4AADJ1AAAyjwAAMqoAADLDAAAy2QAAMvIAADMJAAAzMwAAM0YAADNdAAAzdwAAM4MAADOPAAAzqgAAM7sAADPRAAAz5wAAM+4AADP4AAA0AwAANBUAADQhAAA0NQAANFIAADRhAAA0eQAANI0AADSYAAA0pwAANLoAADTLAAA03AAANPMAADUBAAA1DwAANSEAADU0AABAAAAAgAANpQQ/l8PPPUACwYAAAAAANA0HEwAAAAA0DOsHP6AAkAIQAqAAAAACAACAAEAAAAAAYAAAAAAAAABgAAAAYAAAAGAAAADAAAABIAAAASAAAAEgAAABIAAAAGAAAADwAAAA8AAAAPAAAAEgAAAAYAAAASAAAABgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAABgAAAAYAAAAPAAAAEgAAAA8AAAASAAAAFQAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAADAAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAADAAAABIAAAAMAAAAEgAAABIAAAAJAAAAEgAAABIAAAASAAAAEgAAABIAAAAPAAAAEgAAABIAAAAGAAAAEgAAAA8AAAAJAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAAAwAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAAPAAAABgAAAA8AAAAVAAAABgAAAA8AAAASAAAAEgAAABIAAAAGAAAAEgAAAA8AAwAYAAAADAAAAA8AAAAPAAAAGAAAABIAAAAMAAAAEgAAAAwAAAAMAAAACQAAABIAAAASAAAABgAAAAwAAwAMAAAADAAAAA8AAAAbAAAAGwAAABsAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAHgAAABIAAAASAAAAEgAAABIAAAASAAAADAAAAAwAAAAMAAAADAAAABUAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAAPAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAAeAAAAEgAAABIAAAASAAAAEgAAABIAAAAGA/0ACQAAAAkD/QAJA/0AEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABgAAAAVAAAAFQAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABUAAAAPA/0ADwP9AAwAAAAJA/0ADAAAAAkD/QAMAAAACQAAAAwAAAAGAAAAHgAAABgAAAASAAAAFQAAABIAAAAPAAAADwAAABIAAAAJAAAAEgAAAAkAAAASAAAADAAAABIAAAAMAAAAFQAAAAwAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAAYAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAAeAAAAHgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAAAwAAAASAAAAEgAAABIAAAAMAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAAPAAAAEgAAAA8AAAASAAAAEgAAABIAAAASAAAAEgAAABUAAAAVAAAAEgAAABIAAAASAAAADwAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAAB4AAAAeAAAAEgAAABIAAAASAAAAEgAAABIAAAAMAAAAEgAAABIAAAASAAAADAAAAAwAAAAMAAAACQAAAAkAAAAMAAAACQADAAwAAAAJAAAAEgAAAA8AAAAJAAAACQAAAAYAAAAGAAAAEgAAABgAAAAGAAAAGAAAABgAAAASAAAAGAAAABgAAAAYAAAADwP9ABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAADAAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAAAwAAAASAAAAEgAAABIAAAASAAAABgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAADwAAAAYAAAAPAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAADAAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAAVAAAAEgAAABIAAAASAAAADAAAAAwAAAASAAAAHgAAAB4AAAAVAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAAVAAAAEgAAABIAAAAVAAAAFQAAABgAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAAA8AAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAAYAAAAEgAAABUAAAASAAAAEgAAABUAAAASAAAAFQAAAA8AAAASAAAAEgAAABIAAAASAAAAEgAAABUAAAASAAAAEgAAABIAAAAGAAAADAAAABIAAAAbAAAAGwAAABUAAAAPAAAAEgAAABIAAAASAAAAFQAAABUAAAASAAAAEgAAABIAAAASAAAAFQAAABUAAAAVAAAAEgAAABIAAAASAAAAEgAAABIAAAAVAAAAFQAAABUAAAAVAAAAEgAAABIAAAAVAAAADwAAABIAAAASAAAAFQAAABIAAAAVAAAAFQAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABUAAAAVAAAAFQAAABUAAAASAAAAEgAAABIAAAASAAAABgAAABIAAAASAAAAFQAAABUAAAASAAAAEgAAABUAAAAVAAAAFQAAABIAAAAGAAAAEgAAABIAAAAeAAAAHgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAAJAAAACQAAAAkAAAAJAAAADwAAAA8AAAAPAAAADwAAAAwAAAAMAAAACQAAAAwAAAASAAAAGAAAAAwAAAASAAAADAAAABIAAAAJAAAACQAAAAwD+gAMAAAABgAAAAwAAAAMAAAADAAAAAwAAAAMAAAADAAAAAwAAAAMAAAADAAAAAwAAAAMAAAADAAAAAwAAAAMAAAADAAAAAwAAAASAAAAEgAAABIAAAASAAAAEgAAABIAAAASAAAAEgAAABgAAAAPAAAAGwAAABgAAAAYAAAAGAAAABUAAAAbAAAAGwAAACQAAAAbAAAAGwAAABsAAAAbAAAAGwAAABsAAAAbAAAAGwAAABsAAAAbAAAAGwAAABsAAAAYAAAAGAAAABgAAAAYAAAAGAAAABUAAwAYAAAAGAAAABgAAAAYAAAAGAAAABIAAAAbAAAAGAAAABIAAAASAAAAFQAAABIAAAAVAAAAFQAAAAwAAAAMAAAAEgAAABIAAAAPAAAADwAAABUAAAAVAAAAEgAAABUAAAAPAAAAFQAAABUAAAAPAAAADwAAABIAAAAJAAAACQAAABUAAAAYAAAAAAQAB//8AAgAAAAEAAAAAAAEAAAAOAAAAGAAgAAAAAgABAAEC1AABAAQAAAACAAAAAQAAAAEAAAAAABoBPgABAAAAAAAAABsAAAABAAAAAAABAAsAGwABAAAAAAACAAcAJgABAAAAAAADAA8ALQABAAAAAAAEAA8APAABAAAAAAAFAAsASwABAAAAAAAGABMAVgABAAAAAAAIABYAaQABAAAAAAAJAAwAfwABAAAAAAALABYAiwABAAAAAAAMABYAoQABAAAAAAANACgAtwABAAAAAAATACkA3wADAAEECQAAADYBCAADAAEECQABABYBPgADAAEECQACAA4BVAADAAEECQADAB4BYgADAAEECQAEAB4BgAADAAEECQAFABYBngADAAEECQAGACYBtAADAAEECQAIACwB2gADAAEECQAJABgCBgADAAEECQALACwCHgADAAEECQAMACwCSgADAAEECQANAFACdgADAAEECQATAFICxkNvcHlyaWdodCBBbmRyZXcgVHlsZXIgMjAxNE1pbmVjcmFmdGlhUmVndWxhck1pbmVjcmFmdGlhIDIuME1pbmVjcmFmdGlhIDIuMFZlcnNpb24gMi4wTWluZWNyYWZ0aWEtUmVndWxhcmh0dHA6Ly9hbmRyZXd0eWxlci5uZXRBbmRyZXcgVHlsZXJodHRwOi8vYW5kcmV3dHlsZXIubmV0aHR0cDovL2FuZHJld3R5bGVyLm5ldENyZWF0aXZlIENvbW1vbnMgQXR0cmlidXRpb24gU2hhcmUgQWxpa2VGaXZlIGJpZyBxdWFja2luZyB6ZXBoeXJzIGpvbHQgbXkgd2F4IGJlZABDAG8AcAB5AHIAaQBnAGgAdAAgAEEAbgBkAHIAZQB3ACAAVAB5AGwAZQByACAAMgAwADEANABNAGkAbgBlAGMAcgBhAGYAdABpAGEAUgBlAGcAdQBsAGEAcgBNAGkAbgBlAGMAcgBhAGYAdABpAGEAIAAyAC4AMABNAGkAbgBlAGMAcgBhAGYAdABpAGEAIAAyAC4AMABWAGUAcgBzAGkAbwBuACAAMgAuADAATQBpAG4AZQBjAHIAYQBmAHQAaQBhAC0AUgBlAGcAdQBsAGEAcgBoAHQAdABwADoALwAvAGEAbgBkAHIAZQB3AHQAeQBsAGUAcgAuAG4AZQB0AEEAbgBkAHIAZQB3ACAAVAB5AGwAZQByAGgAdAB0AHAAOgAvAC8AYQBuAGQAcgBlAHcAdAB5AGwAZQByAC4AbgBlAHQAaAB0AHQAcAA6AC8ALwBhAG4AZAByAGUAdwB0AHkAbABlAHIALgBuAGUAdABDAHIAZQBhAHQAaQB2AGUAIABDAG8AbQBtAG8AbgBzACAAQQB0AHQAcgBpAGIAdQB0AGkAbwBuACAAUwBoAGEAcgBlACAAQQBsAGkAawBlAEYAaQB2AGUAIABiAGkAZwAgAHEAdQBhAGMAawBpAG4AZwAgAHoAZQBwAGgAeQByAHMAIABqAG8AbAB0ACAAbQB5ACAAdwBhAHgAIABiAGUAZAAAAAAAAwAAAAMAAAAeAAEAAAAAAyYAAwABAAAFMAAAAAQDCAAAAK4AgAAGAC4AfgCsAX8BgwGPAZIBtwHrAe8B/wIbAjcCWQKSAscCywLdA3UDfgOKA4wDoQPOA9cEXwRjBHUEkwSdBKMEqwSzBLsEwgTKBM8E1QTZBOkE8R6FHp4e8yAjICYgMCAzIDYgOiBEIHEgeSCJIKkgrCCuILEgtCC6IQUhEyEXISAhIiEuIV4hmSIG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"
	local SmallFontBase64 = "AAEAAAAMAIAAAwBAT1MvMmSz/H0AAAFIAAAAYFZETVhoYG/3AAAGmAAABeBjbWFwel+AIwAADHgAAAUwZ2FzcP//AAEAAGP4AAAACGdseWa90hIhAAARqAAARRRoZWFk/hqSzwAAAMwAAAA2aGhlYQegBbsAAAEEAAAAJGhtdHhmdgAAAAABqAAABPBsb2Nh73HeDAAAVrwAAAJ6bWF4cAFBADMAAAEoAAAAIG5hbWX/R4pVAABZOAAABC1wb3N0fPqooAAAXWgAAAaOAAEAAAABAAArGZw2Xw889QAJA+gAAAAAzSamLgAAAADNJqljAAD/OASwAyAAAAAJAAIAAAAAAAAAAQAAAu7/BgAABRQAAABkBLAAAQAAAAAAAAAAAAAAAAAAATwAAQAAATwAMgAEAAAAAAABAAAAAAAAAAAAAAAAAAAAAAADAfMBkAAFAAACvAKKAAD/nAK8AooAAAD6ADIA+gAAAgAAAAAAAAAAAIAAAi8AAAAKAAAAAAAAAABQWVJTAEAAICEiAu7/BgAAAyAAyAAAAAUAAAAAAPoB9AAAACAAAAH0AAAAAAAAAfQAAAH0AAACWAAAAlgAAAJYAAAAyAAAAS0AAAEtAAABkAAAAZAAAAEsAAABkAAAAMgAAAJYAAAB9AAAAZAAAAH0AAAB9AAAAfQAAAH0AAAB9AAAAfQAAAH0AAAB9AAAAMgAAAEsAAABkAAAAZAAAAGQAAAB9AAAAfQAAAH0AAAB9AAAAfQAAAH0AAAB9AAAAfQAAAH0AAAB9AAAAZAAAAH0AAAB9AAAAfQAAAJYAAAB9AAAAfQAAAH0AAAB9AAAAfQAAAH0AAABkAAAAfQAAAGQAAACWAAAAfQAAAGQAAAB9AAAASwAAAJYAAABLAAAAlgAAAH0AAABLAAAAfQAAAH0AAAB9AAAAfQAAAH0AAAB9AAAAfQAAAH0AAABkAAAAfQAAAH0AAAB9AAAAlgAAAH0AAAB9AAAAfQAAAH0AAAB9AAAAfQAAAGQAAAB9AAAAZAAAAJYAAAB9AAAAZAAAAH0AAABkAAAAMgAAAGQAAAB9AAAAlgAAAH0AAABLAAAAfQAAAJYAAACWAAAAZAAAAGQAAACWAAAAyAAAAJYAAABkAAAAlgAAAH0AAACWAAAAZAAAAJYAAABLAAAASwAAAJYAAACWAAAASwAAAGQAAAB9AAAA4QAAAJYAAABkAAAAlgAAAH0AAACWAAAAZAAAAGQAAABkAAAAfQAAAH0AAAB9AAAAMgAAAH0AAAB9AAAAyAAAAH0AAACvAAAAfQAAAEsAAADIAAAAZAAAAGQAAABkAAAAZAAAAGQAAAB9AAAAlgAAAJYAAAAyAAAAfQAAAK8AAAB9AAAArwAAAH0AAAB9AAAAfQAAAGQAAAB9AAAAfQAAAH0AAAB9AAAAlgAAAH0AAACWAAAAfQAAAH0AAAB9AAAAfQAAAH0AAACWAAAAfQAAAH0AAAB9AAAAfQAAAH0AAABkAAAAfQAAAJYAAAB9AAAAlgAAAH0AAACWAAAArwAAAJYAAACvAAAAfQAAAH0AAACWAAAAfQAAAH0AAAB9AAAAfQAAAH0AAACWAAAAfQAAAJYAAAB9AAAAfQAAAH0AAAB9AAAAfQAAAJYAAAB9AAAAfQAAAH0AAAB9AAAAfQAAAGQAAAB9AAAAlgAAAH0AAACWAAAAfQAAAJYAAACvAAAAlgAAAK8AAAB9AAAAfQAAAJYAAAB9AAAAfQAAAH0AAAAyAAAAlgAAAH0AAABkAAAAZAAAAH0AAAB9AAAAfQAAAEsAAABkAAAAZAAAAH0AAAFFAAABRQAAAUUAAAB9AAAAfQAAAH0AAAB9AAAAfQAAAH0AAAB9AAAAlgAAAH0AAAB9AAAAfQAAAH0AAAB9AAAAZAAAAGQAAABkAAAAZAAAAJYAAAB9AAAAfQAAAH0AAAB9AAAAfQAAAH0AAABkAAAAlgAAAH0AAAB9AAAAfQAAAH0AAABkAAAAfQAAAH0AAAB9AAAAfQAAAH0AAAB9AAAAfQAAAH0AAACWAAAAfQAAAH0AAAB9AAAAfQAAAH0AAABkAAAAZAAAAGQAAABkAAAAlgAAAH0AAAB9AAAAfQAAAH0AAAB9AAAAfQAAAGQAAACWAAAAfQAAAH0AAAB9AAAAfQAAAGQAAAB9AAAAZAAAAJYAAACWAAAAfQAAAH0AAABkAAAAfQAAAH0AAAB9AAAAZAAAAH0AAACWAAAAMgAAAGQAAAAAAABAAEBAQEBAAwA+Aj/AAgAB//+AAkACP/+AAoACP/+AAsACf/9AAwACv/9AA0AC//9AA4ADP/9AA8ADP/9ABAADf/8ABEADv/8ABIAD//8ABMAEP/8ABQAEP/8ABUAEf/7ABYAEv/7ABcAE//7ABgAFP/7ABkAFP/7ABoAFf/6ABsAFv/6ABwAF//6AB0AGP/6AB4AGP/6AB8AGf/5ACAAGv/5ACEAG//5ACIAHP/5ACMAHP/5ACQAHf/4ACUAHv/4ACYAH//4ACcAIP/4ACgAIP/4ACkAIf/3ACoAIv/3ACsAI//3ACwAJP/3AC0AJP/3AC4AJf/2AC8AJv/2ADAAJ//2ADEAKP/2ADIAKP/2ADMAKf/1ADQAKv/1ADUAK//1ADYALP/1ADcALP/1ADgALf/0ADkALv/0ADoAL//0ADsAMP/0ADwAMP/0AD0AMf/zAD4AMv/zAD8AM//zAEAANP/zAEEANP/zAEIANf/yAEMANv/yAEQAN//yAEUAOP/yAEYAOP/yAEcAOf/xAEgAOv/xAEkAO//xAEoAPP/xAEsAPP/xAEwAPf/wAE0APv/wAE4AP//wAE8AQP/wAFAAQP/wAFEAQf/vAFIAQv/vAFMAQ//vAFQARP/vAFUARP/vAFYARf/uAFcARv/uAFgAR//uAFkASP/uAFoASP/uAFsASf/tAFwASv/tAF0AS//tAF4ATP/tAF8ATP/tAGAATf/sAGEATv/sAGIAT//sAGMAUP/sAGQAUP/sAGUAUf/rAGYAUv/rAGcAU//rAGgAVP/rAGkAVP/rAGoAVf/qAGsAVv/qAGwAV//qAG0AWP/qAG4AWP/qAG8AWf/pAHAAWv/pAHEAW//pAHIAXP/pAHMAXP/pAHQAXf/oAHUAXv/oAHYAX//oAHcAYP/oAHgAYP/oAHkAYf/nAHoAYv/nAHsAY//nAHwAZP/nAH0AZP/nAH4AZf/mAH8AZv/mAIAAZ//mAIEAaP/mAIIAaP/mAIMAaf/lAIQAav/lAIUAa//lAIYAbP/lAIcAbP/lAIgAbf/kAIkAbv/kAIoAb//kAIsAcP/kAIwAcP/kAI0Acf/jAI4Acv/jAI8Ac//jAJAAdP/jAJEAdP/jAJIAdf/iAJMAdv/iAJQAd//iAJUAeP/iAJYAeP/iAJcAef/hAJgAev/hAJkAe//hAJoAfP/hAJsAfP/hAJwAff/gAJ0Afv/gAJ4Af//gAJ8AgP/gAKAAgP/gAKEAgf/fAKIAgv/fAKMAg//fAKQAhP/fAKUAhP/fAKYAhf/eAKcAhv/eAKgAh//eAKkAiP/eAKoAiP/eAKsAif/dAKwAiv/dAK0Ai//d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ATkBOgE7ATwBPQE+AT8BQAFBAUIBQwFEAUUBRgFHAUgBSQFKAUsBTAFNAU4BTwFQAVEBUgFTAVQBVQFWAVcBWAFZAVoBWwFcAV0BXgFfAWABYQFiAWMBZAFlAWYAowCEAIUAlgCOAJ0A8gDzAI0A3gDxAJ4A9QD0APYAogCtAMkAxwCuAGIAYwCQAGQAywBlAMgAygDPAMwAzQDOAOkAZgDTANAA0QCvAGcA8ACRANYA1ADVAGgA6wDtAIkAagBpAGsAbQBsAG4AoABvAHEAcAByAHMAdQB0AHYAdwDqAHgAegB5AHsAfQB8ALgAoQB/AH4AgACBAOwA7gC6ALAAsQDkAOUAuwDmAOcApgDYANkABgAEAAUFLm51bGwJYWZpaTEwMDUxCWFmaWkxMDA1MglhZmlpMTAxMDAERXVybwlhZmlpMTAwNTgJYWZpaTEwMDU5CWFmaWkxMDA2MQlhZmlpMTAwNjAJYWZpaTEwMTQ1CWFmaWkxMDA5OQlhZmlpMTAxMDYJYWZpaTEwMTA3CWFmaWkxMDEwOQlhZmlpMTAxMDgJYWZpaTEwMTkzCWFmaWkxMDA2MglhZmlpMTAxMTAJYWZpaTEwMDU3CWFmaWkxMDA1MAlhZmlpMTAwMjMJYWZpaTEwMDUzB3VuaTAwQUQJYWZpaTEwMDU2CWFmaWkxMDA1NQlhZmlpMTAxMDMJYWZpaTEwMDk4DnBlcmlvZGNlbnRlcmVkCWFmaWkxMDA3MQlhZmlpNjEzNTIJYWZpaTEwMTAxCWFmaWkxMDEwNQlhZmlpMTAwNTQJYWZpaTEwMTAyCWFmaWkxMDEwNAlhZmlpMTAwMTcJYWZpaTEwMDE4CWFmaWkxMDAxOQlhZmlpMTAwMjAJYWZpaTEwMDIxCWFmaWkxMDAyMglhZmlpMTAwMjQJYWZpaTEwMDI1CWFmaWkxMDAyNglhZmlpMTAwMjcJYWZpaTEwMDI4CWFmaWkxMDAyOQlhZmlpMTAwMzAJYWZpaTEwMDMxCWFmaWkxMDAzMglhZmlpMTAwMzMJYWZpaTEwMDM0CWFmaWkxMDAzNQlhZmlpMTAwMzYJYWZpaTEwMDM3CWFmaWkxMDAzOAlhZmlpMTAwMzkJYWZpaTEwMDQwCWFmaWkxMDA0MQlhZmlpMTAwNDIJYWZpaTEwMDQzCWFmaWkxMDA0NAlhZmlpMTAwNDUJYWZpaTEwMDQ2CWFmaWkxMDA0NwlhZmlpMTAwNDgJYWZpaTEwMDQ5CWFmaWkxMDA2NQlhZmlpMTAwNjYJYWZpaTEwMDY3CWFmaWkxMDA2OAlhZmlpMTAwNjkJYWZpaTEwMDcwCWFmaWkxMDA3MglhZmlpMTAwNzMJYWZpaTEwMDc0CWFmaWkxMDA3NQlhZmlpMTAwNzYJYWZpaTEwMDc3CWFmaWkxMDA3OAlhZmlpMTAwNzkJYWZpaTEwMDgwCWFmaWkxMDA4MQlhZmlpMTAwODIJYWZpaTEwMDgzCWFmaWkxMDA4NAlhZmlpMTAwODUJYWZpaTEwMDg2CWFmaWkxMDA4NwlhZmlpMTAwODgJYWZpaTEwMDg5CWFmaWkxMDA5MAlhZmlpMTAwOTEJYWZpaTEwMDkyCWFmaWkxMDA5MwlhZmlpMTAwOTQJYWZpaTEwMDk1CWFmaWkxMDA5NglhZmlpMTAwOTcNYWZpaTEwMDQ1LjAwMQ1hZmlpMTAwNDcuMDAxAAAAAAAB//8AAA==";
      
	local SmallFont = RegisterFont(
		"SmallestPixel7", 
		400, 
		"normal", 
		{Id = "smallest-pixel7.ttf", Font = crypt.base64.decode(SmallFontBase64)}
	);

	local Minecraft = RegisterFont(
		"Minecraft", 
		400, 
		"normal", 
		{Id = "Minecraft.ttf", Font = crypt.base64.decode(MinecraftBase64)}
	);


	Fonts.SmallestPixel = SmallFont; 
	Fonts.Pixel = Minecraft;
	--

	--// Images
	local Images = {
		"Military PKM", "ArmorImage", "HotKeysImage", "ShadowImage", "OutlineShadowImage", "DropdownImage", "ColorwheelImage", "TransparencyImage", "LogoImage", "ModeratorImage",
		"Salvaged Skorpion", "Salvaged AK47", "Salvaged SMG", "Salvaged M14", "Salvaged Nailgun", "Salvaged AK74u", "Crossbow", "Wooden Bow", "Salvaged Python",
		"Salvaged Sniper", "Military M4A1", "Bruno's M4A1", "Military USP", "Salvaged Pump Action", "Military Barrett", "Salvaged Break Action",
		"Salvaged Pipe Rifle", "Salvaged Double Barrel", "Salvaged Shotgun", "Pumpkin Launcher", "Salvaged RPG", "Iron Shard Pickaxe", "Iron Shard Hatchet",
		"Stone Hatchet", "Stone Pickaxe", "Steel Axe", "Steel Pickaxe", "Wooden Spear", "Stone Spear", "Small Medkit", "Military Grenade",
		"Military Grenade Launcher", "PluginsImage", "SettingsImage", "MiscImage", "VisualsImage", "ESPImage", "CombatImage", "SkinsImage",
		"Mining Drill", "Chainsaw", "Salvaged P250", "HitmarkerImage"
	};

	for Index, Name in Images do
		if isfile(ImagesFolder.."/"..Name..".png") then 
			continue 
		end;

		RequestImage(Name)
		task.wait(0.1);
	end;
	--
end)()
--

Log("Loaded images and fonts")

local GetService = LPH_NO_VIRTUALIZE(function(Service)
	Service = game.GetService(game, Service)
	return cloneref(Service)
end);

local GetImage; do
	GetImage = LPH_NO_VIRTUALIZE(function(Name, Attempt)
		Attempt = Attempt or 1

		local FilePath = ImagesFolder.."/"..Name..".png"
		if isfile(FilePath) then 
			return getcustomasset(FilePath)
		elseif Attempt > 5 then
			return ""
		else
			RequestImage(Name)
			return GetImage(Name, Attempt + 1)
		end
	end);
end;

local HttpService       = GetService("HttpService")
local UserInputService  = GetService("UserInputService");
local Workspace         = GetService("Workspace");
local RunService        = GetService("RunService");
local TweenService      = GetService("TweenService");
local TextService       = GetService("TextService");
local Lighting          = GetService("Lighting");
local CoreGui           = GetService("CoreGui");
local ReplicatedStorage = GetService("ReplicatedStorage");
local Players           = GetService("Players");
local GuiService        = GetService("GuiService");
local TweenService      = GetService("TweenService");

local Camera = Workspace.CurrentCamera;
local Client = Players.LocalPlayer;
local MouseConstant = 30;
local Mouse = Client:GetMouse()

Log("Initializing tables")

local TrialModList = { 
	[4619800148] = "Trial Moderator", --//gobliniukss
	[113179883]  = "Trial Moderator", --// DopeIlI
	[1771300283] = "Trial Moderator"; --// severalracks
	[1077540175] = "Trial Moderator"; --// i3riefcase
	[3320377356] = "Trial Moderator"; --// Kriffith
	[3508020028] = "Trial Moderator"; ---.. SOLDIER
	[3122439095] = "Trial Moderator"; --// CHANCE LMFAO
	[3034556584] = "Trial Moderator"; -- Adam
	[886544546]  = "Trial Moderator";
	[1616925260] = "Trial Moderator";
	[165053216]  = "Trial Moderator";
	[1992294235] = "Trial Moderator";
	[971641336]  = "Trial Moderator";
};

Log("Initialized trial mod list")

local Library = {
	NotificationList = {},
	IsOpen = false;
	CategoryPause = 0.2,
	CategoryTransitionSpeed = 0.25,
	HighlightSpeed = 0.25,
	PageTransitionSpeed = 0.2,
	Windows = {},
	Flags = {},
	Font = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Medium),
	BoldFont = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Bold),
	ConfigPath = Name .. "/Config",
	CachePath = Name .. "/Cache",
	Connections = {},
	Keybinds = {
		MouseButton1 = "MB1",
		MouseButton2 = "MB2",
		MouseButton3 = "MB3",

		ButtonA = "A",
		ButtonB = "B",
		ButtonX = "X",
		ButtonY = "Y",
		ButtonStart = "STRT",
		ButtonSelect = "SELT",
		ButtonL1 = "L1",
		ButtonR1 = "R1",
		ButtonL2 = "L2",
		ButtonR2 = "R2",
		ButtonL3 = "L3",
		ButtonR3 = "R3",
		DPadUp = "DUP",
		DPadDown = "DDN",
		DPadLeft = "DLT",
		DPadRight = "DRT",

		W = "W",
		A = "A",
		S = "S",
		D = "D",
		Space = "SPC",
		LeftShift = "LSFT",
		RightShift = "RSFT",
		LeftControl = "LCTL",
		RightControl = "RCTL",
		LeftAlt = "LALT",
		RightAlt = "RALT",
		Enter = "ENT",
		Escape = "ESC",
		Backspace = "BS",
		Tab = "TAB",
		CapsLock = "CAPS",
		Insert = "INS",
		Delete = "DEL",
		Home = "HOME",
		EndKey = "END",
		PageUp = "PGUP",
		PageDown = "PGDN",
		Up = "UP",
		Down = "DN",
		Left = "LT",
		Right = "RT",

		Zero = "0",
		One = "1",
		Two = "2",
		Three = "3",
		Four = "4",
		Five = "5",
		Six = "6",
		Seven = "7",
		Eight = "8",
		Nine = "9",

		F1 = "F1",
		F2 = "F2",
		F3 = "F3",
		F4 = "F4",
		F5 = "F5",
		F6 = "F6",
		F7 = "F7",
		F8 = "F8",
		F9 = "F9",
		F10 = "F10",
		F11 = "F11",
		F12 = "F12",

		Minus = "-",
		Equals = "=",
		LeftBracket = "[",
		RightBracket = "]",
		Semicolon = ";",
		Quote = "'",
		Comma = ",",
		Period = ".",
		Slash = "/",
		Backslash = "\\",
		Grave = "`",
	},
	HotKeysImage = GetImage("HotkeysImage"),
	ShadowImage = GetImage("ShadowImage"), --"rbxassetid://6014261993",
	OutlineShadowImage = GetImage("OutlineShadowImage"), --"rbxassetid://93984335181980",
	DropdownImage = GetImage("DropdownImage"), --"rbxassetid://106970154099045",
	ColorwheelImage = GetImage("ColorwheelImage"),--"rbxassetid://6042338876",
	TransparencyImage = GetImage("TransparencyImage"),--"rbxassetid://96978989117558",
	LogoImage = GetImage("LogoImage"), --"http://www.roblox.com/asset/?id=71404918936585";
	ModeratorImage = GetImage("ModeratorImage"),
	ArmorImage = GetImage("ArmorImage"),
};

Log("Initialized Library tables")

local Theme = {
	Accent = Color3.fromRGB(63, 201, 176), -- 0, 189, 255
	DarkAccent = Color3.fromRGB(63, 201, 176), -- 0, 157, 209
	AccentedHighlight = Color3.fromRGB(63, 201, 176), -- 0, 89, 118
};

Log("Initialized theme")

local Threads = {
	Render = {},
	Entities = {},
	Character = {},
	Input = {},
};

Log("Initialized thread table")

local EntityClass = {
	Main = {
		Cache = {},
		Functions = {},
	},

	Misc = {
		Cache = {},
		Functions = {},
	},

	Global = {},
	Flags = {},

	AnimationSpeed = 0.15,
	WeaponImages = {
		["Salvaged Skorpion"] = GetImage("Salvaged Skorpion");
		["Salvaged P250"]     = GetImage("Salvaged P250");
		["Salvaged Python"]   = GetImage("Salvaged Python");
		["Salvaged AK47"]     = GetImage("Salvaged AK47");
		["Salvaged AK74u"]    = GetImage("Salvaged AK74u");
		["Wooden Bow"]        = GetImage("Wooden Bow");
		["Nail Gun"]  = GetImage("Salvaged Nailgun");
		["Salvaged SMG"]      = GetImage("Salvaged SMG");
		["Crossbow"]          = GetImage("Crossbow");
		["Salvaged M14"]      = GetImage("Salvaged M14");

		["Salvaged Sniper"]   = GetImage("Salvaged Sniper");
		["Military M4A1"]     = GetImage("Military M4A1");
		["Bruno's M4A1"]      = GetImage("Bruno's M4A1");
		["Military USP"]      = GetImage("Military USP");
		["Salvaged Pump Action"]    = GetImage("Salvaged Pump Action");
		["Military Barrett"]        = GetImage("Military Barrett");
		["Military PKM"]        = GetImage("Military PKM");
		["Salvaged Break Action"]   = GetImage("Salvaged Break Action");
		["Salvaged Pipe Rifle"]     = GetImage("Salvaged Pipe Rifle");
		["Salvaged Double Barrel"]  = GetImage("Salvaged Double Barrel");
		["Salvaged Shotgun"]        = GetImage("Salvaged Shotgun");
		["Pumpkin Launcher"]        = GetImage("Pumpkin Launcher");
		["Salvaged RPG"]            = GetImage("Salvaged RPG");

		["Steel Axe"]           = GetImage("Steel Axe");
		["Steel Pickaxe"]           = GetImage("Steel Pickaxe");
		["Wooden Spear"]            = GetImage("Wooden Spear");
		["Stone Spear"]             = GetImage("Stone Spear");
		["Small Medkit"]                  = GetImage("Small Medkit");
		["Military Grenade"]        = GetImage("Military Grenade");
		["Military Grenade Launcher"]        = GetImage("Military Grenade Launcher");

		["Chainsaw"] = GetImage("Chainsaw"),
		["Mining Drill"] = GetImage("Mining Drill")
	};

	ItemList = { 
		"Bandage",
		"Blueprint",
		"Wooden External Wall",
		"Stone External Wall",
		"Barricade",
		"Care Package Signal",
		"Salvaged Skorpion",
		"Salvaged P250",
		"Salvaged AK47",
		"Salvaged Python",
		"Salvaged AK74u",
		"Wooden Bow",
		"Nail Gun",
		"Salvaged SMG",
		"Crossbow",
		"Salvaged M14",
		"Salvaged Sniper",
		"Military M4A1",
		"Bruno's M4A1",
		"Military USP",
		"Salvaged Pump Action",
		"Military Barrett",
		"Military PKM",
		"Salvaged Break Action",
		"Salvaged Pipe Rifle",
		"Salvaged Double Barrel",
		"Salvaged Shotgun",
		"Pumpkin Launcher",
		"Salvaged RPG",

		"Iron Shard Pickaxe",
		"Iron Shard Hatchet",
		"Stone Hatchet",
		"Stone Pickaxe",
		"Steel Axe",
		"Steel Pickaxe",
		"Wooden Spear",
		"Stone Spear",
		"Small Medkit",
		"Military Grenade",
		"Military Grenade Launcher",

		"Chainsaw",
		"Mining Drill"
	};

	OffscreenImages = { 
		["GlowingArrow"] = "";
		["GlowingArc"] = "";
		["Arc"] = "";
		["Arrow"] = "";
		["OpaqueArrow"] = "";
	};

	IgnoreNames = {
		["HumanoidRootPart"] = true
	},
	Font = Fonts.Pixel,--Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold);
	FontSize = 10.00;
};

Log("Initialized EntityClass object")

local Math = {};
local Visuals = {};
local Globals = {};


Log("Initialized tables")

--#region Globals
Globals.LastArmorCheck = tick()
Globals.ArmorIds = {};
Globals.ArmorNames = {};
Globals.FlaggedStaff = {};
Globals.QuickStackFunctions = {};

Globals.ApplyTextStroke = LPH_NO_VIRTUALIZE(function(Object)
      local NewStroke = Globals:Instance("UIStroke", {
            Parent = Object,
            Thickness = 1,
            Color = Color3.fromRGB(),
      })
      return NewStroke
end);

Globals.DeepCopy = LPH_NO_VIRTUALIZE(function(Table) 
      local Copy = {}
      for k, v in pairs(Table) do
            if type(v) == 'table' then
                  Copy[k] = Globals.DeepCopy(v)
            else
                  Copy[k] = v
            end
      end
      return Copy
end);

function Globals:TweenTransparencyIns(container, targetTransparency, duration)
      duration = duration or 0.2
      for _, obj in ipairs(container:GetDescendants()) do
            if obj:IsA("GuiObject") then
                  local props = {}

                  if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                        props.TextTransparency = targetTransparency
                  end

                  if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
                        props.ImageTransparency = targetTransparency
                  end

                  if obj.BackgroundTransparency ~= nil then
                        props.BackgroundTransparency = targetTransparency
                  end

                  Globals:Tween(obj, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
            end

            if obj:IsA("UIStroke") then
                  Globals:Tween(obj, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = targetTransparency,
                  })
            end
      end

      if container:IsA("GuiObject") then
            Globals:Tween(container, TweenInfo.new(duration, Enum.EasingStyle.Quad), {
                  BackgroundTransparency = targetTransparency,
            })
      end
end

function Globals:Tween(...)
      local NewTween = TweenService:Create(...)
      NewTween:Play()
      return NewTween
end

function Globals:Instance(Class, Properties)
      local Element = Instance.new(Class)

      for Key, Value in Properties do 
            Element[Key] = Value
      end

      return Element
end

function Globals:Tween(...)
      local Tween = TweenService:Create(...)
      Tween:Play()
      return Tween
end;

if ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("Items") then 
      local Items = Globals.DeepCopy(require(ReplicatedStorage.Modules.Items));
      for Index, ItemData in Items do 
            if ItemData.Type == "Armor" then 
                  Globals.ArmorIds[Index] = {
                        Name = ItemData.Name,
                  };
            end;
      end;
      Globals.ItemInfoTable = Items
end;


Log("Loaded globals library")
--#endregion Globals

--#region Library
Library.Theme = Theme
Library.__index = Library

Library.Notifications = Globals:Instance("ScreenGui", { 
      Parent = CoreGui, 
      DisplayOrder = 1,
      IgnoreGuiInset = true,
})

Library.HeadsUp = Globals:Instance("ScreenGui", { 
      Parent = CoreGui, 
      DisplayOrder = 1,
      IgnoreGuiInset = true,
      Enabled = true
})

LPH_NO_VIRTUALIZE(function() --// Functions that arent needing to be protected
      function Library:Connection(Name, Signal, Function)
            local Connection = Signal:Connect(Function)

            self.Connections[Name] = {
                  Signal = Signal,
                  Function = Function,
                  Connection = Connection,
            }

            return self.Connections[Name]
      end

      function Library:Disconnect(Name)
            local Conn = self.Connections[Name]
            if Conn then
                  Conn.Connection:Disconnect()
                  self.Connections[Name] = nil
            end
      end

      function Library:DisconnectAll()
            for Name, Conn in pairs(self.Connections) do
                  Conn.Connection:Disconnect()
            end
            table.clear(self.Connections)
      end

      function Library:DoCallback(Callback, Data)

            local Success, Error = pcall(Callback, Data)
            if not Success and Error then
                  return "Failed", Error
            end
            return Success
      end

      function Library:FormatValue(incr, val)
            if incr < 1 then
                  return string.format("%.2f", val)
            else
                  return tostring(math.floor(val + 0.5))
            end
      end

      function Library:GetInputName(input)
            if input and input.UserInputType then
                  if input.UserInputType == Enum.UserInputType.Keyboard then
                        return input.KeyCode.Name
                  elseif input.UserInputType.Name:match("Mouse") then
                        return input.UserInputType.Name
                  else
                        return "Unknown"
                  end
            end
      end

      function Library:FormatKeyName(name)
            if Library.Keybinds[name] then
                  return Library.Keybinds[name]
            elseif #name > 4 then
                  return name:sub(1, 4)
            end
            return name
      end

      function Library:GetConfig() 
            local Flags = self.Flags

            local Save = {}
            for Flag, Data in Flags do
                  local Class = Data.Class
                  local Value = Data.Value

                  if Class == 'Toggle' then
                        Save[Flag] = Value
                  end

                  if Class == 'Colorpicker' then
                        Save[Flag] = {
                              [1] = { Value[1].R, Value[1].G, Value[1].B },
                              [2] = Value[2],
                        }
                  end

                  if Class == 'Slider' then
                        Save[Flag] = Value
                  end

                  if Class == 'TextBox' then
                        Save[Flag] = Value
                  end

                  if Class == 'Dropdown' then
                        Save[Flag] = Value
                  end

                  if Class == 'Keybind' then
                        if Data.Key then 
                              local Key = {
                                    Type = Data.Key.Type,
                                    Value = Data.Key.Value.Name,
                              };

                              Save[Flag] = Key
                        end;
                  end;
            end;

            return HttpService:JSONEncode(Save);
      end;

      function Library:SaveConfig(Name) 
            local CurrentConfig = Library:GetConfig();

            writefile(ConfigsFolder.."/"..Name..".json", CurrentConfig)
      end

      function Library:LoadConfig(Name) 
            local FilePath = ConfigsFolder.."/"..Name..".json";

            if not isfile(FilePath) then 
                  Library:Notify("Configuration failed to load\nFile, "..FilePath.. " does not exist!", 4, Color3.fromRGB(255, 0, 0));
                  return
            end;

            local Config = readfile(FilePath); 
            local DecodedConfig = HttpService:JSONDecode(Config); 

            for Flag, FlagData in DecodedConfig do 
                  local RealFlag = Library.Flags[Flag];

                  if not RealFlag then
                        continue
                  end; 

                  if RealFlag.Class == "Colorpicker" then 
                        local Color = Color3.new(FlagData[1][1], FlagData[1][2], FlagData[1][3])
                        task.spawn(function()  
                              RealFlag:Set({
                                    Color,
                                    FlagData[2];
                              })
                        end);

                        continue;
                  end;

                  if RealFlag.Class == "Keybind" then 
                        task.spawn(function()
                              local KeyData = FlagData

                              local input = {}

                              if KeyData.Type == "MouseButton" then
                                    input.UserInputType = Enum.UserInputType[KeyData.Value]
                              elseif KeyData.Type == "KeyCode" then
                                    input.UserInputType = Enum.UserInputType.Keyboard
                                    input.KeyCode = Enum.KeyCode[KeyData.Value]
                              else
                                    input.UserInputType = Enum.UserInputType[KeyData.Value]
                              end

                              RealFlag:SetKey(input)
                        end)
                        continue
                  end


                  task.spawn(function() 
                        RealFlag:Set(FlagData);
                  end);
            end;
      end;
end)()

LPH_NO_VIRTUALIZE(function() --// Not that important 
      function Library:CreateHotkeysPanel()
            local Hotkeys = {
                  Keys = 0,
            }

            local Components = {}

            Hotkeys.__index = Hotkeys

            Components["Hotkeys"] = Globals:Instance("Frame", {
                  BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 20, 0.5, 0),
                  Size = UDim2.new(0, 215, 0, 30),
                  Name = "Hotkeys",
                  Parent = Library.HeadsUp,
                  Visible = false,
            })

            Components["HotkeysCorner"] = Globals:Instance("UICorner", {
                  CornerRadius = UDim.new(0, 4),
                  Name = "HotkeysCorner",
                  Parent = Components["Hotkeys"],
            })

            Components["HotkeysStroke"] = Globals:Instance("UIStroke", {
                  Color = Color3.fromRGB(24, 24, 24),
                  Name = "HotkeysStroke",
                  Parent = Components["Hotkeys"],
            })

            Components["HotkeysTitleArea"] = Globals:Instance("Frame", {
                  BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Size = UDim2.new(1, 0, 0, 25),
                  Name = "HotkeysTitleArea",
                  Parent = Components["Hotkeys"],
            })

            Components["HotkeysTitleCorner"] = Globals:Instance("UICorner", {
                  CornerRadius = UDim.new(0, 4),
                  Name = "HotkeysTitleCorner",
                  Parent = Components["HotkeysTitleArea"],
            })

            Components["HotkeysTitlestroke"] = Globals:Instance("UIStroke", {
                  Color = Color3.fromRGB(24, 24, 24),
                  Name = "HotkeysTitlestroke",
                  Parent = Components["HotkeysTitleArea"],
            })

            Components["HotkeysTitle"] = Globals:Instance("TextLabel", {
                  Font = Enum.Font.SourceSansSemibold,
                  Text = "Hotkeys",
                  TextColor3 = Color3.fromRGB(255, 255, 255),
                  TextSize = 14,
                  TextXAlignment = Enum.TextXAlignment.Left,
                  BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                  BackgroundTransparency = 1,
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 35, 0, 0),
                  Size = UDim2.new(1, -35, 1, 0),
                  Name = "HotkeysTitle",
                  Parent = Components["HotkeysTitleArea"],
            })

            Components["HotkeysImage"] = Globals:Instance("ImageLabel", {
                  Image = Library.HotKeysImage,
                  AnchorPoint = Vector2.new(0, 0.5),
                  BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                  BackgroundTransparency = 1,
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 5, 0.5, 0),
                  Size = UDim2.new(0.0116279069, 20, 1, -5),
                  Name = "HotkeysImage",
                  Parent = Components["HotkeysTitleArea"],
            })

            Components["HotkeysActive"] = Globals:Instance("Frame", {
                  BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                  BackgroundTransparency = 1,
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 10, 0, 30),
                  Size = UDim2.new(1, -10, 0, 33),
                  Name = "HotkeysActive",
                  Parent = Components["Hotkeys"],
            })

            Components["UIListLayout"] = Globals:Instance("UIListLayout", {
                  Padding = UDim.new(0, 5),
                  SortOrder = Enum.SortOrder.LayoutOrder,
                  Parent = Components["HotkeysActive"],
            })

            Components["HotkeysShadowHolder"] = Globals:Instance("Frame", {
                  BackgroundTransparency = 1,
                  BorderSizePixel = 0,
                  Size = UDim2.new(1, 0, 1, 0),
                  ZIndex = 0,
                  Name = "HotkeysShadowHolder",
                  Parent = Components["Hotkeys"],
            })

            Components["HotkeysShadow"] = Globals:Instance("ImageLabel", {
                  Image = Library.ShadowImage,
                  ImageColor3 = Color3.fromRGB(0, 0, 0),
                  ScaleType = Enum.ScaleType.Slice,
                  SliceCenter = Rect.new(49, 49, 450, 450),
                  AnchorPoint = Vector2.new(0.5, 0.5),
                  BackgroundTransparency = 1,
                  ImageTransparency = 0.8,
                  BorderSizePixel = 0,
                  Position = UDim2.new(0.5, 0, 0.5, 0),
                  Size = UDim2.new(1, 47, 1, 47),
                  ZIndex = 0,
                  Name = "HotkeysShadow",
                  Parent = Components["HotkeysShadowHolder"],
            })

            Hotkeys.Components = Components

            function Hotkeys:Add(Name, Key)
                  self.Keys += 1
                  Globals:Tween(self.Components.HotkeysShadow, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        ImageTransparency = self.Keys > 0 and 0 or 0.8,
                  })

                  local Hotkey = {}

                  Hotkey["Container"] = Globals:Instance("Frame", {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 14),
                        Name = Name,
                        Parent = Components["HotkeysActive"],
                  })

                  Hotkey["NameLabel"] = Globals:Instance("TextLabel", {
                        Font = Enum.Font.SourceSansSemibold,
                        Text = Name,
                        TextColor3 = Color3.fromRGB(150, 150, 150),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0.5, 0, 1, 0),
                        Position = UDim2.new(0, 0, 0, 0),
                        Name = "NameLabel",
                        Parent = Hotkey.Container,
                  })

                  Hotkey["KeyLabel"] = Globals:Instance("TextLabel", {
                        Font = Enum.Font.SourceSansSemibold,
                        Text = "["..tostring(Key).."]",
                        TextColor3 = Color3.fromRGB(150, 150, 150),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Right,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0.5, -5, 1, 0),
                        Position = UDim2.new(0.5, -3, 0, 0),
                        Name = "KeyLabel",
                        Parent = Hotkey.Container,
                  })

                  Globals:Tween(self.Components.Hotkeys, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        Size = UDim2.new(0, 215, 0, 45) + UDim2.new(0, 0, 0, self.Keys * 17),
                  })
                  --Size = UDim2.new(0, 215, 0, 45) + UDim2.new(0, 0, 0, self.Keys * 17),
            end

            function Hotkeys:UpdateStatus(Name, On, Key, Destroy)
                  local Container = self.Components["HotkeysActive"]:FindFirstChild(Name)
                  if Container then
                        if Key and Key ~= "" then
                              Container.KeyLabel.Text = "["..tostring(Key).."]"
                        end

                        local targetColor = On and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
                        Globals:Tween(Container.NameLabel, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                              TextColor3 = targetColor,
                        })
                        Globals:Tween(Container.KeyLabel, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                              TextColor3 = targetColor,
                        })

                        if Destroy then
                              self.Keys -= 1
                              Container:Destroy()

                              Globals:Tween(
                                    self.Components.Hotkeys,
                                    TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                    {
                                          Size = UDim2.new(0, 215, 0, 45) + UDim2.new(0, 0, 0, self.Keys * 17),
                                    }
                              )
                        end
                  else
                        if Key ~= "" then
                              self:Add(Name, Key)
                        end
                  end

                  Globals:Tween(self.Components.HotkeysShadow, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        ImageTransparency = self.Keys > 0 and 0 or 0.8,
                  })
            end

            return Hotkeys
      end;

      function Library:CreateModeratorsPanel()
            local Moderators = {
                  Count = 0,
            }

            local Components = {}

            Moderators.__index = Moderators

            Components["Moderators"] = Globals:Instance("Frame", {
                  BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 20, 0.5, 200),
                  Size = UDim2.new(0, 215, 0, 30),
                  Name = "Moderators",
                  Parent = Library.HeadsUp,
                  Visible = true,
            })

            Components["ModeratorsCorner"] = Globals:Instance("UICorner", {
                  CornerRadius = UDim.new(0, 4),
                  Name = "ModeratorsCorner",
                  Parent = Components["Moderators"],
            })

            Components["ModeratorsStroke"] = Globals:Instance("UIStroke", {
                  Color = Color3.fromRGB(24, 24, 24),
                  Name = "ModeratorsStroke",
                  Parent = Components["Moderators"],
            })

            Components["ModeratorsTitleArea"] = Globals:Instance("Frame", {
                  BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Size = UDim2.new(1, 0, 0, 25),
                  Name = "ModeratorsTitleArea",
                  Parent = Components["Moderators"],
            })

            Components["ModeratorsTitleCorner"] = Globals:Instance("UICorner", {
                  CornerRadius = UDim.new(0, 4),
                  Name = "ModeratorsTitleCorner",
                  Parent = Components["ModeratorsTitleArea"],
            })

            Components["ModeratorsTitlestroke"] = Globals:Instance("UIStroke", {
                  Color = Color3.fromRGB(24, 24, 24),
                  Name = "ModeratorsTitlestroke",
                  Parent = Components["ModeratorsTitleArea"],
            })

            Components["ModeratorsTitle"] = Globals:Instance("TextLabel", {
                  Font = Enum.Font.SourceSansSemibold,
                  Text = "Moderators",
                  TextColor3 = Color3.fromRGB(255, 255, 255),
                  TextSize = 14,
                  TextXAlignment = Enum.TextXAlignment.Left,
                  BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                  BackgroundTransparency = 1,
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 25, 0, 0),
                  Size = UDim2.new(1, -35, 1, 0),
                  Name = "ModeratorsTitle",
                  Parent = Components["ModeratorsTitleArea"],
            })

            Components["ModeratorsImage"] = Globals:Instance("ImageLabel", {
                  Image = Library.ModeratorImage,
                  AnchorPoint = Vector2.new(0, 0.5),
                  BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                  BackgroundTransparency = 1,
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 5, 0.5, 0),
                  Size = UDim2.new(0, 15, 1, -10),
                  Name = "ModeratorsImage",
                  Parent = Components["ModeratorsTitleArea"],
            })

            Components["ModeratorsList"] = Globals:Instance("Frame", {
                  BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                  BackgroundTransparency = 1,
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 10, 0, 30),
                  Size = UDim2.new(1, -10, 0, 33),
                  Name = "ModeratorsList",
                  Parent = Components["Moderators"],
            })

            Components["UIListLayout"] = Globals:Instance("UIListLayout", {
                  Padding = UDim.new(0, 5),
                  SortOrder = Enum.SortOrder.LayoutOrder,
                  Parent = Components["ModeratorsList"],
            })

            Components["ModeratorsShadowHolder"] = Globals:Instance("Frame", {
                  BackgroundTransparency = 1,
                  BorderSizePixel = 0,
                  Size = UDim2.new(1, 0, 1, 0),
                  ZIndex = 0,
                  Name = "ModeratorsShadowHolder",
                  Parent = Components["Moderators"],
            })

            Components["ModeratorsShadow"] = Globals:Instance("ImageLabel", {
                  Image = Library.ShadowImage,
                  ImageColor3 = Color3.fromRGB(0, 0, 0),
                  ScaleType = Enum.ScaleType.Slice,
                  SliceCenter = Rect.new(49, 49, 450, 450),
                  AnchorPoint = Vector2.new(0.5, 0.5),
                  BackgroundTransparency = 1,
                  ImageTransparency = 0.8,
                  BorderSizePixel = 0,
                  Position = UDim2.new(0.5, 0, 0.5, 0),
                  Size = UDim2.new(1, 47, 1, 47),
                  ZIndex = 0,
                  Name = "ModeratorsShadow",
                  Parent = Components["ModeratorsShadowHolder"],
            })

            Moderators.Components = Components

            function Moderators:Add(Name, Role)
                  self.Count += 1

                  Globals:Tween(self.Components.ModeratorsShadow, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        ImageTransparency = self.Count > 0 and 0 or 0.8,
                  })

                  local Moderator = {}

                  Moderator["Container"] = Globals:Instance("Frame", {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 14),
                        Name = Name,
                        Parent = Components["ModeratorsList"],
                  })

                  Moderator["NameLabel"] = Globals:Instance("TextLabel", {
                        Font = Enum.Font.SourceSansSemibold,
                        Text = Name,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0.5, 0, 1, 0),
                        Position = UDim2.new(0, 0, 0, 0),
                        Name = "NameLabel",
                        Parent = Moderator.Container,
                  })

                  Moderator["RoleLabel"] = Globals:Instance("TextLabel", {
                        Font = Enum.Font.SourceSansSemibold,
                        Text = Role,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Right,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0.5, -5, 1, 0),
                        Position = UDim2.new(0.5, -3, 0, 0),
                        Name = "RoleLabel",
                        Parent = Moderator.Container,
                  })

                  Globals:Tween(self.Components.Moderators, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        Size = UDim2.new(0, 215, 0, 30) + UDim2.new(0, 0, 0, self.Count * 19),
                  })
            end

            function Moderators:UpdateModerator(Name, Role, Remove)
                  local Container = self.Components["ModeratorsList"]:FindFirstChild(Name)

                  if Container then
                        if Role then
                              Container.RoleLabel.Text = Role
                        end

                        if Remove then
                              self.Count -= 1
                              Container:Destroy()

                              Globals:Tween(
                                    self.Components.Moderators,
                                    TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                    {
                                          Size = UDim2.new(0, 215, 0, 30) + UDim2.new(0, 0, 0, self.Count * 19),
                                    }
                              )
                        end
                  else
                        if Name and Role then
                              self:Add(Name, Role)
                        end
                  end

                  Globals:Tween(self.Components.ModeratorsShadow, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        ImageTransparency = self.Count > 0 and 0 or 0.8,
                  })
            end

            function Moderators:ClearAll()
                  for _, child in ipairs(self.Components["ModeratorsList"]:GetChildren()) do
                        if child:IsA("TextLabel") then
                              child:Destroy()
                        end
                  end
                  self.Count = 0

                  Globals:Tween(self.Components.Moderators, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        Size = UDim2.new(0, 215, 0, 45),
                  })

                  Globals:Tween(self.Components.ModeratorsShadow, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        ImageTransparency = 0.8,
                  })
            end

            return Moderators
      end;

      function Library:CreateArmorPanel()
            local Armor = {
                  Count = 0,
            }

            local Components = {}

            Armor.__index = Armor

            Components["Armor"] = Globals:Instance("Frame", {
                  BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(1, -245, 0.5, 0),
                  Size = UDim2.new(0, 215, 0, 30),
                  Name = "Armor",
                  Parent = Library.HeadsUp,
                  Visible = true,
                  ClipsDescendants = true,
            })

            Components["ArmorCorner"] = Globals:Instance("UICorner", {
                  CornerRadius = UDim.new(0, 4),
                  Name = "ArmorCorner",
                  Parent = Components["Armor"],
            })

            Components["ArmorStroke"] = Globals:Instance("UIStroke", {
                  Color = Color3.fromRGB(24, 24, 24),
                  Name = "ArmorStroke",
                  Parent = Components["Armor"],
            })

            Components["ArmorTitleArea"] = Globals:Instance("Frame", {
                  BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Size = UDim2.new(1, 0, 0, 25),
                  Name = "ArmorTitleArea",
                  Parent = Components["Armor"],
            })

            Components["ArmorTitleCorner"] = Globals:Instance("UICorner", {
                  CornerRadius = UDim.new(0, 4),
                  Name = "ArmorTitleCorner",
                  Parent = Components["ArmorTitleArea"],
            })

            Components["ArmorTitlestroke"] = Globals:Instance("UIStroke", {
                  Color = Color3.fromRGB(24, 24, 24),
                  Name = "ArmorTitlestroke",
                  Parent = Components["ArmorTitleArea"],
            })

            Components["ArmorTitle"] = Globals:Instance("TextLabel", {
                  Font = Enum.Font.SourceSansSemibold,
                  Text = "Armor Viewer",
                  TextColor3 = Color3.fromRGB(255, 255, 255),
                  TextSize = 14,
                  TextXAlignment = Enum.TextXAlignment.Left,
                  BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                  BackgroundTransparency = 1,
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 25, 0, 0),
                  Size = UDim2.new(1, -35, 1, 0),
                  Name = "ArmorTitle",
                  Parent = Components["ArmorTitleArea"],
            })

            Components["ArmorImage"] = Globals:Instance("ImageLabel", {
                  Image = Library.ArmorImage,
                  AnchorPoint = Vector2.new(0, 0.5),
                  BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                  BackgroundTransparency = 1,
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 5, 0.5, 0),
                  Size = UDim2.new(0, 15, 1, -10),
                  Name = "ArmorImage",
                  Parent = Components["ArmorTitleArea"],
            })

            Components["ArmorList"] = Globals:Instance("Frame", {
                  BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                  BackgroundTransparency = 1,
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 10, 0, 30),
                  Size = UDim2.new(1, -10, 0, 33),
                  Name = "ArmorList",
                  Parent = Components["Armor"],
                  AutomaticSize = Enum.AutomaticSize.Y,
                  -- ClipsDescendants = true,
            })

            Components["UIListLayout"] = Globals:Instance("UIListLayout", {
                  Padding = UDim.new(0, 5),
                  SortOrder = Enum.SortOrder.LayoutOrder,
                  Parent = Components["ArmorList"],
            })

            Components["ArmorShadowHolder"] = Globals:Instance("Frame", {
                  BackgroundTransparency = 1,
                  BorderSizePixel = 0,
                  Size = UDim2.new(1, 0, 1, 0),
                  ZIndex = 0,
                  Name = "ArmorShadowHolder",
                  Parent = Components["Armor"],
            })

            Components["ArmorShadow"] = Globals:Instance("ImageLabel", {
                  Image = Library.ShadowImage,
                  ImageColor3 = Color3.fromRGB(0, 0, 0),
                  ScaleType = Enum.ScaleType.Slice,
                  SliceCenter = Rect.new(49, 49, 450, 450),
                  AnchorPoint = Vector2.new(0.5, 0.5),
                  BackgroundTransparency = 1,
                  ImageTransparency = 0.8,
                  BorderSizePixel = 0,
                  Position = UDim2.new(0.5, 0, 0.5, 0),
                  Size = UDim2.new(1, 47, 1, 47),
                  ZIndex = 0,
                  Name = "ArmorShadow",
                  Parent = Components["ArmorShadowHolder"],
            })

            Armor.Components = Components

            function Armor:Add(ArmorName, ArmorSkin)
                  if not self.Components.ArmorList:FindFirstChild(ArmorName.."_"..ArmorSkin) then 
                        self.Count += 1

                        Globals:Tween(self.Components.ArmorShadow, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                              ImageTransparency = self.Count > 0 and 0 or 0.8,
                        })

                        local ArmorEntry = {}

                        ArmorEntry["Container"] = Globals:Instance("Frame", {
                              BackgroundTransparency = 1,
                              Size = UDim2.new(1, 0, 0, 14),
                              Name = ArmorName.."_"..ArmorSkin,
                              Parent = Components["ArmorList"],
                        })

                        ArmorEntry.Container:SetAttribute("IsContainer", true)

                        ArmorEntry["PlayerLabel"] = Globals:Instance("TextLabel", {
                              Font = Enum.Font.SourceSansSemibold,
                              Text = ArmorName,
                              TextColor3 = Color3.fromRGB(255, 255, 255),
                              TextSize = 14,
                              TextXAlignment = Enum.TextXAlignment.Left,
                              BackgroundTransparency = 1,
                              Size = UDim2.new(0.5, 0, 1, 0),
                              Position = UDim2.new(0, 0, 0, 0),
                              Name = "PlayerLabel",
                              Parent = ArmorEntry.Container,
                        })

                        ArmorEntry["SkinLabel"] = Globals:Instance("TextLabel", {
                              Font = Enum.Font.SourceSansSemibold,
                              Text = ArmorSkin,
                              TextColor3 = Color3.fromRGB(255, 255, 255),
                              TextSize = 14,
                              TextXAlignment = Enum.TextXAlignment.Right,
                              BackgroundTransparency = 1,
                              Size = UDim2.new(0.5, -5, 1, 0),
                              Position = UDim2.new(0.5, -3, 0, 0),
                              Name = "SkinLabel",
                              Parent = ArmorEntry.Container,
                        })

                        Globals:Tween(self.Components.Armor, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                              Size = UDim2.new(0, 215, 0, 30) + UDim2.new(0, 0, 0, self.Count * 19),
                        });
                  end;
            end

            function Armor:UpdateArmor(ArmorName, ArmorSkin, Remove)
                  local Container = self.Components["ArmorList"]:FindFirstChild(ArmorName)

                  if Container then
                        if ArmorSkin then
                              Container.SkinLabel.Text = ArmorSkin
                        end

                        if Remove then
                              self.Count -= 1
                              Container:Destroy()

                              Globals:Tween(
                                    self.Components.Armor,
                                    TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                    {
                                          Size = UDim2.new(0, 215, 0, 30) + UDim2.new(0, 0, 0, self.Count * 19),
                                    }
                              )
                        end
                  else
                        if ArmorName and ArmorSkin then
                              self:Add(ArmorName, ArmorSkin)
                        end
                  end

                  Globals:Tween(self.Components.ArmorShadow, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        ImageTransparency = self.Count > 0 and 0 or 0.8,
                  })
            end

            function Armor:ClearAll()
                  for _, child in ipairs(self.Components["ArmorList"]:GetChildren()) do
                        if child:IsA("Frame") and child:GetAttribute("IsContainer") then
                              child:Destroy()
                        end
                  end
                  self.Count = 0

                  Globals:Tween(self.Components.Armor, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        Size = UDim2.new(0, 215, 0, 45),
                  })

                  Globals:Tween(self.Components.ArmorShadow, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        ImageTransparency = 0.8,
                  })
            end

            return Armor
      end;

      function Library:CreateWatermark(txt)
            local Components = {}

            Components["Watermark"] = Globals:Instance("Frame", {
                  BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 400, 0, 20),
                  Size = UDim2.new(0, 35, 0, 24),
                  Name = "Watermark",
                  Parent = Library.HeadsUp,
            })

            Components["WatermarkCorner"] = Globals:Instance("UICorner", {
                  CornerRadius = UDim.new(0, 4),
                  Name = "WatermarkCorner",
                  Parent = Components["Watermark"],
            })

            Components["WatermarkStroke"] = Globals:Instance("UIStroke", {
                  Color = Color3.fromRGB(24, 24, 24),
                  Name = "WatermarkStroke",
                  Parent = Components["Watermark"],
            })

            Components["WatermarkLogo"] = Globals:Instance("ImageLabel", {
                  Image = Library.LogoImage,
                  ImageColor3 = Library.Theme.Accent,
                  AnchorPoint = Vector2.new(0.5, 0.5),
                  BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                  BackgroundTransparency = 1,
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 13, 0.5, 0),
                  Size = UDim2.new(0, 25, 0, 25),
                  Name = "WatermarkLogo",
                  Parent = Components["Watermark"],
            })

            Components["WatermarkText"] = Globals:Instance("TextLabel", {
                  Font = Enum.Font.SourceSansSemibold,
                  Text = txt,
                  TextColor3 = Color3.fromRGB(255, 255, 255),
                  TextSize = 14,
                  AutomaticSize = Enum.AutomaticSize.X,
                  BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                  BackgroundTransparency = 1,
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 25, 0, 0),
                  Size = UDim2.new(0, 0, 1, 0),
                  Name = "WatermarkText",
                  Parent = Components["Watermark"],
            })

            Components["WatermarkShadowHolder"] = Globals:Instance("Frame", {
                  BackgroundTransparency = 1,
                  BorderSizePixel = 0,
                  Size = UDim2.new(1, 0, 1, 0),
                  ZIndex = 0,
                  Name = "WatermarkShadowHolder",
                  Parent = Components["Watermark"],
            })

            Components["WatermarkShadow"] = Globals:Instance("ImageLabel", {
                  Image = Library.ShadowImage,
                  ImageColor3 = Color3.fromRGB(0, 0, 0),
                  ImageTransparency = 0.5899999737739563,
                  ScaleType = Enum.ScaleType.Slice,
                  SliceCenter = Rect.new(49, 49, 450, 450),
                  AnchorPoint = Vector2.new(0.5, 0.5),
                  BackgroundTransparency = 1,
                  BorderSizePixel = 0,
                  Position = UDim2.new(0.505405426, 0, 0.501500428, 0),
                  Size = UDim2.new(0.935135126, 47, 0.5, 47),
                  ZIndex = 0,
                  Name = "WatermarkShadow",
                  Parent = Components["WatermarkShadowHolder"],
            })

            function Components:SetText(txt)
                  local label = Instance.new("TextLabel")
                  label.Text = txt
                  label.TextSize = 14
                  label.Font = Enum.Font.SourceSansSemibold
                  label.Position = UDim2.new(-5, 0, 0, 0)
                  label.Visible = true
                  label.Parent = Library.HeadsUp
                  task.wait(0.3)
                  Components["WatermarkText"].Text = ""

                  task.spawn(function()
                        for i = 1, #txt do
                              Components["WatermarkText"].Text = string.sub(txt, 1, i)
                              task.wait(0.03)
                        end
                  end)

                  local TextBounds = label.TextBounds
                  Globals:Tween(Components.Watermark, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                        Size = UDim2.new(0, 35 + TextBounds.X, 0, Components.Watermark.Size.Y.Offset),
                  })
            end
            return Components
      end

      function Library:CreateLoader(Data)
            local Loader = {
                  Expiry = Data.Expiry,
            }
            Loader.__index = Loader

            local Components = {}

            local SelectedGame = ""
            local SelectedType = ""

            do --// Components
                  Components["Loader"] = Globals:Instance("ScreenGui", {
                        IgnoreGuiInset = true,
                        Name = "Loader",
                        Parent = CoreGui,
                  })

                  Components["LoaderOutline"] = Globals:Instance("TextButton", {
                        Font = Enum.Font.SourceSans,
                        Text = "",
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        TextSize = 14,
                        AutoButtonColor = false,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.5, 0, 2, 0),
                        Size = UDim2.new(0, 400, 0, 329),
                        Name = "LoaderOutline",
                        Parent = Components["Loader"],
                  })

                  Components["LoaderUICorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Name = "LoaderUICorner",
                        Parent = Components["LoaderOutline"],
                  })

                  Components["LoaderUIStroke"] = Globals:Instance("UIStroke", {
                        Color = Color3.fromRGB(24, 24, 24),
                        Name = "LoaderUIStroke",
                        Parent = Components["LoaderOutline"],
                  })

                  Components["DropShadowHolder"] = Globals:Instance("Frame", {
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 1, 0),
                        Name = "DropShadowHolder",
                        Parent = Components["LoaderOutline"],
                  })

                  Components["DropShadow"] = Globals:Instance("ImageLabel", {
                        Image = Library.ShadowImage,
                        ImageColor3 = Color3.fromRGB(0, 0, 0),
                        ImageTransparency = 0.12,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(49, 49, 450, 450),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(1, 47, 1, 47),
                        ZIndex = 0,
                        Name = "DropShadow",
                        Parent = Components["DropShadowHolder"],
                  })

                  Components["LoaderTitleArea"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 30),
                        Name = "LoaderTitleArea",
                        Parent = Components["LoaderOutline"],
                  })

                  Components["LoaderTitleCorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Name = "LoaderTitleCorner",
                        Parent = Components["LoaderTitleArea"],
                  })

                  Components["LoaderTitleOutline"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(24, 24, 24),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 1, 0),
                        Size = UDim2.new(1, 0, 0, 1),
                        Name = "LoaderTitleOutline",
                        Parent = Components["LoaderTitleArea"],
                  })

                  Components["IridescentLogo"] = Globals:Instance("ImageLabel", {
                        Image = Library.LogoImage,
                        AnchorPoint = Vector2.new(0, 0.5),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 3, 0.5, 0),
                        Size = UDim2.new(0, 25, 0, 25),
                        Name = "IridescentLogo",
                        Parent = Components["LoaderTitleArea"],
                  })

                  Components["IridescentTitle"] = Globals:Instance("TextLabel", {
                        Font = Enum.Font.SourceSansBold,
                        Text = "Iridescent",
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 30, 0, 0),
                        Size = UDim2.new(0, 200, 1, 0),
                        Name = "IridescentTitle",
                        Parent = Components["LoaderTitleArea"],
                  })

                  Components["Workspace"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 20, 0, 50),
                        Size = UDim2.new(1, -40, 1, -70),
                        Name = "Workspace",
                        Parent = Components["LoaderOutline"],
                  })

                  Components["WorkspaceHider"] = Components["Workspace"]:Clone()
                  Components["WorkspaceHider"].Parent = Components["LoaderOutline"]
                  Components["WorkspaceHider"].Size = UDim2.new(1, 0, 1, -30)
                  Components["WorkspaceHider"].AnchorPoint = Vector2.new(0, 0)
                  Components["WorkspaceHider"].Position = UDim2.new(0, 0, 0, 30)
                  Components.WorkspaceHider.Name = "WorkspaceHider"
                  Components.WorkspaceHider.ZIndex = 10
                  Components.WorkspaceHider.BackgroundColor3 = Color3.fromRGB(11, 11, 11)

                  Components["Products"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, -5, 0, 0),
                        Size = UDim2.new(0, 175, 1, 0),
                        Name = "Products",
                        Parent = Components["Workspace"],
                  })

                  Components["ProductsLayout"] = Globals:Instance("UIListLayout", {
                        Padding = UDim.new(0, 10),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Name = "ProductsLayout",
                        Parent = Components["Products"],
                  })

                  Components["GameStatus1"] = Globals:Instance("Frame", {
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 191, 0, 0),
                        Size = UDim2.new(0, 175, 1, 0),
                        Name = "GameStatus",
                        Parent = Components["Workspace"],
                  })

                  Components["GameImageArea"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 125),
                        Name = "GameImageArea",
                        Parent = Components["GameStatus1"],
                  })

                  Components["GameImageAreaCorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Parent = Components["GameImageArea"],
                  })

                  Components["GameImageAreaStroke"] = Globals:Instance("UIStroke", {
                        Color = Color3.fromRGB(24, 24, 24),
                        Parent = Components["GameImageArea"],
                  })

                  Components["GameImage1"] = Globals:Instance("ImageLabel", {
                        Image = "",
                        ImageTransparency = 0.4,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(1, -10, 1, -10),
                        Name = "GameImage",
                        Parent = Components["GameImageArea"],
                  })

                  Components["GameImageCorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Parent = Components["GameImage1"],
                  })

                  Components["GameImageStroke"] = Globals:Instance("UIStroke", {
                        Color = Color3.fromRGB(24, 24, 24),
                        Parent = Components["GameImage1"],
                  })

                  Components["GameDetectedStatus"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, 135),
                        Size = UDim2.new(1, 0, 0, 36),
                        Name = "GameDetectedStatus",
                        Parent = Components["GameStatus1"],
                  })

                  Components["GameDetectedStatusCorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Parent = Components["GameDetectedStatus"],
                  })

                  Components["GameDetectedStatusStroke"] = Globals:Instance("UIStroke", {
                        Color = Color3.fromRGB(24, 24, 24),
                        Parent = Components["GameDetectedStatus"],
                  })

                  Components["Status"] = Globals:Instance("TextLabel", {
                        Font = Enum.Font.SourceSansBold,
                        Text = "Undetected",
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 5, 0, 16),
                        Size = UDim2.new(1, -20, 0, 20),
                        Name = "Status",
                        Parent = Components["GameDetectedStatus"],
                  })

                  Components["StatusTitle"] = Globals:Instance("TextLabel", {
                        Font = Enum.Font.SourceSansSemibold,
                        Text = "S T A T U S",
                        TextColor3 = Color3.fromRGB(158, 158, 158),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 5, 0, 1),
                        Size = UDim2.new(1, -20, 0, 20),
                        Name = "StatusTitle",
                        Parent = Components["GameDetectedStatus"],
                  })

                  Components["Expiry"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, 180),
                        Size = UDim2.new(1, 0, 0, 36),
                        Name = "Expiry",
                        Parent = Components["GameStatus1"],
                  })

                  Components["ExpiryCorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Parent = Components["Expiry"],
                  })

                  Components["ExpiryStroke"] = Globals:Instance("UIStroke", {
                        Color = Color3.fromRGB(24, 24, 24),
                        Parent = Components["Expiry"],
                  })

                  Components["ExpiryDate"] = Globals:Instance("TextLabel", {
                        Font = Enum.Font.SourceSansBold,
                        Text = "7/30/26",
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 5, 0, 16),
                        Size = UDim2.new(1, -20, 0, 20),
                        Name = "ExpiryDate",
                        Parent = Components["Expiry"],
                  })

                  Components["ExpiryTitle"] = Globals:Instance("TextLabel", {
                        Font = Enum.Font.SourceSansSemibold,
                        Text = Loader.Expiry,
                        TextColor3 = Color3.fromRGB(158, 158, 158),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 5, 0, 1),
                        Size = UDim2.new(1, -20, 0, 20),
                        Name = "ExpiryTitle",
                        Parent = Components["Expiry"],
                        Text = "E X P I R Y",
                  })

                  Components["LaunchButton"] = Globals:Instance("TextButton", {
                        Font = Enum.Font.SourceSansBold,
                        Text = "Launch",
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14,
                        AutoButtonColor = false,
                        BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, 227),
                        Size = UDim2.new(1, 0, 0, 40),
                        Name = "LaunchButton",
                        Parent = Components["GameStatus1"],
                  })

                  Components["LaunchStroke"] = Globals:Instance("UIStroke", {
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        Color = Color3.fromRGB(24, 24, 24),
                        Parent = Components["LaunchButton"],
                  })

                  Components["LaunchCorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Parent = Components["LaunchButton"],
                  })

                  task.wait(0.15)

                  Globals:Tween(Components.LoaderOutline, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                  })

                  Library:Connection("LaunchDown", Components.LaunchButton.MouseButton1Down, function()
                        task.spawn(function()
                              Globals:Tween(
                                    Components.LaunchStroke,
                                    TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                    { Color = Library.Theme.Accent }
                              )
                              Globals:Tween(
                                    Components["LaunchButton"],
                                    TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                    {
                                          BackgroundColor3 = Library.Theme.Accent,
                                    }
                              )
                              task.wait(0.2)
                              Globals:Tween(
                                    Components["LaunchButton"],
                                    TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                    {
                                          BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                                    }
                              )
                        end)

                        Loader:Launch(SelectedGame, SelectedType)
                  end)

                  Library:Connection("LaunchEnter", Components.LaunchButton.MouseEnter, function()
                        Globals:Tween(Components.LaunchStroke, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                              Color = Library.Theme.Accent,
                        })
                  end)

                  Library:Connection("LaunchLeave", Components.LaunchButton.MouseLeave, function()
                        Globals:Tween(Components.LaunchStroke, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                              Color = Color3.fromRGB(24, 24, 24),
                        })
                  end)
            end

            local Selected

            function Loader:NewGame(Name, Type, Image)
                  local GameComponents = {}

                  GameComponents["NewGame"] = Globals:Instance("TextButton", {
                        Font = Enum.Font.SourceSans,
                        Text = "",
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        TextSize = 14,
                        AutoButtonColor = false,
                        BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.05, 0, 0.00619195, 0),
                        Size = UDim2.new(1, 0, 0.0247678, 50),
                        Name = "NewGame",
                        Parent = Components["Products"],
                  })

                  GameComponents["NewGameCorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Name = "NewGameCorner",
                        Parent = GameComponents["NewGame"],
                  })

                  GameComponents["NewGameStroke"] = Globals:Instance("UIStroke", {
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        Color = Color3.fromRGB(24, 24, 24),
                        Name = "NewGameStroke",
                        Parent = GameComponents["NewGame"],
                  })

                  GameComponents["GameTitle"] = Globals:Instance("TextLabel", {
                        Font = Enum.Font.SourceSansSemibold,
                        Text = Name .. " " .. Type,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 8, 0, 36),
                        Size = UDim2.new(1, -10, 0, 10),
                        ZIndex = 2,
                        Name = "GameTitle",
                        Parent = GameComponents["NewGame"],
                  })

                  GameComponents["GameImage"] = Globals:Instance("ImageLabel", {
                        Image = Image,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 8, 0, 5),
                        Size = UDim2.new(0, 20, 0, 20),
                        ZIndex = 2,
                        Name = "GameImage",
                        Parent = GameComponents["NewGame"],
                  })

                  GameComponents["UICorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(1, 0),
                        Parent = GameComponents["GameImage"],
                  })

                  GameComponents["GameStatus"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(41, 255, 130),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 35, 0, 10),
                        Size = UDim2.new(0, 10, 0, 10),
                        Name = "GameStatus",
                        Parent = GameComponents["NewGame"],
                  })

                  GameComponents["UICorner1"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(1, 0),
                        Parent = GameComponents["GameStatus"],
                  })

                  Library:Connection(Name .. Type .. "Down", GameComponents.NewGame.MouseButton1Down, function()
                        Selected = GameComponents.NewGame
                        SelectedGame = Name
                        SelectedType = Type

                        for Index, GameButton in Components.Products:GetChildren() do
                              if GameButton.Name == "NewGame" then
                                    local Stroke = GameButton:FindFirstChild("NewGameStroke")

                                    Globals:Tween(GameButton, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                                          BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                                    })

                                    Globals:Tween(Stroke, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                                          Color = Color3.fromRGB(24, 24, 24),
                                    })
                              end
                        end

                        task.spawn(function()
                              Globals:Tween(
                                    GameComponents.NewGameStroke,
                                    TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                    {
                                          Color = Library.Theme.Accent,
                                    }
                              )
                              Globals:Tween(
                                    GameComponents.NewGame,
                                    TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                    {
                                          BackgroundColor3 = Library.Theme.Accent,
                                    }
                              )
                              task.wait(0.2)
                              Globals:Tween(
                                    GameComponents.NewGame,
                                    TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                    {
                                          BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                                    }
                              )
                        end)

                        task.spawn(function()
                              Globals:Tween(Components["GameImage1"], TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                                    ImageTransparency = 1,
                              })
                              task.wait(0.15)
                              Components["GameImage1"].Image = Image
                              Globals:Tween(Components["GameImage1"], TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
                                    ImageTransparency = 0.4,
                              })
                        end)
                  end)

                  Library:Connection(Name .. Type .. "Enter", GameComponents.NewGame.MouseEnter, function()
                        Globals:Tween(
                              GameComponents.NewGameStroke,
                              TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                              { Color = Library.Theme.Accent }
                        )
                  end)

                  Library:Connection(Name .. Type .. "Leave", GameComponents.NewGame.MouseLeave, function()
                        if Selected ~= GameComponents.NewGame then
                              Globals:Tween(
                                    GameComponents.NewGameStroke,
                                    TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                    { Color = Color3.fromRGB(24, 24, 24) }
                              )
                        end
                  end)
            end

            function Loader:SetProgress(num)
                  Globals:Tween(Components["Progess"], TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        Size = UDim2.new(num / 100, 0, 1, 0),
                  })

                  Components["ProgressPercent"].Text = tostring(math.floor(num)) .. "%"
            end

            function Loader:SetStage(stage)
                  Components["ProgressStage"].Text = "Iridescent | " .. stage
            end

            function Loader:Launch(Game, Type)
                  HookingEnabled = Type ~= "Lite"
                  task.wait(0.2)
                  local HideTween = Globals:Tween(Components.WorkspaceHider, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                        BackgroundTransparency = 0,
                  })
                  task.spawn(function()
                        task.wait(0.15)
                        Globals:Tween(Components.LoaderOutline, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                              Size = UDim2.new(0, 400, 0, 200),
                        })
                  end)

                  HideTween.Completed:Wait()
                  for _, Obj in Components.Workspace:GetChildren() do
                        Obj:Destroy()
                  end
                  task.wait(0.3)

                  do --// Components
                        Components["ProgressBar"] = Globals:Instance("Frame", {
                              AnchorPoint = Vector2.new(0.5, 0.5),
                              BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                              BorderColor3 = Color3.fromRGB(0, 0, 0),
                              BorderSizePixel = 0,
                              Position = UDim2.new(0.5, 0, 0.5, 20),
                              Size = UDim2.new(0, 200, 0, 20),
                              Name = "ProgressBar",
                              Parent = Components["LoaderOutline"],
                        })

                        Components["ProgressBarStroke"] = Globals:Instance("UIStroke", {
                              Color = Color3.fromRGB(24, 24, 24),
                              Name = "ProgressBarStroke",
                              Parent = Components["ProgressBar"],
                        })

                        Components["ProgressBarCorner"] = Globals:Instance("UICorner", {
                              CornerRadius = UDim.new(0, 3),
                              Name = "ProgressBarCorner",
                              Parent = Components["ProgressBar"],
                        })

                        Components["Progess"] = Globals:Instance("Frame", {
                              BackgroundColor3 = Color3.fromRGB(63, 201, 176),
                              BorderColor3 = Color3.fromRGB(0, 0, 0),
                              BorderSizePixel = 0,
                              Size = UDim2.new(0, 0, 1, 0),
                              Name = "Progess",
                              Parent = Components["ProgressBar"],
                        })

                        Components["ProgessCorner"] = Globals:Instance("UICorner", {
                              CornerRadius = UDim.new(0, 3),
                              Name = "ProgessCorner",
                              Parent = Components["Progess"],
                        })

                        Components["ProgressPercent"] = Globals:Instance("TextLabel", {
                              Font = Enum.Font.SourceSansBold,
                              Text = "",
                              TextColor3 = Color3.fromRGB(255, 255, 255),
                              TextSize = 14,
                              BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                              BackgroundTransparency = 1,
                              BorderColor3 = Color3.fromRGB(0, 0, 0),
                              BorderSizePixel = 0,
                              Size = UDim2.new(1, 0, 1, 0),
                              Name = "ProgressPercent",
                              Parent = Components["ProgressBar"],
                        })

                        Components["ProgressPercentStroke"] = Globals:Instance("UIStroke", {
                              Thickness = 0.9,
                              Name = "ProgressPercentStroke",
                              Parent = Components["ProgressPercent"],
                        })

                        Components["ProgressStage"] = Globals:Instance("TextLabel", {
                              Font = Enum.Font.SourceSansBold,
                              Text = "Iridescent",
                              TextColor3 = Color3.fromRGB(255, 255, 255),
                              TextSize = 14,
                              BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                              BackgroundTransparency = 1,
                              BorderColor3 = Color3.fromRGB(0, 0, 0),
                              BorderSizePixel = 0,
                              Position = UDim2.new(0, 0, -1, -5),
                              Size = UDim2.new(1, 0, 1, 0),
                              Name = "ProgressStage",
                              Parent = Components["ProgressBar"],
                        })

                        Components["IridescentLogo"] = Globals:Instance("ImageLabel", {
                              Image = Library.LogoImage,
                              AnchorPoint = Vector2.new(0.5, 0.5),
                              BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                              BackgroundTransparency = 1,
                              BorderColor3 = Color3.fromRGB(0, 0, 0),
                              BorderSizePixel = 0,
                              Position = UDim2.new(0.5, 0, 0.5, -45),
                              Size = UDim2.new(0, 25, 0, 25),
                              Name = "IridescentLogo",
                              Parent = Components["ProgressBar"],
                        })
                  end

                  LoaderLaunched = true
                  Loader.BeginLoading = true

                  Globals:Tween(Components.WorkspaceHider, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                        BackgroundTransparency = 1,
                  })

                  task.spawn(function()
                        while Components.ProgressStage do
                              task.wait()
                              if Components.ProgressStage:GetAttribute("Tweening") then
                                    break
                              end
                              Components.ProgressStage.TextTransparency = math.sin(tick() * 3) + 1 / 2
                        end
                  end)
            end

            Loader.Components = Components
            return Loader
      end

      function Library:Window(WindowData)
            local Window = {
                  Name = WindowData.Name,
                  Tabs = {},
                  Sections = {},
                  Components = {},
                  PlayerImage = WindowData.PlayerImage,
                  Open = true,
                  IsOpen = true,
            }

            Library.IsOpen = true;

            Window.ArmorPanel = self:CreateArmorPanel()
            Window.ModPanel = self:CreateModeratorsPanel()
            Window.Hotkeys = self:CreateHotkeysPanel()
            Window.__index = Window

            local Components = {}

            do --// Components
                  Components["UI"] = Globals:Instance("ScreenGui", {
                        IgnoreGuiInset = true,
                        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                        Name = "UI",
                        Parent = CoreGui,
                        DisplayOrder = 3,
                  })

                  Components["Outline"] = Globals:Instance("TextButton", {
                        Font = Enum.Font.SourceSans,
                        Text = "",
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        TextSize = 14,
                        AutoButtonColor = false,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.5, 0, 3, 0),
                        Size = UDim2.new(0, 650, 0, 470),
                        Name = "Outline",
                        Parent = Components["UI"],
                  })


                  Components["OutlineCorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Name = "OutlineCorner",
                        Parent = Components["Outline"],
                  })

                  Components["WindowNotifications"] = Globals:Instance("Frame", {
                        Position = UDim2.new(1, 0, 1, 0),
                        AnchorPoint = Vector2.new(1, 1),
                        Size = UDim2.new(0, 200, 1, 0),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Name = "Notifications",
                        Parent = Components.Outline,
                  })

                  Components["LeftSideElements"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Size = UDim2.new(0, 50, 1, 0),
                        Name = "LeftSideElements",
                        Parent = Components["Outline"],
                  })

                  Components["LeftSideElmentsCorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Name = "LeftSideElmentsCorner",
                        Parent = Components["LeftSideElements"],
                  })

                  Components["LeftSideFixIGNORE"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(1, -2, 0, 0),
                        Size = UDim2.new(0, 3, 1, 0),
                        Name = "LeftSideFixIGNORE",
                        Parent = Components["LeftSideElements"],
                  })

                  Components["LeftSideOutline"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(24, 24, 24),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(1, 0, 0, 0),
                        Size = UDim2.new(0, 1, 1, 0),
                        Name = "LeftSideOutline",
                        Parent = Components["LeftSideFixIGNORE"],
                  })

                  Components["LogoSpace"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 50),
                        Name = "LogoSpace",
                        Parent = Components["LeftSideElements"],
                  })

                  Components["Logo"] = Globals:Instance("ImageLabel", {
                        Image = Library.LogoImage,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(1, -10, 1, -10),
                        Name = "Logo",
                        Parent = Components["LogoSpace"],
                  })

                  Components["TabsHolder"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, 50),
                        Size = UDim2.new(1, 0, 1, -106),
                        Name = "TabsHolder",
                        Parent = Components["LeftSideElements"],
                  })

                  Components["TabsScrollingFrame"] = Globals:Instance("ScrollingFrame", {
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        CanvasSize = UDim2.new(1, 0, 1, 0),
                        ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                        ScrollBarImageTransparency = 1,
                        ScrollBarThickness = 0,
                        Active = true,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, -3),
                        Size = UDim2.new(1, 0, 1, 3),
                        Name = "TabsScrollingFrame",
                        Parent = Components["TabsHolder"],
                  })

                  Components["ScrollingFrameListLayout"] = Globals:Instance("UIListLayout", {
                        Padding = UDim.new(0, 13),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Name = "ScrollingFrameListLayout",
                        Parent = Components["TabsScrollingFrame"],
                  })

                  Components["UIPadding"] = Globals:Instance("UIPadding", {
                        PaddingLeft = UDim.new(0, 8),
                        PaddingTop = UDim.new(0, 1),
                        Parent = Components["TabsScrollingFrame"],
                  })

                  Components["TabFadeTop"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, -10),
                        Size = UDim2.new(1, 0, 0, 20),
                        Name = "TabFadeTop",
                        Parent = Components["TabsHolder"],
                  })

                  Components["TabFadeTopGradient"] = Globals:Instance("UIGradient", {
                        Color = ColorSequence.new({
                              ColorSequenceKeypoint.new(0, Color3.fromRGB(14, 14, 14)),
                              ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 14, 14)),
                        }),
                        Rotation = 90,
                        Transparency = NumberSequence.new({
                              NumberSequenceKeypoint.new(0, 0.4),
                              NumberSequenceKeypoint.new(1, 1),
                        }),
                        Name = "TabFadeTopGradient",
                        Parent = Components["TabFadeTop"],
                  })

                  Components["TabFadeBottom"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 1, -20),
                        Size = UDim2.new(1, 0, 0, 20),
                        Name = "TabFadeBottom",
                        Parent = Components["TabsHolder"],
                  })

                  Components["TabFadeBottomGradient"] = Globals:Instance("UIGradient", {
                        Color = ColorSequence.new({
                              ColorSequenceKeypoint.new(0, Color3.fromRGB(14, 14, 14)),
                              ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 14, 14)),
                        }),
                        Rotation = -90,
                        Transparency = NumberSequence.new({
                              NumberSequenceKeypoint.new(0, 0.4),
                              NumberSequenceKeypoint.new(1, 1),
                        }),
                        Name = "TabFadeBottomGradient",
                        Parent = Components["TabFadeBottom"],
                  })

                  Components["PlayerIconHolder"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 1, -50),
                        Size = UDim2.new(1, 0, 0, 50),
                        Name = "PlayerIconHolder",
                        Parent = Components["LeftSideElements"],
                  })

            --[[Components["PlayerImageButton"] = Globals:Instance("ImageLabel", {
                  Image = Window.PlayerImage or "",

                  AnchorPoint = Vector2.new(0.5, 0.5),
                  BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                  BackgroundTransparency = 1,
                  BorderColor3 = Color3.fromRGB(0, 0, 0),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0.5, 0, 0.5, 0),
                  Size = UDim2.new(1, -25, 1, -25),
                  Name = "PlayerImageButton",
                  Parent = Components["PlayerIconHolder"],
                  Visible = false
            })]]

                  Components["PlayerImageCorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(1, 0),
                        Name = "PlayerImageCorner",
                        Parent = Components["PlayerImageButton"],
                  })

                  Components["TopSideElements"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 52, 0, 0),
                        Size = UDim2.new(1, -52, 0, 50),
                        Name = "TopSideElements",
                        Parent = Components["Outline"],
                        ClipsDescendants = true,
                  })

                  Components["TopSideElementsCorner"] = Globals:Instance("UICorner", {
                        CornerRadius = UDim.new(0, 3),
                        Name = "TopSideElementsCorner",
                        Parent = Components["TopSideElements"],
                  })

                  Components["TopSideElementsFix"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 1, -2),
                        Size = UDim2.new(1, 0, 0, 3),
                        Name = "TopSideElementsFix",
                        Parent = Components["TopSideElements"],
                  })

                  Components["TopSideOutline"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(24, 24, 24),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 1),
                        Name = "TopSideOutline",
                        Parent = Components["TopSideElementsFix"],
                  })

                  Components["Categorys"] = Globals:Instance("Frame", {
                        AnchorPoint = Vector2.new(0, 0.5),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 15, 0.5, 0),
                        Size = UDim2.new(1, -30, 1, -30),
                        Name = "Categorys",
                        Parent = Components["TopSideElements"],
                  })

                  Components["Pages"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 64, 0, 62),
                        Size = UDim2.new(0, 573, 0, 395),
                        Name = "Pages",
                        Parent = Components["Outline"],
                  })

                  Components["PageHider"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                        BackgroundTransparency = 0,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 64, 0, 62),
                        Size = UDim2.new(0, 573, 0, 395),
                        Name = "PageHider",
                        Parent = Components["Outline"],
                  })

                  Components["PageFadeBottom"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 1, -20),
                        Size = UDim2.new(1, 0, 0, 20),
                        Name = "PageFadeBottom",
                        Parent = Components["Pages"],
                        ZIndex = 2000,
                  })

                  Components["PageFadeTopGradient"] = Globals:Instance("UIGradient", {
                        Color = ColorSequence.new({
                              ColorSequenceKeypoint.new(0, Color3.fromRGB(11, 11, 11)),
                              ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 11, 11)),
                        }),
                        Rotation = -90,
                        Transparency = NumberSequence.new({
                              NumberSequenceKeypoint.new(0, 0),
                              NumberSequenceKeypoint.new(0.43, 1),
                              NumberSequenceKeypoint.new(1, 1),
                        }),
                        Name = "PageFadeTopGradient",
                        Parent = Components["PageFadeBottom"],
                  })

                  Components["PageFadeTop"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, -2),
                        Size = UDim2.new(1, 0, 0, 20),
                        Name = "PageFadeTop",
                        Parent = Components["Pages"],
                        ZIndex = 2000,
                  })

                  Components["PageFadeTopGradient1"] = Globals:Instance("UIGradient", {
                        Color = ColorSequence.new({
                              ColorSequenceKeypoint.new(0, Color3.fromRGB(11, 11, 11)),
                              ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 11, 11)),
                        }),
                        Rotation = 90,
                        Transparency = NumberSequence.new({
                              NumberSequenceKeypoint.new(0, 0),
                              NumberSequenceKeypoint.new(0.43, 1),
                              NumberSequenceKeypoint.new(1, 1),
                        }),
                        Name = "PageFadeTopGradient",
                        Parent = Components["PageFadeTop"],
                  })

                  Components["OutlineShadowHolder"] = Globals:Instance("Frame", {
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 1, 0),
                        ZIndex = 0,
                        Name = "OutlineShadowHolder",
                        Parent = Components["Outline"],
                  })

                  Components["OutlineShadow"] = Globals:Instance("ImageLabel", {
                        Image = Library.OutlineShadowImage,
                        ImageColor3 = Color3.fromRGB(0, 0, 0),

                        ImageTransparency = 0.3,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(49, 49, 450, 450),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(1, 47, 1, 47),
                        ZIndex = 0,
                        Name = "OutlineShadow",
                        Parent = Components["OutlineShadowHolder"],
                  })
            end

            do --// Dragging and Window visibility
                  local Dragging = false
                  local DragStart = nil
                  local StartPosition = nil

                  Components["Outline"].InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and not Window.InDrag then
                              Dragging = true
                              DragStart = input.Position
                              StartPosition = Components["Outline"].Position
                              input.Changed:Connect(function()
                                    if input.UserInputState == Enum.UserInputState.End then
                                          Dragging = false
                                    end
                              end)
                        end
                  end)

                  UserInputService.InputChanged:Connect(function(input)
                        if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                              local delta = input.Position - DragStart
                              local newPosition = UDim2.new(
                                    StartPosition.X.Scale,
                                    StartPosition.X.Offset + delta.X,
                                    StartPosition.Y.Scale,
                                    StartPosition.Y.Offset + delta.Y
                              )

                              TweenService:Create(
                                    Components["Outline"],
                                    TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                    { Position = newPosition }
                              ):Play()
                        end
                  end)

                  UserInputService.InputBegan:Connect(function(inp)
                        if inp.KeyCode == Enum.KeyCode.RightShift and not UserInputService:GetFocusedTextBox() then
                              Window.Open = not Window.Open
                              Library.IsOpen = Window.Open
                              Window:SetVisibility(Window.Open)
                        end
                  end)
            end

            function Window:Notify(txt, duration)
                  -- todo
            end

            function Window:OpenWindow()
                  local outline = self.Components.Outline
                  self.Components.UI.Enabled = true

                  local currentX = outline.Position.X
                  local targetPosition = UDim2.new(currentX.Scale, currentX.Offset, 0.5, 0)

                  if self.CurrentTween then
                        self.CurrentTween:Cancel()
                        self.CurrentTween = nil
                  end

                  outline.Position = UDim2.new(currentX.Scale, currentX.Offset, outline.Position.Y.Scale, outline.Position.Y.Offset)

                  self.CurrentTween = Globals:Tween(outline, TweenInfo.new(0.25), {
                        Position = targetPosition,
                  })

                  local completedConnection
                  completedConnection = self.CurrentTween.Completed:Connect(function()
                        self.CurrentTween = nil
                        self.IsOpen = true
                        if completedConnection then completedConnection:Disconnect() end
                  end)
            end

            function Window:Close()
                  local outline = self.Components.Outline

                  if self.CurrentTween then
                        self.CurrentTween:Cancel()
                        self.CurrentTween = nil
                  end

                  local currentX = outline.Position.X

                  self.CurrentTween = Globals:Tween(outline, TweenInfo.new(0.25), {
                        Position = UDim2.new(currentX.Scale, currentX.Offset, 2, 0),
                  })

                  local completedConnection
                  completedConnection = self.CurrentTween.Completed:Connect(function()
                        self.CurrentTween = nil
                        self.Components.UI.Enabled = false
                        self.IsOpen = false
                        if completedConnection then 
                              completedConnection:Disconnect() 
                        end
                  end)
            end

            function Window:SetVisibility(force)
                  if self.CurrentTween then
                        self.CurrentTween:Cancel()
                        self.CurrentTween = nil
                  end

                  local TargetOpen = (force ~= nil) and force or not self.IsOpen
                  self.Open = TargetOpen
                  self.IsOpen = TargetOpen

                  if TargetOpen then
                        self:OpenWindow()
                  else
                        self:Close()
                  end
            end

            function Window:SetTab(Tab)
                  local TabsContainer = self.Components["TabsScrollingFrame"]
                  local TabCategories = self.Components["Categorys"]
                  local Pages = self.Components["Pages"]
                  local FirstCategory = Tab.Categories[Tab.CategoryOrder[1]]
                  local CatToSet

                  --// Category slide Out animation
                  task.spawn(function()
                        Globals:Tween(
                              self.Components.Categorys,
                              TweenInfo.new(Library.CategoryTransitionSpeed, Enum.EasingStyle.Quad),
                              {
                                    Position = UDim2.new(-0.7, 0, 0.5, 0),
                              }
                        )
                  end)

                  --// Set category
                  task.spawn(function()
                        if FirstCategory then
                              self:SetCategory({
                                    Pointer = FirstCategory,
                                    Name = FirstCategory.Parent.Name .. "_" .. FirstCategory.Name,
                                    Parent = FirstCategory.Parent,
                              })
                        end
                  end)

                  --// Animate tab button
                  task.spawn(function()
                        for _, TabButton in TabsContainer:GetChildren() do
                              local Name = TabButton.Name
                              local TabCategoryContainer = TabCategories:FindFirstChild(Name)
                              if not TabCategoryContainer then
                                    continue
                              end

                              local Opened = Name == Tab.Name
                              if Opened then
                                    CatToSet = TabCategoryContainer
                              else
                                    task.spawn(function()
                                          task.wait(Library.CategoryPause)
                                          TabCategoryContainer.Visible = Opened
                                    end)
                              end

                              TabButton.TabImage:SetAttribute("Opened", Opened)

                              Globals:Tween(TabButton.TabImage, TweenInfo.new(0.25), {
                                    ImageColor3 = Opened and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(126, 126, 126),
                              })
                        end
                  end)

                  --// Category slide in animation
                  task.spawn(function()
                        task.wait(Library.CategoryPause)
                        Globals:Tween(
                              self.Components.Categorys,
                              TweenInfo.new(Library.CategoryTransitionSpeed, Enum.EasingStyle.Quad),
                              {
                                    Position = UDim2.new(0, 15, 0.5, 0),
                              }
                        )
                        task.wait(0.1)
                        CatToSet.Visible = true
                  end)
            end

            function Window:SetCategory(Category)
                  local Pointer = Category.Pointer
                  local Components = Pointer.Components
                  local Tab = Category.Parent
                  local PageContainer = self.Components["Pages"]
                  local hiderIn

                  Components.CategoryButton:SetAttribute("Opened", true)
                  --// Transition
                  task.spawn(function()
                        hiderIn = Globals:Tween(
                              self.Components.PageHider,
                              TweenInfo.new(Library.PageTransitionSpeed, Enum.EasingStyle.Quad),
                              {
                                    BackgroundTransparency = 0,
                              }
                        )
                  end)

                  --// Reset
                  task.spawn(function()
                        for _, CategoryData in Tab.Categories do
                              local Comp = CategoryData.Components
                              Globals:Tween(Comp.CategoryButton, TweenInfo.new(0.25), {
                                    BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                              })
                              Globals:Tween(Comp.CategoryTitle, TweenInfo.new(0.25), {
                                    TextColor3 = Color3.fromRGB(129, 129, 129),
                              })
                              Globals:Tween(Comp.CategoryStroke, TweenInfo.new(0.25), {
                                    Color = Color3.fromRGB(24, 24, 24),
                              })

                              Globals:Tween(Comp.TabDropshadow, TweenInfo.new(0.25), {
                                    ImageTransparency = 1,
                              })

                              Comp.CategoryButton:SetAttribute("Opened", false)
                              CategoryData.IsOpen = false
                        end
                  end)

                  --// animate current category
                  task.spawn(function()
                        Globals:Tween(Components.CategoryButton, TweenInfo.new(0.25), {
                              BackgroundColor3 = Library.Theme.DarkAccent,
                        })
                        Globals:Tween(Components.CategoryTitle, TweenInfo.new(0.25), {
                              TextColor3 = Color3.fromRGB(255, 255, 255),
                        })
                        Globals:Tween(Components.CategoryStroke, TweenInfo.new(0.25), {
                              Color = Library.Theme.Accent,
                        })
                        Globals:Tween(Components.TabDropshadow, TweenInfo.new(0.25), {
                              ImageTransparency = 0.5,
                        })
                        Components.CategoryButton:SetAttribute("Opened", true)
                  end)

                  Pointer.IsOpen = true

                  --// Fade out page hider
                  task.spawn(function()
                        if hiderIn then
                              hiderIn.Completed:Wait()
                        end
                        Globals:Tween(
                              self.Components.PageHider,
                              TweenInfo.new(Library.PageTransitionSpeed, Enum.EasingStyle.Quad),
                              {
                                    BackgroundTransparency = 1,
                              }
                        )

                        --// Set Active page visibility
                        for _, Page in PageContainer:GetChildren() do
                              if not Page:IsA("Frame") or table.find({ "PageFadeTop", "PageFadeBottom" }, Page.Name) then
                                    continue
                              end
                              Page.Visible = Page.Name == Category.Name
                        end
                  end)
            end

            function Window:Tab(TabData)
                  local Tab = {
                        Name = TabData.Name,
                        Image = TabData.Image,
                        Categories = {},
                        CategoryOrder = {},
                  }

                  Tab.__index = Tab
                  local Components = {}

                  do --// Components
                        Components["NewTabButtonHolder"] = Globals:Instance("TextButton", {
                              BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                              BackgroundTransparency = 1,
                              BorderColor3 = Color3.fromRGB(0, 0, 0),
                              BorderSizePixel = 0,
                              Size = UDim2.new(0, 35, 0, 35),
                              Name = Tab.Name,
                              Parent = self.Components["TabsScrollingFrame"],
                              Text = "",
                              AutoButtonColor = false,
                        })

                        Components["TabImage"] = Globals:Instance("ImageLabel", {
                              Image = Tab.Image,
                              AnchorPoint = Vector2.new(0.5, 0.5),
                              BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                              ImageColor3 = Color3.fromRGB(126, 126, 126),
                              BackgroundTransparency = 1,
                              BorderColor3 = Color3.fromRGB(0, 0, 0),
                              BorderSizePixel = 0,
                              Position = UDim2.new(0.5, 0, 0.5, 0),
                              Size = UDim2.new(0, 25, 0, 25),
                              Name = "TabImage",
                              Parent = Components["NewTabButtonHolder"],
                        })

                        Components["CategoryHolder"] = Globals:Instance("Frame", {
                              BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                              BackgroundTransparency = 1,
                              BorderColor3 = Color3.fromRGB(0, 0, 0),
                              BorderSizePixel = 0,
                              Size = UDim2.new(1, 0, 1, 0),
                              Name = Tab.Name,
                              Parent = Window.Components["Categorys"],
                              Visible = false,
                        })

                        Components["CategoryListLayout"] = Globals:Instance("UIListLayout", {
                              Padding = UDim.new(0, 10),
                              FillDirection = Enum.FillDirection.Horizontal,
                              SortOrder = Enum.SortOrder.LayoutOrder,
                              Name = "CategoryHolderLayout",
                              Parent = Components["CategoryHolder"],
                        })
                  end

                  do --// Connections
                        local TabButton = Components["NewTabButtonHolder"]

                        Library:Connection("TabHandler_" .. Tab.Name, TabButton.MouseButton1Down, function()
                              Window:SetTab(Tab)
                        end)

                        Library:Connection("TabMouseEnter_" .. Tab.Name, Components.NewTabButtonHolder.MouseEnter, function()
                              Globals:Tween(
                                    Components["TabImage"],
                                    TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                    {
                                          ImageColor3 = Color3.fromRGB(255, 255, 255),
                                    }
                              )
                        end)

                        Library:Connection("TabMouseLeave_" .. Tab.Name, Components.NewTabButtonHolder.MouseLeave, function()
                              if Components["TabImage"]:GetAttribute("Opened") then
                                    return
                              end
                              Globals:Tween(
                                    Components["TabImage"],
                                    TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                    {
                                          ImageColor3 = Color3.fromRGB(126, 126, 126),
                                    }
                              )
                        end)
                  end

                  function Tab:Category(CategoryData)
                        local Category = {
                              Name = CategoryData.Name,
                              Sections = {},
                              Parent = Tab,
                              IsOpen = false,
                        }

                        Category.__index = Category

                        local Components = {}

                        do --// Components
                              Components["CategoryButton"] = Globals:Instance("TextButton", {
                                    Font = Enum.Font.SourceSansSemibold,
                                    RichText = true,
                                    Text = "",
                                    TextColor3 = Color3.fromRGB(143, 143, 143),
                                    TextSize = 14,
                                    TextTransparency = 1,
                                    AutoButtonColor = false,
                                    BackgroundColor3 = Color3.fromRGB(11, 11, 11), -- 0, 157, 209
                                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                                    BorderSizePixel = 0,
                                    Size = UDim2.new(0, 82, 0, 20),
                                    Name = Category.Name,
                                    Parent = self.Components["CategoryHolder"],
                              })

                              Components["CategoryCorner"] = Globals:Instance("UICorner", {
                                    CornerRadius = UDim.new(0, 4),
                                    Name = "CategoryCorner",
                                    Parent = Components["CategoryButton"],
                              })

                              Components["CategoryStroke"] = Globals:Instance("UIStroke", {
                                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                    Color = Color3.fromRGB(24, 24, 24), -- 0, 189, 255
                                    Name = "CategoryStroke",
                                    Parent = Components["CategoryButton"],
                              })

                              Components["CategoryTitle"] = Globals:Instance("TextLabel", {
                                    Font = Enum.Font.SourceSansSemibold,
                                    Text = Category.Name,
                                    TextColor3 = Color3.fromRGB(133, 133, 133), -- 255, 255, 255
                                    TextSize = 14,
                                    BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                    BackgroundTransparency = 1,
                                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                                    BorderSizePixel = 0,
                                    Size = UDim2.new(1, 0, 1, 0),
                                    Name = "CategoryTitle",
                                    Parent = Components["CategoryButton"],
                              })

                              Components["TabDropshadowContainer"] = Globals:Instance("Frame", {
                                    BackgroundTransparency = 1,
                                    BorderSizePixel = 0,
                                    Size = UDim2.new(1, 0, 1, 0),
                                    ZIndex = 0,
                                    Name = "TabDropshadowContainer",
                                    Parent = Components["CategoryButton"],
                              })

                              Components["TabDropshadow"] = Globals:Instance("ImageLabel", {
                                    Image = Library.ShadowImage,
                                    ImageColor3 = Library.Theme.Accent,
                                    ImageTransparency = 1, -- 0.5,
                                    ScaleType = Enum.ScaleType.Slice,
                                    SliceCenter = Rect.new(49, 49, 450, 450),
                                    AnchorPoint = Vector2.new(0.5, 0.5),
                                    BackgroundTransparency = 1,
                                    BorderSizePixel = 0,
                                    Position = UDim2.new(0.5, 0, 0.5, 0),
                                    Size = UDim2.new(1, 30, 1, 30),
                                    ZIndex = 0,
                                    Name = "TabDropshadow",
                                    Parent = Components["TabDropshadowContainer"],
                              })

                              Components["Page"] = Globals:Instance("Frame", {
                                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                    BackgroundTransparency = 1,
                                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                                    BorderSizePixel = 0,
                                    Size = UDim2.new(1, 0, 1, 0),
                                    Name = Tab.Name .. "_" .. Category.Name,
                                    Visible = false,
                                    Parent = Window.Components["Pages"],
                              })

                              Components["Left"] = Globals:Instance("ScrollingFrame", {
                                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                                    CanvasSize = UDim2.new(0, 0, 1, 24),
                                    ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                                    ScrollBarImageTransparency = 1,
                                    ScrollBarThickness = 0,
                                    Active = true,
                                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                    BackgroundTransparency = 1,
                                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                                    BorderSizePixel = 0,
                                    Size = UDim2.new(0.5, -5, 1, 0),
                                    Name = "Left",
                                    Parent = Components["Page"],
                              })

                              Components["LeftListLayout"] = Globals:Instance("UIListLayout", {
                                    Parent = Components.Left,
                                    Padding = UDim.new(0, 15),
                              })

                              Components["LeftPadding"] = Globals:Instance("UIPadding", {
                                    PaddingLeft = UDim.new(0, 2),
                                    PaddingTop = UDim.new(0, 4),
                                    PaddingBottom = UDim.new(0, 5),
                                    Name = "LeftPadding",
                                    Parent = Components["Left"],
                              })

                              Components["Right"] = Globals:Instance("ScrollingFrame", {
                                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                                    CanvasSize = UDim2.new(0, 0, 1, 0),
                                    ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                                    ScrollBarImageTransparency = 1,
                                    ScrollBarThickness = 0,
                                    Active = true,
                                    AnchorPoint = Vector2.new(0.5, 0),
                                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                    BackgroundTransparency = 1,
                                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                                    BorderSizePixel = 0,
                                    Position = UDim2.new(0.5, 147, 0, 0),
                                    Size = UDim2.new(0.5, -5, 1, 0),
                                    Name = "Right",
                                    Parent = Components["Page"],
                              })

                              Components["RightPadding"] = Globals:Instance("UIPadding", {
                                    PaddingLeft = UDim.new(0, 2),
                                    PaddingTop = UDim.new(0, 4),
                                    PaddingBottom = UDim.new(0, 5),
                                    Name = "RightPadding",
                                    Parent = Components["Right"],
                              })

                              Components["RightListLayout"] = Globals:Instance("UIListLayout", {
                                    Parent = Components.Right,
                                    Padding = UDim.new(0, 15),
                              })
                        end

                        function Category:Section(SectionData)
                              local Section = {
                                    Name = SectionData.Name,
                                    Side = SectionData.Side or "Left",
                                    Elements = {},
                                    ZIndex = 9000,
                              }

                              Section.__index = Section

                              local Components = {}

                              do --// Components
                                    Components["Section"] = Globals:Instance("Frame", {
                                          AutomaticSize = Enum.AutomaticSize.Y,
                                          BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                                          BorderColor3 = Color3.fromRGB(0, 0, 0),
                                          BorderSizePixel = 0,
                                          Size = UDim2.new(1, -4, 0, 30),
                                          Name = "Section",
                                          Parent = self.Components[Section.Side],
                                    })

                                    Components["SectionStroke"] = Globals:Instance("UIStroke", {
                                          Color = Color3.fromRGB(24, 24, 24),
                                          Name = "SectionStroke",
                                          Parent = Components["Section"],
                                    })

                                    Components["SectionCorner"] = Globals:Instance("UICorner", {
                                          CornerRadius = UDim.new(0, 3),
                                          Name = "SectionCorner",
                                          Parent = Components["Section"],
                                    })

                                    Components["SectionTitleLine"] = Globals:Instance("Frame", {
                                          BackgroundColor3 = Color3.fromRGB(24, 24, 24),
                                          BorderColor3 = Color3.fromRGB(0, 0, 0),
                                          BorderSizePixel = 0,
                                          Position = UDim2.new(0, 0, 0, 24),
                                          Size = UDim2.new(1, 0, 0, 1),
                                          Name = "SectionTitleLine",
                                          Parent = Components["Section"],
                                    })

                                    Components["SectionTitle"] = Globals:Instance("TextLabel", {
                                          Font = Enum.Font.SourceSansSemibold,
                                          Text = Section.Name,
                                          TextColor3 = Color3.fromRGB(255, 255, 255),
                                          TextSize = 14,
                                          TextXAlignment = Enum.TextXAlignment.Left,
                                          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                          BackgroundTransparency = 1,
                                          BorderColor3 = Color3.fromRGB(0, 0, 0),
                                          BorderSizePixel = 0,
                                          Position = UDim2.new(0, 14, 0, 2),
                                          Size = UDim2.new(1, -14, 0, 20),
                                          Name = "SectionTitle",
                                          Parent = Components["Section"],
                                    })

                                    Components["SectionElements"] = Globals:Instance("Frame", {
                                          AutomaticSize = Enum.AutomaticSize.Y,
                                          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                          BackgroundTransparency = 1,
                                          BorderColor3 = Color3.fromRGB(0, 0, 0),
                                          BorderSizePixel = 0,
                                          Position = UDim2.new(0, 14, 0, 30),
                                          Size = UDim2.new(0, 249, 0, -30),
                                          Name = "SectionElements",
                                          Parent = Components["Section"],
                                    })

                                    Components["SectionElementsListLayout"] = Globals:Instance("UIListLayout", {
                                          Padding = UDim.new(0, 3),
                                          SortOrder = Enum.SortOrder.LayoutOrder,
                                          Name = "SectionElementsListLayout",
                                          Parent = Components["SectionElements"],
                                    })
                              end

                              function Section:SetVisibility(visible)
                                    self.Visible = visible
                              end

                              function Section:Seperator()
                                    local Components = {}
                                    Components["SectionSeperatorHolder"] = Globals:Instance("Frame", {
                                          BackgroundColor3 = Color3.fromRGB(24, 24, 24),
                                          BackgroundTransparency = 1,
                                          BorderColor3 = Color3.fromRGB(0, 0, 0),
                                          BorderSizePixel = 0,
                                          Size = UDim2.new(1, 0, 0, 6),
                                          Name = "SectionSeperatorHolder",
                                          Parent = self.Components["SectionElements"],
                                    })

                                    Components["SectionSeperatorFrame"] = Globals:Instance("Frame", {
                                          BackgroundColor3 = Color3.fromRGB(24, 24, 24),
                                          BorderColor3 = Color3.fromRGB(0, 0, 0),
                                          BorderSizePixel = 0,
                                          Size = UDim2.new(1, 0, 0, 1),
                                          Name = "SectionSeperatorFrame",
                                          Parent = Components["SectionSeperatorHolder"],
                                    })

                                    function Components:SetVisibility(visible)
                                          Components.SectionSeperatorHolder.Visible = visible
                                    end

                                    return Components
                              end

                              function Section:Toggle(ToggleData)
                                    local Toggle = {
                                          Name = ToggleData.Name,
                                          Flag = ToggleData.Flag,
                                          Value = false,
                                          Default = ToggleData.Default or false,
                                          Callback = ToggleData.Callback or function() end,
                                          Tooltip = ToggleData.Tooltip or nil,
                                          Risky = ToggleData.Risky,
                                          Class = "Toggle"
                                    };

                                    Toggle.__index = Toggle

                                    local Components = {}

                                    do --// Components
                                          Components["ToggleHolder"] = Globals:Instance("TextButton", {
                                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                BackgroundTransparency = 1,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Size = Toggle.Tooltip and UDim2.new(1, 0, 0, 38) or UDim2.new(1, 0, 0, 20),
                                                Name = "ToggleHolder",
                                                Parent = self.Components["SectionElements"],
                                                Text = "",
                                                AutoButtonColor = false,
                                          })

                                          Components["ToggleTitle"] = Globals:Instance("TextLabel", {
                                                Font = Enum.Font.SourceSansSemibold,
                                                Text = Toggle.Name,
                                                TextColor3 = not Toggle.Risky and Color3.fromRGB(129, 129, 129)
                                                      or Color3.fromRGB(150, 14, 23),
                                                TextSize = 14,
                                                TextXAlignment = Enum.TextXAlignment.Left,
                                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                BackgroundTransparency = 1,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(1, 0, 0, 15),
                                                Name = "ToggleTitle",
                                                Parent = Components["ToggleHolder"],
                                          })

                                          Components["ToggleButton"] = Globals:Instance("TextLabel", {
                                                Font = Enum.Font.SourceSans,
                                                Text = "",
                                                TextColor3 = Color3.fromRGB(0, 0, 0),
                                                TextSize = 14,
                                                BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(1, -15, 0, 0),
                                                Size = UDim2.new(0, 15, 0, 15),
                                                Name = "ToggleButton",
                                                Parent = Components["ToggleHolder"],
                                          })

                                          Components["ToggleButtonCorner"] = Globals:Instance("UICorner", {
                                                CornerRadius = UDim.new(0, 4),
                                                Name = "ToggleButtonCorner",
                                                Parent = Components["ToggleButton"],
                                          })

                                          Components["ToggleStroke"] = Globals:Instance("UIStroke", {
                                                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                                Color = Color3.fromRGB(24, 24, 24),
                                                Name = "ToggleStroke",
                                                Parent = Components["ToggleButton"],
                                          })

                                          Components["ToggleDropshadowContainer"] = Globals:Instance("Frame", {
                                                BackgroundTransparency = 1,
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(1, 0, 1, 0),
                                                ZIndex = 0,
                                                Name = "ToggleDropshadowContainer",
                                                Parent = Components["ToggleButton"],
                                          })

                                          Components["ToggleDropshadow"] = Globals:Instance("ImageLabel", {
                                                Image = Library.ShadowImage,
                                                ImageColor3 = Library.Theme.Accent,
                                                ImageTransparency = 0.5,
                                                ScaleType = Enum.ScaleType.Slice,
                                                SliceCenter = Rect.new(49, 49, 450, 450),
                                                AnchorPoint = Vector2.new(0.5, 0.5),
                                                BackgroundTransparency = 1,
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(0.5, 0, 0.5, 0),
                                                Size = UDim2.new(1, 20, 1, 20),
                                                ZIndex = 0,
                                                Name = "ToggleDropshadow",
                                                Parent = Components["ToggleDropshadowContainer"],
                                          })

                                          if Toggle.Tooltip then
                                                Components["Tooltip"] = Globals:Instance("TextLabel", {
                                                      Font = Enum.Font.SourceSansSemibold,
                                                      Text = Toggle.Tooltip,
                                                      TextColor3 = Color3.fromRGB(88, 88, 88),
                                                      TextSize = 14,
                                                      TextXAlignment = Enum.TextXAlignment.Left,
                                                      BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                      BackgroundTransparency = 1,
                                                      BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                      BorderSizePixel = 0,
                                                      Position = UDim2.new(0, 3, 0, 18),
                                                      Size = UDim2.new(1, 0, 0, 15),
                                                      Name = "Tooltip",
                                                      Parent = Components["ToggleHolder"],
                                                })
                                          end
                                    end

                                    local Val = false
                                    Toggle.Components = Components

                                    function Toggle:Set(Value)
                                          self.Value = Value
                                          Val = Value
                                          if self.Value == true then
                                                Globals:Tween(
                                                      Components["ToggleDropshadow"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            ImageTransparency = 0.5,
                                                      }
                                                )

                                                Globals:Tween(
                                                      Components["ToggleButton"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            BackgroundColor3 = Library.Theme.DarkAccent,
                                                      }
                                                )

                                                Globals:Tween(
                                                      Components["ToggleStroke"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            Color = Library.Theme.Accent,
                                                      }
                                                )

                                                Globals:Tween(
                                                      Components["ToggleTitle"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            TextColor3 = self.Risky and Color3.fromRGB(255, 0, 0)
                                                                  or Color3.fromRGB(255, 255, 255),
                                                      }
                                                )
                                          else
                                                Globals:Tween(
                                                      Components["ToggleDropshadow"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            ImageTransparency = 1,
                                                      }
                                                )

                                                Globals:Tween(
                                                      Components["ToggleButton"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                                      }
                                                )

                                                Globals:Tween(
                                                      Components["ToggleStroke"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            Color = Color3.fromRGB(24, 24, 24),
                                                      }
                                                )

                                                Globals:Tween(
                                                      Components["ToggleTitle"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            TextColor3 = self.Risky and Color3.fromRGB(150, 14, 23)
                                                                  or Color3.fromRGB(129, 129, 129),
                                                      }
                                                )
                                          end

                                          Library:DoCallback(self.Callback)
                                    end

                                    function Toggle:SetVisibility(visible)
                                          self.Components.ToggleHolder.Visible = visible
                                    end

                                    Library:Connection(
                                          "ToggleHandler" .. Toggle.Flag,
                                          Components.ToggleHolder.MouseButton1Down,
                                          function()
                                                Toggle:Set(not Val)
                                          end
                                    )

                                    Library:Connection(
                                          "ToggleMouseEnter" .. Toggle.Name,
                                          Components.ToggleHolder.MouseEnter,
                                          function()
                                                Globals:Tween(
                                                      Components["ToggleStroke"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            Color = Library.Theme.Accent,
                                                      }
                                                )
                                          end
                                    )

                                    Library:Connection(
                                          "ToggleMouseLeave" .. Category.Name,
                                          Components.ToggleHolder.MouseLeave,
                                          function()
                                                if Toggle.Value then
                                                      return
                                                end
                                                Globals:Tween(
                                                      Components["ToggleStroke"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            Color = Color3.fromRGB(24, 24, 24),
                                                      }
                                                )
                                          end
                                    )

                                    Library.Flags[Toggle.Flag] = Toggle
                                    Section.Elements[Toggle.Flag] = Toggle

                                    Toggle:Set(Toggle.Default)
                                    return Toggle
                              end

                              function Section:Slider(SliderData)
                                    local Slider = {
                                          Min = SliderData.Min or 0,
                                          Max = SliderData.Max or 100,
                                          Default = SliderData.Default or SliderData.Max,
                                          Increment = SliderData.Increment or 1,
                                          Name = SliderData.Name,
                                          Flag = SliderData.Flag,
                                          Suffix = SliderData.Suffix or "",
                                          Callback = SliderData.Callback or function() end,
                                          Class = "Slider"
                                    };

                                    Slider.__index = Slider

                                    local Components = {}

                                    do --// Components
                                          Components["Slider"] = Globals:Instance("Frame", {
                                                BackgroundColor3 = Color3.fromRGB(255, 0, 4),
                                                BackgroundTransparency = 1,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(1, 0, 0, 44),
                                                Name = "Slider",
                                                Parent = self.Components["SectionElements"],
                                          })

                                          Components["SliderTitle"] = Globals:Instance("TextLabel", {
                                                Font = Enum.Font.SourceSansSemibold,
                                                Text = Slider.Name,
                                                TextColor3 = Color3.fromRGB(129, 129, 129),
                                                TextSize = 14,
                                                TextXAlignment = Enum.TextXAlignment.Left,
                                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                BackgroundTransparency = 1,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(1, 0, 0, 15),
                                                Name = "SliderTitle",
                                                Parent = Components["Slider"],
                                          })

                                          Components["SliderVisualizer"] = Globals:Instance("Frame", {
                                                BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(0, 0, 1, -15),
                                                Size = UDim2.new(1, 0, 0, 2),
                                                Name = "SliderVisualizer",
                                                Parent = Components["Slider"],
                                          })

                                          Components["SliderVisualizerFill"] = Globals:Instance("Frame", {
                                                BackgroundColor3 = Library.Theme.DarkAccent,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(0, 0, 1, 0),
                                                Name = "SliderVisualizerFill",
                                                Parent = Components["SliderVisualizer"],
                                          })

                                          Components["SliderCircle"] = Globals:Instance("Frame", {
                                                AnchorPoint = Vector2.new(0, 0.5),
                                                BackgroundColor3 = Library.Theme.DarkAccent,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(1, -10, 0.5, 0),
                                                Size = UDim2.new(0, 10, 0, 10),
                                                Name = "SliderCircle",
                                                Parent = Components["SliderVisualizerFill"],
                                          })

                                          Components["SliderCircleCorner"] = Globals:Instance("UICorner", {
                                                Name = "SliderCircleCorner",
                                                Parent = Components["SliderCircle"],
                                          })

                                          Components["SliderShadowContainer"] = Globals:Instance("Frame", {
                                                BackgroundTransparency = 1,
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(1, 0, 1, 0),
                                                ZIndex = 0,
                                                Name = "SliderShadowContainer",
                                                Parent = Components["SliderVisualizerFill"],
                                          })

                                          Components["SliderShadow"] = Globals:Instance("ImageLabel", {
                                                Image = Library.ShadowImage,
                                                ImageColor3 = Library.Theme.Accent,
                                                ImageTransparency = 0.72,
                                                ScaleType = Enum.ScaleType.Slice,
                                                SliceCenter = Rect.new(49, 49, 450, 450),
                                                AnchorPoint = Vector2.new(0.5, 0.5),
                                                BackgroundTransparency = 1,
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(0.5, -1, 0.5, 0),
                                                Size = UDim2.new(1, 7, 1, 10),
                                                ZIndex = 0,
                                                Name = "SliderShadow",
                                                Parent = Components["SliderShadowContainer"],
                                          })

                                          Components["SliderValue"] = Globals:Instance("TextLabel", {
                                                Font = Enum.Font.SourceSansSemibold,
                                                Text = tostring(Slider.Default) .. Slider.Suffix,
                                                TextColor3 = Color3.fromRGB(129, 129, 129),
                                                TextSize = 14,
                                                TextXAlignment = Enum.TextXAlignment.Right,
                                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                BackgroundTransparency = 1,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(1, 0, 0, 15),
                                                Name = "SliderValue",
                                                Parent = Components["Slider"],
                                          })
                                    end

                                    function Slider:Set(Value)
                                          Value = Math.RoundToIncrement(math.clamp(Value, self.Min, self.Max), self.Increment)
                                          self.Value = Value

                                          local percent = (Value - self.Min) / (self.Max - self.Min)

                                          Globals:Tween(
                                                Components["SliderVisualizerFill"],
                                                TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                {
                                                      Size = UDim2.new(percent, 0, 1, 0),
                                                }
                                          )

                                          Globals:Tween(
                                                Components["SliderCircle"],
                                                TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                {
                                                      Position = UDim2.new(1, -10, 0.5, 0),
                                                }
                                          )

                                          Components["SliderValue"].Text = Library:FormatValue(Slider.Increment, Value)
                                                .. Slider.Suffix

                                          Library:DoCallback(self.Callback, Value)
                                    end

                                    function Slider:SetVisibility(visible)
                                          self.Slider.Visible = visible
                                    end

                                    Slider.Components = Components

                                    do --// Slider Input
                                          local Dragging = false

                                          local function UpdateFromInput(XPosition)
                                                local SliderVisualizer = Components["SliderVisualizer"]
                                                local SliderVisualizerFill = Components["SliderVisualizerFill"]
                                                local Circle = Components["SliderCircle"]
                                                local ValueLabel = Components["SliderValue"]

                                                local RelativeX = math.clamp(
                                                      (XPosition - SliderVisualizer.AbsolutePosition.X) / SliderVisualizer.AbsoluteSize.X,
                                                      0,
                                                      1
                                                )
                                                local RawValue = (Slider.Max - Slider.Min) * RelativeX + Slider.Min

                                                Slider:Set(RawValue)
                                          end

                                          UserInputService.InputEnded:Connect(function(input)
                                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                                      Dragging = false
                                                      Window.InDrag = false
                                                end
                                          end)

                                          UserInputService.InputChanged:Connect(function(input)
                                                if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                                                      UpdateFromInput(input.Position.X)
                                                end
                                          end)

                                          Library:Connection("Slider" .. Slider.Flag, Components.Slider.InputBegan, function(Input)
                                                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                                      Dragging = true
                                                      Window.InDrag = true
                                                      UpdateFromInput(Input.Position.X)
                                                end
                                          end)
                                    end

                                    Slider:Set(Slider.Default)

                                    Library.Flags[Slider.Flag] = Slider
                                    Section.Elements[Slider.Flag] = Slider
                                    return Slider
                              end

                              function Section:Button(ButtonData)
                                    local Button = {
                                          Name = ButtonData.Name,
                                          Flag = ButtonData.Flag,
                                          Class = "Button",
                                          Callback = ButtonData.Callback or function() end
                                    }

                                    local Components = {}

                                    do --// Components 
                                          Components["ButtonHolder"] = Globals:Instance("Frame", {
                                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                BackgroundTransparency = 1,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(1, 0, 0, 24),
                                                Name = "ButtonHolder",
                                                Parent = self.Components["SectionElements"]
                                          })

                                          Components["Button"] = Globals:Instance("TextButton", {
                                                Font = Enum.Font.SourceSansSemibold,
                                                TextColor3 = Color3.fromRGB(129, 129, 129),
                                                TextSize = 14,
                                                AutoButtonColor = false,
                                                BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(0, 0, 0, 2),
                                                Size = UDim2.new(1, 0, 0, 18),
                                                Name = "Button",
                                                Parent = Components["ButtonHolder"],
                                                Text = Button.Name
                                          })

                                          Components["ButtonCorner"] = Globals:Instance("UICorner", {
                                                CornerRadius = UDim.new(0, 4),
                                                Name = "ButtonCorner",
                                                Parent = Components["Button"]
                                          })

                                          Components["ButtonStroke"] = Globals:Instance("UIStroke", {
                                                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                                Color = Color3.fromRGB(24, 24, 24),
                                                Name = "ButtonStroke",
                                                Parent = Components["Button"]
                                          })
                                    end

                                    Library:Connection("MouseEnter" .. Button.Flag, Components.Button.MouseEnter, function()
                                          Globals:Tween(
                                                Components["ButtonStroke"],
                                                TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                {
                                                      Color = Library.Theme.Accent,
                                                }
                                          )
                                    end)

                                    Library:Connection("MouseLeave" .. Button.Flag, Components.Button.MouseLeave, function()
                                          Globals:Tween(
                                                Components["ButtonStroke"],
                                                TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                {
                                                      Color = Color3.fromRGB(24, 24, 24),
                                                }
                                          )
                                    end)

                                    Library:Connection("ButtonHandler" .. Button.Flag, Components.Button.MouseButton1Down, function()
                                          Library:DoCallback(Button.Callback)
                                          task.spawn(function()
                                                Globals:Tween(
                                                      Components["Button"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            BackgroundColor3 = Library.Theme.Accent,
                                                      }
                                                )
                                                task.wait(0.2)
                                                Globals:Tween(
                                                      Components["Button"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                                      }
                                                )
                                          end);
                                    end)

                                    function Button:AddButton(NewData)
                                          if self.SecondButton then return end

                                          local newFlag = NewData.Flag or (self.Flag .. "_2")
                                          local newName = NewData.Name or "Button"
                                          local newCallback = NewData.Callback or function() end

                                          Components.Button.Size = UDim2.new(0.5, -1, 0, 18)
                                          Components.Button.Position = UDim2.new(0, 0, 0, 2)

                                          local Second = Globals:Instance("TextButton", {
                                                Font = Enum.Font.SourceSansSemibold,
                                                TextColor3 = Color3.fromRGB(129, 129, 129),
                                                TextSize = 14,
                                                AutoButtonColor = false,
                                                BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(0.5, 1, 0, 2),
                                                Size = UDim2.new(0.5, -1, 0, 18),
                                                Name = "Button2",
                                                Parent = Components["ButtonHolder"],
                                                Text = newName
                                          })

                                          Globals:Instance("UICorner", {
                                                CornerRadius = UDim.new(0, 4),
                                                Parent = Second
                                          })

                                          local Stroke = Globals:Instance("UIStroke", {
                                                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                                Color = Color3.fromRGB(24, 24, 24),
                                                Parent = Second
                                          })

                                          Library:Connection("ButtonHandler" .. newFlag, Second.MouseButton1Down, function()
                                                Library:DoCallback(newCallback)
                                                task.spawn(function()
                                                      Globals:Tween(
                                                            Second,
                                                            TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                            {
                                                                  BackgroundColor3 = Library.Theme.Accent,
                                                            }
                                                      )
                                                      task.wait(0.2)
                                                      Globals:Tween(
                                                            Second,
                                                            TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                            {
                                                                  BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                                            }
                                                      )
                                                end);

                                          end)

                                          Library:Connection("MouseEnter" .. newFlag, Second.MouseEnter, function()
                                                Globals:Tween(
                                                      Stroke,
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            Color = Library.Theme.Accent,
                                                      }
                                                )
                                          end)

                                          Library:Connection("MouseLeave" .. newFlag, Second.MouseLeave, function()
                                                Globals:Tween(
                                                      Stroke,
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            Color = Color3.fromRGB(24, 24, 24),
                                                      }
                                                )
                                          end)

                                          self.SecondButton = {
                                                Name = newName,
                                                Flag = newFlag,
                                                Callback = newCallback,
                                                Instance = Second
                                          }

                                          return self.SecondButton
                                    end

                                    Button.Components = Components
                                    Button.__index = Button
                                    Section.Elements[Button.Flag] = Button
                                    return Button
                              end

                              function Section:Dropdown(DropdownData)
                                    local Dropdown = {
                                          Name = DropdownData.Name,
                                          Flag = DropdownData.Flag,
                                          Multi = DropdownData.Multi or false,
                                          Value = not DropdownData.Multi and "" or {},
                                          Default = DropdownData.Default,
                                          Callback = DropdownData.Callback or function() end,
                                          Class = "Dropdown"
                                    };

                                    self.ZIndex -= 1
                                    Dropdown.__index = Dropdown
                                    local vis = false
                                    local Components = {}

                                    do --// Components
                                          Components["Dropdown"] = Globals:Instance("Frame", {
                                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                BackgroundTransparency = 1,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(1, 0, 0, 44),
                                                ZIndex = 2,
                                                Name = "Dropdown",
                                                Parent = self.Components["SectionElements"],
                                                ZIndex = self.ZIndex,
                                          })

                                          Components["DropdownTitle"] = Globals:Instance("TextLabel", {
                                                Font = Enum.Font.SourceSansSemibold,
                                                Text = Dropdown.Name,
                                                TextColor3 = Color3.fromRGB(129, 129, 129),
                                                TextSize = 14,
                                                TextXAlignment = Enum.TextXAlignment.Left,
                                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                BackgroundTransparency = 1,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(1, 0, 0, 15),
                                                Name = "DropdownTitle",
                                                Parent = Components["Dropdown"],
                                          })

                                          Components["DropdownButton"] = Globals:Instance("TextButton", {
                                                Font = Enum.Font.SourceSansSemibold,
                                                Text = "   ",
                                                TextColor3 = Color3.fromRGB(129, 129, 129),
                                                TextSize = 14,
                                                TextXAlignment = Enum.TextXAlignment.Left,
                                                AutoButtonColor = false,
                                                BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(0, 0, 0, 18),
                                                Size = UDim2.new(1, 0, 0, 22),
                                                Name = "DropdownButton",
                                                Parent = Components["Dropdown"],
                                                ClipsDescendants = false,
                                          })

                                          Components["DropdownButtonCorner"] = Globals:Instance("UICorner", {
                                                CornerRadius = UDim.new(0, 4),
                                                Name = "DropdownButtonCorner",
                                                Parent = Components["DropdownButton"],
                                          })

                                          Components["DropdownStroke"] = Globals:Instance("UIStroke", {
                                                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                                Color = Color3.fromRGB(24, 24, 24),
                                                Name = "DropdownStroke",
                                                Parent = Components["DropdownButton"],
                                          })

                                          Components["DropdownImage"] = Globals:Instance("ImageLabel", {
                                                Image = Library.DropdownImage,
                                                AnchorPoint = Vector2.new(0, 0.5),
                                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                BackgroundTransparency = 1,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(1, -15, 0.5, 0),
                                                Size = UDim2.new(0, 15, 0, 15),
                                                Name = "DropdownImage",
                                                Parent = Components["DropdownButton"],
                                                ZIndex = 3,
                                          })

                                          Components["DropdownItemsOutline"] = Globals:Instance("Frame", {
                                                BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(0, 0, 0, 21),
                                                Size = UDim2.new(1, 0, 0, 0),
                                                Name = "DropdownItemsOutline",
                                                Visible = false,
                                                Parent = Components["DropdownButton"],
                                                ClipsDescendants = true,
                                                ZIndex = 2,
                                          })

                                          Components["DropdownItemsStroke"] = Globals:Instance("UIStroke", {
                                                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                                Color = Color3.fromRGB(24, 24, 24),
                                                Name = "DropdownItemsStroke",
                                                Parent = Components["DropdownItemsOutline"],
                                                Transparency = 1,
                                          })

                                          Components["DropdownItems"] = Globals:Instance("ScrollingFrame", {
                                                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                                                CanvasSize = UDim2.new(0, 0, 1, 0),
                                                ScrollBarImageColor3 = Library.Theme.Accent,
                                                ScrollBarImageTransparency = 0.67,
                                                ScrollBarThickness = 3,
                                                Visible = true,
                                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                BackgroundTransparency = 1,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(0, 2, 0, 2),
                                                Size = UDim2.new(1, -4, 1, -4),
                                                Name = "DropdownItems",
                                                Parent = Components["DropdownItemsOutline"],
                                                ClipsDescendants = true,
                                          })

                                          Components["DropdownListLayout"] = Globals:Instance("UIListLayout", {
                                                Padding = UDim.new(0, 3),
                                                SortOrder = Enum.SortOrder.LayoutOrder,
                                                Name = "DropdownListLayout",
                                                Parent = Components["DropdownItems"],
                                          })

                                          Components["DropdownFadeBottom"] = Globals:Instance("Frame", {
                                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(0, 0, 1, -20),
                                                Size = UDim2.new(1, 0, 0, 20),
                                                Name = "DropdownFadeBottom",
                                                Parent = Components["DropdownItemsOutline"],
                                          })

                                          Components["DropdownFadeTopGradient"] = Globals:Instance("UIGradient", {
                                                Color = ColorSequence.new({
                                                      ColorSequenceKeypoint.new(0, Color3.fromRGB(11, 11, 11)),
                                                      ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 11, 11)),
                                                }),
                                                Rotation = -90,
                                                Transparency = NumberSequence.new({
                                                      NumberSequenceKeypoint.new(0, 0.4),
                                                      NumberSequenceKeypoint.new(1, 1),
                                                }),
                                                Name = "DropdownFadeTopGradient",
                                                Parent = Components["DropdownFadeBottom"],
                                          })

                                          Components["DropdownFadeTop"] = Globals:Instance("Frame", {
                                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(1, 0, 0, 20),
                                                Name = "DropdownFadeTop",
                                                Parent = Components["DropdownItemsOutline"],
                                          })

                                          Components["DropdownFadeTopGradient1"] = Globals:Instance("UIGradient", {
                                                Color = ColorSequence.new({
                                                      ColorSequenceKeypoint.new(0, Color3.fromRGB(11, 11, 11)),
                                                      ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 11, 11)),
                                                }),
                                                Rotation = 90,
                                                Transparency = NumberSequence.new({
                                                      NumberSequenceKeypoint.new(0, 0.4),
                                                      NumberSequenceKeypoint.new(1, 1),
                                                }),
                                                Name = "DropdownFadeTopGradient",
                                                Parent = Components["DropdownFadeTop"],
                                          })

                                          Components["DropdownText"] = Globals:Instance("TextLabel", {
                                                Parent = Components["DropdownButton"],
                                                BackgroundTransparency = 1,
                                                TextXAlignment = Enum.TextXAlignment.Left,
                                                TextColor3 = Color3.fromRGB(129, 129, 129),
                                                Size = UDim2.new(1, 0, 1, 0),
                                                ZIndex = 1,
                                                Font = Enum.Font.SourceSansSemibold,
                                                TextSize = 14,
                                                ClipsDescendants = true,
                                          })

                                          Components["DropdownHider"] = Instance.new("Frame")
                                          Components["DropdownHider"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                          Components["DropdownHider"].BorderColor3 = Color3.fromRGB(0, 0, 0)
                                          Components["DropdownHider"].BorderSizePixel = 0
                                          Components["DropdownHider"].Position = UDim2.new(1, -20, 0.5, 0)
                                          Components["DropdownHider"].Size = UDim2.new(0, 20, 1, -2)
                                          Components["DropdownHider"].AnchorPoint = Vector2.new(0, 0.5)
                                          Components["DropdownHider"].Parent = Components["DropdownButton"]

                                          Components["HiderGradient"] = Instance.new("UIGradient")
                                          Components["HiderGradient"].Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(
                                                      0,
                                                      Color3.fromRGB(11.000000294297934, 11.000000294297934, 11.000000294297934)
                                                ),
                                                ColorSequenceKeypoint.new(
                                                      1,
                                                      Color3.fromRGB(11.000000294297934, 11.000000294297934, 11.000000294297934)
                                                ),
                                          })
                                          Components["HiderGradient"].Rotation = -180
                                          Components["HiderGradient"].Transparency = NumberSequence.new({
                                                NumberSequenceKeypoint.new(0, 0),
                                                NumberSequenceKeypoint.new(0.7219451665878296, 0),
                                                NumberSequenceKeypoint.new(0.7842893004417419, 0),
                                                NumberSequenceKeypoint.new(0.8690773248672485, 0.44999998807907104),
                                                NumberSequenceKeypoint.new(0.9650872945785522, 0.7062499523162842),
                                                NumberSequenceKeypoint.new(1, 0.36250001192092896),
                                          })
                                          Components["HiderGradient"].Name = "PageFadeTopGradient"
                                          Components["HiderGradient"].Parent = Components["DropdownHider"]
                                    end

                                    Dropdown.Components = Components

                                    Dropdown.Options = {}

                                    function Dropdown:SetVisibility(visible)
                                          self.Components.Dropdown.Visible = visible
                                    end

                                    function Dropdown:AddOption(Name)
                                          local Option = {
                                                Name = Name,
                                                Value = false,
                                                Components = {},
                                          }

                                          local OptionComponents = {}

                                          OptionComponents["Option"] = Globals:Instance("TextButton", {
                                                Font = Enum.Font.SourceSans,
                                                Text = "",
                                                TextColor3 = Color3.fromRGB(0, 0, 0),
                                                TextSize = 14,
                                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                                BackgroundTransparency = 1,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(1, 0, 0, 20),
                                                Name = "Option",
                                                Parent = Components["DropdownItems"],
                                          })

                                          OptionComponents["OptionOnTitle"] = Globals:Instance("TextLabel", {
                                                Font = Enum.Font.SourceSansSemibold,
                                                Text = Name,
                                                TextColor3 = Color3.fromRGB(129, 129, 129),
                                                TextSize = 14,
                                                TextXAlignment = Enum.TextXAlignment.Left,
                                                BackgroundColor3 = Color3.fromRGB(129, 129, 129),
                                                BackgroundTransparency = 1,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(0, 10, 0, 0),
                                                Size = UDim2.new(1, -10, 1, 0),
                                                Name = "OptionOnTitle",
                                                Parent = OptionComponents["Option"],
                                          })

                                          OptionComponents["OptionIndicator"] = Globals:Instance("Frame", {
                                                BackgroundColor3 = Library.Theme.Accent,
                                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                                BorderSizePixel = 0,
                                                Size = UDim2.new(0, 3, 1, 0),
                                                Name = "OptionIndicator",
                                                Visible = true,
                                                BackgroundTransparency = 1,
                                                Parent = OptionComponents["Option"],
                                          })

                                          Library:Connection(
                                                "OptionHandler" .. Option.Name .. "_" .. Dropdown.Flag,
                                                OptionComponents.Option.MouseButton1Down,
                                                function()
                                                      if Dropdown.Multi then
                                                            Option.Value = not Option.Value
                                                            Globals:Tween(
                                                                  OptionComponents["OptionIndicator"],
                                                                  TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                                  {
                                                                        BackgroundTransparency = Option.Value and 0 or 1,
                                                                  }
                                                            )
                                                            Globals:Tween(
                                                                  OptionComponents["OptionOnTitle"],
                                                                  TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                                  {
                                                                        TextColor3 = Option.Value and Color3.fromRGB(255, 255, 255)
                                                                              or Color3.fromRGB(129, 129, 129),
                                                                  }
                                                            )
                                                      else
                                                            for _, other in ipairs(Dropdown.Options) do
                                                                  other.Value = false

                                                                  Globals:Tween(
                                                                        other.Components["OptionIndicator"],
                                                                        TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                                        {
                                                                              BackgroundTransparency = other.Value and 0 or 1,
                                                                        }
                                                                  )

                                                                  Globals:Tween(
                                                                        other.Components["OptionOnTitle"],
                                                                        TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                                        {
                                                                              TextColor3 = other.Value and Color3.fromRGB(255, 255, 255)
                                                                                    or Color3.fromRGB(129, 129, 129),
                                                                        }
                                                                  )
                                                            end
                                                            Option.Value = true
                                                            Globals:Tween(
                                                                  OptionComponents["OptionIndicator"],
                                                                  TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                                  {
                                                                        BackgroundTransparency = 0,
                                                                  }
                                                            )

                                                            Globals:Tween(
                                                                  OptionComponents["OptionOnTitle"],
                                                                  TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                                  {
                                                                        TextColor3 = Option.Value and Color3.fromRGB(255, 255, 255)
                                                                              or Color3.fromRGB(129, 129, 129),
                                                                  }
                                                            )

                                                            Components["DropdownText"].Text = "   " .. Name
                                                            local SizeTween = Globals:Tween(
                                                                  Components["DropdownItemsOutline"],
                                                                  TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                                  {
                                                                        Size = UDim2.new(1, 0, 0, 0),
                                                                  }
                                                            )
                                                            Globals:Tween(
                                                                  Components["DropdownItemsStroke"],
                                                                  TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                                  {
                                                                        Transparency = 1,
                                                                  }
                                                            )
                                                            task.spawn(function()
                                                                  task.wait(Library.HighlightSpeed)
                                                                  Components.DropdownItemsOutline.Visible = false
                                                            end)
                                                      end

                                                      if Dropdown.Multi then
                                                            local selected = {}
                                                            for _, opt in ipairs(Dropdown.Options) do
                                                                  if opt.Value then
                                                                        table.insert(selected, opt.Name)
                                                                  end
                                                            end
                                                            Dropdown:Set(selected)
                                                      else
                                                            Dropdown:Set(Name)
                                                      end
                                                end
                                          )

                                          Option.Components = OptionComponents
                                          table.insert(Dropdown.Options, Option)
                                          return Option
                                    end

                                    for Index, Name in DropdownData.Options do
                                          Dropdown:AddOption(Name)
                                    end

                                    function Dropdown:Set(Value)
                                          self.Value = Value

                                          if Dropdown.Multi then
                                                local selectedNames = {}
                                                for _, opt in ipairs(self.Options) do
                                                      local selected = table.find(Value, opt.Name) ~= nil
                                                      opt.Value = selected

                                                      Globals:Tween(
                                                            opt.Components["OptionIndicator"],
                                                            TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                            {
                                                                  BackgroundTransparency = selected and 0 or 1,
                                                            }
                                                      )

                                                      Globals:Tween(
                                                            opt.Components["OptionOnTitle"],
                                                            TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                            {
                                                                  TextColor3 = selected and Color3.fromRGB(255, 255, 255)
                                                                        or Color3.fromRGB(129, 129, 129),
                                                            }
                                                      )

                                                      if selected then
                                                            table.insert(selectedNames, opt.Name)
                                                      end
                                                end

                                                if #selectedNames == 0 then
                                                      Components["DropdownText"].Text = "   None"
                                                else
                                                      Components["DropdownText"].Text = "   " .. table.concat(selectedNames, ", ")
                                                end
                                          else
                                                for _, opt in ipairs(self.Options) do
                                                      local selected = opt.Name == Value
                                                      opt.Value = selected

                                                      Globals:Tween(
                                                            opt.Components["OptionIndicator"],
                                                            TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                            {
                                                                  BackgroundTransparency = selected and 0 or 1,
                                                            }
                                                      )

                                                      Globals:Tween(
                                                            opt.Components["OptionOnTitle"],
                                                            TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                            {
                                                                  TextColor3 = selected and Color3.fromRGB(255, 255, 255)
                                                                        or Color3.fromRGB(129, 129, 129),
                                                            }
                                                      )
                                                end

                                                Globals:Tween(
                                                      Components["Dropdown"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            Size = UDim2.new(1, 0, 0, 44),
                                                      }
                                                )

                                                Components["DropdownText"].Text = "   " .. tostring(Value)
                                          end

                                          Library:DoCallback(self.Callback, Value)
                                    end

                                    Library:Connection(
                                          "DropdownHandler_" .. Dropdown.Flag .. "Main",
                                          Components["DropdownButton"].MouseButton1Down,
                                          function()
                                                vis = not vis
                                                if vis then
                                                      local itemCount = #Dropdown.Options
                                                      local itemHeight = 24
                                                      local expandedItemHeight = math.min(itemCount, 3) * itemHeight
                                                      local fullHeight = 44 + expandedItemHeight

                                                      Components.DropdownItemsOutline.Visible = true

                                                      Globals:Tween(
                                                            Components["DropdownItemsOutline"],
                                                            TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                            {
                                                                  Size = UDim2.new(1, 0, 0, expandedItemHeight),
                                                            }
                                                      )

                                                      Globals:Tween(
                                                            Components["Dropdown"],
                                                            TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                            {
                                                                  Size = UDim2.new(1, 0, 0, fullHeight),
                                                            }
                                                      )

                                                      Globals:Tween(
                                                            Components["DropdownItemsStroke"],
                                                            TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                            {
                                                                  Transparency = 0,
                                                            }
                                                      )
                                                else
                                                      Globals:Tween(
                                                            Components["DropdownItemsOutline"],
                                                            TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                            {
                                                                  Size = UDim2.new(1, 0, 0, 0),
                                                            }
                                                      )

                                                      Globals:Tween(
                                                            Components["Dropdown"],
                                                            TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                            {
                                                                  Size = UDim2.new(1, 0, 0, 44),
                                                            }
                                                      )

                                                      Globals:Tween(
                                                            Components["DropdownItemsStroke"],
                                                            TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                            {
                                                                  Transparency = 1,
                                                            }
                                                      )

                                                      task.spawn(function()
                                                            task.wait(Library.HighlightSpeed)
                                                            Components.DropdownItemsOutline.Visible = false
                                                      end)
                                                end
                                          end
                                    )

                                    if not Dropdown.Default or (Dropdown.Multi and #Dropdown.Default == 0) then
                                          if Dropdown.Multi then
                                                Dropdown.Default = { DropdownData.Options[1] }
                                          else
                                                Dropdown.Default = DropdownData.Options[1]
                                          end
                                    end

                                    Dropdown:Set(Dropdown.Default)
                                    Library.Flags[Dropdown.Flag] = Dropdown
                                    Section.Elements[Dropdown.Flag] = Dropdown
                                    return Dropdown
                              end

                              function Section:Textbox(TextboxData)
                                    local TextBox = {
                                          Name = TextboxData.Name,
                                          Flag = TextboxData.Flag,
                                          Default = TextboxData.Default or "",
                                          Callback = TextboxData.Callback or function() end,
                                          Value = "",
                                          Class = "TextBox";
                                    }

                                    local Components = {}

                                    Components.Holder = Globals:Instance("Frame", {
                                          BackgroundTransparency = 1,
                                          Size = UDim2.new(1, 0, 0, 40),
                                          Parent = self.Components.SectionElements,
                                    })

                                    Components.Title = Globals:Instance("TextLabel", {
                                          Font = Enum.Font.SourceSansSemibold,
                                          Text = TextBox.Name,
                                          TextColor3 = Color3.fromRGB(129, 129, 129),
                                          TextSize = 14,
                                          BackgroundTransparency = 1,
                                          Size = UDim2.new(1, 0, 0, 15),
                                          TextXAlignment = Enum.TextXAlignment.Left,
                                          Parent = Components.Holder,
                                    })

                                    local BoxFrame = Globals:Instance("Frame", {
                                          BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                          Position = UDim2.new(0, 0, 0, 18),
                                          Size = UDim2.new(1, 0, 0, 18),
                                          ClipsDescendants = true,
                                          Parent = Components.Holder,
                                    })
                                    Globals:Instance("UICorner", { CornerRadius = UDim.new(0, 4), Parent = BoxFrame })
                                    local Stroke = Globals:Instance("UIStroke", {
                                          Color = Color3.fromRGB(24, 24, 24),
                                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                          Parent = BoxFrame,
                                    })

                                    local Label = Globals:Instance("TextLabel", {
                                          Font = Enum.Font.SourceSansSemibold,
                                          Text = "",
                                          TextColor3 = Color3.fromRGB(230, 230, 230),
                                          TextSize = 14,
                                          TextXAlignment = Enum.TextXAlignment.Left,
                                          BackgroundTransparency = 1,
                                          Size = UDim2.new(1, -5, 1, 0),
                                          Position = UDim2.new(0, 5, 0, 0),
                                          Parent = BoxFrame,
                                    })

                                    local Mask = Globals:Instance("Frame", {
                                          BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                          Size = UDim2.new(1, -2, 1, -2),
                                          Position = UDim2.new(0, 1, 0, 1),
                                          Parent = BoxFrame,
                                    })

                                    Globals:Instance("UICorner", { CornerRadius = UDim.new(0, 4), Parent = Mask })

                                    local Cursor = Globals:Instance("Frame", {
                                          BackgroundColor3 = Color3.fromRGB(230, 230, 230),
                                          Size = UDim2.new(0, 1, 0.8, 0),
                                          Position = UDim2.new(0, 0, 0.1, 0),
                                          Parent = BoxFrame,
                                          ZIndex = Mask.ZIndex + 1,
                                          Visible = false,
                                    })
                                    Globals:Instance("UICorner", { CornerRadius = UDim.new(0, 1), Parent = Cursor })

                                    local InputBox = Globals:Instance("TextBox", {
                                          Font = Label.Font,
                                          TextSize = Label.TextSize,
                                          TextTransparency = 1,
                                          Text = "",
                                          BackgroundTransparency = 1,
                                          ClearTextOnFocus = false,
                                          Size = UDim2.new(1, -5, 1, 0),
                                          Position = UDim2.new(0, 5, 0, 0),
                                          Parent = BoxFrame,
                                    })

                                    local TweenService = TweenService

                                    local BlinkTweenInfo =
                                          TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
                                    local BlinkTween = TweenService:Create(Cursor, BlinkTweenInfo, { BackgroundTransparency = 1 })

                                    local function UpdateMaskAndCursor()
                                          local FullText = Label.Text
                                          local TextWidth = Label.TextBounds.X
                                          local BoxWidth = BoxFrame.AbsoluteSize.X

                                          local RevealX = math.clamp(TextWidth, 0, BoxWidth - 7)

                                          if FullText:sub(-1) == " " then
                                                RevealX = RevealX + 3
                                          end

                                          Mask:TweenPosition(
                                                UDim2.new(0, 1 + 5 + RevealX, 0, 1),
                                                Enum.EasingDirection.Out,
                                                Enum.EasingStyle.Sine,
                                                0.1,
                                                true
                                          )
                                          Cursor:TweenPosition(
                                                UDim2.new(0, 5 + RevealX, 0.1, 0),
                                                Enum.EasingDirection.Out,
                                                Enum.EasingStyle.Sine,
                                                0.1,
                                                true
                                          )
                                    end

                                    function TextBox:Set(Value)
                                          self.Value = Value
                                          Label.Text = Value
                                          InputBox.Text = Value

                                          task.defer(UpdateMaskAndCursor)

                                          Library:DoCallback(self.Callback, Value)
                                    end

                                    function TextBox:SetVisibility(Visible)
                                          Components.Holder.Visible = Visible
                                    end

                                    InputBox.Focused:Connect(function()
                                          TweenService:Create(Stroke, TweenInfo.new(0.2), { Color = Library.Theme.Accent }):Play()
                                          Cursor.Visible = true
                                          if BlinkTween.PlaybackState ~= Enum.PlaybackState.Playing then
                                                BlinkTween:Play()
                                          end
                                    end)

                                    InputBox.FocusLost:Connect(function()
                                          TweenService:Create(Stroke, TweenInfo.new(0.2), { Color = Color3.fromRGB(24, 24, 24) })
                                                :Play()
                                          Cursor.Visible = false
                                          BlinkTween:Pause()
                                    end)

                                    InputBox:GetPropertyChangedSignal("Text"):Connect(function()
                                          local FullText = InputBox.Text
                                          TextBox.Value = FullText
                                          Label.Text = FullText
                                          task.defer(UpdateMaskAndCursor)
                                          Library:DoCallback(TextboxData.Callback, FullText)
                                    end)

                                    TextBox:Set(TextBox.Default)


                                    TextBox.Components = Components
                                    TextBox.__index = TextBox
                                    Library.Flags[TextBox.Flag] = TextBox
                                    return TextBox
                              end

                              function Section:Colorpicker(ColorpickerData)
                                    local Colorpicker = {
                                          Name = ColorpickerData.Name,
                                          Flag = ColorpickerData.Flag,
                                          Default = ColorpickerData.Default or { Color3.fromRGB(255, 255, 255), 0 }, -- {Color, Transparency}
                                          Callback = ColorpickerData.Callback or function() end,
                                          Class = "Colorpicker";
                                    }

                                    Colorpicker.__index = Colorpicker

                                    local Components = {}

                                    Components["Colorpicker"] = Globals:Instance("Frame", {
                                          BackgroundTransparency = 1,
                                          Size = UDim2.new(1, 0, 0, 20),
                                          Name = "Colorpicker",
                                          Parent = self.Components["SectionElements"],
                                          BorderSizePixel = 0,
                                    })

                                    Components["ColorpickerTitle"] = Globals:Instance("TextLabel", {
                                          Font = Enum.Font.SourceSans,
                                          Text = Colorpicker.Name,
                                          TextColor3 = Color3.fromRGB(129, 129, 129),
                                          TextSize = 14,
                                          TextXAlignment = Enum.TextXAlignment.Left,
                                          BackgroundTransparency = 1,
                                          Size = UDim2.new(1, 0, 0, 15),
                                          Name = "ColorpickerTitle",
                                          Parent = Components["Colorpicker"],
                                          BorderSizePixel = 0,
                                    })

                                    Components["ColorpickerButton"] = Globals:Instance("TextButton", {
                                          Font = Enum.Font.SourceSans,
                                          Text = "",
                                          TextColor3 = Color3.fromRGB(0, 0, 0),
                                          TextSize = 14,
                                          AutoButtonColor = false,
                                          BackgroundColor3 = Colorpicker.Default[1],
                                          Position = UDim2.new(1, -15, 0, 0),
                                          Size = UDim2.new(0, 15, 0, 15),
                                          Name = "ColorpickerButton",
                                          Parent = Components["Colorpicker"],
                                          BorderSizePixel = 0,
                                    })

                                    Globals:Instance("UICorner", {
                                          CornerRadius = UDim.new(0, 4),
                                          Parent = Components["ColorpickerButton"],
                                    })

                                    Globals:Instance("UIStroke", {
                                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                          Color = Color3.fromRGB(24, 24, 24),
                                          Parent = Components["ColorpickerButton"],
                                    })

                                    Components["ColorpickerFrame"] = Globals:Instance("Frame", {
                                          BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                          BackgroundTransparency = 1, -- start fully transparent
                                          Position = UDim2.new(1, 20, 0, 0),
                                          Size = UDim2.new(0, 215, 0, 210),
                                          Name = "ColorpickerFrame",
                                          Parent = Window.Components.Outline,
                                          BorderSizePixel = 0,
                                          Visible = false,
                                    })

                                    Globals:Instance("UICorner", {
                                          CornerRadius = UDim.new(0, 3),
                                          Parent = Components["ColorpickerFrame"],
                                    })

                                    Globals:Instance("UIStroke", {
                                          Color = Color3.fromRGB(24, 24, 24),
                                          Transparency = 1, -- start fully transparent
                                          Thickness = 1.5,
                                          Parent = Components["ColorpickerFrame"],
                                    })

                                    Components["ColorpickerTitleLine"] = Globals:Instance("Frame", {
                                          BackgroundColor3 = Color3.fromRGB(24, 24, 24),
                                          BackgroundTransparency = 1, -- start fully transparent
                                          Position = UDim2.new(0, 0, 0, 25),
                                          Size = UDim2.new(1, 0, 0, 1),
                                          Name = "ColorpickerTitleLine",
                                          Parent = Components["ColorpickerFrame"],
                                          BorderSizePixel = 0,
                                    })

                                    Components["ColorpickerTitleHeader"] = Globals:Instance("TextLabel", {
                                          Font = Enum.Font.SourceSansSemibold,
                                          Text = "    " .. Colorpicker.Name,
                                          TextColor3 = Color3.fromRGB(255, 255, 255),
                                          TextSize = 14,
                                          TextXAlignment = Enum.TextXAlignment.Left,
                                          BackgroundTransparency = 1, -- start fully transparent
                                          BackgroundColor3 = Color3.fromRGB(14, 14, 14),
                                          Position = UDim2.new(0, 0, 0, 0),
                                          Size = UDim2.new(1, 0, 0, 25),
                                          Name = "ColorpickerTitleHeader",
                                          Parent = Components["ColorpickerFrame"],
                                          BorderSizePixel = 0,
                                    })

                                    Components["ColorpickerElements"] = Globals:Instance("Frame", {
                                          BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                          BackgroundTransparency = 1, -- start fully transparent
                                          Position = UDim2.new(0, 10, 0, 208),
                                          Size = UDim2.new(1, -20, -0.548837364, -50),
                                          Name = "ColorpickerElements",
                                          Parent = Components["ColorpickerFrame"],
                                          BorderSizePixel = 0,
                                    })

                                    Components["Colorwheel"] = Globals:Instance("ImageLabel", {
                                          Image = Library.ColorwheelImage,
                                          AnchorPoint = Vector2.new(0.5, 0),
                                          BackgroundTransparency = 1,
                                          Position = UDim2.new(0.5, -20, 0, 0),
                                          Size = UDim2.new(0, 150, 0, 150),
                                          Name = "Colorwheel",
                                          Parent = Components["ColorpickerElements"],
                                          BorderSizePixel = 0,
                                    })

                                    Globals:Instance("UICorner", {
                                          CornerRadius = UDim.new(1, 0),
                                          Parent = Components["Colorwheel"],
                                    })

                                    Globals:Instance("UIStroke", {
                                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                          Color = Color3.fromRGB(24, 24, 24),
                                          Transparency = 1, -- start fully transparent
                                          Thickness = 3,
                                          Parent = Components["Colorwheel"],
                                    })

                                    Components["BrightnessPicker"] = Globals:Instance("TextButton", {
                                          Text = "",
                                          AutoButtonColor = false,
                                          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                          Position = UDim2.new(1, -35, 0, 0),
                                          Size = UDim2.new(0, 10, 0, 150),
                                          Name = "BrightnessPicker",
                                          Parent = Components["ColorpickerElements"],
                                          BorderSizePixel = 0,
                                    })

                                    Globals:Instance("UICorner", {
                                          CornerRadius = UDim.new(0, 4),
                                          Parent = Components["BrightnessPicker"],
                                    })

                                    Globals:Instance("UIStroke", {
                                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                          Color = Color3.fromRGB(24, 24, 24),
                                          Transparency = 1, -- start fully transparent
                                          Parent = Components["BrightnessPicker"],
                                    })

                                    Globals:Instance("UIGradient", {
                                          Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
                                          }),
                                          Rotation = 90,
                                          Parent = Components["BrightnessPicker"],
                                    })

                                    Components["TransparencyPickerButton"] = Globals:Instance("TextButton", {
                                          Text = "",
                                          AutoButtonColor = false,
                                          BackgroundColor3 = Colorpicker.Default[1],
                                          Position = UDim2.new(1, -15, 0, 0),
                                          Size = UDim2.new(0, 10, 0, 150),
                                          Name = "TransparencyPickerButton",
                                          Parent = Components["ColorpickerElements"],
                                          BorderSizePixel = 0,
                                    })

                                    local TransparencyPicture = Globals:Instance("ImageLabel", {
                                          Image = Library.TransparencyImage,
                                          ScaleType = Enum.ScaleType.Tile,
                                          TileSize = UDim2.new(8, 0, 0.5, 0),
                                          BackgroundColor3 = Colorpicker.Default[1],
                                          Size = UDim2.new(1, 0, 1, 0),
                                          Name = "TransparencyPicture",
                                          Parent = Components["TransparencyPickerButton"],
                                          BorderSizePixel = 0,
                                          Rotation = 180,
                                          AnchorPoint = Vector2.new(0.5, 0.5),
                                          Position = UDim2.new(0.5, 0, 0.5, 0),
                                    })

                                    Globals:Instance("UIGradient", {
                                          Transparency = NumberSequence.new({
                                                NumberSequenceKeypoint.new(0, 0),
                                                NumberSequenceKeypoint.new(1, 1),
                                          }),
                                          Rotation = 90,
                                          Parent = TransparencyPicture,
                                    })

                                    Globals:Instance("UICorner", {
                                          CornerRadius = UDim.new(0, 4),
                                          Parent = Components["TransparencyPickerButton"],
                                    })

                                    Globals:Instance("UIStroke", {
                                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                          Color = Color3.fromRGB(24, 24, 24),
                                          Parent = Components["TransparencyPickerButton"],
                                    })

                                    local WheelIndicator = Globals:Instance("Frame", {
                                          AnchorPoint = Vector2.new(0.5, 0.5),
                                          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                          BorderColor3 = Color3.fromRGB(0, 0, 0),
                                          BorderSizePixel = 2,
                                          Size = UDim2.new(0, 6, 0, 6),
                                          Name = "WheelIndicator",
                                          Parent = Components["Colorwheel"],
                                    })
                                    Globals:Instance("UICorner", { CornerRadius = UDim.new(1, 0), Parent = WheelIndicator })

                                    local BrightnessIndicator = Globals:Instance("Frame", {
                                          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                          BorderSizePixel = 1,
                                          Size = UDim2.new(1, 0, 0, 2),
                                          Name = "BrightnessIndicator",
                                          Parent = Components["BrightnessPicker"],
                                    })

                                    local TransparencyIndicator = Globals:Instance("Frame", {
                                          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                          BorderSizePixel = 1,
                                          Size = UDim2.new(1, 0, 0, 2),
                                          Name = "TransparencyIndicator",
                                          Parent = Components["TransparencyPickerButton"],
                                    })

                                    Colorpicker.Components = Components

                                    local function FadeInFrame(frame)
                                          frame.Visible = true
                                          Globals:TweenTransparencyIns(frame, 0, 0.2)
                                    end

                                    local function FadeOutFrame(frame)
                                          Globals:TweenTransparencyIns(frame, 1, 0.2)
                                          task.delay(0.2, function()
                                                if frame and frame.Parent then
                                                      frame.Visible = false
                                                end
                                          end)
                                    end

                                    Components["ColorpickerButton"].MouseButton1Down:Connect(function()
                                          local thisFrame = Components["ColorpickerFrame"]
                                          local isOpening = not (thisFrame.Visible and thisFrame.BackgroundTransparency < 1)

                                          for _, child in ipairs(Window.Components.Outline:GetChildren()) do
                                                if child.Name == "ColorpickerFrame" and child ~= thisFrame and child.Visible then
                                                      FadeOutFrame(child)
                                                end
                                          end

                                          if isOpening then
                                                FadeInFrame(thisFrame)
                                          else
                                                FadeOutFrame(thisFrame)
                                          end
                                    end)

                                    local function UpdateIndicators()
                                          local col, transparency = Colorpicker.Value[1], Colorpicker.Value[2]
                                          local h, s, v = col:ToHSV()

                                          local radius = Components["Colorwheel"].AbsoluteSize.X / 2
                                          local angle = h * 2 * math.pi
                                          local distance = s * radius
                                          local offset = Vector2.new(math.cos(angle), math.sin(angle)) * distance

                                          Globals:Tween(WheelIndicator, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                                                Position = UDim2.new(0.5, offset.X, 0.5, offset.Y),
                                          })

                                          Globals:Tween(BrightnessIndicator, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                                                Position = UDim2.new(0, 0, 1 - v, -1),
                                          })

                                          Globals:Tween(TransparencyIndicator, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                                                Position = UDim2.new(0, 0, transparency, -1),
                                          })
                                    end

                                    function Colorpicker:Set(Value)
                                          self.Value = Value

                                          local col = Value[1]
                                          local transparency = Value[2]

                                          Globals:Tween(Components["ColorpickerButton"], TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                                                BackgroundColor3 = col,
                                          })

                                          Globals:Tween(TransparencyPicture, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                                                BackgroundColor3 = col,
                                          })

                                          Globals:Tween(
                                                Components["TransparencyPickerButton"],
                                                TweenInfo.new(0.15, Enum.EasingStyle.Quad),
                                                {
                                                      BackgroundColor3 = col,
                                                }
                                          )

                                          local h, s, v = col:ToHSV()
                                          if v > 0 then
                                                self._LastHue = h
                                                self._LastSaturation = s
                                          end

                                          UpdateIndicators()
                                          Library:DoCallback(self.Callback, Value)
                                    end

                                    function Colorpicker:SetVisibility(visible)
                                          self.Colorpicker.Visible = visible
                                          if self.ColorpickerFrame.Visible and not visible then
                                                self.ColorpickerFrame.Visible = visible
                                          end
                                    end

                                    local function ColorFromWheel(x, y, wheel)
                                          local center = wheel.AbsolutePosition + wheel.AbsoluteSize / 2
                                          local radius = wheel.AbsoluteSize.X / 2
                                          local rel = Vector2.new(x, y) - center
                                          local distance = rel.Magnitude

                                          local hue, sat = 0, 0

                                          if distance > 0 then
                                                hue = math.atan2(rel.Y, rel.X) / (2 * math.pi)
                                                if hue < 0 then
                                                      hue = hue + 1
                                                end
                                                sat = math.clamp(distance / radius, 0, 1)
                                          end

                                          local _, _, v = Colorpicker.Value[1]:ToHSV()
                                          return Color3.fromHSV(hue, sat, v)
                                    end

                                    local function EnableDragging(Component, onDrag)
                                          Component.InputBegan:Connect(function(input)
                                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                                      local moveConn, upConn
                                                      moveConn = RunService.RenderStepped:Connect(function()
                                                            local mousePos = UserInputService:GetMouseLocation()
                                                            local adjustedMousePos = Vector2.new(mousePos.X, mousePos.Y - MouseConstant)

                                                            onDrag(adjustedMousePos)
                                                      end)
                                                      upConn = UserInputService.InputEnded:Connect(function(endInput)
                                                            if endInput.UserInputType == Enum.UserInputType.MouseButton1 then
                                                                  moveConn:Disconnect()
                                                                  upConn:Disconnect()
                                                            end
                                                      end)
                                                end
                                          end)
                                    end

                                    EnableDragging(Components["Colorwheel"], function(mousePosRaw)
                                          local mousePos = Vector2.new(mousePosRaw.X, mousePosRaw.Y - MouseConstant)
                                          local col = ColorFromWheel(mousePos.X, mousePos.Y, Components["Colorwheel"])
                                          Colorpicker:Set({ col, Colorpicker.Value[2] })
                                    end)

                                    EnableDragging(Components["BrightnessPicker"], function(mousePosRaw)
                                          local mousePos = Vector2.new(mousePosRaw.X, mousePosRaw.Y - MouseConstant)
                                          local top = Components["BrightnessPicker"].AbsolutePosition.Y
                                          local height = Components["BrightnessPicker"].AbsoluteSize.Y
                                          local valueY = math.clamp((mousePos.Y - top) / height, 0, 1)

                                          local h, s = Colorpicker._LastHue or 0, Colorpicker._LastSaturation or 0
                                          local v = 1 - valueY

                                          local newColor = Color3.fromHSV(h, s, v)
                                          Colorpicker:Set({ newColor, Colorpicker.Value[2] })
                                    end)

                                    EnableDragging(Components["TransparencyPickerButton"], function(mousePosRaw)
                                          local mousePos = Vector2.new(mousePosRaw.X, mousePosRaw.Y - MouseConstant)
                                          local top = Components["TransparencyPickerButton"].AbsolutePosition.Y
                                          local height = Components["TransparencyPickerButton"].AbsoluteSize.Y
                                          local yVal = math.clamp((mousePos.Y - top) / height, 0, 1)
                                          Colorpicker:Set({ Colorpicker.Value[1], yVal })
                                    end)

                                    Colorpicker:Set(Colorpicker.Default)

                                    Library.Flags[Colorpicker.Flag] = Colorpicker
                                    return Colorpicker
                              end

                              function Section:Keybind(KeybindData)
                                    local Keybind = {
                                          Name = KeybindData.Name,
                                          Flag = KeybindData.Flag,
                                          Default = KeybindData.Default or nil,
                                          Callback = KeybindData.Callback or function() end,
                                          Key = KeybindData.Key or nil,
                                          Mode = KeybindData.Mode or "Toggle",
                                          Active = false,
                                          Class = "Keybind"
                                    }

                                    Keybind.__index = Keybind

                                    local Components = {}

                                    do --// Components
                                          Components["KeybindHolder"] = Globals:Instance("Frame", {
                                                BackgroundTransparency = 1,
                                                Size = UDim2.new(1, 0, 0, 20),
                                                Name = "KeybindHolder",
                                                Parent = self.Components["SectionElements"],
                                          })

                                          Components["KeybindTitle"] = Globals:Instance("TextLabel", {
                                                Font = Enum.Font.SourceSansSemibold,
                                                Text = Keybind.Name,
                                                TextColor3 = Color3.fromRGB(129, 129, 129),
                                                TextSize = 14,
                                                TextXAlignment = Enum.TextXAlignment.Left,
                                                BackgroundTransparency = 1,
                                                Size = UDim2.new(1, 0, 0, 15),
                                                Name = "KeybindTitle",
                                                Parent = Components["KeybindHolder"],
                                          })

                                          Components["KeybindButton"] = Globals:Instance("TextButton", {
                                                Font = Enum.Font.SourceSansSemibold,
                                                Text = "None",
                                                TextColor3 = Color3.fromRGB(135, 135, 135),
                                                TextSize = 14,
                                                TextXAlignment = Enum.TextXAlignment.Center,
                                                AutoButtonColor = false,
                                                BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                                                BorderSizePixel = 0,
                                                Position = UDim2.new(1, -50, 0, 0),
                                                Size = UDim2.new(0, 50, 0, 15),
                                                Name = "KeybindButton",
                                                Parent = Components["KeybindHolder"],
                                          })

                                          Globals:Instance("UICorner", {
                                                CornerRadius = UDim.new(0, 4),
                                                Parent = Components["KeybindButton"],
                                          })

                                          Globals:Instance("UIStroke", {
                                                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                                Color = Color3.fromRGB(24, 24, 24),
                                                Parent = Components["KeybindButton"],
                                          })
                                    end

                                    Keybind.Components = Components

                                    function Keybind:SetVisibility(visible)
                                          self.KeybindHolder.Visible = visible
                                    end

                                    function Keybind:SetKey(input)
                                          if input then
                                                if typeof(input.UserInputType) == "string" then
                                                      input.UserInputType = Enum.UserInputType[input.UserInputType]

                                                      if input.UserInputType == "KeyCode" then
                                                            input.KeyCode = Enum.KeyCode[input.KeyCode]
                                                      end
                                                end

                                                local keyType
                                                local keyValue

                                                if
                                                      input.UserInputType == Enum.UserInputType.MouseButton1
                                                      or input.UserInputType == Enum.UserInputType.MouseButton2
                                                      or input.UserInputType == Enum.UserInputType.MouseButton3
                                                then
                                                      keyType = "MouseButton"
                                                      keyValue = input.UserInputType
                                                elseif input.UserInputType == Enum.UserInputType.Keyboard then
                                                      keyType = "KeyCode"
                                                      keyValue = input.KeyCode
                                                else
                                                      keyType = "UserInputType"
                                                      keyValue = input.UserInputType
                                                end

                                                self.Key = {
                                                      Type = keyType,
                                                      Value = keyValue,
                                                }

                                                Window.Hotkeys:UpdateStatus(
                                                      self.Name,
                                                      self.Active,
                                                      Library:FormatKeyName(Library:GetInputName(input))
                                                )
                                                Components["KeybindButton"].Text = Library:FormatKeyName(Library:GetInputName(input))
                                          else
                                                Window.Hotkeys:UpdateStatus(self.Name, self.Active, "", true)
                                                self.Key = nil
                                                Components["KeybindButton"].Text = "None"
                                          end

                                          Globals:Tween(
                                                Components["KeybindButton"],
                                                TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                {
                                                      TextColor3 = Color3.fromRGB(129, 129, 129),
                                                }
                                          )
                                    end

                                    function Keybind:SetState(state)
                                          self.Active = state
                                          Window.Hotkeys:UpdateStatus(self.Name, self.Active)
                                          Library:DoCallback(self.Callback, state)
                                    end

                                    function Keybind:Set(value)
                                          self.Value = value
                                          self:SetKey(value)
                                    end

                                    function Keybind:Matches(input)
                                          if not self.Key then
                                                return false
                                          end

                                          if self.Key.Type == "KeyCode" then
                                                return input.KeyCode == self.Key.Value
                                          elseif self.Key.Type == "MouseButton" then
                                                return input.UserInputType == self.Key.Value
                                          elseif self.Key.Type == "UserInputType" then
                                                return input.UserInputType == self.Key.Value
                                          end

                                          return false
                                    end

                                    local Listening = false
                                    Library:Connection(
                                          "Keybind_" .. Keybind.Flag .. "_StartListen",
                                          Components["KeybindButton"].MouseButton1Click,
                                          function()
                                                if Listening then
                                                      return
                                                end
                                                Listening = true

                                                Globals:Tween(
                                                      Components["KeybindButton"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            TextColor3 = Color3.fromRGB(11, 11, 11),
                                                      }
                                                )

                                                Components["KeybindButton"].Text = "..."

                                                Globals:Tween(
                                                      Components["KeybindButton"],
                                                      TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                      {
                                                            TextColor3 = Color3.fromRGB(255, 255, 255),
                                                      }
                                                )

                                                local ConnectionName = "Keybind_" .. Keybind.Flag .. "_InputListen"
                                                task.wait(0.06)
                                                Library:Connection(ConnectionName, UserInputService.InputBegan, function(input, gpe)
                                                      if not Listening then
                                                            return
                                                      end
                                                      Listening = false
                                                      Library:Disconnect(ConnectionName)

                                                      if input.KeyCode == Enum.KeyCode.Backspace then
                                                            Keybind:Set(nil)
                                                            return
                                                      end

                                                      if
                                                            input.UserInputType == Enum.UserInputType.MouseButton1
                                                            or input.UserInputType == Enum.UserInputType.MouseButton2
                                                            or input.UserInputType == Enum.UserInputType.MouseButton3
                                                            or input.UserInputType == Enum.UserInputType.Keyboard
                                                      then
                                                            Keybind:SetKey(input)
                                                      end
                                                end)
                                          end
                                    )

                                    Library:Connection(
                                          "Keybind_" .. Keybind.Flag .. "_InputBegan",
                                          UserInputService.InputBegan,
                                          function(input, gpe)
                                                if gpe or Listening or not Keybind.Key then
                                                      return
                                                end

                                                if Keybind:Matches(input) then
                                                      if Keybind.Mode == "Toggle" then
                                                            Keybind:SetState(not Keybind.Active)
                                                      elseif Keybind.Mode == "Callback" then
                                                            Library:DoCallback(Keybind.Callback)
                                                      elseif Keybind.Mode == "Hold" then
                                                            Keybind:SetState(true)
                                                            Keybind.Active = true
                                                      end
                                                end
                                          end
                                    )

                                    Library:Connection(
                                          "Keybind_" .. Keybind.Flag .. "_InputEnded",
                                          UserInputService.InputEnded,
                                          function(input, gpe)
                                                if gpe or Listening or not Keybind.Key then
                                                      return
                                                end

                                                if Keybind:Matches(input) and Keybind.Mode == "Hold" and Keybind.Active then
                                                      Keybind:SetState(false)
                                                      Keybind.Active = false
                                                end
                                          end
                                    )

                                    Keybind:Set(Keybind.Default)
                                    Library.Flags[Keybind.Flag] = Keybind
                                    return Keybind
                              end

                              Section.Components = Components
                              Category.Sections[Section.Name] = Section
                              return Section
                        end

                        Category.Components = Components

                        do --// Connections
                              Library:Connection(
                                    "PageHandler" .. Category.Name,
                                    Components["CategoryButton"].MouseButton1Down,
                                    function()
                                          Window:SetCategory({
                                                Name = Tab.Name .. "_" .. Category.Name,
                                                Pointer = Category,
                                                Parent = Tab,
                                          })
                                    end
                              )

                              Library:Connection(
                                    "CategoryMouseEnter" .. Category.Name,
                                    Components.CategoryButton.MouseEnter,
                                    function()
                                          Globals:Tween(
                                                Components["CategoryStroke"],
                                                TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                {
                                                      Color = Library.Theme.AccentedHighlight,
                                                }
                                          )
                                    end
                              )

                              Library:Connection(
                                    "CategoryMouseLeave" .. Category.Name,
                                    Components.CategoryButton.MouseLeave,
                                    function()
                                          if Components["CategoryButton"]:GetAttribute("Opened") then
                                                return
                                          end
                                          Globals:Tween(
                                                Components["CategoryStroke"],
                                                TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad),
                                                {
                                                      Color = Color3.fromRGB(24, 24, 24),
                                                }
                                          )
                                    end
                              )
                        end

                        table.insert(Tab.CategoryOrder, Category.Name)
                        Tab.Categories[Category.Name] = Category
                        return Category
                  end

                  Tab.Components = Components
                  Window.Tabs[TabData.Name] = Tab
                  return Tab
            end

            function Window:TabSeperator()
                  local Components = {}

                  Components["TabSeparatorHolder"] = Globals:Instance("Frame", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 1),
                        Name = "TabSeparatorHolder",
                        Parent = self.Components["TabsScrollingFrame"],
                  })

                  Components["TabSeparatorLine"] = Globals:Instance("Frame", {
                        AnchorPoint = Vector2.new(0, 0.5),
                        BackgroundColor3 = Color3.fromRGB(24, 24, 24),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0.5, 0),
                        Size = UDim2.new(1, -7, 1, 0),
                        Name = "TabSeparatorLine",
                        Parent = Components["TabSeparatorHolder"],
                  })

                  return Components
            end

            Window.Components = Components
            Library.Window = Window
            return Window
      end

      function Library:Notify(txt, duration, color)
            duration = duration or 3
            color = color or Color3.fromRGB(63, 201, 176)

            local Components = {}
            local Padding = 12
            local IconSize = 25
            local TextPadding = 5
            local LabelFontSize = 14
            local BottomBufferSize = 4

            local TemporaryLabel = Instance.new("TextLabel")
            TemporaryLabel.Size = UDim2.new(1, 0, 1, 0)
            TemporaryLabel.TextSize = LabelFontSize
            TemporaryLabel.Font = Enum.Font.SourceSansBold
            TemporaryLabel.Text = txt
            TemporaryLabel.TextWrapped = true
            TemporaryLabel.Parent = Library.Notifications
            TemporaryLabel.Visible = false

            task.wait()
            local TextBounds = TemporaryLabel.TextBounds
            TemporaryLabel:Destroy()

            local NotificationHeight = math.max(TextBounds.Y + BottomBufferSize, IconSize)
            local NotificationWidth = IconSize + TextBounds.X + TextPadding * 2

            local YPosition = 75
            for _, NotificationData in ipairs(Library.NotificationList) do
                  YPosition = YPosition + NotificationData.Height + Padding
            end

            Components["NewNotification"] = Globals:Instance("Frame", {
                  BackgroundColor3 = Color3.fromRGB(11, 11, 11),
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, -NotificationWidth - 20, 0, YPosition),
                  Size = UDim2.new(0, NotificationWidth, 0, NotificationHeight),
                  Name = "NewNotification",
                  Parent = Library.Notifications,
            })

            Globals:Instance("UICorner", {
                  CornerRadius = UDim.new(0, 3),
                  Parent = Components["NewNotification"],
            })

            Globals:Instance("ImageLabel", {
                  Image = Library.ShadowImage,
                  ImageColor3 = color,
                  ImageTransparency = 0.7,
                  ScaleType = Enum.ScaleType.Slice,
                  SliceCenter = Rect.new(49, 49, 450, 450),
                  AnchorPoint = Vector2.new(0.5, 0.5),
                  BackgroundTransparency = 1,
                  BorderSizePixel = 0,
                  Position = UDim2.new(0.5, 0, 0.5, 0),
                  Size = UDim2.new(1, 30, 1, 30),
                  ZIndex = 0,
                  Parent = Components["NewNotification"],
            })

            Globals:Instance("UIStroke", {
                  Color = Color3.fromRGB(24, 24, 24),
                  Parent = Components["NewNotification"],
            })

            Globals:Instance("TextLabel", {
                  Font = Enum.Font.SourceSansBold,
                  Text = txt,
                  TextColor3 = Color3.new(1, 1, 1),
                  TextSize = LabelFontSize,
                  TextXAlignment = Enum.TextXAlignment.Left,
                  BackgroundTransparency = 1,
                  Position = UDim2.new(0, IconSize + TextPadding, 0, 0),
                  Size = UDim2.new(1, -IconSize - TextPadding * 2, 1, 0),
                  TextWrapped = true,
                  Parent = Components["NewNotification"],
            })

            Globals:Instance("ImageLabel", {
                  Image = Library.LogoImage,
                  ImageColor3 = color,
                  BackgroundTransparency = 1,
                  Size = UDim2.new(0, IconSize, 0, IconSize),
                  Position = UDim2.new(0, 0, 0.5, -IconSize / 2),
                  Parent = Components["NewNotification"],
            })

            table.insert(Library.NotificationList, {
                  Frame = Components["NewNotification"],
                  Height = NotificationHeight,
            })

            Globals:Tween(
                  Components["NewNotification"],
                  TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                  {
                        Position = UDim2.new(0, 10, 0, YPosition),
                  }
            )

            local CurrentY = 75
            for _, NotificationData in ipairs(Library.NotificationList) do
                  Globals:Tween(NotificationData.Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.new(0, 10, 0, CurrentY),
                  })
                  CurrentY = CurrentY + NotificationData.Height + Padding
            end

            task.delay(duration, function()
                  for _, child in pairs(Components["NewNotification"]:GetChildren()) do
                        if child:IsA("TextLabel") then
                              Globals:Tween(child, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { TextTransparency = 1 })
                        elseif child:IsA("ImageLabel") then
                              Globals:Tween(child, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { ImageTransparency = 1 })
                        elseif child:IsA("UIStroke") then
                              Globals:Tween(child, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { Transparency = 1 })
                        end
                  end

                  task.wait(0.2)
                  local IterationToRemove
                  for i, NotificationData in ipairs(Library.NotificationList) do
                        if NotificationData.Frame == Components["NewNotification"] then
                              IterationToRemove = i
                              break
                        end
                  end

                  if IterationToRemove then
                        Library.NotificationList[IterationToRemove].Frame:Destroy()
                        table.remove(Library.NotificationList, IterationToRemove)
                  end

                  CurrentY = 75
                  for _, NotificationData in ipairs(Library.NotificationList) do
                        Globals:Tween(
                              NotificationData.Frame,
                              TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                              {
                                    Position = UDim2.new(0, 10, 0, CurrentY),
                              }
                        )
                        CurrentY = CurrentY + NotificationData.Height + Padding
                  end
            end)
      end
end)()

Log("Loaded UI library.")
--#endregion Library

--#region Threads
Threads.__index = Threads

Threads.Run = LPH_NO_VIRTUALIZE(function(self)
	local Success, Error = pcall(self.Function)
	if not Success and Error then
            Log('Error: ' .. tostring(Error));
		Library:Notify("Error occured. "..tostring(Error), 1, Color3.fromRGB(255, 0, 0))
	end;
end)

Threads.New = LPH_NO_VIRTUALIZE(function(Name, Function, Priority)
	local Thread = setmetatable({
		Name = Name,
		Function = Function,
		Priority = Priority,
	}, Threads)

	if not Priority then
		Priority = "Render"
	end
	Thread.Priority = Priority

	local Index = #Threads[Priority] + 1
	Threads[Priority][Index] = Thread
	return Threads[Priority][Index]
end)
Log("Loaded threads library.")
--#endregion Threads

--#region Math
Math.RoundToIncrement = LPH_NO_VIRTUALIZE(function(value, increment)
	return math.round(value / increment) * increment
end)

Math.FloorVector = LPH_NO_VIRTUALIZE(function(Vector)
	if typeof(Vector) == "Vector2" then
		return Vector2.new(math.floor(Vector.X), math.floor(Vector.Y))
	else
		return Vector3.new(math.floor(Vector.X), math.floor(Vector.Y), math.floor(Vector.Z))
	end
end)
Log("Loaded math library.")
--#endregion Math

--#region Visuals
Visuals.Hitmarkers = {};

--// FOV
Visuals.FOVSpace = Globals:Instance("ScreenGui", { 
	Parent = CoreGui,
	IgnoreGuiInset = true;
});

Visuals.FOVOutline = Globals:Instance("Frame", { 
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	BackgroundTransparency = 1,
	ZIndex = 9999,
	Size = UDim2.new(0, 500, 0, 500),
	Visible = true,
	Parent = Visuals.FOVSpace,
	Visible = false,
});

Visuals.FOVCircle = Globals:Instance("Frame", { 
	BackgroundTransparency = 1,
	ZIndex = 9999,
	Position = UDim2.new(0, -1, 0, -1),
	Size = UDim2.new(1, 2, 1, 2),
	Visible = true,
	Parent = Visuals.FOVOutline,
	BackgroundColor3 = Library.Theme.Accent,
});

Visuals.FOVInline = Globals:Instance("Frame", { 
	Size = UDim2.new(1, -2, 1, -2),
	Position = UDim2.new(0, 1, 0, 1),
	BackgroundTransparency = 0.8,
	Parent = Visuals.FOVCircle,
	BackgroundColor3 = Library.Theme.Accent,
});

Visuals.FOVCircleCorner = Globals:Instance("UICorner", { 
	CornerRadius = UDim.new(1, 0),
	Parent = Visuals.FOVCircle,
});

Visuals.FOVInlineCorner = Globals:Instance("UICorner", { 
	CornerRadius = UDim.new(1, 0),
	Parent = Visuals.FOVInline
});

Visuals.FOVCircleStroke = Globals:Instance("UIStroke", { 
	Parent = Visuals.FOVCircle,
	Thickness = 3,
	Color = Library.Theme.Accent
});

Visuals.FOVOutlineStroke = Globals:Instance("UIStroke", { 
	Thickness = 5,
	Color = Color3.new(),
	Parent = Visuals.FOVOutline
});

Visuals.FOVOutlineCorner = Globals:Instance("UICorner", { 
	CornerRadius = UDim.new(1, 0),
	Parent = Visuals.FOVOutline
});
--

--// Crosshair 
Visuals.CrosshairHolder = Globals:Instance("Frame", { 
	Position = UDim2.new(0, Camera.ViewportSize.X /2 , 0, Camera.ViewportSize.Y / 2),
	Size = UDim2.new(0, 100, 0, 100),
	BackgroundTransparency = 1,
	Parent = Library.HeadsUp,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Visible = false,
});

Visuals.CrosshairTop = Globals:Instance("Frame", { 
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(255,255, 255),
	BorderColor3 = Color3.fromRGB(),
	BorderMode = Enum.BorderMode.Middle,
	Position = UDim2.new(0.5, 0, 0.5, -20),
	Size = UDim2.new(0, 2, 0, 20),
	Parent = Visuals.CrosshairHolder
});

Visuals.CrosshairTopGradient = Globals:Instance("UIGradient", { 
	Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	},
	Rotation = -90,
	Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.694513738155365, 0.5249999761581421),
		NumberSequenceKeypoint.new(0.8503741025924683, 0.78125),
		NumberSequenceKeypoint.new(1, 0.862500011920929)
	},
	Parent = Visuals.CrosshairTop
});

Visuals.CrosshairBottom = Globals:Instance("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BorderColor3 = Color3.fromRGB(0, 0, 0),
	BorderMode = Enum.BorderMode.Middle,
	Position = UDim2.new(0.5, 0, 0.5, 20),
	Size = UDim2.new(0, 2, 0, 20),
	Parent = Visuals.CrosshairHolder,
	Name = "Bottom"
})

Visuals.CrosshairBottomGradient = Globals:Instance("UIGradient", {
	Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	},
	Rotation = 90,
	Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.6945, 0.525),
		NumberSequenceKeypoint.new(0.8504, 0.78125),
		NumberSequenceKeypoint.new(1, 0.8625)
	},
	Parent = Visuals.CrosshairBottom
});

Visuals.CrosshairLeft = Globals:Instance("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BorderColor3 = Color3.fromRGB(0, 0, 0),
	BorderMode = Enum.BorderMode.Middle,
	Position = UDim2.new(0.5, -20, 0.5, 0),
	Size = UDim2.new(0, 20, 0, 2),
	Parent = Visuals.CrosshairHolder,
	Name = "Left"
})

Visuals.CrosshairLeftGradient = Globals:Instance("UIGradient", {
	Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	},
	Rotation = 180,
	Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.6945, 0.525),
		NumberSequenceKeypoint.new(0.8504, 0.78125),
		NumberSequenceKeypoint.new(1, 0.8625)
	},
	Parent = Visuals.CrosshairLeft
});

Visuals.CrosshairRight = Globals:Instance("Frame", {
	Name = "Right",
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BorderColor3 = Color3.fromRGB(0, 0, 0),
	BorderMode = Enum.BorderMode.Middle,
	Position = UDim2.new(0.5, 20, 0.5, 0),
	Size = UDim2.new(0, 20, 0, 2),
	Parent = Visuals.CrosshairHolder
});

Visuals.CrosshairRightGradient = Globals:Instance("UIGradient", {
	Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
	},
	Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.694513738155365, 0.5249999761581421),
		NumberSequenceKeypoint.new(0.8503741025924683, 0.78125),
		NumberSequenceKeypoint.new(1, 0.862500011920929)
	},
	Parent = Visuals.CrosshairRight
});
--

--// ESP 
Visuals.MiscSpace = Globals:Instance("ScreenGui", {
	Parent = CoreGui,
	IgnoreGuiInset = true,
	DisplayOrder = 0,
	Name = "Misc Space",
});

Visuals.ESPSpace = Globals:Instance("ScreenGui", {
	Parent = CoreGui,
	IgnoreGuiInset = true,
	DisplayOrder = 0,
	Name = "ESP Space",
});

Visuals.LOSFrame = Globals:Instance("Frame", { 
	AnchorPoint = Vector2.new(0.5, 0),
	BackgroundTransparency = 1, 
	Size = UDim2.new(0, 500, 0, 500),
	Parent = Visuals.ESPSpace,
	Position = UDim2.new(0.5, 0, 0, 100)
});

Visuals.LOSLayout = Globals:Instance("UIListLayout", { 
	Parent = Visuals.LOSFrame, 
	Padding = UDim.new(0, 3),
});
--

--// Functions
Visuals.CreateHitmarker = LPH_NO_VIRTUALIZE(function(Part, Position) 
	local Index = #Visuals.Hitmarkers+1
	local Hitmarker = Globals:Instance("ImageLabel", { 
		Image = GetImage("HitmarkerImage");
		Size = UDim2.new(0, Library.Flags.HitmarkerSize.Value + 10, 0, Library.Flags.HitmarkerSize.Value + 10);
		BackgroundTransparency = 1;
		AnchorPoint = Vector2.new(0.5, 0.5);
		Parent = Visuals.ESPSpace,
		ZIndex = Library.Flags.PrioritizeHitmarkers.Value and 5 or 1,
		ImageTransparency = 1,
		ImageColor3 = Library.Flags.HitmarkerColor.Value[1];
		Visible = true;
	});

	Visuals.Hitmarkers[Index] = { 
		Position = Position,
		Part = Part,
		Hitmarker = Hitmarker;
	};

	Globals:Tween(Hitmarker, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
		ImageTransparency = 0;
		Size = UDim2.new(0, Library.Flags.HitmarkerSize.Value, 0, Library.Flags.HitmarkerSize.Value);
	});

	if Library.Flags.HitmarkerRandomRotation.Value then 
		Globals:Tween(Hitmarker, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			Rotation = math.random(-90, 90)
		});
	end;

	Delay(Library.Flags.HitmarkerTime.Value, function() 
		local Tween = Globals:Tween(Hitmarker, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
			ImageTransparency = 1;
		});
		Tween.Completed:Wait() 
		Hitmarker:Destroy() 
		Visuals.Hitmarkers[Index] = nil
	end)
end);

Visuals.DrawLine = LPH_NO_VIRTUALIZE(function()
	local Frame = Drawing.new("Line");
	Frame.Visible = false;
	Frame.ZIndex = 2;
	Frame.Color = Color3.fromRGB(255, 255, 255);
	return Frame;
end);

Visuals.DrawOutline = LPH_NO_VIRTUALIZE(function()
	local Frame = Drawing.new("Line");
	Frame.Visible = false;
	Frame.ZIndex = 1;
	Frame.Thickness = 3
	Frame.Color = Color3.fromRGB(0, 0, 0);
	return Frame;
end);

Visuals.IsPartVisible = LPH_NO_VIRTUALIZE(function(Part, Origin)
	if not Part then
		return nil
	end

	if not Origin then 
		Origin = Camera.CFrame.p;
	end;

	local Direction = (Part.CFrame.p - Origin).Unit * ((Part.CFrame.p - Origin).Magnitude + 10)

	local Params = Globals.RaycastParams

	local RayResult = Workspace:Raycast(Origin, Direction, Params)

	if RayResult and RayResult.Instance and RayResult.Instance:IsDescendantOf(Part.Parent) then
		return true
	end

	return nil
end);

Visuals.GetDistanceFromCenter = LPH_NO_VIRTUALIZE(function(part)
	local position = part 
	if typeof(part) == "Instance" then 
		position = part.CFrame.p 
	end 
	local ScreenPosition, OnScreen = Camera:WorldToViewportPoint(position);
	if OnScreen then
		local Center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
		return (Center - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
	end
	return math.huge 
end);
--

Log("Loaded visuals library.")
--#endregion Visuals

--#region EntityClass Global
EntityClass.__index = EntityClass
EntityClass.Global.__index = EntityClass.Global
EntityClass.Main.__index = EntityClass.Main
EntityClass.Main.Functions.__index = EntityClass.Main.Functions

EntityClass.Global.FindVisiblePosition = LPH_NO_VIRTUALIZE(function(Origin, Destination)
	local OriginalDestination = Destination
	if typeof(Origin) ~= "Vector3" then Origin = Origin.Position end

	local CameraCFrame = Camera.CFrame

	local ManipulationOffsets = {
		CameraCFrame * CFrame.new(3, 0, 0),
		CameraCFrame * CFrame.new(-3, 0, 0),
		CameraCFrame * CFrame.new(-6, 0, 0),
		CameraCFrame * CFrame.new(6, 0, 0),
		CameraCFrame * CFrame.new(3, 2, 0),
		CameraCFrame * CFrame.new(-3, 2, 0),
		CameraCFrame * CFrame.new(-6, 2, 0),
		CameraCFrame * CFrame.new(6, 2, 0),
		CameraCFrame * CFrame.new(4, 0, 0),
		CameraCFrame * CFrame.new(-4, 2, 0),
		CameraCFrame * CFrame.new(-4, 0, 0),
		CameraCFrame * CFrame.new(4, 2, 0),
		CameraCFrame * CFrame.new(7, 0, 0),
		CameraCFrame * CFrame.new(-7, 2, 0),
		CameraCFrame * CFrame.new(-7, 0, 0),
		CameraCFrame * CFrame.new(7, 2, 0),
		CameraCFrame * CFrame.new(0.2, 3.9, 0),
		CameraCFrame * CFrame.new(1.8, 4.1, 1),
		CameraCFrame * CFrame.new(2.1, 4.4, 1.1),
		CameraCFrame * CFrame.new(0.15, 5.2, 0.1),
		CameraCFrame * CFrame.new(-1.8, 5.4, -0.2),
		CameraCFrame * CFrame.new(-2.3, 6.35, -0.4),
		CameraCFrame * CFrame.new(0.1, 7.5, 0),
		CameraCFrame * CFrame.new(0.1, 8, 0),
		CameraCFrame * CFrame.new(0.1, 8, 0),
	}

	for _, offset in ManipulationOffsets do
		local newOrigin = offset.Position

		if Visuals.IsPartVisible(Destination, newOrigin) then
			return newOrigin
		end
	end

	return nil;
end);

EntityClass.Global.Create = LPH_NO_VIRTUALIZE(function(self, Object, Data)
	if typeof(Object) ~= "Instance" then
		rconsoleprint(
			"corescript",
			"invalid argument #2 <instance> expected. Did you index instead of namecall?",
			"Type recieved:",
			typeof(Object)
		)
		return
	end

	if typeof(Data) ~= "table" then
		rconsoleprint(
			"corescript",
			"invalid argument #3 <table> expected. Did you index instead of namecall?",
			"Type recieved:",
			typeof(Data)
		)
		return
	end

	local Entity = setmetatable({
		Name = Data.Name or Object.Name,
		Character = Data.Character or (Object:IsA("Player") and Object.Character),
		DisplayName = Object:IsA("Player") and Object.DisplayName or (Data.Name or Object.Name),
		Components = {},
		LastOffscreenRefresh = tick(),
		LastChamsRefresh = tick(),
		LastUpdate = tick(),
		Components = EntityClass.Main.Functions.CreateComponents(),
		CachedArmor = {},
		CachedItem = nil,
		CachedAttachments = {},
		ItemHistory = {},
		Class = Data.Class,
		ClassType = Data.ClassType,
		Pointer = Object,
		Adornments = {},
	}, EntityClass.Main.Functions)

	EntityClass.Main.Cache[Object] = Entity
	return Entity
end);

Log("Loaded EntityClass Global library.")
--#endregion EntityClass Global

--#region EntityClass Main
EntityClass.FlagProperties = { 
	Size = UDim2.new(0, 200, 0, 7),
	FontFace = Fonts.SmallestPixel, 
	TextSize = 8, 
	BackgroundTransparency = 1,
	TextTransparency = 1,
	TextStrokeTransparency = 1, 
	Text = "",
	ClipsDescendants = false,
	TextXAlignment = Enum.TextXAlignment.Left;
	TextYAlignment = Enum.TextYAlignment.Top;
};

EntityClass.Main.Functions.__index = EntityClass.Main.Functions;

EntityClass.Main.Functions.Remove = LPH_NO_VIRTUALIZE(function(self, Instance) 
	local ObjectPointer = EntityClass.Main.Cache[Instance];
	if not ObjectPointer then return end; 

	ObjectPointer.Components.LookAngle:Remove();
	ObjectPointer.Components.LookAngleOutline:Remove();

	for Index, Value in ObjectPointer.Components do 
		if Index == "Corners" or Index == "LookAngle" or Index == "Skeleton" or Index == "LookAngleOutline" then continue end;
		Value:Destroy();
	end;

	for Index, Value in ObjectPointer.Components.Corners do 
		Value:Destroy();
	end; 

	for Index, Value in ObjectPointer.Components.Skeleton do 
		Value:Remove();
	end; 

	EntityClass.Main.Cache[Instance] = nil;
end);

EntityClass.Main.Functions.ApplyArmorVisuals = LPH_NO_VIRTUALIZE(function(self, Instance)
	if Instance:IsA("MeshPart") and Instance.Transparency ~= 1 then 
		Instance:SetAttribute("OriginalMaterial", Instance.Material);
		Instance:SetAttribute("OriginalColor", Instance.Color);
		Instance:SetAttribute("OriginalTextureId", Instance.TextureID);
		Instance:SetAttribute("OriginalReflectance", Instance.Reflectance)
		Instance.CanQuery = false; 

		if Library.Flags["Sandbox"..self.ClassType] and Library.Flags["Sandbox"..self.ClassType].Value then 
			Instance.Color = Library.Flags[self.ClassType.."ArmorColor"].Value[1]; 
			Instance.Reflectance = Library.Flags[self.ClassType.."ArmorReflectance"].Value * Library.Flags[self.ClassType.."ArmorReflectanceMul"].Value;
			Instance.Material = Library.Flags[self.ClassType.."ArmorMaterial"].Value;
			if Instance:IsA("MeshPart") and Instance.Material == Enum.Material.ForceField then 
				Instance.TextureID = "rbxassetid://10913193650";
			elseif Instance:IsA("MeshPart") and Instance.Material ~= Enum.Material.ForceField then 
				Instance.TextureID = "";
			end;
		else 
			Instance.Color = Instance:GetAttribute("OriginalColor");
			Instance.Material = Instance:GetAttribute("OriginalMaterial");
			Instance.Reflectance = Instance:GetAttribute("OriginalReflectance")
			if Instance:IsA("MeshPart") then 
				Instance.TextureID = Instance:GetAttribute("OriginalTextureId")
			end;
		end;
	end;
end);

EntityClass.Main.Functions.OnCharacterAdded = LPH_NO_VIRTUALIZE(function(self, Character) 
	self.CachedArmor = {}
	self.CachedItem = nil;
	if not Character then 
		rconsoleprint("invalid argument #1, <Instance> expected, got", typeof(Character))
		return
	end;

	for Index, Child in next, Character:GetChildren() do 
		if table.find(EntityClass.ItemList, Child.Name) then 
			self.CachedItem = Child;
		end;

		if Child.Name:find("Armor") then 
			for Index, MeshPart in Child:GetChildren() do 
				self:ApplyArmorVisuals(MeshPart)
			end;

			if Globals.ArmorNames[Child.Name] then 
				local Info = Globals.ArmorNames[Child.Name]
				self.CachedArmor[Child] = {
					Name = Info.Name,
					Skin = Info.Skin
				};

			else 
				local ModelName = Child.Name;

				local ArmorSplit = ModelName:split("/");

				if not ArmorSplit then return end;
				local ArmorFormat = ArmorSplit[1]
				local Skin = ArmorSplit[2];

				local ArmorFormatSplit = ArmorFormat:split("_");
				local ArmorId = ArmorFormatSplit[2];
				ArmorId = tonumber(ArmorId)
				local ArmorInfo = Globals.ArmorIds[ArmorId]

				if ArmorInfo then 
					self.CachedArmor[Child] = { 
						Name = ArmorInfo.Name,
						Skin = Skin
					};

					Globals.ArmorNames[Child.Name] = {
						Name = ArmorInfo.Name,
						Skin = Skin
					};
				end;
			end;
		end; 
	end;

	Character.ChildAdded:Connect(function(Child)
		task.wait(0.3);
		if Child and table.find(EntityClass.ItemList, Child.Name) then 
			self.CachedItem = Child;
		end;

		if Child and Child.Name:find("Armor") then 

			for Index, MeshPart in Child:GetChildren() do 
				self:ApplyArmorVisuals(MeshPart)
			end;

			if Globals.ArmorNames[Child.Name] then 
				local Info = Globals.ArmorNames[Child.Name]
				self.CachedArmor[Child] = {
					Name = Info.Name,
					Skin = Info.Skin
				};

			else 
				local ModelName = Child.Name;

				local ArmorSplit = ModelName:split("/");

				if not ArmorSplit then return end;
				local ArmorFormat = ArmorSplit[1]
				local Skin = ArmorSplit[2];

				local ArmorFormatSplit = ArmorFormat:split("_");
				local ArmorId = ArmorFormatSplit[2];
				ArmorId = tonumber(ArmorId)
				local ArmorInfo = Globals.ArmorIds[ArmorId]
                        if (not ArmorInfo) then
                              return;
                        end;

				self.CachedArmor[Child] = { 
					Name = ArmorInfo.Name,
					Skin = Skin
				};

				Globals.ArmorNames[Child.Name] = {
					Name = ArmorInfo.Name,
					Skin = Skin
				};
			end;
		end;   
	end);

	Character.ChildRemoved:Connect(function(Child) 
		if self.CachedItem == Child then 
			self.CachedItem = nil;
		end;

		if self.CachedArmor[Child] then 
			self.CachedArmor[Child] = nil;
		end;
	end)
end);

EntityClass.Main.Functions.CreateComponents = LPH_NO_VIRTUALIZE(function(self)
	local Components = {}

	--// Box Outline
	Components.BoxOutline = Globals:Instance("Frame", {
		Parent = Visuals.ESPSpace,
		Visible = false,
		BackgroundTransparency = 1,
		ZIndex = 2,
	})

	Components.BoxOutlineStroke = Globals:Instance("UIStroke", {
		Parent = Components.BoxOutline,
		Thickness = 3,
		Color = Color3.fromRGB(0, 0, 0),
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		LineJoinMode = Enum.LineJoinMode.Miter,
	})
	--

	--// Box Inline 
	Components.BoxInline = Globals:Instance("Frame", { 
		Parent = Components.BoxOutline,
		Visible = true,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, -1, 0, -1),
		Size = UDim2.new(1, 2, 1, 2),
		ZIndex = 2
	})

	Components.BoxInlineStroke = Globals:Instance("UIStroke", { 
		Parent = Components.BoxInline, 
		LineJoinMode = Enum.LineJoinMode.Miter, 
		Color = Color3.fromRGB(255, 255, 255)
	})
	--

	--// Corners
	Components.FakeCornerBox = Globals:Instance("Frame", { 
		Parent = Components.BoxOutline, 
		BackgroundTransparency = 1, 
		Size = UDim2.new(1, 4, 1, 2),
		Position = UDim2.new(0, -2, 0, -1),
	});

	local Corners = {}

	local CornerWidth = 0.3
	local CornerHeight = 0.3
	local Thickness = 1
	local Offset = -Thickness

	--// Inline
	Corners[1] = Instance.new("Frame")
	Corners[1].Parent = Components.FakeCornerBox
	Corners[1].Size = UDim2.new(CornerWidth, 0, 0, Thickness)
	Corners[1].Position = UDim2.new(0, 0, 0, Offset)
	Corners[1].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Corners[1].BorderSizePixel = 0
	Corners[1].Visible = false

	Corners[2] = Instance.new("Frame")
	Corners[2].Parent = Components.FakeCornerBox
	Corners[2].Size = UDim2.new(0, Thickness, CornerHeight, 0)
	Corners[2].Position = UDim2.new(0, 0, 0, Offset)
	Corners[2].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Corners[2].BorderSizePixel = 0

	Corners[3] = Instance.new("Frame")
	Corners[3].Parent = Components.FakeCornerBox
	Corners[3].Size = UDim2.new(CornerWidth, 0, 0, Thickness)
	Corners[3].Position = UDim2.new(1 - CornerWidth, 0, 0, Offset)
	Corners[3].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Corners[3].BorderSizePixel = 0

	Corners[4] = Instance.new("Frame")
	Corners[4].Parent = Components.FakeCornerBox
	Corners[4].Size = UDim2.new(0, Thickness, CornerHeight, 0)
	Corners[4].Position = UDim2.new(1, -Thickness, 0, Offset)
	Corners[4].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Corners[4].BorderSizePixel = 0

	Corners[5] = Instance.new("Frame")
	Corners[5].Parent = Components.FakeCornerBox
	Corners[5].Size = UDim2.new(0, Thickness, CornerHeight, 0)
	Corners[5].Position = UDim2.new(0, 0, 1 - CornerHeight, 0)
	Corners[5].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Corners[5].BorderSizePixel = 0

	Corners[6] = Instance.new("Frame")
	Corners[6].Parent = Components.FakeCornerBox
	Corners[6].Size = UDim2.new(CornerWidth, 0, 0, Thickness)
	Corners[6].Position = UDim2.new(0, 0, 1, 0)
	Corners[6].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Corners[6].BorderSizePixel = 0

	Corners[7] = Instance.new("Frame")
	Corners[7].Parent = Components.FakeCornerBox
	Corners[7].Size = UDim2.new(0, Thickness, CornerHeight, 0)
	Corners[7].Position = UDim2.new(1, -Thickness, 1 - CornerHeight, 0)
	Corners[7].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Corners[7].BorderSizePixel = 0

	Corners[8] = Instance.new("Frame")
	Corners[8].Parent = Components.FakeCornerBox
	Corners[8].Size = UDim2.new(CornerWidth, 0, 0, Thickness)
	Corners[8].Position = UDim2.new(1 - CornerWidth, 0, 1, 0)
	Corners[8].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Corners[8].BorderSizePixel = 0

	--// Outline (same layout, just with BorderSizePixel = 1)
	for i = 9, 16 do
		local base = Corners[i - 8]:Clone()
		base.Parent = Components.FakeCornerBox
		base.BorderSizePixel = 1
		base.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Corners[i] = base
	end

	Components.Corners = Corners
	--

	--// Healthbar 
	Components["Healthbar"] = Globals:Instance("Frame", { 
		Parent = Components.BoxOutline, 
		Size = UDim2.new(0, 1, 1, 4),
		Position = UDim2.new(0, -6, 0, -2),
		BackgroundColor3 = Color3.fromRGB(255, 0, 0),
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 1,
		Visible = false
	});

	Components["HealthbarBlackout"] = Globals:Instance("Frame", { 
		BackgroundColor3 = Color3.fromRGB(),
		Size = UDim2.new(0, 0, 0, 0),
		Parent = Components.Healthbar;
		BorderSizePixel = 0,
		Visible = false
	});

	Components.Health = Globals:Instance("TextLabel", { 
		BackgroundTransparency = 1, 
		Parent = Components.HealthbarBlackout,
		Visible = false,
		FontFace = EntityClass.Font,
		TextSize = EntityClass.FontSize, 
		TextXAlignment = Enum.TextXAlignment.Right, 
		TextYAlignment = Enum.TextYAlignment.Top,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Text = "",
		Size = UDim2.new(0, 20, 0, 12),
		Position = UDim2.new(-1, -23, 0, -2)
	});

	Components.HealthStroke = Globals.ApplyTextStroke(Components.Health);
	--

	--// Name 
	Components.Name = Globals:Instance("TextLabel", { 
		Parent = Components.BoxOutline, 
		FontFace = EntityClass.Font, 
		TextSize = EntityClass.FontSize, 
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Size = UDim2.new(1, 0, 0, 14),
		Position = UDim2.new(0, 0, 0, -17),
		TextStrokeTransparency = 1,
		Visible = false,
	});

	Components.NameStroke = Globals.ApplyTextStroke(Components.Name)
	--

	--// Weapon 
	Components.Distance = Globals:Instance("TextLabel", { 
		Parent = Components.BoxOutline,
		ZIndex = 1,
		TextSize = EntityClass.FontSize, 
		Size = UDim2.new(1, 0, 0, 14),
		Position = UDim2.new(0, 0, 1, 6),
		TextStrokeTransparency = 1,
		Visible = false,
		Text = "",
		BackgroundTransparency = 1,
		FontFace = EntityClass.Font, 
		TextColor3 = Color3.fromRGB(255, 255, 255),

	});
	Components.DistanceStroke = Globals.ApplyTextStroke(Components.Distance)
	--

	--// Weapon 
	Components.Weapon = Globals:Instance("TextLabel", { 
		Parent = Components.BoxOutline,
		ZIndex = 1,
		TextSize = EntityClass.FontSize, 
		Size = UDim2.new(1, 0, 0, 14),
		Position = UDim2.new(0, 0, 1, 6),
		TextStrokeTransparency = 1,
		Visible = false,
		Text = "",
		BackgroundTransparency = 1,
		FontFace = EntityClass.Font, 
		TextColor3 = Color3.fromRGB(255, 255, 255),

	});
	Components.WeaponStroke = Globals.ApplyTextStroke(Components.Weapon)
	--

	--// Weapon Image 
	Components.WeaponImage = Globals:Instance("ImageLabel", { 
		Parent = Components.BoxOutline, 
		ZIndex = 1,
		Image = GetImage("Salvaged AK47"),
		AnchorPoint = Vector2.new(0.5, 0),
		Size = UDim2.new(0, 25, 0, 25),
		ScaleType = Enum.ScaleType.Fit, 
		ImageColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1
	})
	--

	--// Flags Container
	Components.FlagsContainer = Globals:Instance("Frame", { 
		Parent = Components.BoxOutline, 
		ClipsDescendants = true, 
		Size = UDim2.new(0, 150, 1, 12),
		Position = UDim2.new(1, 2, 0, -6),
		BackgroundTransparency = 1,
	});

	Components.FlagsListLayout = Globals:Instance("UIListLayout", { 
		Padding = UDim.new(0, 0),
		SortOrder = Enum.SortOrder.LayoutOrder, 
		Parent = Components.FlagsContainer,
	});

	Components.FlagsPadding = Globals:Instance("UIPadding", { 
		PaddingTop = UDim.new(0, 2),
		Parent = Components.FlagsContainer,
		PaddingLeft = UDim.new(0, 2),
	})
	--

	--// Flags
	for FlagName, FlagData in EntityClass.Flags do 
		Components["Flag_"..FlagName] = Globals:Instance("TextLabel", EntityClass.FlagProperties);
		Components["Flag_"..FlagName].Parent = Components.FlagsContainer
		Components["FlagStroke_"..FlagName] = Globals.ApplyTextStroke(Components["Flag_"..FlagName]);
		Components["FlagStroke_"..FlagName].Transparency = 1;
	end;
	--

	--// Offscreen 
	Components.OffscreenArrow = Globals:Instance("TextLabel", { 
		Text = "?",
		TextSize = 14, 
		BackgroundTransparency = 1, 
		Size = UDim2.new(0, 20, 0, 20),
		Visible = false, 
		Parent = Visuals.ESPSpace
	});

	Components.ArrowStroke = Globals.ApplyTextStroke(Components.OffscreenArrow)
	--

	--// LOSIndicator 
	Components.LOSIndicator = Globals:Instance("TextLabel", { 
		Parent = Visuals.LOSFrame, 
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold), 
		TextSize = 15, 
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Size = UDim2.new(1, 0, 0, 0),
		Position = UDim2.new(0, 0, 0, -18),
		TextStrokeTransparency = 1,
		TextTransparency = 1,
		Visible = false,
		TextYAlignment = Enum.TextYAlignment.Top;
	});

	Components.LOSStroke = Globals.ApplyTextStroke(Components.LOSIndicator);
	Components.LOSStroke.Transparency = 1;
	--

	--// LookAngle
	Components["LookAngle"] = Visuals.DrawLine();
	Components["LookAngleOutline"] = Visuals.DrawOutline();
	--

	--// Skeleton
	Components["Skeleton"] = {
		Main = Visuals.DrawLine();

		RL_line = Visuals.DrawLine();
		LL_line = Visuals.DrawLine();

		RightFoot = Visuals.DrawLine();
		LeftFoot =  Visuals.DrawLine();

		LeftArm = Visuals.DrawLine();
		RightArm = Visuals.DrawLine();

		RightElbow = Visuals.DrawLine();
		LeftElbow = Visuals.DrawLine();

		Hips = Visuals.DrawLine();
		Shoulders = Visuals.DrawLine();

		MainOutline = Visuals.DrawOutline();

		RL_lineOutline = Visuals.DrawOutline();
		LL_lineOutline = Visuals.DrawOutline();

		RightFootOutline = Visuals.DrawOutline();
		LeftFootOutline =  Visuals.DrawOutline();

		LeftArmOutline = Visuals.DrawOutline();
		RightArmOutline = Visuals.DrawOutline();

		RightElbowOutline = Visuals.DrawOutline();
		LeftElbowOutline = Visuals.DrawOutline();

		HipsOutline = Visuals.DrawOutline();
		ShouldersOutline = Visuals.DrawOutline();
	};
	--
	return Components
end);

EntityClass.Main.Functions.GetBoxSize = LPH_NO_VIRTUALIZE(function(self)
	local Character = self.Character
	local Root = self.Root
	local CameraPosition = Camera.CFrame.Position

	if not Character or not Root then
		return { Visible = false, OnScreen = false, Root = nil }
	end

	if (CameraPosition - Root.Position).Magnitude > 2000 then
		return { Visible = false, OnScreen = false, Root = Root }
	end

	local MaxWidth, MaxHeight, MaxDepth = 10, 20, 10
	local BoundingPosition, BoundingSize = self:GetBoundingBox(Character, Root.CFrame)
	local HalfSize = BoundingSize / 2

	local ClampedSize = Vector3.new(
		math.min(HalfSize.X, MaxWidth / 2) * 2,
		math.min(HalfSize.Y, MaxHeight / 2) * 2,
		math.min(HalfSize.Z, MaxDepth / 2) * 2
	)

	local CornerOffsets = {
		Vector3.new( ClampedSize.X/2,  ClampedSize.Y/2,  ClampedSize.Z/2),
		Vector3.new( ClampedSize.X/2,  ClampedSize.Y/2, -ClampedSize.Z/2),
		Vector3.new( ClampedSize.X/2, -ClampedSize.Y/2,  ClampedSize.Z/2),
		Vector3.new( ClampedSize.X/2, -ClampedSize.Y/2, -ClampedSize.Z/2),
		Vector3.new(-ClampedSize.X/2,  ClampedSize.Y/2,  ClampedSize.Z/2),
		Vector3.new(-ClampedSize.X/2,  ClampedSize.Y/2, -ClampedSize.Z/2),
		Vector3.new(-ClampedSize.X/2, -ClampedSize.Y/2,  ClampedSize.Z/2),
		Vector3.new(-ClampedSize.X/2, -ClampedSize.Y/2, -ClampedSize.Z/2),
	}

	local MinX, MinY = math.huge, math.huge
	local MaxX, MaxY = -math.huge, -math.huge
	local OnScreenCount = 0

	local WorldToViewportPoint = Camera.WorldToViewportPoint

	for _, Offset in ipairs(CornerOffsets) do
		local WorldCorner = BoundingPosition:PointToWorldSpace(Offset)
		local ScreenPos, OnScreen = WorldToViewportPoint(Camera, WorldCorner)
		if OnScreen then
			OnScreenCount += 1
			MinX = math.min(MinX, ScreenPos.X)
			MinY = math.min(MinY, ScreenPos.Y)
			MaxX = math.max(MaxX, ScreenPos.X)
			MaxY = math.max(MaxY, ScreenPos.Y)
		end
	end

	if OnScreenCount == 0 and Character:FindFirstChild("Head") then
		local Visible = Visuals.IsPartVisible(Character.Head)
		return {
			Root = Root,
			OnScreen = false,
			RootPosition = Root.Position,
			Visible = Visible,
			VisiblePart = Visible and Character.Head or nil,
		}
	end

	local VisiblePart = nil
	local PartsToCheck = {
		Character:FindFirstChild("HumanoidRootPart"),
		Character:FindFirstChild("RightLowerLeg"),
		Character:FindFirstChild("LeftLowerLeg"),
		Character:FindFirstChild("RightUpperArm"),
		Character:FindFirstChild("LeftUpperArm"),
	}

	for _, Part in ipairs(PartsToCheck) do
		if Part and Part:IsA("BasePart") and Visuals.IsPartVisible(Part) then
			VisiblePart = Part
			break
		end
	end

	local Width = MaxX - MinX
	local Height = MaxY - MinY
	local Size = Math.FloorVector(Vector2.new(Width, Height))
	local Position = Math.FloorVector(Vector2.new(MinX, MinY))
	local Center2D = Vector2.new(Position.X + Size.X / 2, Position.Y + Size.Y / 2)

	return {
		Visible = VisiblePart ~= nil,
		VisiblePart = VisiblePart,
		Root = Root,
		RootPosition = Root.Position,
		Height = Height,
		Width = Width,
		Size = Size,
		Position = Position,
		Center2D = Center2D,
		OnScreen = OnScreenCount > 0,
	}
end);

EntityClass.Main.Functions.GetBoundingBox = LPH_NO_VIRTUALIZE(function(self, Model, Orientation)
	local Parts = typeof(Model) == "Instance" and Model:GetChildren() or Model
	Orientation = Orientation or CFrame.new()

	local Inf = math.huge
	local MinX, MinY, MinZ = Inf, Inf, Inf
	local MaxX, MaxY, MaxZ = -Inf, -Inf, -Inf

	for _, Part in ipairs(Parts) do
		if Part:IsA("BasePart") then
			local Cf = Orientation:ToObjectSpace(Part.CFrame)
			local Sx, Sy, Sz = Part.Size.X, Part.Size.Y, Part.Size.Z
			local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = Cf:components()

			local Wsx = 0.5 * (math.abs(R00) * Sx + math.abs(R01) * Sy + math.abs(R02) * Sz)
			local Wsy = 0.5 * (math.abs(R10) * Sx + math.abs(R11) * Sy + math.abs(R12) * Sz)
			local Wsz = 0.5 * (math.abs(R20) * Sx + math.abs(R21) * Sy + math.abs(R22) * Sz)

			MinX = math.min(MinX, X - Wsx)
			MinY = math.min(MinY, Y - Wsy)
			MinZ = math.min(MinZ, Z - Wsz)

			MaxX = math.max(MaxX, X + Wsx)
			MaxY = math.max(MaxY, Y + Wsy)
			MaxZ = math.max(MaxZ, Z + Wsz)
		end
	end

	local MinVec = Vector3.new(MinX, MinY, MinZ)
	local MaxVec = Vector3.new(MaxX, MaxY, MaxZ)
	local Middle = (MaxVec + MinVec) / 2
	local Cf = Orientation - Orientation.Position + Orientation:PointToWorldSpace(Middle)
	local Size = MaxVec - MinVec

	return Cf, Size
end);

EntityClass.Main.Functions.GetDistance = LPH_NO_VIRTUALIZE(function(self)
	local root = self.Root
	if not root then
		return 9e9
	end
	return math.floor((root.Position - Camera.CFrame.Position).Magnitude)
end);

EntityClass.Main.Functions.GetHealth = LPH_NO_VIRTUALIZE(function(self)
	if (self.Class == "Player" or self.Class == "AI") and self.Character then
		if self.Character.Name == "BTR" then 
			return self.Character:GetAttribute("Health"), self.Character:GetAttribute("MaxHealth")
		end

		local Humanoid = self.Humanoid
		if not Humanoid then
			return 0, 100
		end
		return Humanoid.Health, Humanoid.MaxHealth
	end

	return 0, 100
end);

EntityClass.Main.Functions.GetRoot = LPH_NO_VIRTUALIZE(function(self)
	local character = self.Character
	if not character then
		return
	end

	local Humanoid = character:FindFirstChildOfClass("Humanoid")
	if Humanoid then
		self.Humanoid = Humanoid
	end

	if self.Class == "Player" or self.Class == "AI" then
		return Humanoid and Humanoid.RootPart or character:FindFirstChild("HumanoidRootPart")
	end
end);

EntityClass.Main.Functions.GetCharacter = LPH_NO_VIRTUALIZE(function(self)
	if self.Class == "AI" then 
		return self.Pointer
	end

	if self.Class == "Player" then 
		return self.Pointer.Character
	end
end);

EntityClass.Main.Functions.ProjectSkeletonLine = LPH_NO_VIRTUALIZE(function(self, part, offset)
	local pos = part.Position + (offset or Vector3.zero)
	local screenPos = Camera:WorldToViewportPoint(pos)
	return Math.FloorVector(Vector2.new(screenPos.X, screenPos.Y))
end);

EntityClass.Main.Functions.SetSkeletonLine = LPH_NO_VIRTUALIZE(function(self, name, from, to, transparency, color)
	local line = self.Components.Skeleton[name]
	if line then
		line.Visible = true
		line.From = from
		line.To = to
		line.Color = color
		line.Transparency = 1 - transparency
	end

	local outline = self.Components.Skeleton[name .. "Outline"]
	if outline then
		outline.Visible = true
		outline.From = from
		outline.To = to
		outline.Transparency = 1 - transparency
	end
end);

EntityClass.Main.Functions.SetSkeletonsInvisible = LPH_NO_VIRTUALIZE(function(self)
	if self.Components.Skeleton.RL_line.Visible then 
		for _, Line in self.Components.Skeleton do 
			Line.Visible = false;
		end;
	end;
end);

EntityClass.Main.Functions.Update = LPH_NO_VIRTUALIZE(function(self)
	self.Character = self:GetCharacter()
	self.Root = self:GetRoot()
	self.Distance = self:GetDistance()
	self.CoreInformation = self:GetBoxSize() or {}

	local Components = self.Components

	if not self.Root then 
		Components.LOSIndicator.Visible = false
		Components.OffscreenArrow.Visible = false
		Components.BoxOutline.Visible = false
		Components.LookAngle.Visible = false
		Components.LookAngleOutline.Visible = false
		self:SetSkeletonsInvisible()
		return
	end;

	local Health, MaxHealth = self:GetHealth()
	local CoreInformation = self.CoreInformation
	local Visible = CoreInformation.Visible
	local ClassType = self.ClassType
	local Flags = Library.Flags
	local StatusColor = not Visible and Flags[ClassType.."OccludedColor"].Value[1] or Flags[ClassType.."VisibleColor"].Value[1]

	if self == EntityClass.TargetData then
		StatusColor = Flags.TargetColor.Value[1]
		if EntityClass.ManipulatedPlayer == self.Pointer then
			StatusColor = Flags.ManipColor.Value[1]
		end
	end

	self.IsDead = Health <= 0.1
	local Transparency = self.IsDead and 1 or 0

	Globals:Tween(Components.BoxInlineStroke, TweenInfo.new(EntityClass.AnimationSpeed, Enum.EasingStyle.Quad), {
		Color = StatusColor
	})

	Globals:Tween(Components.BoxOutlineStroke, TweenInfo.new(EntityClass.AnimationSpeed + 0.25, Enum.EasingStyle.Quad), {
		Transparency = Transparency
	})

	local ComponentColor = Components.BoxInlineStroke.Color
	Transparency = Components.BoxOutlineStroke.Transparency
	local BoxCorners = Components.Corners
	local BottomBounds = 1
	local HasItem = self.CachedItem ~= nil

	if Flags.LockOnIndicator.Value and ClassType == "Player" and Flags.PlayerESP.Value then
		local ClientHead = Client.Character and Client.Character:FindFirstChild("Head")
		local EnemyHead = self.Character and self.Character:FindFirstChild("Head")

		if EnemyHead and ClientHead then
			local Delta = (ClientHead.Position - EnemyHead.Position)
			local Distance = Delta.Magnitude
			local Direction = Delta.Unit
			local LookVector = EnemyHead.CFrame.LookVector
			local DotProduct = LookVector:Dot(Direction)
			local CrossProduct = LookVector:Cross(Direction).Magnitude
			local Angle = math.deg(math.atan2(CrossProduct, DotProduct))
			local MaxAngle = math.clamp(60 - (Distance/10), 15, 60)
			local Percentage = math.floor(math.clamp(100 - (Angle/MaxAngle * 100), 0, 100))
			local IsLooking = Angle <= MaxAngle
			local ThroughWalls = not Visible
			local Color = Percentage >= Flags.LockOnRisk.Value and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255)

			if IsLooking and Percentage >= Flags.LockOnThreshold.Value then
				Components.LOSIndicator.LayoutOrder = tick()
				Components.LOSIndicator.Visible = true
				Components.LOSIndicator.Text = string.format(
					"%s %s (%d%%) [%d studs]\n",
					self.Name,
					ThroughWalls and "is looking at you through walls" or "is looking at you",
					Percentage,
					math.floor(Distance)
				)

				if not Components.LOSIndicator:GetAttribute("IsTweening") then
					Components.LOSIndicator:SetAttribute("IsTweening", true)
					local Tween = Globals:Tween(Components.LOSIndicator, TweenInfo.new(EntityClass.AnimationSpeed, Enum.EasingStyle.Quad), {
						TextColor3 = Color,
						Size = UDim2.new(1, 0, 0, Components.LOSIndicator.TextSize),
						TextTransparency = 0
					})
					Components.LOSStroke.Transparency = Components.LOSIndicator.TextTransparency
					Tween.Completed:Connect(function()
						Components.LOSIndicator:SetAttribute("IsTweening", false)
					end)
				end
				Components.LOSStroke.Transparency = Components.LOSIndicator.TextTransparency
			else
				if not Components.LOSIndicator:GetAttribute("IsTweening") then
					Components.LOSIndicator:SetAttribute("IsTweening", true)
					local Tween = Globals:Tween(Components.LOSIndicator, TweenInfo.new(EntityClass.AnimationSpeed, Enum.EasingStyle.Quad), {
						Size = UDim2.new(1, 0, 0, 0),
						TextTransparency = 1
					})
					Tween.Completed:Connect(function()
						task.wait(0.1)
						Components.LOSIndicator:SetAttribute("IsTweening", false)
						Components.LOSIndicator.Visible = false
					end)
				end
				Components.LOSStroke.Transparency = Components.LOSIndicator.TextTransparency
			end
		end
	else
		Components.LOSIndicator.Visible = false
	end

	if CoreInformation.OnScreen and Flags[ClassType.."ESP"].Value then
		Components.OffscreenArrow.Visible = false
		local CanShowWeapon = ClassType == "Player" and Flags[ClassType.."Weapon"]
		local CanShowWeaponImage = ClassType == "Player" and Flags[ClassType.."WeaponImage"]
		local TweenProperties = TweenInfo.new(EntityClass.AnimationSpeed, Enum.EasingStyle.Quad)

		if tick() - self.LastChamsRefresh > Flags.ChamsRefreshRate.Value then
			self.LastChamsRefresh = tick()
			for _, Part in self.Character:GetChildren() do
				if Part:IsA("Model") and Part.Name:find("Armor") then 
					for Index, MeshPart in Part:GetChildren() do 
						self:ApplyArmorVisuals(MeshPart)
					end;
				end;

				if Part:IsA("BasePart") and not EntityClass.IgnoreNames[Part.Name] then
					if not self.Adornments[Part] then
						local Adornments = {}
						local Adornment
						for Vis = 1, 2 do
							if Part.Name == "Head" then
								Adornment = Globals:Instance("CylinderHandleAdornment", {
									Name = "",
									Adornee = Part,
									Parent = Part,
									ZIndex = Vis == 1 and 2 or 1,
									Height = Vis == 1 and 0.87 or 1.02,
									Radius = Vis == 1 and 0.5 or 0.65,
									CFrame = CFrame.new(Vector3.new(), Vector3.new(0, 1, 0)),
									Visible = false,
									AlwaysOnTop = Vis == 1
								})
							else
								local SizeOffset = Vis == 1 and -0.05 or 0.05
								Adornment = Globals:Instance("BoxHandleAdornment", {
									Name = "",
									Adornee = Part,
									Parent = Part,
									ZIndex = Vis == 1 and 2 or 1,
									AlwaysOnTop = Vis == 1,
									Size = Part.Size + Vector3.new(SizeOffset, SizeOffset, SizeOffset),
									Visible = false
								})
							end
							Adornments[Vis] = Adornment
						end
						self.Adornments[Part] = Adornments
					else
						local Adornments = self.Adornments[Part]
						if Adornments then
							local OccludedColor = Flags[ClassType.."ChamsOccludedColor"].Value[1]
							local OccludedTransparency = Flags[ClassType.."ChamsOccludedColor"].Value[2]
							local ShouldShow = Flags[ClassType.."Chams"].Value
							local GlowChams = Flags[ClassType.."ChamsStyle"].Value == "Glow"
							local VisibleColor = Flags[ClassType.."ChamsVisibleColor"].Value[1]
							local VisibleTransparency = Flags[ClassType.."ChamsVisibleColor"].Value[2]

							Adornments[1].Visible = ShouldShow
							Adornments[1].Color3 = OccludedColor
							Adornments[1].Transparency = OccludedTransparency

							Adornments[2].Visible = ShouldShow
							Adornments[2].ZIndex = GlowChams and 9e9 or 1
							Adornments[2].AlwaysOnTop = GlowChams
							Adornments[2].Color3 = VisibleColor
							Adornments[2].Transparency = VisibleTransparency
						end
					end
				end
			end
		end

		Components.BoxOutline.Position = UDim2.new(0, CoreInformation.Position.X, 0, CoreInformation.Position.Y)
		Components.BoxOutline.Size = UDim2.new(0, CoreInformation.Size.X, 0, CoreInformation.Size.Y)
		Components.BoxOutline.Visible = true

		local CanUseSolid = Flags[ClassType.."BoundingBox"].Value and Flags[ClassType.."BoxStyle"].Value == "Solid"
		Components.BoxOutlineStroke.Enabled = CanUseSolid
		Components.BoxInlineStroke.Enabled = CanUseSolid

		ComponentColor = Components.BoxInlineStroke.Color

		Components.BoxInlineStroke.Transparency = Transparency

		for Index = 1, 16 do
			BoxCorners[Index].Visible = Flags[ClassType.."BoundingBox"].Value and Flags[ClassType.."BoxStyle"].Value == "Corner"

			if BoxCorners[Index].Visible then 
				if Index <= 8 then 
					BoxCorners[Index].ZIndex = 3
					BoxCorners[Index].BackgroundColor3 = ComponentColor
				end;
				BoxCorners[Index].BackgroundTransparency = Transparency
			end;
		end

		if Flags[ClassType.."Healthbar"].Value then
			local HealthPercent = Health / MaxHealth
			if tostring(HealthPercent) == "nan" then
				HealthPercent = 0
			end

			local CalculatedSize = UDim2.new(1, 0, 1 - HealthPercent, 0)

			Components.HealthbarBlackout.Visible = true
			Components.Healthbar.Visible = true
			Components.Healthbar.BackgroundTransparency = Transparency
			Components.HealthbarBlackout.BackgroundTransparency = Transparency

			local ShowIfDamaged = Flags[ClassType.."ShowHealthIfDamaged"].Value
			local CanShowHealth = not ShowIfDamaged or (ShowIfDamaged and Health < MaxHealth)

			if Flags[ClassType.."Health"].Value and CanShowHealth then
				Components.Health.Visible = true
				Components.Health.Text = tostring(math.floor(HealthPercent * 100))
				Components.Health.TextTransparency = Transparency
				Components.HealthStroke.Transparency = Transparency
			else
				Components.Health.Visible = false
			end

			if Health ~= self.LastHealth then
				self.LastHealth = Health
				Globals:Tween(Components.HealthbarBlackout, TweenInfo.new(EntityClass.AnimationSpeed, Enum.EasingStyle.Quad), {
					Size = CalculatedSize
				})

				local LerpedColor = Flags[ClassType.."LowerHealthColor"].Value[1]:lerp(Flags[ClassType.."HigherHealthColor"].Value[1], Health / MaxHealth)

				Globals:Tween(Components.Healthbar, TweenInfo.new(EntityClass.AnimationSpeed, Enum.EasingStyle.Quad), {
					BackgroundColor3 = LerpedColor
				})
			end
		else
			Components.Healthbar.Visible = false
		end

		if Flags[ClassType.."Name"].Value then
			Components.Name.Visible = true
			Components.NameStroke.Transparency = Transparency
			Components.Name.TextTransparency = Transparency
			Components.Name.Text = self.Name
			Components.Name.TextColor3 = ComponentColor
		else
			Components.Name.Visible = false
		end

		if Flags[ClassType.."Distance"].Value then
			Components.Distance.Visible = true
			Components.DistanceStroke.Transparency = Transparency
			Components.Distance.Text = tostring(self.Distance).."s"
			Components.Distance.TextColor3 = ComponentColor
			Components.Distance.TextTransparency = Transparency
			Components.Distance.Position = UDim2.new(0, 0, 1, BottomBounds)
			BottomBounds += 8
		else
			Components.Distance.Visible = false
		end

		if CanShowWeapon and CanShowWeapon.Value then
			Components.Weapon.Visible = true

			if HasItem and self.CachedItem then
				Components.Weapon.Text = self.CachedItem.Name
			end

			Components.Weapon.TextColor3 = ComponentColor

			if not Components.Weapon:GetAttribute("IsTweening") then
				Components.Weapon:SetAttribute("IsTweening", true)

				local TargetY = HasItem and BottomBounds or (BottomBounds - 4)
				local WeaponTween = Globals:Tween(Components.Weapon, TweenProperties, {
					TextTransparency = HasItem and Transparency or 1,
					Position = UDim2.new(0, 0, 1, TargetY)
				})

				Globals:Tween(Components.WeaponStroke, TweenProperties, {
					Transparency = HasItem and Transparency or 1
				})

				WeaponTween.Completed:Connect(function()
					Components.Weapon:SetAttribute("IsTweening", false)
				end)
			end

			BottomBounds += 6
		else
			Components.Weapon.Visible = false
		end

		if CanShowWeaponImage and CanShowWeaponImage.Value then
			if not Components.Weapon.Visible then
				BottomBounds -= 4
			end

			local WeaponImage = (HasItem and self.CachedItem and EntityClass.WeaponImages[self.CachedItem.Name]) or nil
			local HasImage = HasItem and WeaponImage ~= nil

			Components.WeaponImage.Visible = HasImage
			if HasImage then
				Components.WeaponImage.Image = WeaponImage
			end

			if not Components.WeaponImage:GetAttribute("IsTweening") then
				Components.WeaponImage:SetAttribute("IsTweening", true)

				local TargetY = HasImage and BottomBounds or (BottomBounds - 5)
				local ImageTween = Globals:Tween(Components.WeaponImage, TweenProperties, {
					ImageTransparency = HasImage and Transparency or 1,
					Position = UDim2.new(0.5, 0, 1, TargetY)
				})

				ImageTween.Completed:Connect(function()
					Components.WeaponImage:SetAttribute("IsTweening", false)
				end)
			end
		else
			Components.WeaponImage.Visible = false
		end

		if ClassType == "Player" and Flags[ClassType.."Flags"].Value then
			Components.FlagsContainer.Visible = true
			local AnimationSpeed = EntityClass.AnimationSpeed
			local EasingStyle = Enum.EasingStyle.Quad
			local TweenInfo = TweenInfo.new(AnimationSpeed, EasingStyle)

			for FlagName, FlagData in EntityClass.Flags do
				local ShouldShow = FlagData.Allow(self)
				local Flag = Components["Flag_"..FlagName]
				local FlagStroke = Components["FlagStroke_"..FlagName]

				if not Flag then
					Flag = Globals:Instance("TextLabel", EntityClass.FlagProperties)
					Flag.Parent = Components.FlagsContainer
					FlagStroke = Globals.ApplyTextStroke(Flag)
					FlagStroke.Transparency = 1
					Components["Flag_"..FlagName] = Flag
					Components["FlagStroke_"..FlagName] = FlagStroke
				end

				if Flag then
					local Text = FlagData.Text(self) or ""
					Flag.TextColor3 = FlagData.Color and FlagData.Color(self) or Flags[FlagName.."FlagColor"].Value[1]
					Flag.Text = " "..Text

					if not Flag:GetAttribute("IsTweening") then
						Flag:SetAttribute("IsTweening", true)
						if ShouldShow then
							Flag.Visible = true
							Flag.LayoutOrder = tick()
						end

						local FlagTween = Globals:Tween(Flag, TweenInfo, {
							TextTransparency = ShouldShow and Transparency or 1,
							Size = ShouldShow and UDim2.new(0, 200, 0, Flag.TextBounds.Y) or UDim2.new(0, 200, 0, 0)
						})

						Globals:Tween(FlagStroke, TweenInfo, {
							Transparency = ShouldShow and Transparency or 1
						})

						FlagTween.Completed:Connect(function()
							Flag:SetAttribute("IsTweening", false)
							Flag.Visible = ShouldShow
						end)
					end
				end
			end
		else
			Components.FlagsContainer.Visible = false
		end

		if Flags[ClassType.."LookAngle"].Value and self.Character:FindFirstChild("Head") and not Library.IsOpen then
			local Head = self.Character.Head
			local HeadPos, HeadOnScreen = Camera:WorldToViewportPoint(Head.Position)
			local LookPos, LookOnScreen = Camera:WorldToViewportPoint(Head.Position + Head.CFrame.LookVector * 5)

			local Line = Components.LookAngle
			local Outline = Components.LookAngleOutline

			if HeadOnScreen and LookOnScreen then
				local From = Vector2.new(HeadPos.X, HeadPos.Y)
				local To = Vector2.new(LookPos.X, LookPos.Y)

				From = Math.FloorVector(From)
				To = Math.FloorVector(To)

				Line.Visible = true
				Line.From = From
				Line.To = To
				Line.Color = ComponentColor
				Line.Transparency = 1 - Transparency

				Outline.Visible = true
				Outline.From = From
				Outline.To = To
				Outline.Transparency = 1 - Transparency
			else
				Line.Visible = false
				Outline.Visible = false
			end
		else
			Components.LookAngle.Visible = false
			Components.LookAngleOutline.Visible = false
		end

		if Flags[ClassType.."Skeleton"].Value and self.Character:FindFirstChild("Head") and not Library.IsOpen then
			local Valid = true
			for _, Part in {"UpperTorso", "RightUpperLeg", "LeftFoot", "RightFoot", "LeftUpperLeg", "LeftUpperArm", "RightUpperArm", "RightLowerArm", "RightHand", "LeftHand"} do
				if not self.Character:FindFirstChild(Part) then
					Valid = false
					break
				end
			end

			if Valid then
				local Head = self:ProjectSkeletonLine(self.Character.Head)
				local RL = self:ProjectSkeletonLine(self.Character.RightUpperLeg)
				local LL = self:ProjectSkeletonLine(self.Character.LeftUpperLeg)

				local RightLeg = self:ProjectSkeletonLine(self.Character.RightUpperLeg, Vector3.new(0, 0.5, 0))
				local LeftLeg = self:ProjectSkeletonLine(self.Character.LeftUpperLeg, Vector3.new(0, 0.5, 0))

				local RightFoot = self:ProjectSkeletonLine(self.Character.RightFoot)
				local LeftFoot = self:ProjectSkeletonLine(self.Character.LeftFoot)

				local RightArm = self:ProjectSkeletonLine(self.Character.RightUpperArm, Vector3.new(0, 0.2, 0))
				local LeftArm = self:ProjectSkeletonLine(self.Character.LeftUpperArm, Vector3.new(0, 0.2, 0))

				local RightElbow = self:ProjectSkeletonLine(self.Character.RightLowerArm, Vector3.new(0, 0.2, 0))
				local LeftElbow = self:ProjectSkeletonLine(self.Character.LeftLowerArm, Vector3.new(0, 0.2, 0))

				local RightHand = self:ProjectSkeletonLine(self.Character.RightHand)
				local LeftHand = self:ProjectSkeletonLine(self.Character.LeftHand)

				self:SetSkeletonLine("RightFoot", RightFoot, RL, Transparency, ComponentColor)
				self:SetSkeletonLine("LeftFoot", LeftFoot, LL, Transparency, ComponentColor)

				self:SetSkeletonLine("LL_line", LeftLeg, LL, Transparency, ComponentColor)
				self:SetSkeletonLine("RL_line", RightLeg, RL, Transparency, ComponentColor)

				self:SetSkeletonLine("RightArm", RightArm, RightElbow, Transparency, ComponentColor)
				self:SetSkeletonLine("RightElbow", RightElbow, RightHand, Transparency, ComponentColor)

				self:SetSkeletonLine("LeftArm", LeftArm, LeftElbow, Transparency, ComponentColor)
				self:SetSkeletonLine("LeftElbow", LeftElbow, LeftHand, Transparency, ComponentColor)

				self:SetSkeletonLine("Main", Vector2.new((LeftLeg.X + RightLeg.X) / 2, LeftLeg.Y), Head, Transparency, ComponentColor)
				self:SetSkeletonLine("Hips", LeftLeg, RightLeg, Transparency, ComponentColor)
				self:SetSkeletonLine("Shoulders", RightArm, LeftArm, Transparency, ComponentColor)
			else
				self:SetSkeletonsInvisible()
			end
		else
			self:SetSkeletonsInvisible()
		end
	else
		Components.BoxOutline.Visible = false
		Components.LookAngle.Visible = false
		Components.LookAngleOutline.Visible = false
		self:SetSkeletonsInvisible()

		if CoreInformation.Root and Flags[ClassType.."Offscreen"] and Flags[ClassType.."Offscreen"].Value then
			local ArrowRadius = Flags[ClassType.."OffscreenRadius"].Value
			local Size = Flags[ClassType.."OffscreenSize"].Value

			local Arrow = Components.OffscreenArrow
			local CameraPosition = Camera.CFrame.p
			local ViewAngle = Camera.CFrame.lookVector

			local ScreenPos = Camera:WorldToScreenPoint(CoreInformation.Root.Position)
			local Center = Camera.ViewportSize / 2
			local Direction = (Vector2.new(ScreenPos.X, ScreenPos.Y) - Vector2.new(Center.X, Center.Y)).Unit

			local OffscreenRadius = ArrowRadius
			local ClampedPosition = Vector2.new(Center.X, Center.Y) + Direction * OffscreenRadius

			Arrow.TextSize = Size
			Arrow.Size = UDim2.new(0, 25, 0, 25)
			Arrow.Position = UDim2.new(0, ClampedPosition.X - Arrow.Size.X.Offset / 2, 0, ClampedPosition.Y - Arrow.Size.Y.Offset / 2)
			Arrow.Rotation = math.deg(math.atan2(Direction.Y, Direction.X)) + 90
			Arrow.Visible = true
			Arrow.TextColor3 = ComponentColor
			Arrow.TextTransparency = Transparency
			Components.ArrowStroke.Transparency = Transparency
		else
			Components.OffscreenArrow.Visible = false
		end
	end
end)

EntityClass.Main.Functions.AddFlag = LPH_NO_VIRTUALIZE(function(self, Data)
	EntityClass.Flags[Data.Name] = Data;
	return EntityClass.Flags[Data.Name]
end)

Log("Loaded EntityClass main library.")
--#endregion EntityClass Main

--#region EntityClass Misc 
EntityClass.Misc.Functions.__index = EntityClass.Misc   .Functions;

EntityClass.Misc.Functions.CreateComponents = LPH_NO_VIRTUALIZE(function(self)
	local Components = {}

	Components.Name = Globals:Instance("TextLabel", { 
		Parent = Visuals.MiscSpace,
		ZIndex = 1,
		BackgroundTransparency = 1,
		TextSize = EntityClass.FontSize,
		Text = "",
		FontFace = EntityClass.Font,
		Size = UDim2.new(0, 0, 0, EntityClass.FontSize), 
		Visible = false,
		Position = UDim2.new(0, 0, 0, 0),
		TextYAlignment = Enum.TextYAlignment.Top,
		AutomaticSize = Enum.AutomaticSize.Y
	})

	Components.NameStroke = Globals.ApplyTextStroke(Components.Name)

	return Components
end)

EntityClass.Misc.Functions.ScanParent  = LPH_NO_VIRTUALIZE(function(self)
	local ParentFolder = self.Parent; 
	local ClassName    = self.ClassName; 
	local Name         = self.Name; 
	for Index, Object in ParentFolder:GetChildren() do 
		if Object.ClassName == ClassName or Name == Object.Name then 
			self.Object = Object
			EntityClass.Misc.Cache[Object] = { 
				Components = self:CreateComponents(),
				Listener = self,
				Object = Object,
			};
		end;
	end; 

	ParentFolder.ChildAdded:Connect(function(Object)
		task.wait(0.5);
		if ParentFolder == Workspace:FindFirstChild("Drops") then 
			task.wait(2);
		end;

		if (Object.ClassName == ClassName or Name == Object.Name) and not Object:GetAttribute("IsThrow") and not EntityClass.Misc.Cache[Object] then 
			EntityClass.Misc.Cache[Object] = { 
				Components = self:CreateComponents(),
				Listener = self,
				Object = Object,
			};
			Object:GetPropertyChangedSignal("Parent"):Connect(function()
				if Object.Parent ~= ParentFolder and EntityClass.Misc.Cache[Object] then 
					for _, Component in EntityClass.Misc.Cache[Object].Components do 
						Component:Destroy();
					end; 
					EntityClass.Misc.Cache[Object] = nil
				end
			end);
			Object:GetAttributeChangedSignal("IsThrow"):Connect(function()
				task.wait(0.1);
				if Object:GetAttribute("IsThrow") then 
					for _, Component in EntityClass.Misc.Cache[Object].Components do 
						Component:Destroy();
					end; 
					EntityClass.Misc.Cache[Object] = nil
				end;
			end);
		end;
	end);

	ParentFolder.ChildRemoved:Connect(function(Object)
		if EntityClass.Misc.Cache[Object] then 
			for _, Component in EntityClass.Misc.Cache[Object].Components do 
				Component:Destroy();
			end; 
			EntityClass.Misc.Cache[Object] = nil
		end;
	end);
end);

EntityClass.Misc.Functions.AddListener = LPH_NO_VIRTUALIZE(function(Data)
        --[[local ObjectListener = setmetatable({
            Listener    = Data.Listener,
            GetPosition = Data.GetPosition,
            GetDistance = Data.GetDistance,
            GetColor    = Data.GetColor or function()
                return Library.Flags[Data.Flag .. "MiscColor"].Value[1]
            end,
            GetAlpha = Data.GetAlpha or function()
                return Library.Flags[Data.Flag .. "MiscColor"].Value[2]
            end,
            Flag      = Data.Flag,
            GetName   = Data.GetName,
            Parent    = Data.Parent,
            ClassName = Data.ClassName,
            Name      = Data.Name,
            Validate  = Data.Validate,
        }, EntityClass.Misc.Functions)

        ObjectListener:ScanParent()

        task.spawn(function()
            local LastState = false
            while task.wait(5) do
                local Toggle = Library.Flags["ESP" .. ObjectListener.Flag]
                local Enabled = Toggle and Toggle.Value
                
                if Enabled and not LastState then
                    ObjectListener:ScanParent()
                elseif not Enabled and LastState then
                    for Object, Entry in pairs(EntityClass.Misc.Cache) do
                        if Entry.Listener == ObjectListener then
                            for _, Component in pairs(Entry.Components) do
                                Component:Destroy()
                            end
                            EntityClass.Misc.Cache[Object] = nil
                        end
                    end
                end
                
                LastState = Enabled
            end
        end)

        task.spawn(function()
            local Toggle = Library.Flags["ESP" .. ObjectListener.Flag]
            if Toggle and Toggle.Value then
                ObjectListener:ScanParent()
            end
        end)

        return ObjectListener]]
end)

Log("Loaded EntityClass Misc library.")
--#endregion EntityClass Misc

--#region UI Setup

    --[[do --// Loader bullshit
        task.wait(1)
        local Loader = Library:CreateLoader("never")
        Loader:NewGame("Fallen Survival", "Lite", "http://www.roblox.com/asset/?id=99962944873879")
        Loader:NewGame("Fallen Survival", "Full", "http://www.roblox.com/asset/?id=99962944873879")

        repeat
            task.wait()
        until LoaderLaunched
        repeat
            task.wait()
        until Loader.BeginLoading

        do --// Loading...
            task.wait(1)
            Loader:SetStage("Initializing...")
            Loader:SetProgress(10)
            task.wait(0.2)
            Loader:SetStage("Loading visuals...")
            Loader:SetProgress(40)
            task.wait(1)
            Loader:SetStage("Loading hooks...")
            Loader:SetProgress(80)
            task.wait(1)
            Loader:SetStage("Finalizing...")
            Loader:SetProgress(100)
        end

        task.wait(1)

        do --// Finished loading!
            for Index, Object in Loader.Components.Loader:GetDescendants() do
                Object:SetAttribute("Tweening", true)
                if Object:IsA("TextLabel") then
                    Globals:Tween(Object, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        BackgroundTransparency = 1,
                    })

                    Globals:Tween(Object, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        TextTransparency = 1,
                    })
                end

                if Object:IsA("TextButton") then
                    Globals:Tween(Object, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        BackgroundTransparency = 1,
                    })

                    Globals:Tween(Object, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        TextTransparency = 1,
                    })
                end

                if Object:IsA("ImageLabel") then
                    Globals:Tween(Object, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        BackgroundTransparency = 1,
                    })

                    Globals:Tween(Object, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        ImageTransparency = 1,
                    })
                end

                if Object:IsA("Frame") then
                    Globals:Tween(Object, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        BackgroundTransparency = 1,
                    })
                end

                if Object:IsA("ImageButton") then
                    Globals:Tween(Object, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        BackgroundTransparency = 1,
                    })

                    Globals:Tween(Object, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        ImageTransparency = 1,
                    })
                end

                if Object:IsA("UIStroke") then
                    Globals:Tween(Object, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
                        Transparency = 1,
                    })
                end
            end
        end

        task.wait(3)
        Loader.Components.Loader:Destroy()
    end;]]

local Window = Library:Window({
	Name = "MainWindow",
	--PlayerImage = "http://www.roblox.com/asset/?id=118959562649521",
})

LPH_JIT_MAX(function() --// UI Setup
	local Pages = {
		Combat = Window:Tab({
			Name = "Combat",
			Image = GetImage("CombatImage"), -- "rbxassetid://7485051715"
		}),

		ESP = Window:Tab({
			Name = "ESP",
			Image = GetImage("ESPImage"), -- "rbxassetid://13321848320"
		}),

		Seperator1 = Window:TabSeperator(),

		Visuals = Window:Tab({
			Name = "Visuals",
			Image = GetImage("VisualsImage"), -- "rbxassetid://18870359747"
		}),

		Misc = Window:Tab({
			Name = "Misc",
			Image = GetImage("MiscImage") -- rbxassetid://6953992690
		}),

		Skins = Window:Tab({
			Name = "Skins",
			Image = GetImage("SkinsImage"), -- rbxassetid://13693164564
		}),

		Seperator2 = Window:TabSeperator(),

		Settings = Window:Tab({
			Name = "Settings",
			Image = GetImage("SettingsImage") -- rbxassetid://11956055886
		}),
		Plugins = Window:Tab({
			Name = "Plugins",
			Image = GetImage("PluginsImage"), -- http://www.roblox.com/asset/?id=133292957761995
		}),
	}

      local PluginsCategories = { 
		Main = Pages.Plugins:Category({
			Name = "Credits Scene"
		}),
	};

	local CombatCategories = {
		Aimbot = Pages.Combat:Category({
			Name = "Main",
		}),

		AntiAim = Pages.Combat:Category({
			Name = "Anti Aim",
		}),

		WeaponMods = Pages.Combat:Category({
			Name = "Weapon Mods",
		}),

		Crosshair = Pages.Combat:Category({
			Name = "Crosshair"
		})
	};

	do  --// COMBAT CAT
		--// Aimbot
		local Aimbot = CombatCategories.Aimbot:Section({
			Name = "Aimbot",
			Side = "Left",
		})

		Aimbot:Toggle({
			Name = "Enabled",
			Flag = "Aimbot",
			Tooltip = "Redirects bullets to targets",
		});

		Aimbot:Dropdown({
			Name = "Mode",
			Flag = "AimbotMode",
			Options = { 
				"Silent",
				"Memory"
			}
		})

		Aimbot:Toggle({
			Name = "Always target",
			Flag = "AlwaysTarget",
			Tooltip = "Ignores aimbot key requirement"
		});

		Aimbot:Toggle({
			Name = "Random hitpart",
			Flag = "RandomizeHitPart"
		});

		Aimbot:Toggle({
			Name = "Visibility check",
			Flag = "VisibleCheck",
			Tooltip = "Prioritizes hitboxes based on visibility"
		});

		Aimbot:Toggle({
			Name = "Manipulation",
			Flag = "Manipulation",
			Tooltip = "Shoot around obstructions"
		})

		Aimbot:Seperator()

		Aimbot:Keybind({
			Name = "Manipulation Key",
			Flag = "Manipulation Activation",
			Mode = "Toggle"
		})

		Aimbot:Keybind({
			Name = "Aimbot key",
			Flag = "Aimbot Activation",
			Mode = "Hold",
		});

		Aimbot:Seperator()

		Aimbot:Toggle({
			Name = "Target Players",
			Flag = "TargetPlayer"
		});

		Aimbot:Toggle({
			Name = "Target AI",
			Flag = "TargetAI",
		});

		Aimbot:Toggle({
			Name = "Target Bosses",
			Flag = "TargetBoss",
		});

		Aimbot:Seperator();

		Aimbot:Slider({
			Name = "Distance",
			Flag = "AimbotDistance",
			Min = 0,
			Max = 1200,
			Suffix = "s",
			Increment = 0.1,
		});

		Aimbot:Dropdown({
			Name = "Hit part",
			Flag = "AimbotPart",
			Options = {
				"Head",
				"LowerTorso",
				"UpperTorso",
			},
		});
		--

		--// Target Settings
		local FOVSettings = CombatCategories.Aimbot:Section({
			Name = "FOV Settings",
			Side = "Right",
		})

		FOVSettings:Toggle({
			Name = "Visualize FOV",
			Flag = "VisualizeFOV",
			Callback = function(v)
				Visuals.FOVOutline.Visible = Library.Flags.VisualizeFOV.Value
			end;
		})

		FOVSettings:Toggle({
			Name = "Dynamic Radius", 
			Flag = "DynamicFOV",
			Tooltip = "Scales radius based on Camera FOV",
		});

		FOVSettings:Slider({
			Name = "Radius",
			Flag = "FOVRadius",
			Suffix = "px",
			Min = 30, 
			Max = 1500,
		});

		FOVSettings:Colorpicker({
			Name = "Color",
			Flag = "FOVColor",
			Default = {Library.Theme.Accent, 0.8},
			Callback = function(v)
				Visuals.FOVCircleStroke.Color = Library.Flags.FOVColor.Value[1]
				Visuals.FOVInline.BackgroundColor3 = Library.Flags.FOVColor.Value[1]
				Visuals.FOVInline.BackgroundTransparency = Library.Flags.FOVColor.Value[2]
			end,
		})

		FOVSettings:Colorpicker({
			Name = "Target color",
			Flag = "TargetColor", 
			Default = {Library.Theme.Accent, 0}
		});

		FOVSettings:Colorpicker({
			Name = "Manipulated color",
			Flag = "ManipColor", 
			Default = {Color3.fromRGB(255, 162, 0), 0}
		})
		--

		--// Armor Viewer Settings 
		local ArmorViewer = CombatCategories.Aimbot:Section({
			Name = "Armor Viewer",
			Side = "Right"
		});

		ArmorViewer:Toggle({
			Name = "Enabled",
			Flag = "ArmorViewer",
			Tooltip = "Displays targets armor",
			Callback = function()
				Window.ArmorPanel.Components.Armor.Visible = Library.Flags.ArmorViewer.Value 
			end;
		})
		--

		--// Gun Mods 
		local ToolInfo = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("ToolInfo") and require(ReplicatedStorage.Modules.ToolInfo) or {};
		local ToolInfoCopy = Globals.DeepCopy(ToolInfo)

		Globals.ToolInfo = ToolInfo
		local Universal = CombatCategories.WeaponMods:Section({
			Name = "Universal",
			Side = "Left"
		})

		local Guns = CombatCategories.WeaponMods:Section({
			Name = "Guns",
			Side = "Right"
		});

		local Melees = CombatCategories.WeaponMods:Section({
			Name = "Melees",
			Side = "Left"
		})

		--// Universal 
		Universal:Toggle({
			Name = "Instant equip",
			Flag = "FastEquip",
			Callback = LPH_NO_VIRTUALIZE(function()
				for Index, Value in ToolInfo do 
					if type(Value) == "table" and rawget(Value, "Weapon") then 
						local Old = ToolInfoCopy[Index].Weapon;
						Value.Weapon.EquipAnimSpeed = Library.Flags.FastEquip.Value and 6 or Old.EquipAnimSpeed;
					end;
				end;
			end);
		});
		--

		--// Guns
		Guns:Toggle({
			Name = "Remove recoil",
			Flag = "RemoveRecoil"
		});

		Guns:Toggle({
			Name = "Instant bullet",
			Flag = "InstantBullet"
		});

		Guns:Toggle({
			Name = "Force automatic",
			Flag = "ForceAuto",
			Callback = LPH_NO_VIRTUALIZE(function()
				for Index, Value in ToolInfo do 
					if type(Value) == "table" and rawget(Value, "Weapon") and rawget(Value.Weapon, 'RPM') then 
						Value.Weapon.Auto = Library.Flags.ForceAuto.Value and true or ToolInfoCopy[Index].weapon.Auto
					end
				end;
			end);
		})

		Guns:Seperator()

		Guns:Toggle({
			Name = "Instant Bolt",
			Flag = "InstantBolt",
			Risky = true,
			Callback = LPH_NO_VIRTUALIZE(function()
				for Index, Value in ToolInfo do 
					if type(Value) == "table" and rawget(Value, "Weapon") and rawget(Value.Weapon, 'BoltAnimSpeed') then 
						Value.Weapon.ReloadAnimSpeed = Library.Flags.InstantBolt.Value and 10 or ToolInfoCopy[Index].Weapon.ReloadAnimSpeed
						Value.Weapon.BoltAnimSpeed = Library.Flags.InstantBolt.Value and 10 or ToolInfoCopy[Index].Weapon.BoltAnimSpeed
					end
				end;
			end);
		});

		Guns:Seperator()

		Guns:Toggle({
			Name = "Rapid Fire",
			Flag = "RapidFire",
			Risky = true,
			Callback = LPH_NO_VIRTUALIZE(function()
				for Index, Value in ToolInfo do 
					if type(Value) == "table" and rawget(Value, "Weapon") and rawget(Value.Weapon, 'RPM') then 
						Value.Weapon.RPM = Library.Flags.RapidFire.Value and ToolInfoCopy[Index].Weapon.RPM * Library.Flags.RPMMult.Value or ToolInfoCopy[Index].Weapon.RPM
					end
				end;
			end);
		});

		Guns:Slider({
			Name = "RPM Multiplier",
			Flag = "RPMMult",
			Suffix = "x",
			Min = 1, Max = 3, Increment = 0.01,
			Callback = LPH_NO_VIRTUALIZE(function()
				for Index, Value in ToolInfo do 
					if type(Value) == "table" and rawget(Value, "Weapon") and rawget(Value.Weapon, 'RPM') then 
						Value.Weapon.RPM = Library.Flags.RapidFire.Value and ToolInfoCopy[Index].Weapon.RPM * Library.Flags.RPMMult.Value or ToolInfoCopy[Index].Weapon.RPM
					end
				end;
			end);
		});

		Guns:Seperator();

		Guns:Toggle({
			Name = "Faster ADS",
			Flag = "FastADS",
			Callback = LPH_NO_VIRTUALIZE(function()
				local TOGGLE = Library.Flags.FastADS.Value;
				for Index, Value in next, ToolInfo do 
					if type(Value) == "table" and rawget(Value, "Weapon") then 
						local Old = ToolInfoCopy[Index].Weapon;
						if rawget(Value.Weapon, "AimDownSpeed") then 
							Value.Weapon.AimDownSpeed.In = TOGGLE and Old.AimDownSpeed.In - (Old.AimDownSpeed.In * (Library.Flags.AimSpeed.Value / 100)) or Old.AimDownSpeed.In;
							Value.Weapon.AimDownSpeed.Out =TOGGLE and Old.AimDownSpeed.Out - (Old.AimDownSpeed.Out * (Library.Flags.AimSpeed.Value / 100)) or Old.AimDownSpeed.Out;
						end;
					end;    
				end;
			end);
		});

		Guns:Slider({
			Name = "ADS Percent",
			Flag = "AimSpeed",
			Suffix = "%",
			Min = 0, Max = 100,
			Callback = LPH_NO_VIRTUALIZE(function()
				local TOGGLE = Library.Flags.FastADS.Value;
				for Index, Value in next, ToolInfo do 
					if type(Value) == "table" and rawget(Value, "Weapon") then 
						local Old = ToolInfoCopy[Index].Weapon;
						if rawget(Value.Weapon, "AimDownSpeed") then 
							Value.Weapon.AimDownSpeed.In = TOGGLE and Old.AimDownSpeed.In - (Old.AimDownSpeed.In * (Library.Flags.AimSpeed.Value / 100)) or Old.AimDownSpeed.In;
							Value.Weapon.AimDownSpeed.Out = TOGGLE and Old.AimDownSpeed.Out - (Old.AimDownSpeed.Out * (Library.Flags.AimSpeed.Value / 100)) or Old.AimDownSpeed.Out;
						end;
					end;    
				end;
			end);
		});
		--

		--// Melees 
		Melees:Toggle({
			Name = "Reach",
			Flag = "Reach",
			Risky = true
		})

		Melees:Toggle({
			Name = "Perfect farm",
			Flag = "PerfectFarm"
		})

		Melees:Toggle({
			Name = "Fast cooldown",
			Flag = "FastCooldown",
			Callback = LPH_NO_VIRTUALIZE(function()
				for Index, Value in ToolInfo do 
					if type(Value) == "table" and rawget(Value, "Weapon") and rawget(Value.Weapon, 'Cooldown') then 
						Value.Weapon.Cooldown = Library.Flags.FastCooldown.Value and ToolInfoCopy[Index].Weapon.Cooldown * 0.8 or ToolInfoCopy[Index].Weapon.Cooldown
					end
				end;
			end);
		})

            Melees:Toggle({
			Name = "Killaura (Uses Silent Aim Target)",
			Flag = "KillauraToggle"
		})
            Melees:Keybind({
			Name = "Killaura Key",
			Flag = "Killaura Activation",
			Mode = "Toggle"
		})
		--
		--

		--// Anti aim tab 
		local AntiaimMaster = CombatCategories.AntiAim:Section({
			Name = "Master",
			Side = "Left"
		});

		AntiaimMaster:Toggle({
			Name = "Enabled",
			Flag = "AntiAim"
		});

		local YawSection = CombatCategories.AntiAim:Section({
			Name = "Yaw",
			Side = "Right"
		})

		YawSection:Slider({
			Name = "Modifier",
			Flag = "YawModifier",
			Min = 0, Max = 360, Suffix = "°"
		});

		YawSection:Dropdown({
			Name = "Base",
			Flag = "YawBase",
			Options = {"Camera", "Random", "Spin", "Targets"}
		});


		local PitchSection = CombatCategories.AntiAim:Section({
			Name = "Pitch",
			Side = "Left"
		});

		PitchSection:Slider({
			Name = "Modifier",
			Flag = "PitchModifier",
			Min = -1, Max = 1, Increment = 0.1,
		});

		PitchSection:Dropdown({
			Name = "Base",
			Flag = "PitchBase",
			Options = {"Nod", "Up", "Down", "Custom"}
		})
		--

		--// Crosshair settings 
		local CrosshairSettings = CombatCategories.Crosshair:Section({
			Name = "Settings",
			Side = "Left"
		});

		CrosshairSettings:Toggle({
			Name = "Enabled",
			Flag = "Crosshair"
		});

		CrosshairSettings:Toggle({
			Name = "Apply rotation animation",
			Flag = "RotateCrosshair"
		});

		CrosshairSettings:Seperator();
		CrosshairSettings:Slider({
			Name = "Length",
			Flag = "CrosshairLength",
			Min = 3,
			Max = 40,
			Default = 20
		});

		CrosshairSettings:Slider({
			Name = "Width",
			Flag = "CrosshairWidth",
			Min = 2,
			Max = 4,
			Default = 2
		});

		CrosshairSettings:Slider({
			Name = "Gap",
			Flag = "CrosshairGap",
			Min = 1,
			Max = 20,
			Default = 10
		});
		CrosshairSettings:Seperator();
		CrosshairSettings:Colorpicker({
			Name = "Color",
			Flag = "CrosshairColor",
			Default = {Color3.fromRGB(255, 255, 255), 0}
		})
		--

		--// Crosshair Target Settings 
		local CrosshairTargetSettings = CombatCategories.Crosshair:Section({
			Name = "Target Settings",
			Side = "Right"
		});

		CrosshairTargetSettings:Toggle({
			Name = "Stick to target",
			Flag = "StickToTarget",
			Tooltip = "Crosshair will move to targe"
		});

		CrosshairTargetSettings:Toggle({
			Name = "Sync to lock color",
			Flag = "SyncToLockColor",
			Tooltip = "Crosshair will sync with target color if locked"
		})
		--
	end

	local ESPCategories = {
		Players = Pages.ESP:Category({ Name = "Players" }),
		AI = Pages.ESP:Category({ Name = "AI" }),
		Boss = Pages.ESP:Category({ Name = "Bosses" }),
		World = Pages.ESP:Category({ Name = "World" })
	}

	do --// ESP Categories
		do --// Players
			local PlayersMain = ESPCategories.Players:Section({
				Name = "Main",
				Side = "Left",
			})

			local PlayersSettings = ESPCategories.Players:Section({
				Name = "Settings",
				Side = "Left",
			})

			local PlayersColors = ESPCategories.Players:Section({
				Name = "Colors",
				Side = "Right",
			})

			local PlayerModels = ESPCategories.Players:Section({
				Name = "Character model",
				Side = "Right",
			});

			local LockOn = ESPCategories.Players:Section({
				Name = "Lock on indicators",
				Side = "Left"
			})

			do --// Lock on 
				LockOn:Toggle({
					Name = "Enabled",
					Flag = "LockOnIndicator"
				});

				LockOn:Slider({
					Name = "Lock on threshold",
					Flag = "LockOnThreshold",
					Min = 30,
					Max = 90,
					Default = 70
				});

				LockOn:Slider({
					Name = "Lock on danger threshold",
					Flag = "LockOnRisk",
					Min = 30,
					Max = 90,
					Default = 70
				});
			end; 

			do --// Players main
				PlayersMain:Toggle({
					Name = "Enabled",
					Flag = "PlayerESP",
				})

				PlayersMain:Toggle({
					Name = "Bounding box",
					Flag = "PlayerBoundingBox",
				});

				PlayersMain:Toggle({
					Name = "Skeleton",
					Flag = "PlayerSkeleton",
				});

				PlayersMain:Toggle({
					Name = "View angle",
					Flag = "PlayerLookAngle",
				})

				PlayersMain:Toggle({
					Name = "Healthbar",
					Flag = "PlayerHealthbar",
				})

				PlayersMain:Toggle({
					Name = "Name",
					Flag = "PlayerName",
				})

				PlayersMain:Toggle({
					Name = "Distance",
					Flag = "PlayerDistance",
				})

				PlayersMain:Toggle({
					Name = "Item",
					Flag = "PlayerWeapon",
				})

				PlayersMain:Toggle({
					Name = "Health",
					Flag = "PlayerHealth",
					Tooltip = "Displays players health on text",
				})

				PlayersMain:Toggle({
					Name = "Weapon image",
					Flag = "PlayerWeaponImage",
					Tooltip = "2d icon of held weapon",
				})

				PlayersMain:Toggle({
					Name = "Flags",
					Flag = "PlayerFlags",
					Tooltip = "Flag certain actions/attributes",
				})

				PlayersMain:Dropdown({
					Multi = true,
					Name = "Selected flags",
					Flag = "PlayerFlagsList",
					Options = {
						"Aiming",
						"Reloading",
						"Healing",
						"Clan",
						"VIP",
						"Staff",
					},
				})

				PlayersMain:Toggle({
					Name = "Offscreen indicators",
					Flag = "PlayerOffscreen",
				});
			end

			do --// Players settings
				PlayersSettings:Toggle({
					Name = "Ignore friends",
					Flag = "IgnoreFriends",
					Tooltip = "Doesn't render in players marked as friendly",
				})

				PlayersSettings:Dropdown({
					Name = "Bounding box type",
					Flag = "PlayerBoxStyle",
					Options = {
						"Solid",
						"Corner",
					},
				})

				PlayersSettings:Toggle({
					Name = "Only show health if damaged",
					Flag = "PlayerShowHealthIfDamaged",
				})

				PlayersSettings:Slider({
					Name = "Maximum distance",
					Flag = "PlayerMaxDistance",
					Min = 100,
					Max = 1300,
					Suffix = "studs",
				})

				PlayersSettings:Slider({
					Name = "Offscreen arrow size",
					Flag = "PlayerOffscreenSize",
					Min = 10,
					Max = 30,
					Increment = 0.1,
				})

				PlayersSettings:Slider({
					Name = "Offscreen arrow radius",
					Flag = "PlayerOffscreenRadius",
					Min = 100,
					Max = 700,
					Increment = 0.1,
				})
			end

			do --// Players colors
				PlayersColors:Colorpicker({
					Name = "Visible color",
					Flag = "PlayerVisibleColor",
					Default = { Color3.fromRGB(255, 0, 0), 0 },
				})

				PlayersColors:Colorpicker({
					Name = "Occluded color",
					Flag = "PlayerOccludedColor",
					Default = { Color3.fromRGB(255, 255, 255), 0 },
				});

				PlayersColors:Colorpicker({
					Name = "Higher health color",
					Flag = "PlayerHigherHealthColor",
					Default = {Color3.fromRGB(120, 255, 100), 0}
				})

				PlayersColors:Colorpicker({
					Name = "Lower health color",
					Flag = "PlayerLowerHealthColor",
					Default = {Color3.fromRGB(255, 0, 0), 0}
				});

				PlayersColors:Seperator();
				PlayersColors:Colorpicker({
					Name = "Aiming flag color",
					Flag = "AimingFlagColor",
					Default = {Color3.fromRGB(3, 169, 252), 0}
				});

				PlayersColors:Colorpicker({
					Name = "Reloading flag color",
					Flag = "ReloadingFlagColor",
					Default = {Color3.fromRGB(255, 255, 255), 0}
				});

				PlayersColors:Colorpicker({
					Name = "Healing flag color",
					Flag = "HealingFlagColor",
					Default = {Color3.fromRGB(120, 255, 100), 0}
				});

				PlayersColors:Colorpicker({
					Name = "VIP flag color",
					Flag = "VIPFlagColor",
					Default = {Color3.fromRGB(252, 211, 3), 0}
				});

				PlayersColors:Colorpicker({
					Name = "Safezone flag color",
					Flag = "SafezoneFlagColor",
					Default = {Color3.fromRGB(0, 211, 0), 0}
				});

				PlayersColors:Colorpicker({
					Name = "Clan flag color",
					Flag = "ClanFlagColor",
					Default = {Color3.fromRGB(255, 255, 255), 0}
				});

				PlayersColors:Colorpicker({
					Name = "Staff flag color",
					Flag = "StaffFlagColor",
					Default = {Color3.fromRGB(255, 255, 255), 0}
				});
			end

			do --// Player models
				PlayerModels:Toggle({
					Name = "Chams",
					Flag = "PlayerChams",
				});

				PlayerModels:Dropdown({
					Name = "Chams style",
					Flag = "PlayerChamsStyle",
					Options = { 
						"Solid",
						"Glow"
					}
				})


				PlayerModels:Colorpicker({
					Name = "Chams visible color",
					Flag = "PlayerChamsVisibleColor",
					Default = { Library.Theme.Accent, 0.2 },
				})

				PlayerModels:Colorpicker({
					Name = "Chams occluded color",
					Flag = "PlayerChamsOccludedColor",
					Default = { Library.Theme.Accent, 0.8 },
				})

				PlayerModels:Seperator()

				PlayerModels:Toggle({
					Name = "Sandbox armor models",
					Flag = "SandboxPlayer",
				})

				PlayerModels:Dropdown({
					Name = "Material",
					Flag = "PlayerArmorMaterial",
					Options = {
						"ForceField",
						"Neon",
						"SmoothPlastic",
						"Plastic",
						"Glass",
					},
				})

				PlayerModels:Slider({
					Name = "Reflectance",
					Flag = "PlayerArmorReflectance",
					Min = 0, Max = 1, Increment = 0.001
				});

				PlayerModels:Slider({ 
					Name = "Reflectance multiplier",
					Flag = "PlayerArmorReflectanceMul",
					Min = 0, Max = 100
				})

				PlayerModels:Colorpicker({
					Name = "Color",
					Flag = "PlayerArmorColor",
					Default = { Library.Theme.Accent, 0.2 },
				})
			end
		end

		do --// AI
			local AIMain = ESPCategories.AI:Section({
				Name = "Main",
				Side = "Left",
			})

			local AISettings = ESPCategories.AI:Section({
				Name = "Settings",
				Side = "Left",
			})

			local AIColors = ESPCategories.AI:Section({
				Name = "Colors",
				Side = "Right",
			})

			local AIModels = ESPCategories.AI:Section({
				Name = "Character model",
				Side = "Right",
			});

			do --// AIs main
				AIMain:Toggle({
					Name = "Enabled",
					Flag = "AIESP",
				})

				AIMain:Toggle({
					Name = "Bounding box",
					Flag = "AIBoundingBox",
				});

				AIMain:Toggle({
					Name = "Skeleton",
					Flag = "AISkeleton",
				});

				AIMain:Toggle({
					Name = "View angle",
					Flag = "AILookAngle",
				})

				AIMain:Toggle({
					Name = "Healthbar",
					Flag = "AIHealthbar",
				})

				AIMain:Toggle({
					Name = "Name",
					Flag = "AIName",
				})

				AIMain:Toggle({
					Name = "Distance",
					Flag = "AIDistance",
				})

				AIMain:Toggle({
					Name = "Health",
					Flag = "AIHealth",
					Tooltip = "Displays AIs health on text",
				})
			end

			do --// AIs settings
				AISettings:Dropdown({
					Name = "Bounding box type",
					Flag = "AIBoxStyle",
					Options = {
						"Solid",
						"Corner",
					},
				})

				AISettings:Toggle({
					Name = "Only show health if damaged",
					Flag = "AIShowHealthIfDamaged",
				})

				AISettings:Slider({
					Name = "Maximum distance",
					Flag = "AIMaxDistance",
					Min = 100,
					Max = 1300,
					Suffix = "studs",
				})
			end

			do --// AIs colors
				AIColors:Colorpicker({
					Name = "Visible color",
					Flag = "AIVisibleColor",
					Default = { Color3.fromRGB(255, 0, 0), 0 },
				})

				AIColors:Colorpicker({
					Name = "Occluded color",
					Flag = "AIOccludedColor",
					Default = { Color3.fromRGB(255, 255, 255), 0 },
				});

				AIColors:Colorpicker({
					Name = "Higher health color",
					Flag = "AIHigherHealthColor",
					Default = {Color3.fromRGB(120, 255, 100), 0}
				})

				AIColors:Colorpicker({
					Name = "Lower health color",
					Flag = "AILowerHealthColor",
					Default = {Color3.fromRGB(255, 0, 0), 0}
				});
			end

			do --// AI models

				AIModels:Toggle({
					Name = "Chams",
					Flag = "AIChams",
				});

				AIModels:Dropdown({
					Name = "Chams style",
					Flag = "AIChamsStyle",
					Options = { 
						"Solid",
						"Glow"
					}
				})

				AIModels:Colorpicker({
					Name = "Chams visible color",
					Flag = "AIChamsVisibleColor",
					Default = { Library.Theme.Accent, 0.2 },
				})

				AIModels:Colorpicker({
					Name = "Chams occluded color",
					Flag = "AIChamsOccludedColor",
					Default = { Library.Theme.Accent, 0.8 },
				})
			end
		end

		do --// Bosses
			local BossMain = ESPCategories.Boss:Section({
				Name = "Main",
				Side = "Left",
			})

			local BossSettings = ESPCategories.Boss:Section({
				Name = "Settings",
				Side = "Left",
			})

			local BossColors = ESPCategories.Boss:Section({
				Name = "Colors",
				Side = "Right",
			})

			local BossModels = ESPCategories.Boss:Section({
				Name = "Character model",
				Side = "Right",
			});

			do --// Boss main
				BossMain:Toggle({
					Name = "Enabled",
					Flag = "BossESP",
				})

				BossMain:Toggle({
					Name = "Bounding box",
					Flag = "BossBoundingBox",
				});

				BossMain:Toggle({
					Name = "Skeleton",
					Flag = "BossSkeleton",
				});

				BossMain:Toggle({
					Name = "View angle",
					Flag = "BossLookAngle",
				})

				BossMain:Toggle({
					Name = "Healthbar",
					Flag = "BossHealthbar",
				})

				BossMain:Toggle({
					Name = "Name",
					Flag = "BossName",
				})

				BossMain:Toggle({
					Name = "Distance",
					Flag = "BossDistance",
				})

				BossMain:Toggle({
					Name = "Health",
					Flag = "BossHealth",
					Tooltip = "Displays Bosses health on text",
				})
			end

			do --// Boss settings
				BossSettings:Dropdown({
					Name = "Bounding box type",
					Flag = "BossBoxStyle",
					Options = {
						"Solid",
						"Corner",
					},
				})

				BossSettings:Toggle({
					Name = "Only show health if damaged",
					Flag = "BossShowHealthIfDamaged",
				})

				BossSettings:Slider({
					Name = "Maximum distance",
					Flag = "BossMaxDistance",
					Min = 100,
					Max = 1300,
					Suffix = "studs",
				})
			end

			do --// Boss colors
				BossColors:Colorpicker({
					Name = "Visible color",
					Flag = "BossVisibleColor",
					Default = { Color3.fromRGB(255, 0, 0), 0 },
				})

				BossColors:Colorpicker({
					Name = "Occluded color",
					Flag = "BossOccludedColor",
					Default = { Color3.fromRGB(255, 255, 255), 0 },
				});

				BossColors:Colorpicker({
					Name = "Higher health color",
					Flag = "BossHigherHealthColor",
					Default = {Color3.fromRGB(120, 255, 100), 0}
				})

				BossColors:Colorpicker({
					Name = "Lower health color",
					Flag = "BossLowerHealthColor",
					Default = {Color3.fromRGB(255, 0, 0), 0}
				});
			end

			do --// Boss models

				BossModels:Toggle({
					Name = "Chams",
					Flag = "BossChams",
				});

				BossModels:Dropdown({
					Name = "Chams style",
					Flag = "BossChamsStyle",
					Options = { 
						"Solid",
						"Glow"
					}
				})

				BossModels:Colorpicker({
					Name = "Chams visible color",
					Flag = "BossChamsVisibleColor",
					Default = { Library.Theme.Accent, 0.2 },
				})

				BossModels:Colorpicker({
					Name = "Chams occluded color",
					Flag = "BossChamsOccludedColor",
					Default = { Library.Theme.Accent, 0.8 },
				})
			end
		end

		do --// World 
			--// Global
			local Global = ESPCategories.World:Section({
				Name = "Global settings",
				Side = "Left"
			});

			Global:Keybind({
				Name = "Combat Hide",
				Flag = "CombatHide",
				Mode = "Toggle"
			});

			Global:Toggle({
				Name = "Smart ESP Fade",
				Tooltip = "Fades objects not in center",
				Flag = "SmartESP"
			});

			Global:Slider({
				Name = "Smart ESP Radius",
				Flag = "FadeRadius",
				Min = 0,
				Max = 1000,
			});

                    --[[Global:Colorpicker({
                        Name = "Distance color",
                        Flag = "ESPMiscDistanceColor",
                        Default = {Color3.fromRGB(255, 255, 255), 0}
                    })]]
			--

			--// Wool
			local Wool = ESPCategories.World:Section({
				Side = "Left",
				Name = "Cloth plants"
			});

			Wool:Toggle({
				Name = "Enabled",
				Flag = "ESPWoolPlants"
			});

			Wool:Colorpicker({
				Name = "Color",
				Flag = "WoolPlantsMiscColor",
				Default = {Color3.fromRGB(25, 107, 0), 1}
			});

			Wool:Slider({
				Min = 10, Max = 1000,
				Suffix = "s",
				Name = "Distance",
				Flag = "WoolPlantsDistance"
			});
			--

			--// Nodes
			local Nodes = ESPCategories.World:Section({
				Side = "Right",
				Name = "Nodes"
			});

			Nodes:Toggle({
				Name = "Enabled",
				Flag = "ESPNodes"
			});

			Nodes:Seperator()

			Nodes:Toggle({
				Name = "Stone",
				Flag = "Stone nodeCanShow"
			});

			Nodes:Colorpicker({
				Name = "Stone color",
				Flag = "Stone nodeColor",
				Default = {Color3.fromRGB(255, 255, 255), 1}
			});

			Nodes:Seperator()

			Nodes:Toggle({
				Name = "Metal",
				Flag = "Metal nodeCanShow"
			})

			Nodes:Colorpicker({
				Name = "Metal color",
				Flag = "Metal nodeColor",
				Default = {Color3.fromRGB(214, 135, 153), 1}
			});

			Nodes:Seperator()

			Nodes:Toggle({
				Name = "Phosphate",
				Flag = "Phosphate nodeCanShow"
			});

			Nodes:Colorpicker({
				Name = "Phosphate color",
				Flag = "Phosphate nodeColor",
				Default = {Color3.fromRGB(237, 193, 104), 1}
			});

			Nodes:Seperator()

			Nodes:Slider({
				Min = 10, Max = 1000,
				Suffix = "s",
				Name = "Distance",
				Flag = "NodesDistance"
			});
			--

			--// Body bags
			local Bodybags = ESPCategories.World:Section({
				Name = "Body bags",
				Side = "Left"
			});

			Bodybags:Toggle({
				Name = "Enabled",
				Flag = "ESPBodyBags",
				Default = {Color3.fromRGB(244, 80, 40), 0}
			});

			Bodybags:Colorpicker({
				Name = "Color",
				Flag = "BodyBagsMiscColor",
				Default = {Color3.fromRGB(255, 255, 255), 0}
			})
			Bodybags:Slider({
				Name ="Distance",
				Flag = "BodyBagsDistance",
				Min = 50, Max = 1000, Suffix = "s"
			});
			--

			--// Dropped items 
			local Items = ESPCategories.World:Section({
				Name = "Items",
				Side = "Right"
			});

			Items:Toggle({
				Name = "Enabled",
				Flag = "ESPItems"
			});

			Items:Seperator();

			Items:Toggle({
				Name = "Guns",
				Flag = "IncludeGun"
			});

			Items:Toggle({
				Name = "Consumable ammo",
				Flag = "IncludeConsumableAmmo"
			});

			Items:Toggle({
				Name = "Consumable armor",
				Flag = "IncludeConsumableAmmoArmor",
			});

			Items:Toggle({
				Name = "Ammo",
				Flag = "IncludeAmmo"
			});

			Items:Toggle({
				Name = "Armor",
				Flag = "IncludeArmor"
			});

			Items:Toggle({
				Name = "Tools",
				Flag = "IncludeTool"
			});

			Items:Toggle({
				Name = "Locks",
				Flag = "IncludeLock"
			});

			Items:Toggle({
				Name = "Benches",
				Flag = "IncludeBench"
			});

			Items:Toggle({
				Name = "Resources",
				Flag = "IncludeResource"
			});

			Items:Toggle({
				Name = "Components / Misc",
				Flag = "IncludeMisc"
			})

			Items:Toggle({
				Name = "Attachments",
				Flag = "IncludeAttachment"
			});

			Items:Toggle({
				Name = "Consumables",
				Flag = "IncludeConsumable"
			});

			Items:Seperator();

			Items:Colorpicker({
				Name = "Color", Flag = "ItemsColor"
			});

			Items:Slider({Name = "Distance", Flag = "ItemsDistance", Min = 50, Max = 1000, Suffix = "s"})
			--

			--// Raids 
			local Raids = ESPCategories.World:Section({Name = "Raids", Side = "Right"});
			Raids:Toggle({
				Name = "Enabled",
				Flag = "ESPRaids"
			});

			Raids:Colorpicker({
				Name = "Color",
				Flag = "RaidsMiscColor",
				Default = {
					Color3.fromRGB(255, 0, 102),
					0
				}
			})

			Raids:Slider({
				Name = "Distance",
				Flag = "RaidsDistance",
				Min = 50, Max = 10000, Suffix = "s"
			});

			Raids:Seperator()
			Raids:Toggle({
				Name = "Notifications",
				Flag = "RaidNotifications",
				Tooltip = "Notifies you when a raid starts"
			});
			-- 

			--// Timed Crates
			local TimedCrates = ESPCategories.World:Section({Name = "Timed Crates", Side = "Left"});
			TimedCrates:Toggle({
				Name = "Enabled",
				Flag = "ESPTimedCrates"
			});

			TimedCrates:Colorpicker({
				Flag = "TimedCratesMiscColor",
				Default = {
					Color3.fromRGB(0, 122, 8),
					0
				},
				Name = "Color"
			});

			TimedCrates:Slider({
				Name = "Distance",
				Flag = "TimedCratesDistance",
				Min = 50, Max = 1000, Suffix = "s"
			})
			--

			--// Care Packages 
			local CarePackages = ESPCategories.World:Section({
				Name = "Care Packages",
				Side = "Right"
			});

			CarePackages:Toggle({
				Name = "Enabled",
				Flag = "ESPCarePackages",
			});

			CarePackages:Colorpicker({
				Name = "Color",
				Flag = "CarePackagesMiscColor",
				Default = {
					Color3.fromRGB(0, 244, 8),
					0
				}
			});

			CarePackages:Slider({
				Name = "Distance",
				Flag = "CarePackagesDistance",
				Min = 50, Max = 10000, Suffix = "s"
			})
			--

			--// Sleepers
			local Sleepers = ESPCategories.World:Section({
				Name = "Sleepers",
				Side = "Right"
			});

			Sleepers:Toggle({
				Name = "Enabled",
				Flag = "ESPSleepers"
			});

			Sleepers:Colorpicker({
				Name = "Color",
				Flag = "SleepersMiscColor",
			})

			Sleepers:Slider({
				Name = "Distance",
				Flag = "SleepersDistance",
				Min = 50, Max = 1000, Suffix = "s"
			})
			--
		end;
	end

	local VisualsCategories = {
		Camera = Pages.Visuals:Category({ Name = "Camera"}),
		World = Pages.Visuals:Category({ Name = "World"}),
		Viewmodel = Pages.Visuals:Category({ Name = "Viewmodel "});
	};

	--// Visuals Categories 
	--// Camera
	local CamEffects = VisualsCategories.Camera:Section({
		Name = "Camera Effects",
		Side = "Left"
	});

	local DebugCamera = VisualsCategories.Camera:Section({
		Name = "Debug Camera",
		Side = "Right"
	})

	local ThirdPerson = VisualsCategories.Camera:Section({
		Name = "Third person",
		Side = "Right"
	});

	--// Third person 
	ThirdPerson:Toggle({
		Name = "Enabled",
		Flag = "ThirdPerson",
		Tooltip = "WARNING: Can cause invalids"
	})

	ThirdPerson:Keybind({
		Name = "Third Person Key",
		Flag = "Third Person Activation",
		Mode = "Toggle",
		Callback = function()
			local Viewmodel = Workspace.VFX.VMs:GetChildren()[1];
			local ThirdPerson = Library.Flags.ThirdPerson.Value and Library.Flags["Third Person Activation"].Active
			if Viewmodel then 
				if ThirdPerson then 
					for Index, Part in Viewmodel:GetDescendants() do 
						if Part:IsA("Part") or Part:IsA("MeshPart") then 
							if Part.Transparency ~= 1 then 
								Part:SetAttribute("OriginalTransparency", Part.Transparency)
							end;
							Part.Transparency = 1;
						end;
					end;
				else 
					for Index, Part in Viewmodel:GetDescendants() do 
						if Part:IsA("Part") or Part:IsA("MeshPart") then 
							if Part:GetAttribute("OriginalTransparency") then 
								Part.Transparency = Part:GetAttribute("OriginalTransparency")
							end;
						end;
					end;
				end;
			end;
		end;
	})

	ThirdPerson:Slider({
		Name = "Distance",
		Flag = "ThirdPersonDistance",
		Min = 0, Max = 20, 
		Increment = 0.1,
	})
	--

	--// Cam Effects
	CamEffects:Toggle({
		Name = "Remove bobbing",
		Flag = "RemoveCameraBobbing"
	});

	CamEffects:Seperator();

	CamEffects:Toggle({
		Name = "Custom field of view",
		Flag = "ChangeFOV",
		Callback = function()
			if Library.Flags.ChangeFOV.Value then 
				Camera.FieldOfView = Library.Flags.CustomFOV.Value 
			end;
		end;
	});

	local MaximumFOV = 120
	CamEffects:Slider({
		Name = "Field of view",
		Suffix = "°",
		Flag = "CustomFOV",
		Min = 70, Max = MaximumFOV,
		Callback = function()
			if Library.Flags.ChangeFOV.Value then 
				Camera.FieldOfView = Library.Flags.CustomFOV.Value 
			end;
		end;
	});

	CamEffects:Seperator();

	CamEffects:Toggle({
		Name = "Zoom",
		Flag = "Zoom"
	});

	CamEffects:Slider({
		Name = "Zoom level",
		Suffix = "°",
		Flag = "ZoomFOV",
		Min = 10, Max = 40
	});

	CamEffects:Keybind({
		Name = "Zoom key",
		Flag = "Zoom Activation",
		Mode = "Hold",
		Callback = function()
			if Library.Flags["Zoom"].Value and Library.Flags["Zoom Activation"].Active then 
				Camera.FieldOfView = Library.Flags.ZoomFOV.Value 
			end;
		end;
	})
	--

	--// Debug Camera 
	DebugCamera:Toggle({
		Name = "Enabled",
		Flag = "DebugCamera"
	})

	DebugCamera:Keybind({
		Name = "Debug Camera Key",
		Flag = "Debug Camera Activation",
		Mode = "Toggle"
	})

	DebugCamera:Slider({
		Name = "Speed",
		Flag = "DebugCameraSpeed",
		Min = 1, Max = 300, Increment = 0.1
	})
	--
	--

	--// World 
	local LightingSection = VisualsCategories.World:Section({
		Name = "Lighting",
		Side = "Left"
	});

	local BaseSection = VisualsCategories.World:Section({
		Name = "Bases",
		Side = "Right"
	}); 

	local Hitmarkers = VisualsCategories.World:Section({
		Name = "Hitmarkers",
		Side = "Left"
	});

	local Tracers = VisualsCategories.World:Section({
		Name = "Tracers",
		Side = "Right"
	});

	local TerrainSection = VisualsCategories.World:Section({
		Name = "Terrain",
		Side = "Left"
	});

	local CloudsSection = VisualsCategories.World:Section({
		Name = "Clouds",
		Side = "Right"
	})

	local FogSection = VisualsCategories.World:Section({
		Name = "Fog",
		Side = "Left"
	});

	local BloomSection = VisualsCategories.World:Section({
		Name = "Bloom",
		Side = "Right"
	});

	--// Bloom Section 
	local Bloom = Lighting:FindFirstChildOfClass("BloomEffect") or Globals:Instance("BloomEffect", {
		Parent = Lighting,
		Enabled = false
	});

	BloomSection:Toggle({
		Name = "Enabled",
		Flag = "Bloom",
		Callback = function() 
			Bloom.Enabled = Library.Flags.Bloom.Value 
		end
	});

	BloomSection:Slider({
		Name = "Intensity",
		Flag = "BloomIntensity",
		Min = 0, Max = 5,
		Increment = 0.1,
		Callback = function()
			Bloom.Intensity = Library.Flags.BloomIntensity.Value
		end;
	})

	BloomSection:Slider({
		Name = "Threshold",
		Flag = "BloomThreshold",
		Min = 0, Max = 1,
		Increment = 0.1,
		Callback = function()
			Bloom.Intensity = Library.Flags.BloomThreshold.Value
		end;
	})

	BloomSection:Slider({
		Name = "Size",
		Flag = "BloomSize",
		Min = 0, Max = 50,
		Increment = 0.1,
		Callback = function()
			Bloom.Size = Library.Flags.BloomSize.Value
		end;
	});
	--

	--// Tracers Section
	Tracers:Toggle({
		Name = "Enabled",
		Flag = "BulletTracers"
	});

	Tracers:Toggle({
		Name = "Show enemy tracers",
		Flag = "ShowEnemyTracers"
	});

	Tracers:Seperator()

	Tracers:Colorpicker({
		Name = "Client tracer color",
		Flag = "TracerColor", Default = {Library.Theme.Accent, 0}
	});

	Tracers:Colorpicker({
		Name = "Enemy tracer color",
		Flag = "EnemyTracerColor", Default = {Color3.fromRGB(255, 0, 0), 0}
	});

	Tracers:Seperator()

	Tracers:Slider({
		Name = "Brigtness",
		Min = 1, Max = 10,
		Flag = "TracerBrightness"
	});

	Tracers:Slider({
		Name = "Lifetime",
		Flag = "TracerLifetime",
		Min = 1, Max = 5, Increment = 0.1
	});

	Tracers:Slider({
		Name = "Speed",
		Flag = "ReferenceTime",
		Min = 50, Max = 300, Default = 250
	});

	Tracers:Seperator()
	--                        BulletTracers:AddDropdown("Texture", "BeamTexture", {"Default", "Lightning", "Dark"});
	Tracers:Dropdown({Name = "Texture", Flag = "BeamTexture", Options = {"Default", "Lightning", "Dark"}})
	--, TracerBrightness, BeamTexture, TracerLifetime, ReferenceTime, 
	--

	--// Hitmarkers Section 
	--HitmarkerColor, HitmarkerSize, HitmarkerTime
	Hitmarkers:Toggle({
		Name = "Enabled",
		Flag = "Hitmarkers",
	});

	Hitmarkers:Toggle({
		Name = "Prioritize hitmarker visibility",
		Flag = "PrioritizeHitmarkers"
	})

	Hitmarkers:Toggle({
		Name = "Apply random rotation",
		Flag = "HitmarkerRandomRotation"
	})

	Hitmarkers:Colorpicker({
		Name = "Color",
		Flag = "HitmarkerColor"
	});

	Hitmarkers:Slider({
		Name = "Size",
		Flag = "HitmarkerSize",
		Min = 10, Max = 20
	});

	Hitmarkers:Slider({
		Name = "Lifetime",
		Flag = "HitmarkerTime",
		Min = 0.1, Max = 3, Increment = 0.1;
	})
	--

	--// Clouds Section
	if Workspace.Terrain:FindFirstChild("Clouds") then 
		local OldDensity = Workspace.Terrain.Clouds.Density; 
		local OldCover = Workspace.Terrain.Clouds.Cover; 
		local OldCloudColor = Workspace.Terrain.Clouds.Color

		local function CloudCallback()
			Workspace.Terrain.Clouds.Density = Library.Flags.ChangeCloudDensity.Value and Library.Flags.CloudDensity.Value or OldDensity
			Workspace.Terrain.Clouds.Cover = Library.Flags.ChangeCloudCover.Value and Library.Flags.CloudCover.Value or OldCover
			Workspace.Terrain.Clouds.Color = Library.Flags.ChangeCloudColor.Value and Library.Flags.CloudColor.Value[1] or OldloudColor;
		end;

		CloudsSection:Toggle({
			Name = "Change cloud density",
			Flag = "ChangeCloudDensity",
			Callback = CloudCallback
		});

		CloudsSection:Slider({
			Name = "Density",
			Flag = "CloudDensity",
			Min = 0, Max = 1, Increment = 0.001,
			Callback = CloudCallback
		});

		CloudsSection:Seperator()

		CloudsSection:Toggle({
			Name = "Change cloud cover",
			Flag = "ChangeCloudCover",
			Callback = CloudCallback
		});

		CloudsSection:Slider({
			Name = "Density",
			Flag = "CloudCover",
			Min = 0, Max = 1, Increment = 0.001,
			Callback = CloudCallback
		});

		CloudsSection:Seperator()

		CloudsSection:Toggle({
			Name = "Change cloud color",
			Flag = "ChangeCloudColor",
			Callback = CloudCallback
		});

		CloudsSection:Colorpicker({
			Name = "Color",
			Flag = "CloudColor",
			Callback = CloudCallback;
		})
	end
	--

	--// Fog Section
	local Atmosphere = Lighting:FindFirstChild("Atmosphere");

	if Atmosphere then 
		local OldFogDensity = Atmosphere.Density; 
		local OldFogColor = Atmosphere.Color; 
		local OldFogHaze = Atmosphere.Haze 
		local OldFogGlare = Atmosphere.Glare 
		local OldFogDecay = Atmosphere.Decay; 

		local function FogCallback() 
			Atmosphere.Density = Library.Flags.ChangeFogDensity.Value and Library.Flags.FogDensity.Value or OldFogDensity
			Atmosphere.Color = Library.Flags.ChangeFogColor.Value and Library.Flags.FogColor.Value[1] or OldFogColor 
			Atmosphere.Decay = Library.Flags.ChangeFogDecay.Value and Library.Flags.DecayColor.Value[1] or OldFogDecay
			Atmosphere.Glare = Library.Flags.ChangeFogGlare.Value and Library.Flags.FogGlare.Value or OldFogGlare 
			Atmosphere.Haze = Library.Flags.ChangeFogHaze.Value and Library.Flags.FogHaze.Value or OldFogHaze 
		end;

		FogSection:Toggle({
			Name = "Change fog density",
			Flag = "ChangeFogDensity",
			Callback = FogCallback
		});

		FogSection:Slider({
			Name = "Density",
			Flag = "FogDensity",
			Min = 0, Max = 1, Increment = 0.001,
			Callback = FogCallback
		});
		--
		FogSection:Seperator()
		--
		FogSection:Toggle({
			Name = "Change fog haze",
			Flag = "ChangeFogHaze",
			Callback = FogCallback
		});

		FogSection:Slider({
			Name = "Haze",
			Min = 0, Max = 1, Increment = 0.001, Callback = FogCallback, Flag = "FogHaze"
		});
		--
		FogSection:Seperator()
		--
		FogSection:Toggle({
			Name = "Change fog glare",
			Flag = "ChangeFogGlare",
			Callback = FogCallback
		});

		FogSection:Slider({
			Name = "Glare",
			Min = 0, Max = 1, Increment = 0.001, Callback = FogCallback, Flag = "FogGlare"
		});

		FogSection:Toggle({
			Name = "Change fog color",
			Flag = "ChangeFogColor",
			Callback = FogCallback
		});

		FogSection:Colorpicker({
			Name = "Color",
			Flag = "FogColor",
			Callback = FogCallback
		})
		--
		FogSection:Seperator()
		--
		FogSection:Toggle({
			Name = "Change fog decay",
			Flag = "ChangeFogDecay",
			Callback = FogCallback
		});

		FogSection:Colorpicker({
			Name = "Decay",
			Flag = "FogDecay",
			Callback = FogCallback
		});
	end
	--

	--// Lighting Section
                    --[[
                        Lighting:GetPropertyChangedSignal("Ambient"):Connect(LPH_NO_VIRTUALIZE(function()
                            if Library.Flags.Ambient.Value then 
                                Lighting.Ambient = Library.Flags.AmbientColor.Value[1]
                            end
                        end))

                        Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(LPH_NO_VIRTUALIZE(function()
                            if Library.Flags.Ambient.Value then 
                                Lighting.OutdoorAmbient = Library.Flags["AmbientColor"].Value[1]
                            end
                        end))

                        Lighting:GetPropertyChangedSignal("ClockTime"):Connect(LPH_NO_VIRTUALIZE(function()
                            if Library.Flags.ChangeTime.Value then 
                                Lighting.ClockTime = Library.Flags.Time.Value 
                            end;
                        end))
                    ]]

	local BrightnessCallback = LPH_NO_VIRTUALIZE(function() 
		if Library.Flags.Fullbright.Value then 
			Lighting.Brightness = Library.Flags.Brightness.Value;
		end;
	end);

	local AmbientCallback = LPH_NO_VIRTUALIZE(function() 
		if Library.Flags.Ambient.Value then 
			Lighting.OutdoorAmbient = Library.Flags["AmbientColor"].Value[1]
			Lighting.Ambient = Library.Flags["AmbientColor"].Value[1]
		end;
	end);

	local TimeCallback = LPH_NO_VIRTUALIZE(function() 
		if Library.Flags.ChangeTime.Value then 
			Lighting.ClockTime = Library.Flags.Time.Value 
		end;
	end);

	LightingSection:Toggle({Name = "Fullbright", Flag = "Fullbright", Callback = BrightnessCallback});
	LightingSection:Slider({Name = "Brightness", Flag = "Brightness", Min = 2, Max = 6, Increment = 0.1, Callback = BrightnessCallback})
	LightingSection:Seperator()
	LightingSection:Toggle({Name = "Ambience", Flag = "Ambient", Callback = AmbientCallback});
	LightingSection:Colorpicker({Name = "Ambient color", Flag = "AmbientColor", Default = {Library.Theme.Accent, 0.1}, Callback = AmbientCallback});

	LightingSection:Seperator()
	LightingSection:Toggle({Name = "Change time", Flag = "ChangeTime", Callback = TimeCallback})
	LightingSection:Slider({Name = "Time", Flag = "Time", Min = 0, Max = 14, Increment = 0.1, Callback = TimeCallback})
	--

	--// Base Section
	BaseSection:Toggle({
		Name = "XRay",
		Flag = "XRay",
	})

	BaseSection:Keybind({
		Name = "XRay Key",
		Flag = "XRay Activation",
		Callback = LPH_NO_VIRTUALIZE(function()
			for Index, Part in next, Globals.XRayParts do 
				if Library.Flags.XRay.Value and Library.Flags["XRay Activation"].Active  then 
					Part.Transparency = Library.Flags.XRayTransparency.Value;
				else 
					Part.Transparency = 0;
				end;
			end;
		end)
	});

	BaseSection:Slider({
		Name = "XRay transparency",
		Flag = "XRayTransparency",
		Min = 0, Max = 1, Increment = 0.1, Default = 0.5
	})
	--

	--// Terrain Section
	TerrainSection:Toggle({
		Name = "Remove grass",
		Flag = "RemoveGrass",
		Callback = function()
			sethiddenproperty(Workspace.Terrain, "Decoration", not Library.Flags.RemoveGrass.Value);
		end
	})
	--
	--

	--// Viewmodel
	local ViewmodelMaster = VisualsCategories.Viewmodel:Section({
		Name = "Master",
		Side = "Left"
	})

	ViewmodelMaster:Toggle({
		Name = "Enabled",
		Flag = "ViewmodelSandbox"
	});

	local Items = VisualsCategories.Viewmodel:Section({
		Name = "Items",
		Side = "Right"
	});

	local Arms = VisualsCategories.Viewmodel:Section({
		Name = "Arms",
		Side = "Left"
	})

	local Gloves = VisualsCategories.Viewmodel:Section({
		Name = "Gloves",
		Side = "Left"
	});

	local Sleeves = VisualsCategories.Viewmodel:Section({
		Name = "Sleeves",
		Side = "Right"
	});

	local Highlight = VisualsCategories.Viewmodel:Section({
		Name = "Highlight",
		Side = "Left"
	})

	--// Items
	Items:Toggle({
		Name = "Enabled",
		Flag = "ItemChams"
	});

	Items:Toggle({
		Name = "Ignore attachments",
		Flag = "IgnoreAttachments"
	});

	Items:Colorpicker({
		Name = "Color",
		Flag = "VMItemColor",
		Default = {Color3.fromRGB(0, 100, 255), 0}
	});

	Items:Dropdown({
		Name = "Material",
		Flag = "VMItemMaterial",
		Options = {"SmoothPlastic", "ForceField", "Neon", "Glass"}
	});

	Items:Slider({
		Name = "Reflectance", Flag = "ItemReflectance",
		Min = 0, Max = 5, Increment = 0.001
	})
	--

	--// Arms
	Arms:Toggle({
		Name = "Enabled",
		Flag = "ArmChams"
	});

	Arms:Colorpicker({
		Name = "Color",
		Flag = "ArmColor",
		Default = {Color3.fromRGB(0, 100, 255), 0}
	})

	Arms:Dropdown({
		Name = "Material",
		Flag = "ArmMaterial",
		Options = {"SmoothPlastic", "ForceField", "Neon", "Glass"}
	});

	Arms:Slider({
		Name = "Reflectance", Flag = "ArmReflectance",
		Min = 0, Max = 5, Increment = 0.001
	})
	--

	--// Shirt
	Sleeves:Toggle({
		Name = "Enabled",
		Flag = "ShirtChams"
	})

	Sleeves:Colorpicker({
		Name = "Color",
		Flag = "ShirtColor",
		Default = {Color3.fromRGB(0, 100, 255), 0}
	})

	Sleeves:Dropdown({
		Name = "Material",
		Flag = "ShirtMaterial",
		Options = {"SmoothPlastic", "ForceField", "Neon", "Glass"}
	});

	Sleeves:Toggle({
		Name = "Remove sleeves",
		Flag = "RemoveClothing"
	});

	Sleeves:Slider({
		Name = "Reflectance", Flag = "ShirtReflectance",
		Min = 0, Max = 5, Increment = 0.001
	})
	--

	--// Gloves
	Gloves:Toggle({
		Name = "Enabled",
		Flag = "GloveChams"
	})

	Gloves:Colorpicker({
		Name = "Color",
		Flag = "GloveColor",
		Default = {Color3.fromRGB(0, 100, 255), 0}
	})

	Gloves:Dropdown({
		Name = "Material",
		Flag = "GloveMaterial",
		Options = {"SmoothPlastic", "ForceField", "Neon", "Glass"}
	});

	Gloves:Slider({
		Name = "Reflectance", Flag = "GloveReflectance",
		Min = 0, Max = 5, Increment = 0.001
	})
	--

	--// Highlight 
	Highlight:Colorpicker({
		Name = "Fill Color",
		Flag = "VMFillColor",
		Default = {Color3.fromRGB(0, 0, 0), 1}
	})

	Highlight:Colorpicker({
		Name = "Outline Color",
		Flag = "VMOutlineColor",
		Default = {Color3.fromRGB(0, 0, 0), 0}
	})
	--

	--
                --[[
                     ViewmodelSandbox:AddColorpicker("Highlight fill color", "VMFillColor", Color3.fromRGB(0, 0, 0), 1);
                        ViewmodelSandbox:AddColorpicker("Highlight outline color", "VMOutlineColor", Color3.fromRGB(0, 0, 0), 0)
                ]]
	--
	-- 

	local MiscCategories = {
		Interactions = Pages.Misc:Category({ Name = "Interactions" }),
		Movement = Pages.Misc:Category({ Name = "Movement" }),
	};

	--// Misc Interaction Categories 
	local Loot = MiscCategories.Interactions:Section({
		Name = "Looting",
		Side = "Right"
	});

	Loot:Toggle({
		Name = "Instant loot",
		Flag = "InstantLoot",
		Callback = function()
			if #Globals.QuickStackFunctions > 0 then
				for _, FUNCTION in pairs(Globals.QuickStackFunctions) do
					debug.setconstant(FUNCTION, 19, Library.Flags.InstantLoot.Value and 0 or 0.9) -- 0.9 
					debug.setconstant(FUNCTION, 20, Library.Flags.InstantLoot.Value and 0 or 0.3) -- 0.3
					debug.setconstant(FUNCTION, 21, Library.Flags.InstantLoot.Value and 0 or 0.1) -- 0.1
				end
			end
		end;
	});

	local Bases = MiscCategories.Interactions:Section({
		Name = "Bases",
		Side = "Left"
	});

	Bases:Toggle({
		Name = "Disable turrets",
		Flag = "DisableTurrets",
		Callback = LPH_NO_VIRTUALIZE(function()
			for Index, Part in next, Globals.TouchCollisions do 
				Part.CanTouch = not Library.Flags.DisableTurrets.Value
			end;
		end);
	});

	Bases:Toggle({
		Name = "Disable trap damage",
		Flag = "DisableDamageParts",
		Callback = LPH_NO_VIRTUALIZE(function()
			for Index, Part in next, Globals.DamageParts do 
				Part.CanTouch = not Library.Flags.DisableDamageParts.Value 
			end;
		end);
	});

	local Building = MiscCategories.Interactions:Section({
		Name = "Building",
		Side = "Left"
	});

	Building:Toggle({
		Name = "Auto Upgrade",
		Flag = "AutoUpgrade"
	});

	Building:Slider({
		Name = "Distance",
		Flag = "AutoUpgradeDistance",
		Min = 5, Max = 30
	});

	Building:Dropdown({
		Name = "Level",
		Flag = "UpgradeMaterial",
		Options = {
			"Wood",
			"Stone",
			"Metal",
			"Steel"
		};
	});
	-- 

	--// Misc Movement categories 
	local Flight = MiscCategories.Movement:Section({
		Name = "Flight",
		Side = "Left"
	});

	local GeneralMovement = MiscCategories.Movement:Section({
		Name = "General movement",
		Side = "Right"
	})

	local NoFall = MiscCategories.Movement:Section({
		Name = "Anti fall damage",
		Side = "Left"
	});

	local TeleportSection = MiscCategories.Movement:Section({
		Name = "Teleport",
		Side = "Right"
	})

	--// Teleport section
	TeleportSection:Toggle({
		Name = "Enabled",
		Flag = "ShootOnTP",
		Risky = true
	});

	TeleportSection:Keybind({
		Name = "Teleport Key",
		Flag = "Teleport Activation",
		Mode = "Toggle"
	})
	--

	--// Flight Section
	Flight:Toggle({
		Name = "Enabled",
		Flag = "Fly",
	});

	Flight:Toggle({
		Name = "Bypass flight restriction",
		Flag = "InfiniteFly",
		Risky = true
	});

	Flight:Keybind({
		Name = "Fly key",
		Flag = "Fly Activation"
	});

	Flight:Slider({
		Name = "Fly speed",
		Flag = "FlySpeed",
		Min = 2, Max = 6,
		Increment = 0.1,
	});
	--

	--// General movement 
	GeneralMovement:Toggle({
		Name = "Silent step",
		Flag = "SilentStep",
		Risky = true
	});

	GeneralMovement:Toggle({
		Name = "Bunnyhop",
		Flag = "Bunnyhop"
	});

	GeneralMovement:Toggle({
		Name = "Omnisprint",
		Flag = "Omnisprint"
	});

	GeneralMovement:Toggle({
		Name = "Always grounded",
		Flag = "AlwaysGrounded",
		Tooltip = "Doesn't work on potassium"
	});
	--

	--// No fall
	NoFall:Toggle({
		Name = "Enabled",
		Flag = "NoFall"
	})
	--
	--

	local SkinCategories = {
		Global = Pages.Skins:Category({ Name = "Global Settings" }),
		Guns = Pages.Skins:Category({ Name = "Items" }),
		Armor = Pages.Skins:Category({ Name = "Armor" }),
	}

	--// Skins 

	local GlobalSection = SkinCategories.Global:Section({
		Name = "Global Settings",
		Side = "Left"
	})

	GlobalSection:Toggle({
		Name = "Enable skin changer",
		Flag = "SkinChanger",
	})

	if ReplicatedStorage:FindFirstChild("VMs") then
		local VMs = ReplicatedStorage.VMs; 
		local Sleeves = ReplicatedStorage.Sleeves;

		local ItemSkins = {};
		local ArmorSkins = {}; 

		for Index, Item in VMs:GetChildren() do 
			if Item:IsA("Folder") then 
				ItemSkins[Item.Name] = {}
				for _, Skin in Item:GetChildren() do 
					if Skin:IsA("Model") then 
						ItemSkins[Item.Name][#ItemSkins[Item.Name] + 1] = Skin.Name;
					end;
				end;
			end;
		end;

		for Index, Armor in Sleeves:GetChildren() do 
			if Armor:IsA("Folder") then 
				ArmorSkins[Armor.Name] = {}
				for _, Skin in Armor:GetChildren() do 
					if Skin:IsA("Model") then 
						ArmorSkins[Armor.Name][#ArmorSkins[Armor.Name] + 1] = Skin.Name;
					end;
				end;
			end;
		end;

		do --// Guns/Items
			local GoLeft = false
			for Item, Skins in ItemSkins do 
				if #Skins > 1 then 
					GoLeft = not GoLeft
					local Section = SkinCategories.Guns:Section({
						Name = Item,
						Side = GoLeft and "Left" or "Right"
					});

					Section:Toggle({
						Name = "Enabled",
						Flag = "EnableSkin_"..Item
					})
					Section:Dropdown({
						Name = "Skin",
						Flag = "Skin_"..Item,
						Options = Skins,
					})
				end;
			end;
		end; 

		do --// Armor 
			local GoLeft = false 
			for Armor, Skins in ArmorSkins do 
				if #Skins > 1 then 
					GoLeft = not GoLeft
					local Section = SkinCategories.Armor:Section({
						Name = Armor,
						Side = GoLeft and "Left" or "Right"
					});

					Section:Toggle({
						Name = "Enabled",
						Flag = "EnableSkin_"..Armor
					})
					Section:Dropdown({
						Name = "Skin",
						Flag = "Skin_"..Armor,
						Options = Skins,
					})
				end;
			end;
		end;
	end;
	-- 

	local SettingsCategories = { 
		Main = Pages.Settings:Category({
			Name = "Main"
		}),
	};

	--// Configs 
	local Configs = SettingsCategories.Main:Section({
		Name = "Configurations",
		Side = "Left"
	});

	Configs:Textbox({
		Name = "Configuration Name",
		Flag = "ConfigName",
	});

	local Save = Configs:Button({
		Name = "Save",
		Flag = "SaveButton",
		Confirm = true,
		Callback = LPH_NO_VIRTUALIZE(function()
			Library:SaveConfig(Library.Flags.ConfigName.Value)
		end)
	}):AddButton({
		Name = "Load",
		Flag = "LoadButton",
		Confirm = true,
		Callback = LPH_NO_VIRTUALIZE(function() 
			local s, e = pcall(Library:LoadConfig(Library.Flags.ConfigName.Value))
			if not s and e then rconsoleprint(e); end;
		end);
	});
	Configs:Button({
		Name = "Delete config",
		Flag = "DeleteButton",
		Confirm = true,
		Callback = function() 
			local Name = tostring(Library.Flags.ConfigName.Value);
			local FilePath = ConfigsFolder.."/"..Name..".json";
			if not isfile(FilePath) then 
				Library:Notify("Failed to load config!\n"..FilePath.."does not exist!", 4, Color3.fromRGB(255, 165, 0))
				return
			end;

			delfile(FilePath)
		end;
	});

	if game.PlaceId == 17574618959 or game.PlaceId == 18911599934 then 
		Configs:Button({
			Name = "Rejoin",
			Flag = "Rejoin",
			Callback = function() 
				game.TeleportService:Teleport(game.PlaceId);
			end;
		})
	end;
	--

	--// HUD
	local HUD = SettingsCategories.Main:Section({
		Name = "Heads up Display",
		Side = "Right"
	});

	HUD:Toggle({
		Name = "Hotkeys panel",
		Flag = "HotkeysPanel",
		Default = true,
		Callback = function()
			Window.Hotkeys.Components.Hotkeys.Visible = Library.Flags.HotkeysPanel.Value 
		end;
	})

	HUD:Toggle({
		Name = "Moderator panel",
		Flag = "ModeratorPanel",
		Default = true,
		Callback = function()
			Window.ModPanel.Components.Moderators.Visible = Library.Flags.ModeratorPanel.Value 
		end;
	})
	--;

	--// ESP 
	local ESPSettingsGlobal = SettingsCategories.Main:Section({
		Name = "Global ESP settings",
		Side = "Left"
	})

	ESPSettingsGlobal:Slider({
		Name = "Chams refresh rate",
		Flag = "ChamsRefreshRate",
		Min = 0, Max = 10, Suffix = "s", Increment = 0.1
	})
	--;

	local Watermark = Library:CreateWatermark("")
	task.wait(0.5)

	Globals:Tween(Window.Components.Outline, TweenInfo.new(Library.HighlightSpeed, Enum.EasingStyle.Quad), {
		Position = UDim2.new(0.5, 0, 0.5, 0),
	})
	Window:SetTab(Pages.Combat)
	task.wait(2)

	Watermark:SetText("X64DBG - Survivals!"); -- Feel free to change it!

	local ArmorPanel = Window.ArmorPanel;
	Globals.ArmorPanel = ArmorPanel;
end)()

Log("Successfully setup UI")
--#endregion UI Setup

--#region Flags 
local AimingAnimationId = "rbxassetid://10982316984"
local HealingAnimationIds = {
	["rbxassetid://14860445359"] = true,
	["rbxassetid://2529243689"] = true
}

EntityClass.Main.Functions:AddFlag({
	Name = "Aiming",
	ClassTypes = {"Player"},
	Text = LPH_NO_VIRTUALIZE(function(self) return "Scope" end),
	Allow = LPH_NO_VIRTUALIZE(function(self)
		if not (self.Character and self.Character:FindFirstChild("Humanoid")) then return false end

		local Root = self.Character.Humanoid.RootPart
		if not Root then return false end

		local Weapon = self.CachedItem
		if Weapon and Weapon.Name == "Wooden Bow" then
			local DrawAnim = Root:FindFirstChild("Wooden BowDraw")
			return DrawAnim and DrawAnim.IsPlaying
		end

		for _, track in ipairs(self.Character.Humanoid:GetPlayingAnimationTracks()) do
			if track.Animation.AnimationId == AimingAnimationId then
				return true
			end
		end
		return false
	end)
})

EntityClass.Main.Functions:AddFlag({
	Name = "Reloading",
	ClassTypes = {"Player"},
	Text = LPH_NO_VIRTUALIZE(function(self) return "Reload" end),
	Allow = LPH_NO_VIRTUALIZE(function(self)
		local Root = self.Character and self.Character:FindFirstChild("HumanoidRootPart")
		local Weapon = self.CachedItem
		if not (Root and Weapon) then return false end

		local WeaponName = Weapon.Name
		local MagIn, MagOut

		if WeaponName == "Crossbow" then
			MagIn = Root:FindFirstChild("CrossbowPlaceArrow")
			MagOut = Root:FindFirstChild("CrossbowPull")
		else
			MagIn = Root:FindFirstChild(WeaponName.. "MagIn")
			MagOut = Root:FindFirstChild(WeaponName .. "MagOut")
		end

		return (MagIn and MagIn.IsPlaying) or (MagOut and MagOut.IsPlaying)
	end)
})

EntityClass.Main.Functions:AddFlag({
	Name = "Healing",
	ClassTypes = {"Player"},
	Text = LPH_NO_VIRTUALIZE(function(self) return "Heal" end),
	Allow = LPH_NO_VIRTUALIZE(function(self)
		if not (self.Character and self.Character:FindFirstChild("Humanoid")) then return false end

		for _, track in ipairs(self.Character.Humanoid:GetPlayingAnimationTracks()) do
			if HealingAnimationIds[track.Animation.AnimationId] then
				return true
			end
		end
		return false
	end)
})

EntityClass.Main.Functions:AddFlag({
	Name = "VIP",
	ClassTypes = {"Player"},
	Text = LPH_NO_VIRTUALIZE(function(self) return "VIP" end),
	Allow = LPH_NO_VIRTUALIZE(function(self)
		return self.Pointer and self.Pointer:GetAttribute("VIP")
	end)
})

EntityClass.Main.Functions:AddFlag({
	Name = "Clan",
	ClassTypes = {"Player"},
	Text = LPH_NO_VIRTUALIZE(function(self)
		if self.Pointer:GetAttribute("ClanTag") then 
			return "C: "..self.Pointer:GetAttribute("ClanTag")
		end 
		return ""
	end),
	Allow = LPH_NO_VIRTUALIZE(function(self)
		return self.Pointer and self.Pointer:GetAttribute("ClanTag")
	end)
})

EntityClass.Main.Functions:AddFlag({
	Name = "Staff",
	ClassTypes = {"Player"},
	Text = LPH_NO_VIRTUALIZE(function(self)
		return self.Pointer and Globals.FlaggedStaff[self.Pointer] 
			and "STAFF: "..Globals.FlaggedStaff[self.Pointer] or nil
	end),
	Allow = LPH_NO_VIRTUALIZE(function(self)
		return self.Pointer and Globals.FlaggedStaff[self.Pointer]
	end)
})
--#endregion Flags

--#region Connections
local RaidsFolder = Globals:Instance("Folder", { 
	Parent = CoreGui,
	Name = "Raids"
});

Globals.RaidsFolder = RaidsFolder;

local AttackersFolder = Globals:Instance("Folder", { 
	Parent = CoreGui,
	Name = "AttackerFolder"
})

Globals.AttackersFolder = AttackersFolder;

--// All important connections
LPH_JIT_MAX(function()
	--// Players
	local ModPanel = Library.Window.ModPanel;
	local FlaggedRoles = {
		"OG",
		"Game Tester",
		"Game Moderator",
		"Developers",
		"Lead Developer",
		"Co-Founder",
		"Founder",
	};

	local function CheckMod(Player) 
		if Player == Client then 
			Library:Notify("Test....");
			ModPanel:Add(Player.Name, "test")
		end;

		local Role = "cuck"
		local IsMod = false;
		if Player:IsInGroup(1154360) then
			Role = Player:GetRoleInGroup(1154360)
			if table.find(FlaggedRoles, Role) then
				Library:Notify("Staff detected! ["..Player.Name .. "] Role: "..Role, 15, Color3.fromRGB(255, 0, 0))
				ModPanel:Add(Player.Name, Role);
				Globals.FlaggedStaff[Player] = Role
			end
		end;

		if TrialModList[Player.UserId] and not Globals.FlaggedStaff[Player] then 
			Role = "Trial Moderator";
			Library:Notify("Staff detected! "..Player.Name .. " | Role: "..Role, 15, Color3.fromRGB(255, 0, 0))
			ModPanel:Add(Player.Name, Role);
			Globals.FlaggedStaff[Player] = Role
		end;

		return IsMod, Role
	end;

	for Index, Player in Players:GetChildren() do 
		if Player ~= Client then 
			local EntityObject = EntityClass.Global:Create(
				Player,
				{
					Class = "Player",
					ClassType = "Player",
				}
			); 

			Player.CharacterAdded:Connect(function(Character)
				EntityObject:OnCharacterAdded(Character)
			end)

			if Player.Character then 
				EntityObject:OnCharacterAdded(Player.Character);
			end;

			pcall(CheckMod, Player)
		end;
	end;

	Players.PlayerAdded:Connect(function(Player)
		local EntityObject = EntityClass.Global:Create(
			Player,
			{
				Class = "Player",
				ClassType = "Player",
			}
		); 

		Player.CharacterAdded:Connect(function(Character)
			EntityObject:OnCharacterAdded(Character)
		end)

		if Player.Character then 
			EntityObject:OnCharacterAdded(Player.Character);
		end;

		pcall(CheckMod, Player)
	end);

	Players.ChildRemoved:Connect(function(Player)
		EntityClass.Main.Functions:Remove(Player);
		if Globals.FlaggedStaff[Player] then 
			ModPanel:UpdateModerator(Player.Name, nil, true)
		end;
	end)
	--

	--// AI 
	local Military = Workspace:FindFirstChild("Military")
	if Military then 
		local Events = Workspace:FindFirstChild("Events")
		local function CacheSoldier(Soldier)
			if table.find({"Brutus", "Bruno", "BTR", "Boris", "Soldier"}, Soldier.Name) then 
				local ClassType = "AI"
				if Soldier.Name == "Brutus" or Soldier.Name == "Bruno" or Soldier.Name == "Boris" or Soldier.Name == "BTR" then 
					ClassType = "Boss"
				end;

				local EntityObject = EntityClass.Global:Create(
					Soldier,
					{
						Class = "AI",
						ClassType = ClassType,
					}
				); 
			else 
				return
			end;
		end;

		for Index, BTR in Events:GetChildren() do 
			if BTR.Name == "BTR" then 
				CacheSoldier(BTR)
			end;
		end;

		Events.ChildAdded:Connect(function(BTR)
			task.wait(1)
			if BTR.Name == "BTR" then 
				CacheSoldier(BTR)
			end;
		end)

		Events.ChildRemoved:Connect(function(BTR)
			EntityClass.Main.Functions:Remove(BTR)
		end)

		for _, Folder in Military:GetChildren() do 
			for Index, Soldier in Folder:GetChildren() do 
				if Soldier:IsA("Model") then 
					CacheSoldier(Soldier)
				end;
			end;

			Folder.ChildAdded:Connect(function(Soldier)
				task.wait(1)
				if Soldier:IsA("Model") then 
					CacheSoldier(Soldier)
				end;
			end)

			Folder.ChildRemoved:Connect(function(Soldier)
				EntityClass.Main.Functions:Remove(Soldier)
			end)
		end;
	end;
	--

	--// Misc ESP
	local Nodes = Workspace:FindFirstChild("Nodes");
	local Drops = Workspace:FindFirstChild("Drops");
	local Bases = Workspace:FindFirstChild("Bases");
	local Plants = Workspace:FindFirstChild("Plants")

	local FixedNames = {
		["Metal_Node"]      = "Metal node",
		["Phosphate_Node"]  = "Phosphate node",
		["Stone_Node"]      = "Stone node",
	};

	if Nodes then 
		EntityClass.Misc.Functions.AddListener({
			Parent = Nodes,
			ClassName = "Model",
			Listener = "NodeListener",
			Flag = "Nodes",
			GetColor = LPH_NO_VIRTUALIZE(function(Data) 
				local Name = FixedNames[Data.Object.Name];
				return Library.Flags[Name.."Color"].Value[1];
			end);

			GetAlpha = LPH_NO_VIRTUALIZE(function(Data) 
				local Name = FixedNames[Data.Object.Name];
				return Library.Flags[Name.."Color"].Value[2];
			end);

			GetName = LPH_NO_VIRTUALIZE(function(Data)
				local HealthPercent = math.floor((Data.Object:GetAttribute("Health") / Data.Object:GetAttribute("MaxHealth")) * 100);
				local Name = FixedNames[Data.Object.Name];

				return Name .. " "..tostring(HealthPercent).."%"
			end);

			GetPosition = LPH_NO_VIRTUALIZE(function(Data) 
				return Data.Object:FindFirstChild("Main") and Data.Object:FindFirstChild("Main").CFrame.p 
			end);

			GetDistance = LPH_NO_VIRTUALIZE(function(Data) 
				return Data.Object:FindFirstChild("Main") and math.floor((Camera.CFrame.p - Data.Object:FindFirstChild("Main").CFrame.p).Magnitude);
			end);

			Validate    = LPH_NO_VIRTUALIZE(function(Data) 
				local Name = FixedNames[Data.Object.Name];
				return Library.Flags[Name.."CanShow"].Value;
			end);
		});

		Library:Notify("Added node listener...")
	end;
	--
	if Drops then
		local ItemColors = {
			["Misc"] = Color3.fromRGB(210, 210, 210),
			["Gun"] = Color3.fromRGB(214, 20, 20),
			["Ammo"] = Color3.fromRGB(214, 50, 50),
			["Consumable"] = Color3.fromRGB(50, 214, 50),
			["Bench"] = Color3.fromRGB(210, 210, 210),
			["Attachment"] = Color3.fromRGB(252, 215, 3),
			["Resource"] = Color3.fromRGB(3, 252, 161),
			["Lock"] = Color3.fromRGB(210, 210, 210),
			["Tool"] = Color3.fromRGB(255, 255, 255),
			["Armor"] = Color3.fromRGB(255, 0, 183)
		};

		EntityClass.Misc.Functions.AddListener({
			Parent = Drops,
			ClassName = "Model",
			Listener = "ItemListener",
			Flag = "Items",
			GetColor = LPH_NO_VIRTUALIZE(function(Data) 
				return  Library.Flags["ItemsColor"].Value[1];
			end);

			GetAlpha = LPH_NO_VIRTUALIZE(function(Data) 
				return Library.Flags["ItemsColor"].Value[2];
			end);

			GetName = LPH_NO_VIRTUALIZE(function(Data)
				if not Data.DecodedInformation then 
					local Item = Data.Object:FindFirstChild("Item");
					Item = HttpService:JSONDecode(Item.Value);
					local ID = Item.ID; 
					local Amount = Item.Amount;

					local ItemInfo = Globals.ItemInfoTable[ID];
					local Type = ItemInfo.Type;
					Data.Type = Type; 
					Data.DecodedInformation = { 
						ID = ID,
						Amount = Amount,
					};
				end;

				local Color = ItemColors[Data.Type]
				local Name = Data.Object.Name;

				if Data.DecodedInformation.Amount > 1 then
					Name = Name .. " x"..tostring(Data.DecodedInformation.Amount)
				end;

				return Name
			end);

			GetPosition = LPH_NO_VIRTUALIZE(function(Data) 
				return Data.Object.PrimaryPart and Data.Object.PrimaryPart.CFrame.p 
			end);

			GetDistance = LPH_NO_VIRTUALIZE(function(Data) 
				return Data.Object.PrimaryPart and math.floor((Camera.CFrame.p - Data.Object.PrimaryPart.CFrame.p).Magnitude);
			end);

			Validate    = LPH_NO_VIRTUALIZE(function(Data) 
				if Data.Object:FindFirstChild("Item") then 
					if not Data.DecodedInformation then 
						local Item = Data.Object:FindFirstChild("Item");
						Item = HttpService:JSONDecode(Item.Value);
						local ID = Item.ID; 
						local Amount = Item.Amount;

						local ItemInfo = Globals.ItemInfoTable[ID];
						local Type = ItemInfo.Type;
						Data.Type = Type; 
						Data.DecodedInformation = { 
							ID = ID,
							Amount = Amount,
						};
					end;
					return Library.Flags["Include"..Data.Type].Value;
				end;
			end);
		});

		Library:Notify("Added item listener..")
		EntityClass.Misc.Functions.AddListener({
			Parent = Globals.RaidsFolder,
			ClassName = "Part",
			Listener = "RaidListener",
			Flag = "Raids",
			GetName = LPH_NO_VIRTUALIZE(function(Data) 
				local Object = Data.Object;
				local Type = Object.Name
				local Time = tostring(math.floor(tick() - Object.StartedAt.Value));
				return "Potential Raid - "..Object.Name.."\n"..tostring(Time).." seconds ago";
			end);

			GetPosition = LPH_NO_VIRTUALIZE(function(Data) 
				return Data.Object and Data.Object.CFrame.p 
			end);

			GetDistance = LPH_NO_VIRTUALIZE(function(Data) 
				return Data.Object and math.floor((Camera.CFrame.p - Data.Object.CFrame.p).Magnitude);
			end);

			Validate = LPH_NO_VIRTUALIZE(function(Data)
				return true;
			end);
		});

		EntityClass.Misc.Functions.AddListener({ 
			Parent = Globals.AttackersFolder,
			ClassName = "Part",
			Listener = "AttackerListener",
			Flag = "Attackers",
			GetName = LPH_NO_VIRTUALIZE(function(Data) 
				return Data.Object.Name
			end);

			GetPosition = LPH_NO_VIRTUALIZE(function(Data) 
				return Data.Object and Data.Object.CFrame.p 
			end);

			GetDistance = LPH_NO_VIRTUALIZE(function(Data) 
				return Data.Object and math.floor((Camera.CFrame.p - Data.Object.CFrame.p).Magnitude);
			end);

			Validate = LPH_NO_VIRTUALIZE(function(Data)
				return true;
			end);
		})
	end;
	--
	if Bases then 
		local Loners = Bases:FindFirstChild("Loners");
		local TimedCrate = Loners:FindFirstChild("Timed Crate");
		local Sleeper = Loners:FindFirstChild("Sleeper");

		if TimedCrate then 
			EntityClass.Misc.Functions.AddListener({
				Parent = TimedCrate,
				ClassName = "Model",
				Listener = "TimedCrateListener",
				Flag = "TimedCrates",
				GetName = LPH_NO_VIRTUALIZE(function(Data)
					local Name = Data.Object.Name
					local Timer = Data.Object:FindFirstChild("Timer");
					local GuiHolder = Timer and Timer:FindFirstChild("GuiHolder");
					local SurfaceGui = GuiHolder and GuiHolder:FindFirstChild("Label");
					local TextLabel = SurfaceGui and SurfaceGui:FindFirstChild("TextLabel");
					local TimeRemaining = TextLabel and TextLabel.Text or "12:00";

					return Name .. " ["..TimeRemaining.."]"
				end);

				GetPosition = LPH_NO_VIRTUALIZE(function(Data) 
					return Data.Object.PrimaryPart and Data.Object.PrimaryPart.CFrame.p 
				end);

				GetDistance = LPH_NO_VIRTUALIZE(function(Data) 
					return Data.Object.PrimaryPart and math.floor((Camera.CFrame.p - Data.Object.PrimaryPart.CFrame.p).Magnitude);
				end);

				Validate    = LPH_NO_VIRTUALIZE(function(Data) 
					return true
				end);
			});

			Library:Notify("Added timed crate listener...")
		end;
		--
		if Loners then 
			local CarePackage = Loners:FindFirstChild("Care Package");
			local BodyBag = Loners:FindFirstChild("Body Bag")
			if CarePackage then 
				EntityClass.Misc.Functions.AddListener({
					Parent = CarePackage,
					ClassName = "Model",
					Listener = "CarePackageListener",
					Flag = "CarePackages",
					GetName = LPH_NO_VIRTUALIZE(function(Data)
						local Name = Data.Object.Name
						return Name
					end);

					GetPosition = LPH_NO_VIRTUALIZE(function(Data) 
						return Data.Object.PrimaryPart and Data.Object.PrimaryPart.CFrame.p 
					end);

					GetDistance = LPH_NO_VIRTUALIZE(function(Data) 
						return Data.Object.PrimaryPart and math.floor((Camera.CFrame.p - Data.Object.PrimaryPart.CFrame.p).Magnitude);
					end);

					Validate    = LPH_NO_VIRTUALIZE(function(Data) 
						return true
					end);

				});

				Library:Notify("Added care package listener...")
			end;

			if BodyBag then 
				EntityClass.Misc.Functions.AddListener({
					Parent = BodyBag,
					ClassName = "Model",
					Name = "Body Bag",
					Listener = "BodyBagListener",
					Flag = "BodyBags",
					GetName = LPH_NO_VIRTUALIZE(function(Data)
						local Name = Data.Object.Name;
						local OwnerName = Data.Object:GetAttribute("OwnerName");

						local FixedName = Name .. " - "..OwnerName
						return FixedName
					end);

					GetPosition = LPH_NO_VIRTUALIZE(function(Data) 
						return Data.Object.PrimaryPart and Data.Object.PrimaryPart.CFrame.p 
					end);

					GetDistance = LPH_NO_VIRTUALIZE(function(Data) 
						return Data.Object.PrimaryPart and math.floor((Camera.CFrame.p - Data.Object.PrimaryPart.CFrame.p).Magnitude);
					end);

					Validate    = LPH_NO_VIRTUALIZE(function(Data) 
						return true
					end);
				});
				Library:Notify("Added body bag listener...")
			end;
		end;
		--
		if Sleeper then 
			EntityClass.Misc.Functions.AddListener({
				Parent = Sleeper,
				ClassName = "Model",
				Listener = "SleeperListener",
				Flag = "Sleepers",
				GetName = LPH_NO_VIRTUALIZE(function(Data)
					local Name = Data.Object.Name;
					local OwnerName = "Owner";
					local NameTag = Data.Object:FindFirstChild("NameTag");
					local Label = NameTag and NameTag:FindFirstChild("Label");
					OwnerName = Label and Label.Text or OwnerName;

					local FixedName = Name .. " - "..OwnerName
					return FixedName
				end);

				GetPosition = LPH_NO_VIRTUALIZE(function(Data) 
					return Data.Object.PrimaryPart and Data.Object.PrimaryPart.CFrame.p 
				end);

				GetDistance = LPH_NO_VIRTUALIZE(function(Data) 
					return Data.Object.PrimaryPart and math.floor((Camera.CFrame.p - Data.Object.PrimaryPart.CFrame.p).Magnitude);
				end);

				Validate    = LPH_NO_VIRTUALIZE(function(Data) 
					return true
				end);
			});
			Library:Notify("Added sleeper listener...")
		end;
	end; 

	if Plants then 
		EntityClass.Misc.Functions.AddListener({
			Parent = Plants,
			Name = "Wool Plant",
			Listener = "WoolListener",
			Flag = "WoolPlants",
			GetName = LPH_NO_VIRTUALIZE(function(Data)
				return "Cloth Plant"
			end);

			GetPosition = LPH_NO_VIRTUALIZE(function(Data) 
				return Data.Object.PrimaryPart and Data.Object.PrimaryPart.CFrame.p 
			end);

			GetDistance = LPH_NO_VIRTUALIZE(function(Data) 
				return Data.Object.PrimaryPart and math.floor((Camera.CFrame.p - Data.Object.PrimaryPart.CFrame.p).Magnitude);
			end);

			Validate    = LPH_NO_VIRTUALIZE(function(Data) 
				return true
			end);
		});

		Library:Notify("Added plant listener...")
	end;
	--

	--// Camera 
	Camera:GetPropertyChangedSignal("FieldOfView"):Connect(LPH_NO_VIRTUALIZE(function()
		if Library.Flags.Zoom.Value and Library.Flags["Zoom Activation"].Active then 
			Camera.FieldOfView = Library.Flags.ZoomFOV.Value
			return 
		end;

		if Library.Flags.ChangeFOV.Value then 
			Camera.FieldOfView = Library.Flags.CustomFOV.Value
		end;
	end));
	--

	--// Viewmodel 
	local VFX = Workspace:FindFirstChild("VFX")
	local VMs = VFX and VFX:FindFirstChild("VMs"); 

	if VMs then 
		VMs.ChildAdded:Connect(LPH_NO_VIRTUALIZE(function(Viewmodel) 
			task.wait()
			if Viewmodel:IsA("Model") then 
				local Arms = Viewmodel:WaitForChild("Arms");
				local Weapon = Viewmodel:WaitForChild("Weapon");
				local Highlight = Viewmodel:WaitForChild("Highlight", 1); 

				if Arms and Weapon then
					if Library.Flags.ViewmodelSandbox.Value then 
						if Highlight then 
							Highlight.FillColor = Library.Flags.VMFillColor.Value[1];
							Highlight.FillTransparency = Library.Flags.VMFillColor.Value[2];

							Highlight.OutlineColor = Library.Flags.VMOutlineColor.Value[1];
							Highlight.OutlineTransparency = Library.Flags.VMOutlineColor.Value[2];
						end;

						for Index, Part in next, Arms:GetDescendants() do 
							if Part:IsA("MeshPart") then
								if (Part.Name == "Sleeve" or Part.Name == "Armor")  and Library.Flags.ShirtChams and Library.Flags.ShirtChams.Value then 
									Part.Material = Library.Flags.ShirtMaterial.Value;
									Part.Color = Library.Flags.ShirtColor.Value[1];
									Part.Transparency = Library.Flags.ShirtColor.Value[2];
									Part.Reflectance = Library.Flags.ShirtReflectance.Value
								end; 

								if (Part.Name == "Sleeve" or Part.Name == "Armor") and Library.Flags.RemoveClothing and Library.Flags.RemoveClothing.Value then 
									Part.Transparency = 1; 
								end;

								if (Part.Name == "Glove" or Part.Name == "Wrap") and Library.Flags.GloveChams and Library.Flags.GloveChams.Value then 
									Part.Material = Library.Flags.GloveMaterial.Value;
									Part.Color = Library.Flags.GloveColor.Value[1];
									Part.Transparency = Library.Flags.GloveColor.Value[2];
									Part.Reflectance = Library.Flags.GloveReflectance.Value
								end;

								if (Part.Name == "RightArm" or Part.Name == "LeftArm") and Library.Flags.ArmChams and Library.Flags.ArmChams.Value then 
									Part.Material = Library.Flags.ArmMaterial.Value; 
									Part.Color = Library.Flags.ArmColor.Value[1]; 
									Part.Transparency = Library.Flags.ArmColor.Value[2];
									Part.Reflectance = Library.Flags.ArmReflectance.Value
								end;

								if Part.Material == Enum.Material.SmoothPlastic or Part.Material == Enum.Material.Glass or Part.Material == Enum.Material.Neon then 
									Part.TextureID = ""; 
								end;

								if Part.Material == Enum.Material.ForceField then 
									Part.TextureID = "rbxassetid://5843010904";
								end;
							end;
						end;

						if Library.Flags.ItemChams.Value then
							for Index, Part in next, Weapon:GetDescendants() do 
								if Part and Part:IsA("MeshPart") and Part.Transparency ~= 1 then
									if Weapon:FindFirstChild("Attachments") then 
										if Part:IsDescendantOf(Weapon:FindFirstChild("Attachments")) then 
											if not Library.Flags.IgnoreAttachments.Value then 
												Part.Material = Library.Flags.VMItemMaterial.Value;
												Part.Color = Library.Flags.VMItemColor.Value[1];
												Part.Transparency = Library.Flags.VMItemColor.Value[2];
												Part.Reflectance = Library.Flags.ItemReflectance.Value
											end;
										else
											Part.Reflectance = Library.Flags.ItemReflectance.Value
											Part.Material = Library.Flags.VMItemMaterial.Value;
											Part.Color = Library.Flags.VMItemColor.Value[1];
											Part.Transparency = Library.Flags.VMItemColor.Value[2];
										end;
									else 
										Part.Reflectance = Library.Flags.ItemReflectance.Value
										Part.Material = Library.Flags.VMItemMaterial.Value;
										Part.Color = Library.Flags.VMItemColor.Value[1];
										Part.Transparency = Library.Flags.VMItemColor.Value[2];
									end; 

									if Part.Material == Enum.Material.SmoothPlastic or Part.Material == Enum.Material.Glass or Part.Material == Enum.Material.Neon then 
										Part.TextureID = ""; 
									end;

									if Part.Material == Enum.Material.ForceField then 
										Part.TextureID = "rbxassetid://5843010904";
									end;
								end;
							end;
						end;
					end;

					if Library.Flags.ThirdPerson.Value and Library.Flags["Third Person Activation"].Active then 
						for Index, Part in Viewmodel:GetDescendants() do 
							if Part:IsA("MeshPart") or Part:IsA("Part") then 
								if Part.Transparency ~= 1 then 
									Part:SetAttribute("OriginalTransparency", Part.Transparency)
								end;
								Part.Transparency = 1;
							end;
						end;
					end;
				end;
			end;
		end));
	end;
	--

	--// World 
	local TouchCollisions = {};
	local DamageParts = {};
	local XRayParts = {};
	local AllowedBuildings = {
		"Wall",
		"Half Wall",
		"Low Wall",
		"Doorway",
		"Window",
		"Foundation",
		"Floor",
		"Triangle Floor",
		"Wall Frame",
		"Floor Frame",
		"Triangle Floor Frame",
		"L-Shaped Stairs",
		"U-Shaped Stairs",
		"Foundation Steps",
		"Foundation",
		"Triangle Foundation"
	};

	local BGrade = {
		["Wood"] = 1,
		["Stone"] = 2,
		["Metal"] = 3,
		["Steel"] = 4,
	};

	if Workspace:FindFirstChild("Bases") then
		LPH_NO_VIRTUALIZE(function()
			for Index, Value in next, Workspace.Bases:GetDescendants() do 
				if Value:IsA("MeshPart") and Value.Name == "Detail" then 
					if Value.Parent and table.find(AllowedBuildings, Value.Parent.Name) then 
						XRayParts[#XRayParts+1] = Value
					end;
				end; 

				if Value.Name == "TouchCollision" and Value.Parent and Value.Parent.Name == "Shotgun Turret" then 
					TouchCollisions[#TouchCollisions+1] = Value
				end; 

				if Value.Name == "DamagePart" then 
					DamageParts[#DamageParts+1] = Value;
				end;
			end;
		end)();

		Workspace.Bases.DescendantAdded:Connect(LPH_NO_VIRTUALIZE(function(Value)
			if  Value.ClassName == 'Model' and Client.Character and Client.Character:FindFirstChild("Blueprint") and table.find(AllowedBuildings, Value.Name) and Library.Flags.AutoUpgrade.Value then 
				task.spawn(function()
					if not Value.PrimaryPart then
						local StartTime = tick()
						repeat
							task.wait()
						until Value.PrimaryPart or tick() - StartTime > 2
					end

					local Main = Value.PrimaryPart; 
					if Main and (Main.CFrame.p - Camera.CFrame.p).Magnitude < Library.Flags.AutoUpgradeDistance.Value then 
						local BuildingGrade = BGrade[Library.Flags.UpgradeMaterial.Value];
                                    if (not BuildingGrade) then
                                          return;
                                    end;

						Library:Notify(
							"Auto Upgrade\n[Building]: "..Value.Name.. " [Quality]: "..Library.Flags.UpgradeMaterial.Value.." [Distance]: "..tostring(math.floor((Main.CFrame.p - Camera.CFrame.p).Magnitude)).."s",
							3,
							Color3.fromRGB(255, 133, 3)
						)

                                    -- '\223\155\187BG2\179\190\204\146\219\194<\001c\152\005\141:?';
                                    -- 'NM\182\001\154\155j\149\231\163\004\179F\180\232\247\208\a\221\217';

                                    -- 'NM\182\1\154\155j\149\231\163\4\179F\180\232\247\208\7\221\217'

						Globals.BuildingNetworkPointer(
							"Fire",
							"NM\182\1\154\155j\149\231\163\4\179F\180\232\247\208\7\221\217",
							"\223\155\187BG2\179\190\204\146\219\194<\1c\152\5\141:?",
							Value,
							BuildingGrade
						);
					end;
				end);
			end;

			task.wait(0.5);

			if Value:IsA("MeshPart") and Value.Name == "Detail" then 
				if Value.Parent and table.find(AllowedBuildings, Value.Parent.Name) then 
					XRayParts[#XRayParts+1] = Value

					if Library.Flags.XRay.Value and Library.Flags["XRay Activation"].Active then 
						Value.Transparency = Library.Flags.XRayTransparency.Value
					end;
				end;
			end; 

			if Value.Name == "TouchCollision" and Value.Parent and Value.Parent.Name == "Shotgun Turret"  then 
				TouchCollisions[#TouchCollisions+1] = Value
				Value.CanTouch = not Library.Flags.DisableTurrets.Value 
			end; 

			if Value.Name == "DamagePart" then 
				DamageParts[#DamageParts+1] = Value;
				Value.CanTouch = not Library.Flags.DisableDamageParts.Value 
			end;
		end));
	end;

	Globals.TouchCollisions = TouchCollisions;
	Globals.DamageParts = DamageParts; 
	Globals.XRayParts = XRayParts
	--
end)()

Lighting:GetPropertyChangedSignal("Brightness"):Connect(LPH_NO_VIRTUALIZE(function()
	if Library.Flags.Fullbright.Value then 
		Lighting.Brightness = Library.Flags.Brightness.Value;
	end;
end));

Lighting:GetPropertyChangedSignal("Ambient"):Connect(LPH_NO_VIRTUALIZE(function()
	if Library.Flags.Ambient.Value then 
		Lighting.Ambient = Library.Flags.AmbientColor.Value[1]
	end
end))

Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(LPH_NO_VIRTUALIZE(function()
	if Library.Flags.Ambient.Value then 
		Lighting.OutdoorAmbient = Library.Flags["AmbientColor"].Value[1]
	end
end));

local Terrain = Workspace.Terrain; 
local Clouds = Terrain:FindFirstChild("Clouds")
local Atmosphere = Lighting:FindFirstChild("Atmosphere");

if Clouds then 
	Clouds:GetPropertyChangedSignal("Density"):Connect(LPH_NO_VIRTUALIZE(function()
		if Library.Flags.ChangeCloudDensity.Value then 
			Clouds.Density = Library.Flags.CloudDensity.Value;
		end;
	end))

	Clouds:GetPropertyChangedSignal("Cover"):Connect(LPH_NO_VIRTUALIZE(function()
		if Library.Flags.ChangeCloudCover.Value then 
			Clouds.Cover = Library.Flags.CloudCover.Value;
		end;
	end))
	Clouds:GetPropertyChangedSignal("Color"):Connect(LPH_NO_VIRTUALIZE(function()
		if Library.Flags.ChangeCloudColor.Value then 
			Clouds.Color = Library.Flags.CloudColor.Value[1];
		end;
	end));
end;

if Atmosphere then 
	Atmosphere:GetPropertyChangedSignal("Density"):Connect(function()
		if Library.Flags.ChangeFogDensity.Value then 
			Atmosphere.Density = Library.Flags.FogDensity.Value
		end;
	end);

	Atmosphere:GetPropertyChangedSignal("Color"):Connect(function()
		if Library.Flags.ChangeFogColor.Value then 
			Atmosphere.Color = Library.Flags.FogColor.Value[1]
		end;
	end);

	Atmosphere:GetPropertyChangedSignal("Decay"):Connect(function()
		if Library.Flags.ChangeFogDecay.Value then 
			Atmosphere.Decay = Library.Flags.FogDecay.Value[1]
		end;
	end);

	Atmosphere:GetPropertyChangedSignal("Haze"):Connect(function()
		if Library.Flags.ChangeFogHaze.Value then 
			Atmosphere.Haze = Library.Flags.FogHaze.Value
		end;
	end);

	Atmosphere:GetPropertyChangedSignal("Glare"):Connect(function()
		if Library.Flags.ChangeFogGlare.Value then 
			Atmosphere.Glare = Library.Flags.FogGlare.Value
		end;
	end);
end;

    --[[Lighting:GetPropertyChangedSignal("ClockTime"):Connect(LPH_NO_VIRTUALIZE(function()
        if Library.Flags.ChangeTime.Value then 
            Lighting.ClockTime = Library.Flags.Time.Value 
        end;
    end))]]

Log("Loaded Connenctions.")
--#endregion Connections

--#region Threads
EntityClass.LastTarget = EntityClass.LastTarget or nil
EntityClass.LastArmorData = EntityClass.LastArmorData or {}

local Swing = LPH_JIT_MAX(function(Remote, Hash, Arguments) -- dereks fuckass broken functions
      Globals.VMNetworkPointer(
            'Fire',
            'd\147e\1R\169#o\249,9\133\153`B4q^W\6',
            '#\250)\215\28\1U\143\237}\154\218\231Cl-\15H\1\147',
            unpack(Arguments)
      );
end);
local Hit = LPH_JIT_MAX(function(Time, MeleeArguments) -- dereks broken fucking function
      local ServerTime = Time or Workspace:GetServerTimeNow();
      local Seed = ServerTime * 10000
      local RoundedSeed = math.round(Seed)
      local RandomCode = Random.new(RoundedSeed):NextInteger(1, 1000000000)
      local RandomCode2 = Random.new(RoundedSeed):NextInteger(1, 10000000000)
      local Table = { 
            RandomCode;        -- used for  hashing
            RandomCode2;       -- used for  hashing
            MeleeArguments[6]; -- Material
            MeleeArguments[4]; -- Angle
            MeleeArguments[5]; -- Root To Tip
            MeleeArguments[3]; -- TargetPart
            MeleeArguments[2]; -- CF
            MeleeArguments[1], -- Random Fuckass number
      };
      local OriginCFrame = Table[2]
      local OriginPosition = OriginCFrame.Position
      local TargetPosition = Table[3].Position
      local Delta = TargetPosition - OriginPosition
                              local Distance = Delta.Magnitude + 20
      local Direction = Delta.Unit * Distance
      local Parent = Table[3].Parent
      local AdjustedHitPosition
      local Params2 = RaycastParams.new();
      Params2.FilterDescendantsInstances = {Parent}
      Params2.FilterType = Enum.RaycastFilterType.Whitelist
      Params2.IgnoreWater = true
      local Result = Workspace:Raycast(OriginPosition, Direction, Globals.RaycastParams);
      local Result2 = Workspace:Raycast(OriginPosition, Direction, Params2)
      if Result and Result.Instance then
            if Result.Normal.Magnitude ~= 1 then 
                  Table[5] = Result.Normal;
            end;
            if Result2 and Result2.Normal then 
                  Table[5] = Result2.Normal;
            end;
            local HitPos = Result.Position
            Table[4] = Table[3].CFrame:PointToObjectSpace(HitPos);
            if not Result.Instance:IsDescendantOf(Parent) then 
                  return
            end;
      end;
                        if typeof(Table[3]) == "Instance" and typeof(Table[2]) == "CFrame" and typeof(Table[5]) == "Vector3" and type(Table[8]) == "number" then
            pcall(function()
                  Globals.VMNetworkPointer(
                        "Fire",
                        'd\147e\1R\169#o\249,9\133\153`B4q^W\6',
                        "\160\29\229\248\31\16pJ\140]\137-\250\171Z_\1\135\223#",
                        unpack(Table)
                  );
            end);
      end;
end);



local doKillaura = LPH_JIT_MAX(function(MeleeArguments) -- yea fixed ur shitty code derek

      local ServerTime  = workspace:GetServerTimeNow();
	local Seed        = ServerTime * 10000
	local RoundedSeed = math.round(Seed)
      local RandomCode1 = Random.new(RoundedSeed):NextInteger(1, 1000000000)
	local RandomCode2 = Random.new(RoundedSeed):NextInteger(1, 10000000000)

      local attackCFrame      = MeleeArguments[2];
      local attackOrigin      = attackCFrame.Position;

      local hitInstance       = MeleeArguments[3];
      local hitCharacter      = hitInstance.Parent;

      if (hitCharacter.Parent ~= workspace) then
            Log('Bad Parent' .. tostring(hitInstance:GetFullName()));
            return;
      end;

      local Params = RaycastParams.new();
      Params.FilterType = Enum.RaycastFilterType.Include;
	Params.FilterDescendantsInstances = { hitCharacter };

      local RaycastResult =  Workspace:Raycast(attackOrigin, hitInstance.Position - attackOrigin, Params);
      if (not RaycastResult) then
            return;
      end;

      Globals.VMNetworkPointer(
		'Fire',
		'd\147e\001R\169#o\249,9\133\153`B4q^W\006',
		'#\250)\215\028\001U\143\237}\154\218\231Cl-\015H\001\147',
		ServerTime,
            MeleeArguments[7]
	);

      task.wait();

      local hitInfo = {
            [1] = RandomCode2;
            [2] = RandomCode1;
            [3] = RaycastResult.Material.Name;
            [4] = RaycastResult.Normal;
            [5] = hitInstance.CFrame:PointToObjectSpace(RaycastResult.Position);
            [6] = hitInstance;
            [7] = CFrame.new( attackOrigin, hitInstance.Position );
            [8] = 3; -- SwingProgression (not a fuckass variable)
      };

      Globals.VMNetworkPointer(
            'Fire',
            'd\147e\001R\169#o\249,9\133\153`B4q^W\006',
            '\160\029\229\248\031\016pJ\140]\137-\250\171Z_\001\135\223#',
            unpack(hitInfo)
      );
end);

local LastArmorTick = tick();
local LastSwing = tick();
local EntityThread = Threads.New("Entity Handler", LPH_NO_VIRTUALIZE(function()
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Blacklist
	Params.FilterDescendantsInstances = {Camera, Client.Character, Workspace:FindFirstChild("VFX")}
	Globals.RaycastParams = Params

	local FOVRadius = Library.Flags.FOVRadius.Value

	if Library.Flags.DynamicFOV and Library.Flags.DynamicFOV.Value then
		local CurrentFOV = Library.Flags.ChangeFOV.Value and Library.Flags.CustomFOV.Value or 90
		local Difference = (CurrentFOV / Camera.FieldOfView)
		Globals:Tween(Visuals.FOVOutline, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
			Size = UDim2.new(0, Difference * FOVRadius, 0, Difference * FOVRadius)
		})
	else
		Visuals.FOVOutline.Size = UDim2.new(0, FOVRadius, 0, FOVRadius)
	end

	local LastDistance = math.huge
	local ClosestTarget, EntityCharacter, EntityData, EntityInstance = nil, nil, nil, nil
	local Manipulated, ManipulatedPosition, ManipulatedPart, ManipulatedPlayer = false, nil, nil, nil

	local AimbotEnabled = Library.Flags.Aimbot.Value
	local ActivationActive = Library.Flags["Aimbot Activation"].Active
	local AlwaysTarget = Library.Flags.AlwaysTarget.Value
	local UseVisibleCheck = Library.Flags.VisibleCheck.Value
	local RandomizeHitPart = Library.Flags.RandomizeHitPart.Value
	local AimbotPart = Library.Flags.AimbotPart.Value
	local ManipulationActive = Library.Flags.Manipulation.Value and Library.Flags["Manipulation Activation"].Active
	local DynamicFOVRadius = Visuals.FOVCircle.AbsoluteSize.X / 2
	local ClientRoot = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")

	for Entity, Object in EntityClass.Main.Cache do

		if tick() - Object.LastUpdate > 0.0145 then 
			Object.LastUpdate = tick();
			Object:Update()
		end;

		local Core = Object.CoreInformation
		if not (Core and Core.Root and Object.Character and Entity ~= Client) then continue end

		if not (Core.OnScreen and not Object.Friendly and AimbotEnabled) then continue end

		local TargetingFlag = Library.Flags["Target" .. Object.ClassType]
		if not (TargetingFlag and TargetingFlag.Value and (ActivationActive or AlwaysTarget)) then continue end

		local Distance = Visuals.GetDistanceFromCenter(Core.Root)
		if Distance >= LastDistance or Distance > DynamicFOVRadius then continue end

		local TargetPart
		if UseVisibleCheck and Core.Visible then
			TargetPart = Core.VisiblePart
		elseif not UseVisibleCheck then
			TargetPart = Object.Character:FindFirstChild(AimbotPart)
		end

		if Core.Visible and RandomizeHitPart then
			local Parts = {}
			for _, Part in ipairs(Object.Character:GetChildren()) do
				if Part:IsA("BasePart") and Visuals.IsPartVisible(Part) then
					table.insert(Parts, Part)
				end
			end
			if #Parts > 0 then
				TargetPart = Parts[math.random(1, #Parts)]
			end
		end

		if Object.Character.Name == "BTR" then
			TargetPart = Object.Character:FindFirstChild("HumanoidRootPart")
		end

		if ManipulationActive and ClientRoot and TargetPart and not Core.Visible then
			local StartPos = ClientRoot.CFrame
			local VisiblePos = EntityClass.Global.FindVisiblePosition(StartPos, TargetPart)
			if VisiblePos then
				Manipulated = true
				ManipulatedPart = TargetPart
				ManipulatedPosition = VisiblePos
				ManipulatedPlayer = Entity
			end
		end

		if TargetPart then
			ClosestTarget = TargetPart
			EntityCharacter = Object.Character
			EntityData = Object
			EntityInstance = Entity
			LastDistance = Distance
		end
	end

	EntityClass.Manipulated = Manipulated
	EntityClass.ManipulatedPart = ManipulatedPart
	EntityClass.ManipulatedPosition = ManipulatedPosition
	EntityClass.ManipulatedPlayer = ManipulatedPlayer
	EntityClass.TargetPart = ClosestTarget
	EntityClass.TargetData = EntityData
	EntityClass.TargetInstance = EntityInstance
	EntityClass.TargetCharacter = EntityCharacter

	if ClosestTarget and Library.Flags.AimbotMode.Value == "Memory" then
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, ClosestTarget.Position)
	end

	local ArmorPanel = Library.Window.ArmorPanel
	if EntityData and EntityData.CachedArmor and Library.Flags.ArmorViewer.Value then
		if tick() - Globals.LastArmorCheck > 0.2 then
			local seen = {}
			for _, armor in pairs(EntityData.CachedArmor) do
				if armor.Name and armor.Skin then
					local key = armor.Name .. "_" .. armor.Skin
					seen[key] = true
					ArmorPanel:Add(armor.Name, armor.Skin)
				end
			end
			for _, child in ipairs(ArmorPanel.Components.ArmorList:GetChildren()) do
				if child:IsA("Frame") and not seen[child.Name] then
					ArmorPanel:UpdateArmor(child.Name, nil, true)
				end
			end
			Globals.LastArmorCheck = tick()
		end
	else
		ArmorPanel:ClearAll()
	end 

	local KillAuraTarget = EntityClass.TargetInstance
	if KillAuraTarget and Library.Flags.KillauraToggle.Value and Library.Flags["Killaura Activation"].Active then 
            --[[
            Globals.VMNetworkPointer(
                'Fire',
                'd\147e\1R\169#o\249,9\133\153`B4q^W\6',
                '#\250)\215\28\1U\143\237}\154\218\231Cl-\15H\1\147',
                Workspace:GetServerTimeNow(),
                Weapon
            );

            local Time = Workspace:GetServerTimeNow()
            Swing(Remote, Hash, { Weapon.Name, Time })

            Globals.VMNetworkPointer(
                "Fire",
                'd\147e\1R\169#o\249,9\133\153`B4q^W\6',
                "\160\29\229\248\31\16pJ\140]\137-\250\171Z_\1\135\223#",
            );
            ]]

            --[[]]
		local Weapon = Workspace.VFX.VMs:GetChildren()[1]
		local WeaponData = Weapon and Globals.ToolInfo[Weapon.Name]

		if KillAuraTarget:IsA("Player") then
			KillAuraTarget = KillAuraTarget.Character
		end

		if Client.Character and KillAuraTarget and WeaponData and rawget(WeaponData, "Weapon") and rawget(WeaponData, "Melee") and rawget(WeaponData.Weapon, "Cooldown") then
			local Root = Client.Character:FindFirstChild("HumanoidRootPart") 

			local Cooldown = WeaponData.Weapon.Cooldown
			local Tip = Weapon:FindFirstChild("Weapon") and Weapon.Weapon:FindFirstChild("Main") or Weapon.Weapon:FindFirstChild("Handle")
			local Target = KillAuraTarget:FindFirstChild("Head")

			local AttackCFrame = CFrame.new(Root.Position + Vector3.new(0, 3, 0), Target.Position)
			if Target and (Root.CFrame.p - Target.CFrame.p).Magnitude <= 12 and tick() - LastSwing > Cooldown then
				LastSwing = tick()

				task.spawn(function()
					local Time = Workspace:GetServerTimeNow()

					-- Library:Notify("Attempting to hit") -- not needed tbh

					local RootToTip = Root.CFrame:PointToObjectSpace(Tip.Position)
					local Angle = (Client.Character.Head.Position - Target.Position).Unit

					if Library.Flags.ThirdPerson.Value and Library.Flags["Third Person Activation"].Active then
						local WorldModel = Client.Character:FindFirstChild(Weapon.Name)
						Tip = WorldModel and WorldModel:FindFirstChild("Handle")
						if not Tip then
							return
						end
						RootToTip = Root.CFrame:PointToObjectSpace(Tip.Position) / 10
					end

					if AttackCFrame and Target and Angle and RootToTip then
						Library:Notify("Kill aura attempt!")
						doKillaura({ 3, AttackCFrame, Target, Angle, RootToTip, "Plastic", Weapon.Name })
					end
				end)
			end
		end

            --]]
	end;

end), "Entities")

local VisualsThread = Threads.New("Visuals Handler", LPH_NO_VIRTUALIZE(function()
	--// Crosshair 
	Visuals.CrosshairHolder.Visible = Library.Flags.Crosshair.Value

	if Visuals.CrosshairHolder.Visible then 
		local Length = Library.Flags.CrosshairLength.Value 
		local Width = Library.Flags.CrosshairWidth.Value 
		local Gap = Library.Flags.CrosshairGap.Value; 

		Visuals.CrosshairTop.Size = UDim2.new(0, Width, 0, Length);
		Visuals.CrosshairBottom.Size = UDim2.new(0, Width, 0, Length);

		Visuals.CrosshairRight.Size = UDim2.new(0, Length, 0, Width);
		Visuals.CrosshairLeft.Size = UDim2.new(0, Length, 0, Width);

		Visuals.CrosshairTop.Position = UDim2.new(0.5, 0, 0.5, -Gap - Length / 2)
		Visuals.CrosshairBottom.Position = UDim2.new(0.5, 0, 0.5, Gap + Length / 2)
		Visuals.CrosshairLeft.Position = UDim2.new(0.5, -Gap - Length / 2, 0.5, 0)
		Visuals.CrosshairRight.Position = UDim2.new(0.5, Gap + Length / 2, 0.5, 0)

		Globals:Tween(Visuals.CrosshairTop, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			BackgroundColor3 = EntityClass.TargetPart and Library.Flags.SyncToLockColor.Value and Library.Flags.TargetColor.Value[1] or Library.Flags.CrosshairColor.Value[1]
		});
		Globals:Tween(Visuals.CrosshairBottom, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			BackgroundColor3 = EntityClass.TargetPart and Library.Flags.SyncToLockColor.Value and Library.Flags.TargetColor.Value[1] or Library.Flags.CrosshairColor.Value[1]
		});
		Globals:Tween(Visuals.CrosshairLeft, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			BackgroundColor3 = EntityClass.TargetPart and Library.Flags.SyncToLockColor.Value and Library.Flags.TargetColor.Value[1] or Library.Flags.CrosshairColor.Value[1]
		});
		Globals:Tween(Visuals.CrosshairRight, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			BackgroundColor3 = EntityClass.TargetPart and Library.Flags.SyncToLockColor.Value and Library.Flags.TargetColor.Value[1] or Library.Flags.CrosshairColor.Value[1]
		});

		if Library.Flags.RotateCrosshair.Value then 
			Visuals.CrosshairHolder.Rotation = Visuals.CrosshairHolder.Rotation + 0.5
		else 
			Visuals.CrosshairHolder.Rotation = 0 
		end;

		if Library.Flags.StickToTarget.Value and EntityClass.TargetPart then
			local Position, OnScreen = Camera:WorldToViewportPoint(EntityClass.TargetPart.Position)
			if OnScreen then
				Globals:Tween(Visuals.CrosshairHolder, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					Position = UDim2.new(0, Position.X, 0, Position.Y)
				})
			end
		else
			local ScreenSize = Camera.ViewportSize
			Globals:Tween(Visuals.CrosshairHolder, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Position = UDim2.new(0, ScreenSize.X / 2, 0, ScreenSize.Y / 2)
			})
		end
	end;
	--

	--// Skin changer 
	if Library.Flags.SkinChanger.Value and tick() - LastArmorTick > 3 then 
		LastArmorTick = tick();
		local ArmorSleeves = Client:GetAttribute("ArmorSleeves") or ""
		local Split = string.split(ArmorSleeves, "^");

		if type(Split) == "table" and Split[1] then 
			local ShirtSplit = Split[1]:split("/")
			local GloveSplit = Split[2] and Split[2]:split("/") or {}

			local Shirt = ShirtSplit[1] or ""
			local ShirtSkin = ShirtSplit[2] or "Default"
			local Glove = GloveSplit[1] or ""
			local GloveSkin = GloveSplit[2] or "Default"

			if Library.Flags["EnableSkin_"..Shirt] and Library.Flags["EnableSkin_"..Shirt].Value then 
				local ClientSkin = Library.Flags["Skin_"..Shirt].Value;
				local SleeveFolder = ReplicatedStorage.Sleeves:FindFirstChild(Shirt)
				if SleeveFolder and SleeveFolder:FindFirstChild(ClientSkin) then 
					ShirtSkin = ClientSkin
				end
			end

			if Library.Flags["EnableSkin_"..Glove] and Library.Flags["EnableSkin_"..Glove].Value then 
				local ClientSkin = Library.Flags["Skin_"..Glove].Value;
				local SleeveFolder = ReplicatedStorage.Sleeves:FindFirstChild(Glove)
				if SleeveFolder and SleeveFolder:FindFirstChild(ClientSkin) then 
					GloveSkin = ClientSkin
				end
			end

			local NewArmor = ""

			if Shirt ~= "" then 
				NewArmor = Shirt.."/"..ShirtSkin; 
			end; 

			if Glove ~= "" then

				if Shirt ~= "" then 
					NewArmor = NewArmor.."^" 
				end;

				NewArmor = NewArmor.. Glove.."/"..GloveSkin
			end;

			if NewArmor ~= "/^/" then
				Client:SetAttribute("ArmorSleeves", NewArmor)
			end;
		end;
	end;
	--

	--// Hitmarkers 
	for Index, Data in Visuals.Hitmarkers do 
		if not Data.Hitmarker then continue end; 

		local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Data.Position);
		if not OnScreen then 
			Data.Hitmarker.Visible = false; 
			continue
		end;

		Data.Hitmarker.Position = UDim2.new(0, ScreenPos.X, 0, ScreenPos.Y);
		Data.Hitmarker.Visible = true;
	end;
	--

	if Library.Flags.ChangeTime.Value then 
		Lighting.ClockTime = Library.Flags.Time.Value 
	end;

end), "Render");

local MiscLoop = Threads.New("Misc entity loop", LPH_NO_VIRTUALIZE(function()
	local SmartESP = Library.Flags.SmartESP.Value
	local CombatHide = Library.Flags.CombatHide.Active
	local FadeRadius = Library.Flags.FadeRadius.Value
	local Font = EntityClass.Font
	local FontSize = EntityClass.FontSize

	if not CombatHide then 
		Visuals.MiscSpace.Enabled = true
		for Entity, Data in EntityClass.Misc.Cache do
			local Listener = Data.Listener
			local Components = Data.Components
			local Object = Entity

			if not Object or not Components or not Components.Name then
				if Components and Components.Name then Components.Name:Destroy() end
				continue
			end

			local Flag = Listener.Flag
			local EnabledFlag = Library.Flags["ESP" .. Flag]
			local MaxDistanceFlag = Library.Flags[Flag .. "Distance"]

			if CombatHide or not EnabledFlag or not EnabledFlag.Value or not Listener.Validate(Data) then
				Components.Name.Visible = false
				continue
			end

			local Position = Listener.GetPosition(Data)
			if not Position then
				Components.Name.Visible = false
				continue
			end

			local Distance = Listener.GetDistance(Data)
			if not Distance or Distance > MaxDistanceFlag.Value then
				Components.Name.Visible = false
				continue
			end

			local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Position)
			if not OnScreen then
				Components.Name.Visible = false
				continue
			end

			local Name = Listener.GetName(Data)
			local NameColor = Listener.GetColor(Data)
			local Alpha = Listener.GetAlpha(Data)

			Components.Name.Text = Name; 
			Components.Name.TextColor3 = NameColor;

			Components.Name.Position = UDim2.new(0, ScreenPos.X, 0, ScreenPos.Y)
			Components.Name.Name = Name
			Components.Name.FontFace = Font
			Components.Name.TextSize = FontSize
			Components.Name.Visible = true

			if SmartESP then
				local CenterDist = Visuals.GetDistanceFromCenter(Position)
				local Fade = math.clamp(CenterDist / FadeRadius, 0, 1)
				Components.Name.TextTransparency = Fade
				Components.Name.UIStroke.Transparency = Fade
			else
				Components.Name.TextTransparency = Alpha
				Components.Name.UIStroke.Transparency = Alpha
			end
		end
	else 
		Visuals.MiscSpace.Enabled = false
	end;
end), "Render")

local MainCharacterThread = Threads.New("Character thread", LPH_NO_VIRTUALIZE(function()
	local Character = Client.Character; 
	local Root = Character and Character:FindFirstChild("HumanoidRootPart");
	local Humanoid = Character and Character:FindFirstChild("Humanoid")
	if Humanoid and Root then 

		--// Third person
		if Library.Flags.ThirdPerson.Value and Library.Flags["Third Person Activation"].Active then
			Client.CameraMaxZoomDistance = Library.Flags.ThirdPersonDistance.Value
			Client.CameraMinZoomDistance = Library.Flags.ThirdPersonDistance.Value
			Client.CameraMode = Enum.CameraMode.Classic

			if Library.Flags.AntiAim and not Library.Flags.AntiAim.Value then
				local LookVector = Camera.CFrame.LookVector
				local Angle = -math.atan2(LookVector.Z, LookVector.X) + math.rad(-90)
				local Angled = CFrame.new(Root.Position) * CFrame.Angles(0, Angle, 0)
				local _, Y, _ = Angled:ToOrientation()
				Globals.AntiAimAngle = CFrame.new(Angled.Position) * CFrame.Angles(0, Y, 0)
				Root.CFrame = Globals.AntiAimAngle
				Humanoid.AutoRotate = false
			end
		else
			Client.CameraMode = Enum.CameraMode.LockFirstPerson
			if not (Library.Flags.AntiAim and Library.Flags.AntiAim.Value) then
				Humanoid.AutoRotate = true
			end
		end
		--

		--// AntiAim
		if Library.Flags.AntiAim and Library.Flags.AntiAim.Value then
			--// Yaw calculation
			local LookVector = Camera.CFrame.LookVector
			local Angle = -math.atan2(LookVector.Z, LookVector.X) + math.rad(-90)

			if Library.Flags.YawBase.Value == "Random" then
				Angle = -math.atan2(LookVector.Z, LookVector.X + math.rad(math.random(-180, 120)))
			elseif Library.Flags.YawBase.Value == "Spin" then
				Angle = -math.atan2(LookVector.Z, LookVector.X) + (tick() * 10) % 360
			elseif Library.Flags.YawBase.Value == "None" then
				Angle = -math.atan2(LookVector.Z, LookVector.X) + math.rad(-90)
			end

			local Offset = math.rad(Library.Flags.YawModifier.Value)
			local Angled = CFrame.new(Root.Position) * CFrame.Angles(0, Angle + Offset, 0)

			if (Library.Flags.YawBase.Value == "Targets") and EntityClass.TargetPart  then
				Angled = CFrame.new(Root.Position, EntityClass.TargetPart.Position) * CFrame.Angles(0, Offset, 0)
			end

			local _, Y, _ = Angled:ToOrientation()
			Globals.AntiAimAngle = CFrame.new(Angled.Position) * CFrame.Angles(0, Y, 0)

			Root.CFrame = Globals.AntiAimAngle
			Humanoid.AutoRotate = false
			--

			--// Pitch calculation
			local Pitch = Library.Flags.PitchModifier.Value
			local PitchBase = Library.Flags.PitchBase.Value

			if PitchBase == "Down" then
				Pitch = 0.7
			elseif PitchBase == "Up" then
				Pitch = -0.7
			elseif PitchBase == "Nod" then
				Pitch = math.sin(tick() * 3)
			elseif PitchBase == "Random" then
				Pitch = math.random() / 10
			end

			Pitch = math.clamp(Pitch, -0.7, 0.7)

			local TorsoController = Client.Character:FindFirstChild("TorsoController")
			local Look = TorsoController and TorsoController:FindFirstChild("Look")
			if Look then
				Look:FireServer(Pitch, 0)
			end
			--      
		else
			if Client.Character:FindFirstChild("CameraController") and not Client.Character.CameraController:GetAttribute("FreeLooking") then 
				Humanoid.AutoRotate = true
			end;
		end
		--

		--// Bunny hop 
		if Library.Flags.Bunnyhop.Value then 
			local Jump = Humanoid.Jump 
			local FloorMaterial = Humanoid.FloorMaterial 
			if tostring(FloorMaterial) ~= "Air" and UserInputService:IsKeyDown(Enum.KeyCode.Space) then 
				Humanoid.Jump = true 
			end;
		end; 

		--// Omnisprint 
		if Globals.DirectionTable and Library.Flags.Omnisprint.Value and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then

			--// Direction setting
			Globals.DirectionTable.Left, Globals.DirectionTable.Right, Globals.DirectionTable.Backward, Globals.DirectionTable.Crouch = false, false, false, false
			Globals.DirectionTable.Forward, Globals.DirectionTable.Sprint = true, true
			Globals.DirectionTable.BackwardLeft, Globals.DirectionTable.BackwardRight = false, false
			Globals.DirectionTable.ForwardLeft, Globals.DirectionTable.ForwardRight = false, false
			--

			Humanoid.WalkSpeed = 19

			if Character:FindFirstChild("StateController") then 
				Character.StateController:SetAttribute("IsSprint", true);
				Character.StateController:SetAttribute("Direction", "Forward");
			end;
		end

		--// Debug Camera
		local IsFlying = Library.Flags.Fly.Value and Library.Flags["Fly Activation"].Value
		if Library.Flags.DebugCamera.Value and Library.Flags["Debug Camera Activation"].Active and not IsFlying then
			task.spawn(function()
				if not Globals.DebugStarted then
					Globals.DebugStarted = tick()
				end

				Globals.NeedToReturn = true

				local CameraLookVector = Camera.CFrame.LookVector
				local NormalCameraLookVector = CameraLookVector

				if not Globals.SavedPosition then
					Globals.SavedPosition = Humanoid.RootPart.CFrame
				end

				sethiddenproperty(Humanoid.RootPart, "NetworkIsSleeping", true);

				local UpPos = Vector3.new(0, 1, 0)
				local DownPos = Vector3.new(0, -1, 0)
				local NonePos = Vector3.new(0, 0, 0)

				local BaseCFrame = Humanoid.RootPart.CFrame
				local IsUpPressed = UserInputService:IsKeyDown(Enum.KeyCode.E)
				local IsDownPressed = UserInputService:IsKeyDown(Enum.KeyCode.Q)
				local IsForwardPressed = UserInputService:IsKeyDown(119) -- W
				local IsBackwardPressed = UserInputService:IsKeyDown(115) -- S

				Humanoid.RootPart.Anchored = true
				Humanoid.RootPart.Velocity = NonePos

				local Delta = Globals.Delta * Library.Flags.DebugCameraSpeed.Value * 3

				local MovementVector = (
					Humanoid.MoveDirection +
						(IsUpPressed and UpPos or NonePos) +
						(IsDownPressed and DownPos or NonePos) +
						(IsForwardPressed and Vector3.new(0, NormalCameraLookVector.Y, 0) or NonePos) +
						(IsBackwardPressed and Vector3.new(0, -NormalCameraLookVector.Y, 0) or NonePos)
				) * Delta

				BaseCFrame += MovementVector

				local Position = BaseCFrame.p
				Humanoid.RootPart.CFrame = CFrame.new(Position, Position + Vector3.new(CameraLookVector.X, 0, CameraLookVector.Z))
				Humanoid.AutoRotate = false
			end)
		else
			Globals.DebugStarted = nil
			if Globals.NeedToReturn then
				Humanoid.AutoRotate = true
				Globals.NeedToReturn = false
				sethiddenproperty(Humanoid.RootPart, "NetworkIsSleeping", false)

				for _, Value in pairs(Character:GetChildren()) do
					if Value:IsA("BasePart") then
						sethiddenproperty(Value, "NetworkIsSleeping", false)
					end
				end

				Humanoid.RootPart.CFrame = Globals.SavedPosition
				Humanoid.RootPart.Anchored = false
				Globals.SavedPosition = nil
			end
		end
		--
	end;
end), "Character");

local CharacterHeartbeat = RunService.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(Delta)
	local Character = Client.Character; 
	local Root = Character and Character:FindFirstChild("HumanoidRootPart");
	local Humanoid = Character and Character:FindFirstChild("Humanoid")

	local IsFlying;
	if Humanoid and Root then 
		--// Fly
		if Library.Flags.Fly.Value and Library.Flags["Fly Activation"].Active then
			task.spawn(function()
				IsFlying = true;
				if Humanoid and Humanoid.Health > 0 then
					local Delta = Delta * Library.Flags.FlySpeed.Value * 3
					local MoveVector = Humanoid.MoveDirection

					if UserInputService:IsKeyDown(Enum.KeyCode.E) then
						MoveVector += Vector3.new(0, 1, 0)
					end
					if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
						MoveVector += Vector3.new(0, -1, 0)
					end
					if UserInputService:IsKeyDown(119) then
						MoveVector += Vector3.new(0, Camera.CFrame.LookVector.Y, 0)
					end
					if UserInputService:IsKeyDown(115) then
						MoveVector += Vector3.new(0, -Camera.CFrame.LookVector.Y, 0)
					end

					local MovementDelta = MoveVector * Delta
					local Position = Root.CFrame.Position + MovementDelta
					Humanoid.PlatformStand = false
					Root.Velocity = Vector3.zero
					Root.CFrame = CFrame.new(Position, Position + Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z))
				end
			end)
		end

		--// Infinite Fly Fall Correction
		if Library.Flags.InfiniteFly.Value and IsFlying then
			local Origin = Root.Position;
			local Result = Workspace:Raycast(Origin, Vector3.new(0, -1000, 0), Globals.RaycastParams);
			if Result and Result.Distance > 4 then
				task.spawn(function()
					local OldVel = Root.Velocity;
					for _, Part in Character:GetChildren() do
						if Part:IsA("BasePart") or Part:IsA("MeshPart") then
							Part.Velocity = Vector3.new(0, -9999, 0);
						end;
					end;
					RunService.RenderStepped:Wait()
					for _, Part in Character:GetChildren() do
						if Part:IsA("BasePart") or Part:IsA("MeshPart") then
							Part.Velocity = OldVel;
						end;
					end;
				end);
			end;
		end;

		--// NoFall
		if Library.Flags.NoFall.Value and not IsFlying then
			local Origin = Root.Position;
			local Result = Workspace:Raycast(Origin, Vector3.new(0, -1000, 0), Globals.RaycastParams);

			if Result and Result.Distance > 10 then
				task.spawn(function()
					local OldVel = Root.Velocity;
					for _, Part in Character:GetChildren() do
						if Part:IsA("BasePart") or Part:IsA("MeshPart") then
							Part.Velocity = Vector3.new(0, 9999, 0);
						end;
					end;
					RunService.RenderStepped:Wait()
					for _, Part in Character:GetChildren() do
						if Part:IsA("BasePart") or Part:IsA("MeshPart") then
							Part.Velocity = OldVel;
						end;
					end;
				end);
			end;
		end;
	end;
end));

Log("Loaded threads.")
--#endregion Threads

--#region RunService
RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(Delta)
	Globals.Delta = Delta 

	for Index, Thread in Threads.Input do 
		local Error = Thread:Run()
	end

	for Index, Thread in Threads.Entities do 
		local Error = Thread:Run()
	end

	for Index, Thread in Threads.Character do 
		local Error = Thread:Run()
	end

	for Index, Thread in Threads.Render do 
		local Error = Thread:Run()
	end
end))

Log("Loaded run service connections")
--#endregion RunService

--#region Hooks 
local Modules = ReplicatedStorage:FindFirstChild("Modules");
if Modules then 
	local VFX = require(Modules.VFXModule);
	local ItemsModule = require(Modules.Items);
	local RaycastUtil = require(Modules.RaycastUtil);
	local SoundModule = require(Modules.SoundModule)

	--// Bindable Events
	local HitEvent = Instance.new("BindableEvent", ReplicatedStorage.ClientSignals);
	local TracerEvent = Instance.new("BindableEvent", ReplicatedStorage.ClientSignals);

	TracerEvent.Event:Connect(function(Origin, Destination, IsEnemy)
		local Color = (not IsEnemy and Library.Flags.TracerColor.Value[1]) or Library.Flags.EnemyTracerColor.Value[1]
		local TracerModel = Instance.new("Model", Workspace)
		TracerModel.Name = "TracerModel"

		--// Attachments
		local function CreateAnchorPart(position)
			local part = Instance.new("Part")
			part.Name = "Anchor"
			part.Size = Vector3.new(0.0001, 0.0001, 0.0001)
			part.Position = position
			part.Anchored = true
			part.CanCollide = false
			part.CanQuery = false
			part.Transparency = 1
			part.Parent = TracerModel
			return part
		end

		local Part0 = CreateAnchorPart(Origin)
		local Part1 = CreateAnchorPart(Origin)

		local Attachment0 = Instance.new("Attachment", Part0)
		local Attachment1 = Instance.new("Attachment", Part1)

		--// Beam setup
		local Beam = Instance.new("Beam")
		Beam.Name = "MainBeam"
		Beam.Attachment0 = Attachment0
		Beam.Attachment1 = Attachment1
		Beam.FaceCamera = true
		Beam.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0.0, Color),
			ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1.0, Color),
		})
		Beam.Width0 = 0.3
		Beam.Width1 = 0.3
		Beam.LightEmission = 1
		Beam.LightInfluence = 0
		Beam.Brightness = Library.Flags.TracerBrightness.Value
		Beam.Texture = "rbxassetid://12788927812"
		Beam.TextureLength = 10
		Beam.TextureMode = Enum.TextureMode.Wrap
		Beam.TextureSpeed = 1
		Beam.Parent = TracerModel
		local TextureType = Library.Flags.BeamTexture.Value
		local Beam2, Beam3

		if TextureType == "Lightning" then
			Beam.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, 0)
			})
			Beam.Texture = "rbxassetid://12781800668"
			Beam.TextureLength = 4
			Beam.TextureSpeed = 10
			Beam.Width0 = 0.5
			Beam.Width1 = 0.5

			local SpeedTween = TweenService:Create(Beam, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 2, true), {
				TextureSpeed = 2
			})
			SpeedTween:Play()
		elseif TextureType == "Dark" then
			Beam.Texture = "rbxassetid://12781848822"
			Beam.TextureLength = 20
			Beam.TextureSpeed = 0.9
			Beam.TextureMode = Enum.TextureMode.Static
			Beam.LightInfluence = 1
			Beam.LightEmission = 0.25
			Beam.Width0 = 0.5
			Beam.Width1 = 0.5

			Beam2 = Beam:Clone()
			Beam2.Name = "DarkBeam2"
			Beam2.Parent = TracerModel
			Beam2.Attachment0 = Attachment0
			Beam2.Attachment1 = Attachment1

			Beam3 = Beam:Clone()
			Beam3.Name = "DarkBeam3"
			Beam3.Parent = TracerModel
			Beam3.Attachment0 = Attachment0
			Beam3.Attachment1 = Attachment1
		end


		local ReferenceDistance = 30
		local ReferenceTime = ReferenceDistance / Library.Flags.ReferenceTime.Value
		local Distance = (Destination - Origin).Magnitude
		local TravelTime = (Distance / ReferenceDistance) * ReferenceTime

		local MoveTween = TweenService:Create(Part1, TweenInfo.new(TravelTime, Enum.EasingStyle.Linear), {
			Position = Destination
		})
		MoveTween:Play()

		local PulseTween = TweenService:Create(Beam, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 2, true), {
			Width0 = 0.35,
			Width1 = 0.35
		})
		PulseTween:Play()

		Delay(Library.Flags.TracerLifetime.Value, function()
			local FadeTween = TweenService:Create(Beam, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
				Width0 = 0,
				Width1 = 0,
				TextureSpeed = 0,
				Brightness = 0
			})
			FadeTween:Play()

			if Beam2 and Beam3 then
				local Fade2 = TweenService:Create(Beam2, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
					Width0 = 0,
					Width1 = 0,
					TextureSpeed = 0,
					Brightness = 0
				})
				local Fade3 = TweenService:Create(Beam3, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
					Width0 = 0,
					Width1 = 0,
					TextureSpeed = 0,
					Brightness = 0
				})
				Fade2:Play()
				Fade3:Play()
			end

			FadeTween.Completed:Wait()
			TracerModel:Destroy()
		end)
	end)

	HitEvent.Event:Connect(LPH_NO_VIRTUALIZE(function(HitData)
		if Library.Flags.Hitmarkers.Value then
			local HitPart = HitData[1];
			local HitPos = HitData[2];
			local HitMaterial = HitData[4];

			if HitMaterial == Enum.Material.Plastic then 
				Visuals.CreateHitmarker(HitPart, HitPos);
			end;
		end;
	end));

	local RaidEvent = Instance.new("BindableEvent", ReplicatedStorage.ClientSignals);
	RaidEvent.Event:Connect(LPH_NO_VIRTUALIZE(function(Type, CFrame) 
		local Time = tick();

		local Part = Instance.new("Part", CoreGui.Raids);
		Part.CanCollide = false;
		Part.CanQuery = false;
		Part.CanTouch = false;
		Part.Transparency = 1;
		Part.CFrame = CFrame; 
		Part.Name = Type;

		local StartedAt = Instance.new("IntValue", Part);
		StartedAt.Name = "StartedAt";
		StartedAt.Value = Time
		Part:SetAttribute("StartedAt", Time);
		Part:SetAttribute("Type", Type);

		Delay(600, function() 
			Part:Destroy();
		end);

		if Library.Flags.RaidNotifications.Value then
			local Pos = CFrame.p
			local Coordinates = tostring(math.floor(Pos.X)) .. ", ".. tostring(math.floor(Pos.Y)) ..", ".. tostring(math.floor(Pos.Z))
			Library:Notify("A potential raid has started using "..Type.. " at "..Coordinates, 10, Library.Flags.RaidsMiscColor.Value[1])
		end;
	end));
	--

	--// Hooks
	local InitHooks = LPH_JIT_MAX(function()
		local CreateProjectile; CreateProjectile = hookfunction(VFX.CreateProjectile, LPH_NO_UPVALUES(function(self, ...)
			local Args = {...}

			local Traceback = debug.traceback();
			if Traceback:find("ViewmodelController") and Args[1].StepFunction ~= "FakeStepFunc" and Args[1].HitFunction ~= "FakeHitFunc" and not tostring(Args[1].HitFunction):find("Ignore") then
				if debug.isvalidlevel(3) then 
					local HitFunction; HitFunction = Args[1].HitFunction; 
					Args[1].HitFunction = function(...)
						local Arguments = {...};

						HitEvent:Fire(Arguments)
						return HitFunction(...)
					end;

					local Stack = debug.getstack(3);
					local Recoil = rawget(Stack, 25);

					if Recoil and typeof(Recoil) == "table" and rawget(Recoil, "FinishStart") and rawget(Recoil, "RecoilStart") and rawget(Recoil, "RecoilFinish") and Library.Flags.RemoveRecoil.Value then 
						local RecoilStart = Recoil.RecoilStart
						local RecoilFinish = Recoil.RecoilFinish
						Recoil.RecoilStart = function(...)
							--local X, Y = RecoilStart(...)
							return 0, 0
						end

						Recoil.RecoilFinish = function(...)
							--local X, Y = RecoilFinish(...)
							return 0, 0
						end

						Recoil.Shake.X = {0, 0}
						Recoil.Shake.Y = {0, 0}
					end;

					local CameraStack = rawget(Stack, 45);
					local FlashpartStack = rawget(Stack, 51);
					local HRPStack = rawget(Stack, 52);
					local MouseHitStack = rawget(Stack, 52)

					local SpreadStack = rawget(Stack, 62);

					if CameraStack and FlashpartStack and HRPStack and MouseHitStack and EntityClass.TargetPart and Library.Flags.AimbotMode.Value == "Silent" then 
						local HitPosition = EntityClass.TargetPart.CFrame.p;
						local CameraPosition = CameraStack.p;

						if Library.Flags.InstantBullet.Value then
							local Speed, Gravity = Args[1].Speed, Args[1].Gravity
							local Distance = (Camera.CFrame.Position - HitPosition).Magnitude
							local TimeToHit = Distance / Speed

							local G = Gravity * -195
							local Drop = -0.5 * G * TimeToHit * TimeToHit
							if tostring(Drop):find("nan") then Drop = 0 end

							HitPosition = HitPosition + Vector3.new(0, Drop, 0)
						end

						local FakeCameraCFrame = CFrame.new(CameraPosition, HitPosition)
						local FakeHRPCFrame = CFrame.new(HRPStack.p, HitPosition);

						local OriginalFlashOffset = FlashpartStack - CameraPosition
						local NewFlashpartPosition = CFrame.new(FlashpartStack, HitPosition).p

						if EntityClass.ManipulatedPosition then 
							NewFlashpartPosition = CFrame.new(EntityClass.ManipulatedPosition, HitPosition).p;

							local FlashpartOffsetCamera = CameraPosition - FlashpartStack;
							local FlashpartOffsetHRP = HRPStack.p - FlashpartStack;

							local NewCameraPos = NewFlashpartPosition + FlashpartOffsetCamera
							local NewHRPPos = NewFlashpartPosition + FlashpartOffsetHRP

							FakeCameraCFrame = CFrame.new(NewCameraPos, HitPosition);
							FakeHRPCFrame = CFrame.new(NewHRPPos, HitPosition);
						end; 

						debug.setstack(3, 45, FakeCameraCFrame);
						debug.setstack(3, 54, HitPosition);
						debug.setstack(3, 52, FakeHRPCFrame)
						debug.setstack(3, 51, NewFlashpartPosition)
					end;

					if Library.Flags.ShootOnTP.Value and Library.Flags["Teleport Activation"].Active then 
						Client.Character.HumanoidRootPart.CFrame = Mouse.Hit;
					end;
				end;

				if Library.Flags.InstantBullet.Value then 
					Args[1].Speed = 9e9;
				end;

				if EntityClass.TargetPart and Library.Flags.AimbotMode.Value == "Silent" then 
					local HitPosition = EntityClass.TargetPart.CFrame.p;
					local Origin = Args[1].Position; 

					local Direction = (HitPosition - Origin).Unit
					local CorrectedPosition = CFrame.new(Origin, HitPosition).Position

					if EntityClass.ManipulatedPosition then 
						Direction = (HitPosition - EntityClass.ManipulatedPosition).Unit; 
						CorrectedPosition = CFrame.new(EntityClass.ManipulatedPosition, HitPosition).p;
					end;

					Args[1].Position = CorrectedPosition

					if Args[1].PositionFirst then 
						Args[1].PositionFirst = CorrectedPosition
					end;

					Args[1].DirectionFirst = Direction
					Args[1].Direction = Direction

					Globals.BulletOrigin = CorrectedPosition;
				end;
			end;

			task.spawn(function()
				if Library.Flags.BulletTracers.Value and (Args[1].Position - Camera.CFrame.Position).Magnitude < 1200 then
					local IsEnemy = (
						Args[1].StepFunction == "FakeStepFunc" or
							Args[1].HitFunction == "FakeHitFunc" or
							tostring(Args[1].HitFunction):find("Ignore")
					)

					if IsEnemy and not Library.Flags.ShowEnemyTracers.Value then 
						return 
					end;

					local Ray = Workspace:Raycast(
						Args[1].Position,
						Args[1].Direction * Args[1].MaxRange,
						Globals.RaycastParams
					)

					if Ray and Ray.Position then
						TracerEvent:Fire(Args[1].Position, Ray.Position, IsEnemy)
					end
				end
			end)
			return CreateProjectile(self, unpack(Args));
		end));

		Log("Initialized projectiles.")

		local CreateExplosion; CreateExplosion = hookfunction(VFX.CreateExplosion, LPH_NO_UPVALUES(function(...) 
			local Arguments = {...};

			local Type = tostring(Arguments[5]);
			local CFrame = Arguments[2];

			task.spawn(function() RaidEvent:Fire(Type, CFrame) end)

			return CreateExplosion(...)
		end));

		Log("Initialized raids")

		local OldRaycast; OldRaycast = hookfunction(RaycastUtil.Raycast, LPH_NO_UPVALUES(function(self, ...) 
			local Arguments = {...};

			if not checkcaller() then 
				local Traceback = debug.traceback();

				if Traceback and Traceback:find("ViewmodelController") and Library.Flags.Reach.Value then
					Arguments[2] = Arguments[2] * 10
				end; 

				if Library.Flags.PerfectFarm.Value then 
					local Output = {OldRaycast(self, ...)}
					local HitInstance  = Output[1]
					local HitPosition = Output[2]

					if not HitInstance or typeof(HitInstance) ~= "Instance" then
						return unpack(Output)
					end

					if not HitPosition or typeof(HitPosition) ~= "Vector3" then
						return unpack(Output)
					end

					local Model = HitInstance.Parent

					if not Model or (not Model:IsA("Model")) then
						return unpack(Output)
					end

					local Folder = Model.Parent

					if Folder and (Folder.Name == "Trees" or Folder.Name == "Nodes") and Folder:IsA("Folder") then
						local CriticalPart = Model:FindFirstChild("NodeSpark") or Model:FindFirstChild("TreeX")
						if CriticalPart and typeof(CriticalPart) == "Instance" and CriticalPart:IsA("Model") and CriticalPart.PrimaryPart then
							Output[1] = CriticalPart.PrimaryPart
							return unpack(Output)
						end;
					end;
				end;
			end;
			return OldRaycast(self, unpack(Arguments));
		end))   

		Log("Initialized raycast")

		local ToggleFootstep; ToggleFootstep = hookfunction(SoundModule.ToggleFootstep, LPH_NO_UPVALUES(function(...) 
			local Arguments = {...};

			if Library.Flags.SilentStep.Value and Arguments[3] then 
				return SoundModule:StopSound(Arguments[3])
			end;

			return ToggleFootstep(...);
		end));    

		local PlaySound; PlaySound = hookfunction(SoundModule.PlaySound, LPH_NO_UPVALUES(function(...) 
			local Arguments = {...};
			if Library.Flags.SilentStep.Value and Arguments[2] and Arguments[2].Name == "WalkWater" then 
				return SoundModule:StopSound(Arguments[2]);
			end;

			return PlaySound(...)
		end));

		Log("Initialized sounds")
		Log("Primary hooks initialized!")
	end);

	InitHooks();
	--

	local HooksOnCharacterAdded = LPH_JIT_MAX(function()
		Globals.QuickStackFunctions = {};
		for _, Function in getgc(false) do 

			if type(Function) ~= "function" then continue end 
			if not islclosure(Function) then continue end; 
			if isexecutorclosure(Function) then continue end; 
			if isfunctionhooked(Function) then continue end; 

			local Constants = debug.getconstants(Function); 
			local Upvalues = debug.getupvalues(Function)
			local Info = debug.getinfo(Function); 
			local Source = Info.source; 

			if Source:find("ViewmodelController") then 
				if table.find(Constants, "CameraOffset") then 
					local Old; Old = hookfunction(Function, LPH_NO_UPVALUES(function(...) 
						if Library.Flags.RemoveCameraBobbing.Value then 
							return 
						end; 

						return Old(...)
					end))
				end;

				if table.find(Constants, "Landed") then 
					local Old; Old = hookfunction(Function, LPH_NO_UPVALUES(function(OldState, NewState) 
						if Library.Flags.AlwaysGrounded.Value then 
							OldState = Enum.HumanoidStateType.Running; 
							NewState = Enum.HumanoidStateType.Running; 
						end;

						return Old(OldState, NewState)
					end));
				end;

                        -- yea followed ur coding style aswell
                        if table.find(Constants, "CreateBlood") then
                              for index, value in pairs(Upvalues) do
                                    if type(value) == "function" and debug.info(value, "s"):find("AssetContainer") then
                                          Globals.VMNetworkPointer = value;
                                          break;
                                    end;
                              end;

                        end;

			end;

			if Source:find("InventoryController") then 
				local Upvalues = debug.getupvalues(Function);
				if type(Upvalues[1]) == "table" and type(Upvalues[2]) == "table" and type(Upvalues[3]) == "table" then 
					local Old; Old = hookfunction(Function, LPH_NO_UPVALUES(function()
						local InventoryTable, _, _2 = Old() 

						local Toolbar = InventoryTable.Toolbar;
						if Toolbar and Library.Flags.SkinChanger.Value then 
							for ItemIndex, ItemData in Toolbar do 

								if type(ItemData) ~= "table" then 
									continue 
								end;

								local ItemName = ItemsModule[ItemData.ID].Name;
								local SKIN = Library.Flags["EnableSkin_"..ItemName]
								if SKIN and SKIN.Value then 
									local ClientSkin = Library.Flags["Skin_"..ItemName].Value;
									ItemData.Skin = ClientSkin;
								else 
									continue
								end;
							end;
						end;

						return InventoryTable, _, _2 
					end));
				end;

				if Constants[1] == "ArmorEquip" and Constants[5] == "GetAttribute" then 
					if Library.Flags.InstantLoot.Value then 
						debug.setconstant(Function, 19, 0) -- 0.9 
						debug.setconstant(Function, 20, 0) -- 0.3
						debug.setconstant(Function, 21, 0) -- 0.1
					end;
					table.insert(Globals.QuickStackFunctions, Function)
				end
			end;

			if Source:find("StateController") then 
				if table.find(Constants, "Forward") then 
					if type(Upvalues[1]) == "table" and (Upvalues[1].Forward == false or Upvalues[1].Forward == true) then 
						Globals.DirectionTable = debug.getupvalue(Function, 1)
					end
				end;
			end;

			if Info.source:find("BuildController") then 
				if type(Upvalues[16]) == "function" then 
					local BuildEvent = debug.getupvalue(Function, 16);
					Globals.BuildingNetworkPointer = BuildEvent;
				end
			end;

		end;

		repeat task.wait() until Client.Character ~= nil 
		local Character = Client.Character; 
		local StateController = Character:WaitForChild("StateController", 5);

		if StateController then 
			StateController:GetAttributeChangedSignal("IsSprint"):Connect(function()
				if Library.Flags.Omnisprint.Value and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then 
					StateController:SetAttribute("IsSprint", true);
				end;
			end);

			StateController:GetAttributeChangedSignal("Direction"):Connect(function()
				if Library.Flags.Omnisprint.Value and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then 
					StateController:SetAttribute("Direction", "Forward");
				end;
			end);
		end;
	end);

	repeat task.wait() until Client.Character

	HooksOnCharacterAdded();

	Client.CharacterAdded:Connect(function()
		task.wait(3);
		HooksOnCharacterAdded();
	end);
end;
Log("All hooks loaded!")
--#endregion Hooks