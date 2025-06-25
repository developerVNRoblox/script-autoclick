local vim = game:GetService("VirtualInputManager")
local gui = Instance.new("ScreenGui")
gui.Name = "FB:QuangVinh"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = gethui and gethui() or game:GetService("CoreGui")

local clickX, clickY = 0, 0
local isClicking = false
local delay = 0.1
local dot = nil

-- Nút mini khi thu nhỏ
local miniBtn = Instance.new("TextButton")
miniBtn.Text = "🖱 FB: TranQuangVinh"
miniBtn.Size = UDim2.new(0, 160, 0, 30)
miniBtn.Position = UDim2.new(0, 10, 1, -40)
miniBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextScaled = true
miniBtn.Visible = false
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 8)
miniBtn.Parent = gui

-- GUI chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 270)
frame.Position = UDim2.new(0.02, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Tiêu đề
local title = Instance.new("TextLabel", frame)
title.Text = "AUTO CLICK - FB: TranQuangVinh"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

-- Nút thu nhỏ
local minimize = Instance.new("TextButton", frame)
minimize.Text = "📥"
minimize.Size = UDim2.new(0, 25, 0, 25)
minimize.Position = UDim2.new(1, -55, 0, 2)
minimize.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.Font = Enum.Font.GothamBold
minimize.TextScaled = true
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 8)

minimize.MouseButton1Click:Connect(function()
	frame.Visible = false
	miniBtn.Visible = true
end)

miniBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	miniBtn.Visible = false
end)

-- Nút tắt
local close = Instance.new("TextButton", frame)
close.Text = "❌"
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -28, 0, 2)
close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.TextScaled = true
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Trạng thái
local status = Instance.new("TextLabel", frame)
status.Text = "📍 Chưa chọn vị trí"
status.Position = UDim2.new(0, 0, 0, 30)
status.Size = UDim2.new(1, 0, 0, 20)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.new(1, 1, 1)
status.Font = Enum.Font.Gotham
status.TextScaled = true

-- Tạo nút
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

-- Chọn vị trí
createBtn("🎯 Chọn vị trí", 60, function()
	local layer = Instance.new("ScreenGui")
	layer.IgnoreGuiInset = true
	layer.Parent = gethui and gethui() or game:GetService("CoreGui")

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

-- Reset vị trí
createBtn("🗑 Reset vị trí", 95, function()
	clickX = 0
	clickY = 0
	status.Text = "📍 Toạ độ đã reset!"
	if dot then dot:Destroy() end
end, Color3.fromRGB(180, 50, 50))

-- Tăng tốc độ
createBtn("➕ Tăng tốc độ", 130, function()
	delay = math.max(0.01, delay - 0.01)
	status.Text = "⏱ Tốc độ: " .. string.format("%.2fs", delay)
end)

-- Giảm tốc độ
createBtn("➖ Giảm tốc độ", 165, function()
	delay += 0.01
	status.Text = "⏱ Tốc độ: " .. string.format("%.2fs", delay)
end)

-- Bật/Tắt Auto
createBtn("🟢 Bật / Tắt Auto", 200, function()
	isClicking = not isClicking
	if isClicking then
		status.Text = "🔁 Đang click tại: " .. clickX .. ", " .. clickY
		coroutine.wrap(function()
			while isClicking do
				vim:SendMouseButtonEvent(clickX, clickY, 0, true, game, 0)
				wait(0.02)
				vim:SendMouseButtonEvent(clickX, clickY, 0, false, game, 0)
				wait(delay)
			end
		end)()
	else
		status.Text = "⛔ Đã tắt auto click"
	end
end, Color3.fromRGB(0, 180, 0))