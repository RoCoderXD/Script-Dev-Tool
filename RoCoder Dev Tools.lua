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
	local path = TracePath
	local segments=path:split("")
	local current=game --location to search
	for i,v in pairs(segments) do
		current=current[v]
	end
	path = current


	for i,v in pairs(getconnections(path[ConnectionType])) do
     	print(getfenv(getconnections(path)[i].Function).script)
	end
end



EventsTab:AddTextbox({ -- Add path textbox for event tracing
	Name = "Path",
	Default = "",
	TextDisappear = false,
	Callback = function(Value)
		TracePath = Value
		local segments=TracePath:split(".")
		local current=game --location to search
		for i,v in pairs(segments) do
			if i > 1 then
				current=current[v]
			end
		end
		TracePath = current
	end
})
EventsTab:AddDropdown({
	Name = "EventType",
	Default = "None",
	Options = Events,
	Flag = "ConnectionType",
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
