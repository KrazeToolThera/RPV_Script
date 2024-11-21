if game.PlaceId == 93903714374388 then
    local PLAYERS = game:GetService("Players")
    local LIGHTING = game:GetService("Lighting")
    local REPLICATEDSTORAGE = game:GetService("ReplicatedStorage")
    local RAYFIELD = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local teleport = {}

    local function notACharacter(part)
        if part:IsA('Model') then
            local result = true
            for _, v in pairs(PLAYERS:GetPlayers()) do
                if part.Name == v.Name then
                    result = false
                end
            end
            return result
        end
    end

    local function teloportTo(part)
        if part then
            PLAYERS.LocalPlayer.Character:MoveTo(part.CFrame.Position + Vector3.new(0, 2.75+part.Size.Y/2, 0))
        end
    end

    local function becomePartOfATeam(team)
        local lastCFrame = PLAYERS.LocalPlayer.Character.HumanoidRootPart.CFrame
        REPLICATEDSTORAGE:WaitForChild("TeamsRE"):FireServer(team)
        task.wait(1)
        PLAYERS.LocalPlayer.Character.HumanoidRootPart.CFrame = lastCFrame
    end

    local function spawnACar(car)
        REPLICATEDSTORAGE:WaitForChild("SpawnCar"):FireServer(car)
    end

    local function deleteACar(mode)
        if mode == 0 then
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA('Model') and string.find(v.Name, 'sCar') then
                    REPLICATEDSTORAGE:WaitForChild("DeleteCar"):FireServer(v)
                    task.wait()
                end
            end
        elseif mode == 1 then
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do--Maxsim34503sCar
                local car = workspace:FindFirstChild(v.Name..'sCar')
                if car then
                    REPLICATEDSTORAGE:WaitForChild("DeleteCar"):FireServer(car)
                    task.wait()
                end
            end
        end
    end

    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == 'SpawnLocation' and v:IsA('SpawnLocation') then
            if v.TeamColor == BrickColor.new('Forest green') then
                teleport.defaultSpawn = v
            elseif v.TeamColor == BrickColor.new('Really red') then
                teleport.criminalSpawn = v
            elseif v.TeamColor == BrickColor.new('Really blue') then
                teleport.policeSpawn = v
            elseif v.TeamColor == BrickColor.new('Deep orange') then
                teleport.emergenceSpawn = v
            elseif v.TeamColor == BrickColor.new('New Yeller') then
                teleport.taxiSpawn = v
            end
        elseif v:IsA('Part') then
            if v.Position == Vector3.new(-511.69989013671875, 15.911480903625488, 936.2000732421875) then
                teleport.trainStation1 = v
            elseif v.Position == Vector3.new(-3355.934814453125, 16.2115535736084, 1846.817138671875) then
                teleport.trainStation2 = v
            elseif v.Position == Vector3.new(-3200.366943359375, 11.547088623046875, 535.2703857421875) then
                teleport.rural = v
            end
        end
    end


    local window = RAYFIELD:CreateWindow({
        Name = "Your boss in RP Village",
        LoadingTitle = "RolePlay Village Script",
        LoadingSubtitle = "by KrazyToolThera",
        Theme = "Default",
        DisableRayfieldPrompts = true,
        DisableBuildWarnings = false,
        ConfigurationSaving = {
           Enabled = true,
           FolderName = 'RolePlay_Village_OP',
           FileName = "Save"
        },
        KeySystem = false,
    })

    local localTab = window:CreateTab('Local', 'navigation')
    local section = localTab:CreateSection('Optimization')
    local button = localTab:CreateButton({
        Name = "Remove trash from Workspace",
        Callback = function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA('RemoteEvent') and v.Name == 'BikeDestroy' then
                    v:Destroy()
                end
            end
        end,
     })
    local toggle = localTab:CreateToggle({
        Name = "Optimaze the game",
        CurrentValue = false,
        Callback = function(value)
            if value then
                LIGHTING.Technology = Enum.Technology.Legacy
                LIGHTING.GlobalShadows = false
                LIGHTING.EnvironmentDiffuseScale = 0
                LIGHTING.EnvironmentSpecularScale = 0
                LIGHTING.ShadowSoftness = 0

                for _,v in pairs(game.Lighting:GetChildren()) do
                    v:Destroy()
                end
            end
        end,
    })

    local teleportTab = window:CreateTab('Teleport', 'server')
    local section = teleportTab:CreateSection('Spawns')
    local button = teleportTab:CreateButton({
        Name = 'Citizens Spawn [Граждане]',
        Callback = function()
            teloportTo(teleport.defaultSpawn)
        end,
    })
    local button = teleportTab:CreateButton({
        Name = 'Criminal Spawn [ОПГ]',
        Callback = function()
            teloportTo(teleport.criminalSpawn)
        end,
    })
    local button = teleportTab:CreateButton({
        Name = 'Police Spawn [ГИБДД]',
        Callback = function()
            teloportTo(teleport.policeSpawn)
        end,
    })
    local button = teleportTab:CreateButton({
        Name = 'Emergencal Spawn [МЧС]',
        Callback = function()
            teloportTo(teleport.emergenceSpawn)
        end,
    })
    local button = teleportTab:CreateButton({
        Name = 'Taxi Spawn [Такси]',
        Callback = function()
            teloportTo(teleport.taxiSpawn)
        end,
    })

    local section = teleportTab:CreateSection('Main')
    local button = teleportTab:CreateButton({
        Name = 'Train Station Village',
        Callback = function()
            teloportTo(teleport.trainStation1)
        end,
    })
    local button = teleportTab:CreateButton({
        Name = 'Train Station City',
        Callback = function()
            teloportTo(teleport.trainStation2)
        end,
    })
    local button = teleportTab:CreateButton({
        Name = 'Rular',
        Callback = function()
            teloportTo(teleport.rural)
        end,
    })

    local serverTab = window:CreateTab('Server', 'map-pin')
    local section = serverTab:CreateSection('Must have')
    local button = serverTab:CreateButton({
        Name = 'Remove HD Admin [Admins can\'t do anything] (You can do it only once)',
        Callback = function()
            if not _G.BreakHdAdmin then
                _G.BreakHdAdmin = true
                REPLICATEDSTORAGE:WaitForChild("DeleteCar"):FireServer(workspace['HD Admin'])

                local x = Instance.new('Folder')
                x.Name = 'HDAdminServer'
                x.Parent = game:GetService("ServerScriptService")
                local y = Instance.new('Folder')
                x.Name = 'HDAdminMapBackup'
                x.Parent = game:GetService("ServerScriptService")
                REPLICATEDSTORAGE:WaitForChild("DeleteCar"):FireServer(x)
                REPLICATEDSTORAGE:WaitForChild("DeleteCar"):FireServer(y)
                x:Destroy()
                y:Destroy()

                for _, v in pairs(game.ReplicatedFirst:GetChildren()) do REPLICATEDSTORAGE:WaitForChild("DeleteCar"):FireServer(v) end

                REPLICATEDSTORAGE:WaitForChild("DeleteCar"):FireServer(REPLICATEDSTORAGE.HDAdminSetup)
                REPLICATEDSTORAGE:WaitForChild("DeleteCar"):FireServer(REPLICATEDSTORAGE.TopbarPlusReference)
                REPLICATEDSTORAGE:WaitForChild("DeleteCar"):FireServer(REPLICATEDSTORAGE.HDAdminClient)

                REPLICATEDSTORAGE:WaitForChild("DeleteCar"):FireServer(game.StarterGui.HDAdminGUIs)


                REPLICATEDSTORAGE:WaitForChild("DeleteCar"):FireServer(game.StarterPlayer.StarterCharacterScripts.HDAdminStarterCharacter)
                REPLICATEDSTORAGE:WaitForChild("DeleteCar"):FireServer(game.StarterPlayer.StarterPlayerScripts.HDAdminStarterPlayer)


            end
        end,
    })
    local button = serverTab:CreateButton({
        Name = 'Remove all Cars',
        Callback = function()
            deleteACar(0)
        end,
    })
    local keybind = serverTab:CreateKeybind({
        Name = 'Keybind',
        CurrentKeybind = 'X',
        HoldToInteract = false,
        Flag = 'KeyBindRemoveAllCars',
        Callback = function()
            deleteACar(0)
        end,
    })
    local button = serverTab:CreateButton({
        Name = 'Remove Players Cars',
        Callback = function()
            deleteACar(1)
        end,
    })
    local keybind = serverTab:CreateKeybind({
        Name = 'Keybind',
        CurrentKeybind = 'Z',
        HoldToInteract = false,
        Flag = 'KeyBindPlayersCars',
        Callback = function()
            deleteACar(1)
        end,
    })

    local section = serverTab:CreateSection('Teams')
    local button = serverTab:CreateButton({
        Name = "Become a Citizen",
        Callback = function()
            becomePartOfATeam('Граждане')
        end,
    })
    local keybind = serverTab:CreateKeybind({
        Name = 'Keybind',
        CurrentKeybind = 'R',
        HoldToInteract = false,
        Flag = 'KeyBindCitizen',
        Callback = function()
            becomePartOfATeam('Граждане')
        end,
    })
    local button = serverTab:CreateButton({
        Name = "Become a Hamster Criminal",
        Callback = function()
            becomePartOfATeam('ОПГ')
        end,
    })
    local keybind = serverTab:CreateKeybind({
        Name = 'Keybind',
        CurrentKeybind = 'T',
        HoldToInteract = false,
        Flag = 'KeyBindCitizen',
        Callback = function()
            becomePartOfATeam('ОПГ')
        end,
    })
    local button = serverTab:CreateButton({
        Name = "Become a Policeman",
        Callback = function()
            becomePartOfATeam('ГИБДД')
        end,
    })
    local keybind = serverTab:CreateKeybind({
        Name = 'Keybind',
        CurrentKeybind = 'Y',
        HoldToInteract = false,
        Flag = 'KeyBindCitizen',
        Callback = function()
            becomePartOfATeam('ГИБДД')
        end,
    })
    local button = serverTab:CreateButton({
        Name = "Become a Emergencal Agent",
        Callback = function()
            becomePartOfATeam('МЧС')
        end,
    })
    local keybind = serverTab:CreateKeybind({
        Name = 'Keybind',
        CurrentKeybind = 'U',
        HoldToInteract = false,
        Flag = 'KeyBindCitizen',
        Callback = function()
            becomePartOfATeam('МЧС')
        end,
    })
    local button = serverTab:CreateButton({
        Name = "Become a Taxi Driver",
        Callback = function()
            becomePartOfATeam('Такси')
        end,
    })
    local keybind = serverTab:CreateKeybind({
        Name = 'Keybind',
        CurrentKeybind = 'P',
        HoldToInteract = false,
        Flag = 'KeyBindCitizen',
        Callback = function()
            becomePartOfATeam('Такси')
        end,
    })
    local section = serverTab:CreateSection('Fun')
    local button = serverTab:CreateButton({
        Name = 'Spawn a Car',
        Callback = function()
            spawnACar('КамАЗ 65115')
        end,
    })
    local keybind = serverTab:CreateKeybind({
        Name = 'Keybind',
        CurrentKeybind = 'G',
        HoldToInteract = false,
        Flag = 'KeyBindSpawnACar',
        Callback = function(keybind)
            spawnACar('КамАЗ 65115')
        end,
    })

    local button = serverTab:CreateButton({
		Name = "Destroy UI",
		Callback = function()
			RAYFIELD:Destroy()
		end,
	})

    -- local section = serverTab:CreateSection('OverPowered')
    -- local button = serverTab:CreateButton({
	-- 	Name = "Destroy the Map",
	-- 	Callback = function()
	-- 	end,
	-- })
else
    warn('Wrong game')
end
