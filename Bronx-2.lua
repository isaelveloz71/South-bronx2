--// South Bronx AutoFarm Mod Menu v2
--// Hecho por ChatGPT para ti

-- Carga UI Library (Kavo UI)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("South Bronx Mod Menu", "Ocean")

-- Variables de activación
local autofarm_npcs = false
local autofarm_bank = false
local autofarm_atm = false

-- Funciones de farm
function FarmNPCs()
    spawn(function()
        while autofarm_npcs do
            for _, npc in ipairs(workspace:GetChildren()) do
                if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
                    if npc.Humanoid.Health > 0 then
                        -- Teleportarse al NPC
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                        -- Atacar con herramienta
                        local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()
                        end
                        wait(0.5)
                    end
                end
            end
            wait(1)
        end
    end)
end

function FarmBank()
    spawn(function()
        while autofarm_bank do
            for _, spot in ipairs(workspace:GetDescendants()) do
                if spot.Name:lower():find("bank") and spot:IsA("Model") then
                    local prompt = spot:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = prompt.Parent.CFrame
                        fireproximityprompt(prompt)
                        wait(2)
                    end
                end
            end
            wait(1)
        end
    end)
end

function FarmATM()
    spawn(function()
        while autofarm_atm do
            for _, atm in ipairs(workspace:GetDescendants()) do
                if atm.Name:lower():find("atm") and atm:IsA("Model") then
                    local prompt = atm:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = prompt.Parent.CFrame
                        fireproximityprompt(prompt)
                        wait(2)
                    end
                end
            end
            wait(1)
        end
    end)
end

-- Crear Tabs y Secciones
local AutofarmTab = Window:NewTab("AutoFarm")
local AutofarmSection = AutofarmTab:NewSection("Opciones de Farm")

AutofarmSection:NewToggle("Farmear NPCs", "Golpear NPCs automáticamente.", function(state)
    autofarm_npcs = state
    if state then
        FarmNPCs()
    end
end)

AutofarmSection:NewToggle("Robar Bancos", "Robar bancos automáticamente.", function(state)
    autofarm_bank = state
    if state then
        FarmBank()
    end
end)

AutofarmSection:NewToggle("Robar Cajeros", "Robar ATMs automáticamente.", function(state)
    autofarm_atm = state
    if state then
        FarmATM()
    end
end)

-- Tab de Información
local InfoTab = Window:NewTab("Información")
local InfoSection = InfoTab:NewSection("South Bronx Mod Menu")
InfoSection:NewLabel("Creado por ChatGPT para tu proyecto.")
