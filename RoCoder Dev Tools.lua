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

local function GetPath(obj, isString)
	
	
	return obj:GetFullName()
	--if isString == true then
		--local path
		--local segemets = {obj.Name}
		--for i=1, #
			--table.insert(segments, obj.Parent)
		--end
	--end
end

local function PrintConnections(TraceResults)
	local path = TracePath.."."..ConnectionType
	local segments=path:split(".")
	local current=game --location to search
	for i,v in pairs(segments) do
		if i > 1 then
			current=current[v]
		end
	end
	path = current

	local resultstable = {}
	for i,v in pairs(getconnections(path)) do
     	table.insert(resultstable, getfenv(getconnections(path)[i].Function).script.Name)
		print("Result "..i.." path is: "..GetPath(getfenv(getconnections(path)[i].Function).script, true))
	end

	if #resultstable > 0 then
		TraceResults:Set(table.concat(resultstable, ", ")..". Check console for paths!")
	else
		TraceResults:Set("Nothing found!")
		wait(3)
		TraceResults:Set("")
	end

end



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
	Flag = "ConnectionType",
	Callback = function(Value)
		ConnectionType = Value
	end
})
local TraceResults = EventsTab:AddParagraph("Results","")
EventsTab:AddButton({
	Name = "Check for scripts",
	Callback = function()
		local success, err = pcall(PrintConnections, TraceResults)
		
		if success then
			print("Traced connections")
		else
			warn(err)
		end
  	end
})









OrionLib:Init()
