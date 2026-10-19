--Serviços 
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debounce = require(ReplicatedStorage.Libs.DebounceHandler)  


--Pastas de Remotes 
local Remotes = ReplicatedStorage:WaitForChild("Remotes") :: Folder

-- RemotesEvent 
local DetectorTeclaRemote = Remotes:WaitForChild("DetectorTecla") :: RemoteEvent
local CooldownRemote = Remotes:WaitForChild("Cooldown") :: RemoteEvent

local _Cooldown = {
    Z = 15,
    X = 10,
    C = 60
}


DetectorTeclaRemote.OnServerEvent:Connect(function(player: Player, tecla: InputObject)

    local _tempo : number = _Cooldown[tecla.Name]
    if _tempo == nil then return end

    local chave = player.UserId .. tecla.Name
    if not Debounce:Check(chave) then 
        print("travado, ignorando") 
        return 

    end

    Debounce:Add(chave, _tempo)

    CooldownRemote:FireClient(player, tecla.Name, _tempo)
    

end)