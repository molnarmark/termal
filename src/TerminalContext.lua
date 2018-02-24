TerminalContext = {}
TerminalContext.__index = TerminalContext

function TerminalContext:create()
	local data = {
		pixels = {}
	}

	data.__index = TerminalContext
	return setmetatable(data, TerminalContext)
end

function TerminalContext:getDataAtPixels(r, c)
	return self.pixels[r][c]
end

function TerminalContext:setPixelColor(pixel, fgColor, bgColor)
	pixel.fg.r = fgColor.r
	pixel.fg.g = fgColor.g
	pixel.fg.b = fgColor.b

	pixel.bg.r = bgColor.r
	pixel.bg.g = bgColor.g
	pixel.bg.b = bgColor.b

	pixel.value = nil
end

function TerminalContext:clear()
	for r = 1, self.config.rows do
		for c = 1, self.config.columns do
			local pixelData = self:getDataAtPixels(r, c)
			self:setPixelColor(pixelData, COLOR_WHITE, COLOR_BLACK)
		end
	end
end

function TerminalContext:draw()
	for r = 1, self.config.rows do
		for c = 1, self.config.columns do
			local pixelData = self:getDataAtPixels(r, c)
			local r = pixelData.r
			local g = pixelData.g
			local b = pixelData.b
			local value = pixelData.value
		end
	end
end