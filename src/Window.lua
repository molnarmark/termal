Window = {}
Window.__index = Window

function Window:create()
	local data = {
		context  = TerminalContext:create()
	}

	data.__index = Window
	return setmetatable(data, Window)
end

function Window:draw()
	-- Draw titlebar, etc.
end

function Window:update()
	self:draw()

	self.context:update()
	self.context:draw()
end