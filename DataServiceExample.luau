local ds = require(script.DataService)
local plrs = game:GetService("Players")
 
 
 
plrs.PlayerAdded:Connect(function(plr)
    local Data = ds:GetAsync(plr.UserId, plr.UserId)
    print(Data)
    for i, v in pairs(Data["Data"]) do
        print(i, v)
    end
    
    local ls = Instance.new("Folder", plr)
    ls.Name = "leaderstats"
    local Money = Instance.new("NumberValue", ls)
    Money.Name = "Money"
    Money.Value = Data["Data"].Money
    
    while task.wait(1) and plr do 
        Money.Value += 1 
    end 
    
end)
 
plrs.PlayerRemoving:Connect(function(plr)
    local DataService = ds:GetAsync(plr.UserId, plr.UserId)
    DataService["Data"].Money = plr.leaderstats.Money.Value
    
    local saved = ds:SetAsync(plr.UserId, DataService, plr.UserId)
    print(saved)
    
    for i, v in pairs(saved) do
        print(i, v)
    end
    
    for j, k in pairs(saved["Data"]) do
        print(j, k)
    end
end) 
 





while task.wait(30) do 
    for _, plr in pairs(plrs:GetPlayers()) do
        local DataService = ds:GetAsync(plr.UserId, plr.UserId)
        DataService.Data.Money = plr.leaderstats.Money.Value
        
        local saved = ds:SetAsync(plr.UserId, DataService, plr.UserId)
        print(saved)
        
        for i, v in pairs(saved) do
            print(i, v)
        end
        
        for j, k in pairs(saved["Data"]) do
            print(j, k)
        end 
    end
end 








--local data = ds:GetAsync(124767284)
--print(data)

--local data2 = ds:SetAsync(1234)
--print(data2)

