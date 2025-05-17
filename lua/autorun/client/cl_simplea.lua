local god = "God mode: OFF"
local commands = {"!cmds - list of commands","!god/!ungod - God mode","!kill - Kills the player","!hp - Set hp","!strip - remove all weapons from inventory","!hands on/off - toggle spawning with hands"}
local admin = {"!cmds - list of commands","!god (user)/!ungod (user) - God mode","!kill (user) - Kills the player","!hp - set hp","!strip - remove all weapons from inventory","!hands on/off - toggle spawning with hands"}
local cmds = {"----- SIMPLE ADMIN -----","!cmds - list of commands","-------------------------------"}
local adminPasted = false
local pasted = false

hook.Add("Think", "Start", function()
	if pasted == false then
		for i,v in pairs(cmds) do
			LocalPlayer():ChatPrint(v)
		end
		pasted = true
	end
end)

hook.Add("OnPlayerChat", "god", function(ply,text)
    if text == "!god" then
        god = "God mode: ON"
    elseif text == "!ungod" then
        god = "God mode: OFF"
    elseif text == "!cmds" then
		if LocalPlayer():IsAdmin() then
			for i,v in pairs(admin) do
				LocalPlayer():ChatPrint(v)
			end
		else
			for i,v in pairs(commands) do
            	LocalPlayer():ChatPrint(v)
        	end
		end
    elseif text == "!hp" then
		LocalPlayer():ChatPrint("HP Set!")
	elseif text == "!strip" then
        LocalPlayer():ChatPrint("Removed all weapons!")
    elseif text == "!hands on" then
        LocalPlayer():ChatPrint("Spawn with hands: ON")
	elseif text == "!hands off" then
		LocalPlayer():ChatPrint("Spawn with hands: OFF")
    end
end)

surface.CreateFont( "godText", {
	font = "Arial",
	extended = false,
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

hook.Add("HUDPaint", "box", function()
    draw.RoundedBox(10, 38, 910, 170, 50, Color(0, 0, 0, 100))
end)

hook.Add("HUDPaint", "text", function()
    draw.SimpleText(god, "godText",45,923,Color(255,255,0,255),0,0)
end)
