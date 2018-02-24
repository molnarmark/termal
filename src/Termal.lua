TERMAL = {}

local function readConfig()
	local file = fileOpen(TERMAL_CONFIG_FILE)
	TERMAL = fromJSON(fileRead(file, 99999))
	fileClose(file)
end

function Termal()
	local window = Window:create()
	window:update()
end

if fileExists(TERMAL_CONFIG_FILE) then
	Termal()
else
	-- Generate Termal Configuration
end