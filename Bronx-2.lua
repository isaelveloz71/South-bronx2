--// Carga de librerías
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("South Bronx Mod Menu", "Dark")

-- Variables
local autofarm_npcs = false
local autofarm_bank = false
local autofarm_atm = false
local autofarm_bolsa = false

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

function FarmBolsaMagica()
    task.spawn(function()
        while autofarm_bolsa do
            for _, object in ipairs(workspace:GetDescendants()) do
                if object:IsA("Model") and object.Name:lower():find("bolsa magica") then
                    local prompt = object:FindFirstChildWhichIsA("ProximityPrompt")
                    if prompt then
                        -- Teletransportar y activar el prompt
                        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.CFrame = object.CFrame + Vector3.new(0, 2, 0)
                            fireproximityprompt(prompt)
                        end
                        task.wait(2)
                    end
                end
            end
            task.wait(1)
        end
    end)
end

-- Nueva opción para vender la bolsa mágica automáticamente
function AutoSellBolsaMagica()
    task.spawn(function()
        while autofarm_bolsa do
            for _, object in ipairs(workspace:GetDescendants()) do
                if object:IsA("Model") and object.Name:lower():find("bolsa magica") then
                    -- Simula la venta
                    local sellPrompt = object:FindFirstChildWhichIsA("ProximityPrompt")
                    if sellPrompt then
                        fireproximityprompt(sellPrompt)
                        task.wait(1)  -- espera un poco entre ventas
                    end
                end
            end
            task.wait(2)
        end
    end)
end

-- Crear Tabs
local autofarmTab = Window:NewTab("AutoFarm")
local section = autofarmTab:NewSection("Opciones de Farm")

-- Toggle de NPCs, Bancos, ATMs y Bolsa Mágica
section:NewToggle("Farmear NPCs", "Golpear NPCs automáticamente.", function(state)
    autofarm_npcs = state
    if state then
        FarmNPCs()
    end
end)

section:NewToggle("Robar Bancos", "Robar bancos automáticamente.", function(state)
    autofarm_bank = state
    if state then
        FarmBank()
    end
end)

section:NewToggle("Robar Cajeros", "Robar ATMs automáticamente.", function(state)
    autofarm_atm = state
    if state then
        FarmATM()
    end
end)

section:NewToggle("Farmear Bolsa Mágica", "Farmear Bolsa Mágica automáticamente.", function(state)
    autofarm_bolsa = state
    if state then
        FarmBolsaMagica()
        AutoSellBolsaMagica()
    end
end)

-- Info Tab
local infoTab = Window:NewTab("Info")
local infoSection = infoTab:NewSection("South Bronx Mod Menu")
infoSection:NewLabel("Creado por ChatGPT para tu proyecto.")
