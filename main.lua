local vim = game:GetService("VirtualInputManager")
local gui = Instance.new("ScreenGui")
gui.Name = "AutoClickGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = gethui and gethui() or game:GetService("CoreGui")

local clickX, clickY = 0, 0
local isClicking = false
local delay = 0.1

-- Nút thu nhỏ hiện khi GUI bị ẩn
local miniBtn = Instance.new("TextButton", gui)
miniBtn.Text = "📌"
miniBtn.Size = UDim2.new(0, 30, 0, 30)
miniBtn.Position = UDim2.new(0, 10, 1, -40)
miniBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
miniBtn.TextColor3 = Color3.new(1, 1, 1)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextScaled = true
miniBtn.Visible = false
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(1, 0)

-- GUI chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 260)
frame.Position = UDim2.new(0.02, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Header
local title = Instance.new("TextLabel", frame)
title.Text = "AUTO CLICK"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

-- Nút đóng
local close = Instance.new("TextButton", frame)
close.Text = "x"
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -28, 0, 2)
close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.TextScaled = true
Instance.new("UICorner", close).CornerRadius = UDim.new(1, 0)
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Nút thu nhỏ
local minimize = Instance.new("TextButton", frame)
minimize.Text = "-"
minimize.Size = UDim2.new(0, 25, 0, 25)
minimize.Position = UDim2.new(1, -55, 0, 2)
minimize.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.Font = Enum.Font.GothamBold
minimize.TextScaled = true
Instance.new("UICorner", minimize).CornerRadius = UDim.new(1, 0)
minimize.MouseButton1Click:Connect(function()
	frame.Visible = false
	miniBtn.Visible = true
end)

miniBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	miniBtn.Visible = false
end)

-- Trạng thái hiển thị
local status = Instance.new("TextLabel", frame)
status.Text = "📍 Chưa chọn vị trí"
status.Position = UDim2.new(0, 0, 0, 30)
status.Size = UDim2.new(1, 0, 0, 20)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.new(1, 1, 1)
status.Font = Enum.Font.Gotham
status.TextScaled = true

-- Hàm tạo nút nhỏ
local function createBtn(text, x, y, callback, color)
	local btn = Instance.new("TextButton", frame)
	btn.Text = text
	btn.Position = UDim2.new(x, 0, 0, y)
	btn.Size = UDim2.new(0.4, 0, 0, 25)
	btn.BackgroundColor3 = color or Color3.fromRGB(70, 70, 70)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Nút: Chọn vị trí
createBtn("🎯", 0.05, 60, function()
	local layer = Instance.new("ScreenGui", gethui and gethui() or game:GetService("CoreGui"))
	layer.IgnoreGuiInset = true
	local full = Instance.new("TextButton", layer)
	full.Size = UDim2.new(1, 0, 1, 0)
	full.BackgroundTransparency = 1
	full.Text = ""
	full.ZIndex = 999
	local tap = 0
	full.MouseButton1Down:Connect(function(x, y)
		tap += 1
		if tap == 2 then
			clickX = x
			clickY = y
			status.Text = "📍 Tọa độ: " .. x .. ", " .. y
			layer:Destroy()
		else
			status.Text = "👉 Nhấn lần 2 để xác nhận"
		end
	end)
end)

-- Nút: Reset
createBtn("❌", 0.55, 60, function()
	clickX = 0
	clickY = 0
	status.Text = "📍 Đã reset!"
end, Color3.fromRGB(150, 60, 60))

-- Nút: Tăng tốc
createBtn("➕", 0.05, 95, function()
	delay = math.max(0.01, delay - 0.01)
	status.Text = "⏱ Tốc độ: " .. string.format("%.2fs", delay)
end, Color3.fromRGB(60, 120, 60))

-- Nút: Giảm tốc
createBtn("➖", 0.55, 95, function()
	delay += 0.01
	status.Text = "⏱ Tốc độ: " .. string.format("%.2fs", delay)
end, Color3.fromRGB(60, 120, 60))

-- Nút Auto ở giữa
local autoBtn = Instance.new("TextButton", frame)
autoBtn.Text = "🟢 Auto Click"
autoBtn.Position = UDim2.new(0.1, 0, 0, 130)
autoBtn.Size = UDim2.new(0.8, 0, 0, 30)
autoBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
autoBtn.TextColor3 = Color3.new(1, 1, 1)
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextScaled = true
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 10)

autoBtn.MouseButton1Click:Connect(function()
	isClicking = not isClicking
	if isClicking then
		status.Text = "🔁 Đang auto click tại: " .. clickX .. ", " .. clickY
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
end)

-- Nút Discord góc dưới phải
local discord = Instance.new("TextButton", frame)
discord.Text = "💬"
discord.Size = UDim2.new(0, 25, 0, 25)
discord.Position = UDim2.new(1, -30, 1, -30)
discord.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discord.TextColor3 = Color3.new(1, 1, 1)
discord.Font = Enum.Font.GothamBold
discord.TextScaled = true
Instance.new("UICorner", discord).CornerRadius = UDim.new(1, 0)

discord.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/KdH2N2Gn")
	status.Text = "✅ Đã copy Discord!"
end)