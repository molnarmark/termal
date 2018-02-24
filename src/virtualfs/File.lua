File = {}
File.__index = File

function File:create(branch, contents)
	local data = {}
	data.__index = File
	local self = setmetatable(data, File)

	return file
end