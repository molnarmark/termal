Context = {}
Context.__index = Context

function Context:create(config)
	local data = {
		_config = config,
		cursorX = 1, cursorY = 1,
		pixels = {}
	}

	for r = 1, config.rows do
		data.pixels[r] = {}
		for c = 1, config.columns do
			data.pixels[r][c] = {
				bg = COLOR_DARK_GREY,
				fg = COLOR_WHITE,
				value = nil
			}
		end
	end

	data.__index = Context
	local self = setmetatable(data, Context)
	return self
end

function Context:getDataAtPixels(row, column)
	return self.pixels[row][column]
end

function Context:setPixelColor(pixel, fgColor, bgColor)
	pixel.fg.r = fgColor.r
	pixel.fg.g = fgColor.g
	pixel.fg.b = fgColor.b

	pixel.bg.r = bgColor.r
	pixel.bg.g = bgColor.g
	pixel.bg.b = bgColor.b

	pixel.value = nil
end

function Context:_clear()
	for r = 1, self._config.rows do
		for c = 1, self._config.columns do
			local pixelData = self:getDataAtPixels(r, c)
			self:setPixelColor(pixelData, COLOR_WHITE, COLOR_BLACK)
		end
	end
end

function Context:_writeToBuffer(data)
	local splitText = split(data, " ")

	for index, text in pairs(splitText) do
		debugLog(text)
		self:_setPixelValue(self.cursorX, self.cursorY, text)
		self.cursorY = self.cursorY + text:len()
	end
end

function Context:_setPixelValue(row, column, value)
	self.pixels[row][column].value = value
end

function Context:update()

end

function Context:draw()
	for r = 1, self._config.rows do
		for c = 1, self._config.columns do
			local pixelData = self:getDataAtPixels(r, c)

			local x = self._config.positionX + (c * TERMAL_PIXEL_SIZE) - TERMAL_PIXEL_SIZE
			local y = self._config.positionY + (r * TERMAL_PIXEL_SIZE) - TERMAL_PIXEL_SIZE

			-- debugLog(x)

			local bgr = pixelData.bg.r
			local bgg = pixelData.bg.g
			local bgb = pixelData.bg.b

			local value = pixelData.value

			dxDrawRectangle(x, y, TERMAL_PIXEL_SIZE, TERMAL_PIXEL_SIZE, tocolor(bgr, bgg + c, bgb + r, 255), false)

			if value ~= nil then
				dxDrawText(value, x, y, x, y, tocolor(255, 255, 255, 255), 1, "arial", "left", "center", false, false, true, true, false)
			end
		end
	end
end