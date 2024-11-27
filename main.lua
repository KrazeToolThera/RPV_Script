if game.PlaceId == 93903714374388 then
    local VERSION = '2.6.1'

    local PLAYERS = game:GetService("Players")
    local LIGHTING = game:GetService("Lighting")
    --local TEXTCHATSERVICE = game:GetService("TextChatService")
    local REPLICATEDSTORAGE = game:GetService("ReplicatedStorage")
    local SCREENGUI = game:GetService("StarterGui")
    local STARTERPLAYER = game:GetService("StarterPlayer")
    local RAYFIELD = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

    local localPlayer = PLAYERS.LocalPlayer
    local deleteEvent = REPLICATEDSTORAGE:WaitForChild('DeleteCar', 15)

    local cars = {}
    local players = {}
    local teleport = {}

    local teleportBack = true

    local selectedCar

    local function teloportTo(position : Vector3)
        if position then
            localPlayer.Character:MoveTo(position)
        end
    end
    local function becomePartOfATeam(team : string)
        if teleportBack then
            local lastCFrame = localPlayer.Character.HumanoidRootPart.CFrame
            REPLICATEDSTORAGE:WaitForChild("TeamsRE"):FireServer(team)
            localPlayer.CharacterAdded:Once(function(character)localPlayer.Character:WaitForChild('HumanoidRootPart').CFrame=lastCFrame end)
        else REPLICATEDSTORAGE:WaitForChild("TeamsRE"):FireServer(team)end
    end
    local function spawnACar()--Patriot DPS 'КамАЗ 65115'
        REPLICATEDSTORAGE:WaitForChild("SpawnCar"):FireServer(selectedCar)
    end
    local function finalOutput(object_X)
        if workspace:FindFirstChild(object_X.Name)then warn('✖: '..object_X.Name..' was\'t deleted.')
        else print('✔: '..object_X.Name..' was deleted in ['..object_X:GetFullName()..'] successfully .')end
    end
    local function deleteACar(mode)
        deleteEvent:FireServer()
    end


    teleport.defaultSpawn=Vector3.new(-390, 18, -82)
    teleport.criminalSpawn=Vector3.new(-200, 15, -118)
    teleport.policeSpawn=Vector3.new(-279, 17, -256)
    teleport.emergenceSpawn=Vector3.new(-18, 16, 198)
    teleport.taxiSpawn=Vector3.new(-4502, 15.5, 2012)
    --teleport.hidenSpawn=Vector3.new()

    teleport.prisonCell1=Vector3.new(-280, 18, -363)
    teleport.prisonCell2=Vector3.new(-258.5, 18, -363)
    teleport.hospital=Vector3.new(70, 16, 69.8)
    teleport.school=Vector3.new(88.5, 18, 439)
    teleport.shop=Vector3.new(125, 15.5, -250)
    teleport.garages=Vector3.new(416, 14.5, -144)
    teleport.storage=Vector3.new(-779, 14.5, 174)
    teleport.gasStation1=Vector3.new(-405, 15, 1234)
    teleport.gasStation2=Vector3.new(-1762, 15, 2345)
    teleport.checkpoint=Vector3.new(-275, 15, 1743)
    teleport.trainStation1=Vector3.new(-577, 54, 885.4)
    teleport.trainStation2=Vector3.new(-3421, 54.5, 1796)

    --teleport.mall=Vector3.new()
    teleport.wildberries=Vector3.new(-3736, 15, 2053)
    teleport.hotel=Vector3.new(-4303, 15, 2035)
    teleport.playground=Vector3.new(-3588, 15, 2156)
    teleport.mail=Vector3.new(-3703, 15.5, 2335)
    teleport.mcdonald=Vector3.new(-4358, 15, 2318)
    teleport.parking=Vector3.new(-3962, 84.5, 2288)
    teleport.magnit=Vector3.new(-4893, 15.5, 2249)
    teleport.universam=Vector3.new(-3881, 15, 2093)
    teleport.burgerKing=Vector3.new(-4960,14,2059)

    teleport.rural=Vector3.new(-3274,15,1178)
    teleport.ruralPool=Vector3.new(-3118,15,567)
    teleport.ruralShop=Vector3.new(-3207,15.5,755.5)
    teleport.forest=Vector3.new(-2840,15,1337)
    teleport.field1=Vector3.new(-1806,15.5,404)
    teleport.field2=Vector3.new(-1695,15,-276)
    teleport.fishing=Vector3.new(-798,13.5,-439)
    teleport.theEnd=Vector3.new(-6650,14,3010)
    teleport.thueTheEnd=Vector3.new(-6674,14,-516)
    --teleport.undergroundLake=Vector3.new()

    teleport.point1=Vector3.new(158,101,-160)
    teleport.point2=Vector3.new(-629,101,-352)
    teleport.point3=Vector3.new(-6, 101, 471)
    teleport.point4=Vector3.new(-653,101,1180)
    teleport.point5=Vector3.new(-824,101,2140)
    teleport.point6=Vector3.new(-2153.094970703125, 138.6460418701172, 1840.330322265625)
    teleport.point6=Vector3.new(-2974.08056640625, 209.64869689941406, 1506.141845703125)
    teleport.point7=Vector3.new(-3336.282958984375, 264.1777038574219, 302.3792724609375)
    teleport.point8=Vector3.new(-3912.40283203125, 188.2904815673828, 2082.079345703125)
    teleport.point9=Vector3.new(-6066.234375, 150.45118713378906, 2602.861328125)
    teleport.point10=Vector3.new(-2194.579345703125, 223.71780395507812, -204.53009033203125)


    for i,v in pairs(PLAYERS:GetPlayers())do
        players[i]=v.Name
    end
    selectedPlayer=players[1]

    if SCREENGUI:FindFirstChild('ScreenGui')and SCREENGUI.ScreenGui:FindFirstChild('Frame')then
        for i,v in pairs(SCREENGUI.ScreenGui.Frame:GetChildren())do cars[i] = v.Name end
        selectedCar=cars[1]
    end
    
    local window = RAYFIELD:CreateWindow({
        Name="Your boss in RP Village",LoadingTitle="RolePlay Village Script",LoadingSubtitle="by KrazyToolThera",Theme="Ocean",
        DisableRayfieldPrompts=true,DisableBuildWarnings=true,ConfigurationSaving = {Enabled=true,FolderName='RolePlay_Village_OP',FileName ="Save"},KeySystem = false,
    })


    local localTab = window:CreateTab('Local', 'navigation')
    local section = localTab:CreateSection('Optimization')
    local button = localTab:CreateButton({
        Name = "Remove trash from Workspace",
        Callback = function()
            for _, v in pairs(workspace:GetChildren()) do
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


    local teleportTab = window:CreateTab('Teleport', 'map-pin')
    local section = teleportTab:CreateSection('Spawns')
    local button = teleportTab:CreateButton({Name='Citizens Spawn [Граждане]',Callback=function()teloportTo(teleport.defaultSpawn)end,})
    local button=teleportTab:CreateButton({Name='Criminal Spawn [ОПГ]',Callback=function()teloportTo(teleport.criminalSpawn)end,})
    local button=teleportTab:CreateButton({Name='Police Spawn [ГИБДД]',Callback=function()teloportTo(teleport.policeSpawn)end,})
    local button=teleportTab:CreateButton({Name='Emergencal Spawn [МЧС]',Callback=function()teloportTo(teleport.emergenceSpawn)end,})
    local button=teleportTab:CreateButton({Name='Taxi Spawn [Такси]',Callback=function()teloportTo(teleport.taxiSpawn)end,})

    local section=teleportTab:CreateSection('Village')
    local button=teleportTab:CreateButton({Name='Checkpoint [КПП]',Callback=function()teloportTo(teleport.checkpoint)end,})
    local button=teleportTab:CreateButton({Name='Shop',Callback=function()teloportTo(teleport.shop)end,})
    local button=teleportTab:CreateButton({Name='Train Station Village',Callback=function()teloportTo(teleport.trainStation1)end,})
    local button=teleportTab:CreateButton({Name='Gas Station Village',Callback=function()teloportTo(teleport.gasStation1)end,})
    local button=teleportTab:CreateButton({Name='Hospital',Callback=function()teloportTo(teleport.hospital)end,})
    local button=teleportTab:CreateButton({Name='School',Callback=function()teloportTo(teleport.school)end,})
    local button=teleportTab:CreateButton({Name='Prison Cell 1',Callback=function()teloportTo(teleport.prisonCell1)end,})
    local button=teleportTab:CreateButton({Name='Prison Cell 2',Callback=function()teloportTo(teleport.prisonCell2)end,})
    local button=teleportTab:CreateButton({Name='Garages',Callback=function()teloportTo(teleport.garages)end,})
    local button=teleportTab:CreateButton({Name='Storage',Callback=function()teloportTo(teleport.storage)end,})    
    
    local section=teleportTab:CreateSection('Rular')
    local button=teleportTab:CreateButton({Name='Rular',Callback=function()teloportTo(teleport.rural)end,})
    local button=teleportTab:CreateButton({Name='Rural Pool',Callback=function()teloportTo(teleport.ruralPool)end,})
    local button=teleportTab:CreateButton({Name='Rular Shop',Callback=function()teloportTo(teleport.ruralShop)end,})

    local section=teleportTab:CreateSection('City')
    local button=teleportTab:CreateButton({Name='Train Station City',Callback=function()teloportTo(teleport.trainStation2)end,})
    local button=teleportTab:CreateButton({Name='Gas Station City',Callback=function()teloportTo(teleport.gasStation2)end,})
    local button=teleportTab:CreateButton({Name='Wildberries',Callback=function()teloportTo(teleport.wildberries)end,})
    local button=teleportTab:CreateButton({Name='Hotel',Callback=function()teloportTo(teleport.hotel)end,})
    local button=teleportTab:CreateButton({Name='Mail',Callback=function()teloportTo(teleport.mail)end,})
    local button=teleportTab:CreateButton({Name='Magnit',Callback=function()teloportTo(teleport.magnit)end,})
    local button=teleportTab:CreateButton({Name='Universam',Callback=function()teloportTo(teleport.universam)end,})
    local button=teleportTab:CreateButton({Name='Parking',Callback=function()teloportTo(teleport.parking)end,})
    local button=teleportTab:CreateButton({Name='Playground',Callback=function()teloportTo(teleport.playground)end,})
    local button=teleportTab:CreateButton({Name='McDonald\'s',Callback=function()teloportTo(teleport.mcdonald)end,})
    local button=teleportTab:CreateButton({Name='Burger King',Callback=function()teloportTo(teleport.burgerKing)end,})

    local section=teleportTab:CreateSection('Nature')
    local button=teleportTab:CreateButton({Name='Forest',Callback=function()teloportTo(teleport.forest)end,})
    local button=teleportTab:CreateButton({Name='Field 1',Callback=function()teloportTo(teleport.field1)end,})
    local button=teleportTab:CreateButton({Name='Field 2',Callback=function()teloportTo(teleport.field2)end,})
    local button=teleportTab:CreateButton({Name='Fishing',Callback=function()teloportTo(teleport.fishing)end,})
    local button=teleportTab:CreateButton({Name='The End?',Callback=function()teloportTo(teleport.theEnd)end,})
    local button=teleportTab:CreateButton({Name='The End',Callback=function()teloportTo(teleport.thueTheEnd)end,})
    

    local serverTab = window:CreateTab('Server', 'server')
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

    local section=serverTab:CreateSection('Cars')
    local dropdown=serverTab:CreateDropdown({Name='Select a car',Options=cars,CurrentOption={selectedCar},MultipleOptions=false,Flag='SelectedCar',Callback=function(Options)selectedCar=Options[1]end,})
    local button=serverTab:CreateButton({Name='Spawn a Car',Callback = function()spawnACar()end,})--
    local keybind=serverTab:CreateKeybind({Name='Keybind',CurrentKeybind='G',HoldToInteract=false,Flag='KeyBindSpawnACar',Callback=function()spawnACar()end,})
    local button=serverTab:CreateButton({Name='Delete all Your Cars',Callback=function()deleteACar(2)end,})--
    local Keybind = serverTab:CreateKeybind({Name='Keybind',CurrentKeybind ='C',HoldToInteract=false,Flag='DeleteAllYourCars',Callback=function()deleteACar(2)end,})
    local button=serverTab:CreateButton({Name='Remove all Cars',Callback=function()deleteACar(0)end,})--
    local keybind=serverTab:CreateKeybind({Name='Keybind',CurrentKeybind='X',HoldToInteract=false,Flag='KeyBindRemoveAllCars',Callback=function()deleteACar(0)end,})
    local button=serverTab:CreateButton({Name='Remove Players Cars',Callback=function()deleteACar(1)end,})--
    local keybind = serverTab:CreateKeybind({Name='Keybind',CurrentKeybind='Z',HoldToInteract=false,Flag='KeyBindPlayersCars',Callback=function()deleteACar(1)end,})

    local section=serverTab:CreateSection('Players')
    local Slider=serverTab:CreateSlider({Name='WalkSpeed',Range={1,700},Increment=1,Suffix='Speed',CurrentValue=16,Flag='WalkSpeed',
     Callback=function(Value)localPlayer.Character.Humanoid.WalkSpeed=(Value)end,})
    local slider = serverTab:CreateSlider({Name='JumpPower',
		Range={1,350},
		Increment = 1,
		Suffix = "Jump",
		CurrentValue = 16,
		Flag = "JumpPower",
		Callback = function(Value)
			localPlayer.Character.Humanoid.JumpPower = (Value)
		end,
	})
    local slider = serverTab:CreateSlider({
		Name = "Gravity",
		Range = {0, 1000},
		Increment = 1,
		Suffix = "Force",
		CurrentValue = 192,
		Flag = "Gravity",
		Callback = function(Value)
			workspace.Gravity = (Value)
		end,
	})
    local button = serverTab:CreateButton({
		Name = "Infinite Jump",
		Callback = function()
			_G.infinjump = not _G.infinjump
			if _G.infinJumpStarted == nil then
				_G.infinJumpStarted = true
				local plr = localPlayer local m = plr:GetMouse()
				m.KeyDown:connect(function(k)
					if _G.infinjump then
						if k:byte() == 32 then
							local humanoid = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') humanoid:ChangeState('Jumping')
							task.wait() humanoid:ChangeState('Seated')
						end
					end
				end)
			end
		end,
	})
    local button=serverTab:CreateButton({Name="Anti AFK",Callback=function()repeat task.wait()until game:IsLoaded()
     PLAYERS.LocalPlayer.Idled:connect(function()game:GetService("VirtualUser"):ClickButton2(Vector2.new())end)
     game:GetService("StarterGui"):SetCore("SendNotification",{Title='ANTI AFK',Text='ANTI AFK ON',Icon="rbxassetid://4483345998"})end})

     
    local section=serverTab:CreateSection('World')
    local button=serverTab:CreateButton({
        Name='Toggle a Barrier',
        Callback = function()
            for _,v in pairs(workspace:GetChildren()) do
                if v.Name=='Barrier'and v:IsA('Model') and v:FindFirstChild('Button') then
                    fireclickdetector(v.Button.ClickDetector)
                end
            end
        end,
    })

    local scriptsTab=window:CreateTab('Scripts', 'scroll-text')
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
    local paragraph=aboutTab:CreateParagraph({Title="Changelog",Content =[[
 [Version 2.6.1]
* Removed patched features
    ]]})
    local label=aboutTab:CreateLabel('Version '..VERSION)
    local label=aboutTab:CreateLabel('Executor: '..identifyexecutor())
	local label=aboutTab:CreateLabel('This script made by KrazyToolThera')
    local button=aboutTab:CreateButton({Name='Destroy UI',Callback=function()RAYFIELD:Destroy()end,})

    PLAYERS.PlayerAdded:Connect(function(player)
        table.insert(players, player)
        playerDropdown:Set(players)
        if player.UserId==7560353036 then print('Your master joined you.')end
    end)

    PLAYERS.PlayerRemoving:Connect(function(player)
        for i,v in pairs(players) do
            if v.UserId==player.UserId then
                table.remove(players, i)
            end
        end
        playerDropdown:Set(players)
    end)
else warn('Wrong game')end
