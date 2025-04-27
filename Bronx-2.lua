--// South Bronx AutoFarm Mod Menu
--// Hecho por ChatGPT (Adaptado para tu pedido)

-- Cargando la librería de interfaz de usuario
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("South Bronx AutoFarm", "Ocean")

-- Variables
local autofarm_npcs = false
local autofarm_bank = false
local autofarm_atm = false

-- Funciones
function FarmNPCs()
    while autofarm_npcs do
        for _, npc in pairs(game:GetService("Workspace"):GetChildren()) do
            if npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
                if npc.Humanoid.Health > 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
                    -- Simula ataque (puedes cambiar esto por tu sistema de combate)
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
end

function FarmBank()
    while autofarm_bank do
        -- Suponiendo que el banco es una parte que se puede robar
        for _, bank in pairs(game:GetService("Workspace").RobberySpots:GetChildren()) do
            if bank.Name == "Bank" and bank:FindFirstChild("Steal") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = bank.Steal.CFrame
                fireproximityprompt(bank.Steal.ProximityPrompt)
                wait(2)
            end
        end
        wait(1)
    end
end

function FarmATM()
    while autofarm_atm do
        for _, atm in pairs(game:GetService("Workspace").ATMs:GetChildren()) do
            if atm:FindFirstChild("Steal") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = atm.Steal.CFrame
                fireproximityprompt(atm.Steal.ProximityPrompt)
                wait(2)
            end
        end
        wait(1)
    end
end

-- Tabs y botones del menú
local AutofarmTab = Window:NewTab("AutoFarm")
local AutofarmSection = AutofarmTab:NewSection("Farm Options")

AutofarmSection:NewToggle("Farmear NPCs", "Golpea automáticamente NPCs para farmear.", function(state)
    autofarm_npcs = state
    if state then
        FarmNPCs()
    end
end)

AutofarmSection:NewToggle("Robar Bancos", "Roba bancos automáticamente.", function(state)
    autofarm_bank = state
    if state then
        FarmBank()
    end
end)

AutofarmSection:NewToggle("Robar Cajeros", "Roba ATMs automáticamente.", function(state)
    autofarm_atm = state
    if state then
        FarmATM()
    end
end)

-- Info Extra
local InfoTab = Window:NewTab("Información")
local InfoSection = InfoTab:NewSection("¡Hecho para South Bronx!")
InfoSection:NewLabel("Activa las opciones que quieras para farmear.")
