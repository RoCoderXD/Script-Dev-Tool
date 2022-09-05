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



EventsTab:AddTextbox({ -- Add path textbox for event tracing
	Name = "Path",
	Default = "",
	TextDisappear = false,
	Callback = function(Value)
		TracePath = Value
	end	  
})
EventsTab:AddDropdown({
	Name = "EventType",
	Default = "None",
	Options = Events,
	Callback = function(Value)
    	if loadstring(TracePath..":IsA('GuiObject')") == true then
    		print("Selected GuiObject")
    	elseif loadstring(TracePath..":IsA('BasePart')") == true then
            print("Selected BasePart")
    	end
	end    
})








OrionLib:Init()