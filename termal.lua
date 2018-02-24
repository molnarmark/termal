local function readConfig()
	local file = fileOpen(TERMAL_CONFIG_FILE)
	local configuration = fromJSON(fileRead(file, 99999))
	fileClose(file)

	return configuration
end

function Termal()
	local configuration = readConfig(TERMAL_CONFIG_FILE)
	local renderer = Renderer:create(configuration)
	renderer:clear()
end

if fileExists(TERMAL_CONFIG_FILE) then
	Termal()
else
	-- Generate Termal Configuration
end