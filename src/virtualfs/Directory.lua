Directory = {}
Directory.__index = Directory

function Directory:create(name)
	local data = {
		name = name
	}
	data.__index = Directory
	local self = setmetatable(data, Directory)
	return self
end