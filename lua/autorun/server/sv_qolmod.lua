local godMode = false
local autohand = false

hook.Add("PlayerSay", "Commands", function(ply,text)
    if text:sub(1,4) == "!god" then
        if text != "!god" then
            if ply:IsAdmin() or ply:IsSuperAdmin() then
                if text == "!god all" then
                    for i,v in pairs(player.GetAll()) do
                        v:GodEnable()
                        if v:Health() < v:GetMaxHealth() then
                            v:SetHealth(v:GetMaxHealth())
                        end
                    end
                    for i,v in pairs(player.GetAll()) do
                        v:ChatPrint("(Everyone) God mode on")
                    end
                else
                    for i,v in pairs(player.GetAll()) do
                        if v:Name() == text:sub(7) then
                            v:GodEnable()
                            if v:Health() < v:GetMaxHealth() then
                                v:SetHealth(v:GetMaxHealth())
                            end
                        end
                        for i,b in pairs(player.GetAll()) do
                            b:ChatPrint("("..v:Name()..") God mode on")
                        end
                    end
                end
            end
        else
            godMode = true
            if ply:Health() < ply:GetMaxHealth() then
                ply:SetHealth(v:GetMaxHealth())
            end
            ply:GodEnable()
            for i,v in pairs(player.GetAll()) do
                v:ChatPrint("("..ply:Name()..") God mode on")
            end
        end
    elseif text:sub(1,6) == "!ungod" then
        if text != "!ungod" then
            if ply:IsAdmin() or ply:IsSuperAdmin() then
                if text == "!ungod all" then
                    for i,v in pairs(player.GetAll()) do
                        v:GodDisable()
                    end
                    for i,v in pairs(player.GetAll()) do
                        v:ChatPrint("(Everyone) God mode off")
                    end
                else
                    for i,v in pairs(player.GetAll()) do
                        if v:Name() == text:sub(7) then
                            v:GodDisable()
                        end
                        for i,b in pairs(player.GetAll()) do
                            b:ChatPrint("("..v:Name()..") God mode off")
                        end
                    end
                end
            end
        else
            godMode = false
            ply:GodDisable()
            for i,v in pairs(player.GetAll()) do
                v:ChatPrint("("..ply:Name()..") God mode on")
            end
        end
    end

    if text:sub(1,5) == "!kill" then
        if text != "!kill" then
            if ply:IsAdmin() or ply:IsSuperAdmin() then
                if text == "!kill all" then
                    for i,v in pairs(player.GetAll()) do
                        v:Kill()
                    end
                    for i,v in pairs(player.GetAll()) do
                        v:ChatPrint(ply:Name().." Killed all")
                    end
                elseif text == "!kill others" then
                    for i,v in pairs(player.GetAll()) do
                        if v:Nick() != ply:Nick() then
                            v:Kill()
                        end
                    end
                    for i,v in pairs(player.GetAll()) do
                        v:ChatPrint(ply:Name().." Killed others")
                    end
                else
                    for i,v in pairs(player.GetAll()) do
                        if v:Name() == text:sub(7) then
                            v:Kill()
                            for i,b in pairs(player.GetAll()) do
                                b:ChatPrint(ply:Name().." Killed "..text:sub(7))
                            end
                        end
                    end
                end
            end
        else
            ply:Kill()
        end
    end
    if text:sub(1,3) == "!hp" then
        local hp = text:sub(5)
        if ply:IsAdmin() or ply:IsSuperAdmin() then
            ply:SetHealth(tonumber(hp))
        else
            if tonumber(hp) < 101 then
                ply:SetHealth(tonumber(hp))
            else
                ply:SetHealth(100)
            end
        end
    end

    if text == "!hands on" then
        ply:Give("none")
        autohand = true
    elseif text == "!hands off" then
        ply:StripWeapon("none")
        autohand = false
        if ply:HasWeapon("weapon_physgun") then
            ply:SelectWeapon("weapon_physgun")
        end
    end
    
    if text == "!strip" then
        ply:StripWeapons()
        ply:Give("weapon_physgun")
        ply:Give("gmod_tool")
        ply:Give("gmod_camera")
        if autohand == true then
            ply:Give("none")
        end
    end

    if text:sub(1,5) == "!kick" then
        if ply:IsAdmin() then
            for i,v in pairs(player.GetAll()) do
                if v:Name() == text:sub(7) then
                    v:Kick("No reason given")
                end
            end
        end
    end
end)

hook.Add("PlayerSpawn", "godKeep", function(ply)
    if godMode == true then
        ply:GodEnable()
    end
end)

hook.Add("PlayerSpawn", "GiveHands", function(ply)
    if autohand == true then
        ply:Give("none")
    end
end)