-- https://github.com/shlexware/Orion/blob/main/Documentation.md

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "RoCoder's Dev Tools", HidePremium = true, SaveConfig = true, ConfigFolder = "configsave"})

local EventsTab = Window:MakeTab({
	Name = "Events",
	PremiumOnly = false
})

local EventTracer = EventsTab:AddSection({
	Name = "Event Tracer"
})


local Events = {
    "Activated",
    "MouseButton1Click",
    "MouseButton1Down",
    "MouseButton1Up",
    "MouseButton2Click",
    "MouseButton2Down",
    "MouseButton2Up",
    "InputBegan",
    "InputChanged",
    "InputEnded",
    "MouseEnter",
    "MouseLeave",
    "MouseMoved",
    "MouseWheelBackward",
    "MouseWheelForward",
    "TouchEnded",
    "Touched",
    "Changed"
}



-- EVENT TRACING

-- Variables
local TracePath
local ConnectionType


-- Functions
local function PrintConnections()
	for i,v in pairs(getfenv(getconnections(TracePath[ConnectionType]))) do
     		print(i,v)
	end)
end



EventsTab:AddTextbox({ -- Add path textbox for event tracing
	Name = "Path",
	Default = "",
	TextDisappear = false,
	Callback = function(Value)
		TracePath = string.format(Value, "%s")
	end	  
})
EventsTab:AddDropdown({
	Name = "EventType",
	Default = "None",
	Options = Events,
	Callback = function(Value)
		if TracePath ~= nil then
			ConnectionType = Value
		end
	end
})
EventsTab:AddButton({
	Name = "Check for scripts",
	Callback = function()
		local success, err = pcall(PrintConnections)
		
		if success then
			print("Traced connections")
		else
			warn(err)
		end
  	end
})









OrionLib:Init()
