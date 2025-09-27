--|================================================|
--| DATASERVICE CREATED BY LCJUNIOR1220 (124767284)|
--|------------------------------------------------|
--| DOCUMENTATION: dataservice.prp.bio             |
--|================================================|
 
-- SERVICES -- 
local plrs = game:GetService("Players")
local dss = game:GetService("DataStoreService")
 
 
-- INITIALIZE DATASERVICE --
local DataService = {}
local INVALID_TABLE = {["Data"] = {}}
local DATA

-- API CHECK --
local success, ISAPI = pcall(function()
    DATA = dss:GetDataStore("DataSevice_"..game.PlaceId)
    return DATA:GetAsync("DATASERVICEAPICHECK12_20") -- please don't set this as your key.
end)

if success and DATA then
    print("[DataService]: ✅ ROBLOX API SERVICES ARE ENABLED! Data will be saved.")
elseif string.find(ISAPI, "API Services are not enabled") or string.find(ISAPI, "Trust check failed") then
    print("[DataService]: ❌ ROBLOX API SERVICES ARE NOT ENABLED! Data will not be saved.")
else
    print("[DataService]: ❌ ROBLOX API SERVICES ARE DOWN OR YOU’VE TEMPORARILY HIT THE RATE LIMIT.")
end 
 
-- TEMPLATE --
DataService.DATA_TEMPLATE = {
Money = 100,
Gems = 0 
}
 
local temp = DataService.DATA_TEMPLATE
-- FUNCTIONS --
 
local function DeepCopy(template)
    local c = {}
    for i, v in pairs(template) do
        if type(v) == "table" then
            v = DeepCopy(v)
        end
        c[i] = v
    end
    return c
end
 
 
function DataService:SetAsync(self, data, uid)
    if not tonumber(uid) then error("No UserId Provided In Arg 3 Of DataService:SetAsync() (We use it to follow the GDPR Policy.)") return INVALID_TABLE end
    
    if data and not data["Data"] then error("Arg 2 of DataService:SetAsync() Has An Invalid Table. Please Include The Original Table By Calling DataService:GetAsync() And Replace The Original Value With The Updated One.") return INVALID_TABLE end
    
    local un
    
    local s, e = pcall(function()
        return plrs:GetNameFromUserIdAsync(uid)
    end)
    
    if s and e then
        un = valid
    else 
        warn("Not a valid UserId")
        return INVALID_TABLE
    end
    
    local success, valid = pcall(function()
        DATA:SetAsync(self, data, uid)
        return data
    end)
    
    if success and valid then
        return {un.."'s Data Was Successfully Saved!", ["Data"] = valid}
    else
        return {valid, ["Data"] = {}}
    end
end





function DataService:GetAsync(self, uid)
    if not tonumber(uid) then error("No UserId Provided In Arg 2 Of DataService:GetAsync()") return INVALID_TABLE end
    
    local t = DeepCopy(DataService.DATA_TEMPLATE)
    local tdata = DATA:GetAsync(self) or t
    local un
    
    local success, valid = pcall(function()
        return plrs:GetNameFromUserIdAsync(uid)
    end) 
    
    if success and valid then
        un = valid
    else 
        warn("Not a valid UserId")
        return INVALID_TABLE
    end
    
    local s, e = pcall(function()
        local data = DATA:GetAsync(self) or t
        for i, v in pairs(data) do
            for j, k in pairs(t) do
                if j ~= i then
                    data[j] = t[j]  
                end
            end
        end
        return data
    end)
    
    
    
    if s and e then
        return {"Successfully Got Data For "..un, ["Data"] = e} -- add pcalls to make sure the key loads and is a valid utf-8 character
    else
        return {e, ["Data"] = {}}
    end
end


















return DataService