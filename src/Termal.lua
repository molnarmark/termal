local function readConfig()
	local file = fileOpen(TERMAL_CONFIG_FILE)
	local configuration = fromJSON(fileRead(file, fileGetSize(file)))
	fileClose(file)
	return configuration
end

function Termal()
	local termalConfig = readConfig()
	local window = Window:create(termalConfig)
	local tree = Tree:create()

	window:write("atleast something is showing up..")

	addEventHandler("onClientPreRender", root, function()
		window:update()
	end)
end

if fileExists(TERMAL_CONFIG_FILE) then
	Termal()
else
	-- Generate Termal Configuration
end