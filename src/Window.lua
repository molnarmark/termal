Window = {}
Window.__index = Window

function Window:create(config)
	local data = {
		x = config.positionX,
		y = config.positionY,
		_config = config,
		context  = Context:create(config)
	}
	data.__index = Window
	local self = setmetatable(data, Window)
	self:_calculateSize(config.columns, config.rows)
	return self
end

function Window:_calculateSize(columns, rows)
	local width = columns * TERMAL_PIXEL_SIZE
	local height = rows * TERMAL_PIXEL_SIZE

	self.width = width
	self.height = height

	debugLog("Width -> " .. width .. " Height -> " .. height)
end

function Window:write(text)
	return self.context:_writeToBuffer(text)
end

function Window:draw()
	dxDrawRectangle(self.x, self.y - 30, self.width, 60, tocolor(13, 19, 23, 255))
	dxDrawImage(self.x + 10, self.y - 22, 54, 14, "src/assets/title-buttons.png")
	dxDrawRectangle(self.x, self.y, self.width, self.height, tocolor(13, 19, 23, 255))
end

function Window:update()
	self:draw()

	self.context:update()
	self.context:draw()
end