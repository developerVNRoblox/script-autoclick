local vim = game:GetService("VirtualInputManager")
local cam = workspace.CurrentCamera
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "AutoclickV2_GUI"

-- Toạ độ click & bù lệch
local clickX, clickY = 0, 0
local offsetX, offsetY = 0, 0
local isClicking = false
local delay = 0.1
local dot

-- GUI khung chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 180, 0, 260)
frame.Position = UDim2.new(0.02, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local function createBtn(text, y, callback, color)
	local btn = Instance.new("TextButton", frame)
	btn.Text = text
	btn.Position = UDim2.new(0.1, 0, 0, y)
	btn.Size = UDim2.new(0.8, 0, 0, 25)
	btn.BackgroundColor3 = color or Color3.fromRGB(80, 80, 80)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Tiêu đề & trạng thái
local title = Instance.new("TextLabel", frame)
title.Text = "AUTO CLICK V2.5"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

local status = Instance.new("TextLabel", frame)
status.Text = "📍 Chưa chọn vị trí"
status.Position = UDim2.new(0, 0, 0, 30)
status.Size = UDim2.new(1, 0, 0, 20)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.new(1, 1, 1)
status.Font = Enum.Font.Gotham
status.TextScaled = true

-- Nút chọn vị trí
createBtn("🎯 Chọn vị trí", 60, function()
	local layer = Instance.new("ScreenGui", game.CoreGui)
	local full = Instance.new("TextButton", layer)
	full.Size = UDim2.new(1, 0, 1, 0)
	full.BackgroundTransparency = 1
	full.Text = ""
	full.ZIndex = 1000

	local tap = 0
	full.MouseButton1Down:Connect(function(x, y)
		tap += 1
		if tap == 2 then
			clickX = x
			clickY = y
			status.Text = "📍 Toạ độ: " .. x .. ", " .. y

			if dot then dot:Destroy() end
			dot = Instance.new("Frame", gui)
			dot.Size = UDim2.new(0, 10, 0, 10)
			dot.Position = UDim2.new(0, x - 5, 0, y - 5)
			dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			dot.BorderSizePixel = 0
			dot.ZIndex = 999
			Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

			layer:Destroy()
		else
			status.Text = "👉 Nhấn lần 2 để xác nhận"
		end
	end)
end, Color3.fromRGB(100, 100, 255))

-- Nút reset vị trí
createBtn("🗑 Reset vị trí", 95, function()
	clickX = 0
	clickY = 0
	offsetX = 0
	offsetY = 0
	status.Text = "📍 Toạ độ đã reset!"
	if dot then dot:Destroy() end
end, Color3.fromRGB(180, 50, 50))

-- Tăng / Giảm delay
createBtn("➕ Tăng tốc độ", 130, function()
	delay = math.max(0.01, delay - 0.01)
	status.Text = "⏱ Tốc độ: " .. string.format("%.2fs", delay)
end)

createBtn("➖ Giảm tốc độ", 165, function()
	delay = delay + 0.01
	status.Text = "⏱ Tốc độ: " .. string.format("%.2fs", delay)
end)

-- Bù lệch
createBtn("⬅ Bù X-", 200, function() offsetX -= 1 end)
createBtn("➡ Bù X+", 230, function() offsetX += 1 end)

-- Auto click toggle
createBtn("🟢 Bật / Tắt Auto", 200 + 30 + 10, function()
	isClicking = not isClicking
	if isClicking then
		status.Text = "🔁 Đang click tại: " .. (clickX + offsetX) .. "," .. (clickY + offsetY)
		coroutine.wrap(function()
			while isClicking do
				vim:SendMouseButtonEvent(clickX + offsetX, clickY + offsetY, 0, true, game, 0)
				wait(0.02)
				vim:SendMouseButtonEvent(clickX + offsetX, clickY + offsetY, 0, false, game, 0)
				wait(delay)
			end
		end)()
	else
		status.Text = "⛔ Đã tắt auto click"
	end
end, Color3.fromRGB(0, 180, 0))