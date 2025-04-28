-- Carga la librería UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("South Bronx Mod Menu v3", "Ocean")

-- Variables
local autofarm_npcs = false
local autofarm_bank = false
local autofarm_atm = false

-- Funciones
function FarmNPCs()
    task.spawn(function()
        while autofarm_npcs do
            for _, npc in ipairs(workspace:GetDescendants()) do
                if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
                    if npc.Humanoid.Health > 0 then
                        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                            -- Activar herramienta si existe
                            local tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
                            if tool then
                                tool:Activate()
                            end
                        end
                        task.wait(0.5)
                    end
                end
            end
            task.wait(1)
        end
    end)
end

function FarmBank()
    task.spawn(function()
        while autofarm_bank do
            for _, object in ipairs(workspace:GetDescendants()) do
                if object:IsA("ProximityPrompt") and object.Parent and object.Parent:IsA("BasePart") then
                    if string.find(object.Parent.Name:lower(), "bank") or string.find(object.Parent.Name:lower(), "vault") then
                        -- Teletransportar y activar prompt
                        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.CFrame = object.Parent.CFrame + Vector3.new(0,2,0)
                            fireproximityprompt(object)
                        end
                        task.wait(2)
                    end
                end
            end
            task.wait(1)
        end
    end)
end

function FarmATM()
    task.spawn(function()
        while autofarm_atm do
            for _, object in ipairs(workspace:GetDescendants()) do
                if object:IsA("ProximityPrompt") and object.Parent and object.Parent:IsA("BasePart") then
                    if string.find(object.Parent.Name:lower(), "atm") then
                        -- Teletransportar y activar prompt
                        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.CFrame = object.Parent.CFrame + Vector3.new(0,2,0)
                            fireproximityprompt(object)
                        end
                        task.wait(2)
                    end
                end
            end
            task.wait(1)
        end
    end)
end

-- Tabs
local tab = Window:NewTab("AutoFarm")
local section = tab:NewSection("Farm Opciones")

section:NewToggle("Farmear NPCs", "Ataca NPCs automáticamente", function(value)
    autofarm_npcs = value
    if value then
        FarmNPCs()
    end
end)

section:NewToggle("Robar Bancos", "Roba bancos automáticamente", function(value)
    autofarm_bank = value
    if value then
        FarmBank()
    end
end)

section:NewToggle("Robar Cajeros", "Roba cajeros automáticamente", function(value)
    autofarm_atm = value
    if value then
        FarmATM()
    end
end)

local info = Window:NewTab("Info")
local info_section = info:NewSection("Hecho para South Bronx v3")
info_section:NewLabel("Activa cualquier opción y funcionará.")
