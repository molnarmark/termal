Tree = {}
Tree.__index = Tree

function Tree:create()
	if not fileExists(TERMAL_FS_FILE) then
		return debugLog("File System doesn't exist.")
	end

	local data = {}

	data.__index = Tree
	local self = setmetatable(data, Tree)

	local file = fileOpen(TERMAL_FS_FILE)
	local bytes = fileRead(file, fileGetSize(file))
	fileClose(file)
	debugLog(self:fromBytes(split(bytes, " ")))
	self.fileSystem = fromJSON(self:fromBytes(split(bytes, " ")))
	self.currentDirectory = "root"
	self.currentBranch = self.fileSystem[self.currentDirectory]

	return self
end

function Tree:makeDirectory(name)
	local branch = self.currentBranch
	local dir = Directory:create(name)
	self:push(dir, "dir")
end

function Tree:push(element, theType)
	if theType == "dir" then
		self.fileSystem["root"]["dirs"][element.name] = {
			files = {}
		}

	else
		debugLog("Files are not supported as of now.")
	end

	self:save()
end

function Tree:save()
	local file = fileOpen(TERMAL_FS_FILE)

	if file then
		local byteFS = self:toBytes(toJSON(self.fileSystem))
		local bytesWritten = fileWrite(file, byteFS)
		local flushed = fileFlush(file)
		local closed = fileClose(file)
		debugLog("Successfully flushed: " .. tostring(flushed))
		debugLog("Successfully closed: " .. tostring(closed))
		debugLog("Wrote " .. tostring(bytesWritten) .. " bytes to the File System.")
		outputDebugString(byteFS)
	else
		debugLog("Couldn't open/create the file")
	end
end

function Tree:toBytes(text)
	local bytes = { string.byte(text, 1, -1) }
	return tostring(table.concat(bytes, " "))
end

function Tree:fromBytes(text)
  local bytearr = {}
  for _, v in ipairs(text) do
    local utf8byte = tonumber(v) < 0 and (0xff + v + 1) or tonumber(v)
    table.insert(bytearr, string.char(utf8byte))
  end
  return table.concat(bytearr)
end