Context = {}
Context.__index = Context

function Context:create(config)
	local data = {
		_config = config,
		pixels = {}
	}

	for r = 0, config.rows - 1 do
		data.pixels[r] = {}
		for c = 0, config.columns - 1 do
			data.pixels[r][c] = {
				bg = COLOR_WHITE,
				fg = COLOR_WHITE,
				value = nil
			}
		end
	end

	data.__index = Context
	local self = setmetatable(data, Context)
	return self
end

function Context:getDataAtPixels(r, c)
	return self.pixels[r][c]
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

function Context:update()

end

function Context:draw()
	for r = 0, self._config.rows - 1 do
		for c = 0, self._config.columns - 1 do
			local pixelData = self:getDataAtPixels(r, c)

			local x = self._config.positionX + (c * TERMAL_PIXEL_SIZE)
			local y = self._config.positionY + (r * TERMAL_PIXEL_SIZE)

			-- debugLog(x)

			local bgr = pixelData.bg.r % r
			local bgg = pixelData.bg.g % c
			local bgb = pixelData.bg.b % r

			local value = pixelData.value

			dxDrawRectangle(x, y, TERMAL_PIXEL_SIZE, TERMAL_PIXEL_SIZE, tocolor(bgr, bgg, bgb, 255), true)
		end
	end
end