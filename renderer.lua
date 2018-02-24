Renderer = {}
Renderer.__index = Renderer

function Renderer:create(config)
	local data = {
		config = config,
		pixels = {}
	}

	data.__index = Renderer
	return setmetatable(data, Renderer)
end

function Renderer:getDataAtPixels(r, c)
	return self.pixels[r][c]
end

function Renderer:setPixelColor(pixel, fgColor, bgColor)
	pixel.fg.r = fgColor.r
	pixel.fg.g = fgColor.g
	pixel.fg.b = fgColor.b

	pixel.bg.r = bgColor.r
	pixel.bg.g = bgColor.g
	pixel.bg.b = bgColor.b

	pixel.value = nil
end

function Renderer:clear()
	for r = 1, self.config.rows do
		for c = 1, self.config.columns do
			local pixelData = self:getDataAtPixels(r, c)
			self:setPixelColor(pixelData, COLOR_WHITE, COLOR_BLACK)
		end
	end
end

function Renderer:draw()
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