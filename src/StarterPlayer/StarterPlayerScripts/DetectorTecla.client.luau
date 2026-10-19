local UIS  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService") 

local Remotes = ReplicatedStorage:WaitForChild("Remotes") :: Folder
local DetectorTeclaRemote = Remotes:WaitForChild("DetectorTecla") :: RemoteEvent
local CooldownRemote = Remotes:WaitForChild("Cooldown") :: RemoteEvent

-- Interface 
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui"):WaitForChild("HabilidadesGui")
local _barra = gui:WaitForChild("Barra")


local Enums = {
    Enum.KeyCode.Z,
    Enum.KeyCode.X,
    Enum.KeyCode.C
}

UIS.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean)
    if gameProcessedEvent then
        return
    end
    
    for _, tecla in ipairs(Enums) do
        if input.KeyCode == tecla then
            DetectorTeclaRemote:FireServer(tecla)
            return
        end
    end
    
end)


CooldownRemote.OnClientEvent:Connect(function(nome: any, tempo: any)
    local slot = _barra:FindFirstChild("Slot" .. nome)
    if slot == nil then return end
    
    local numero = slot:WaitForChild("Numero")
    numero.Visible = true

    local simbolo = slot:WaitForChild("Simbolo")
    
    
    local restante = tempo

    local sweep = slot:WaitForChild("Sweep")
    sweep.Size = UDim2.fromScale(1, 1)
    TweenService:Create(sweep, TweenInfo.new(tempo, Enum.EasingStyle.Linear), { Size = UDim2.fromScale(1, 0) }):Play()

    simbolo.Visible = false
    
    while restante > 0 do
        numero.Text = tostring(math.ceil(restante))
        
        task.wait(0.1)

        restante -= 0.1
        
    end
    

    numero.Text = ""
    numero.Visible = false

    simbolo.Visible = true
    
end)

