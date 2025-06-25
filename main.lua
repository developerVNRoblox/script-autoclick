local vim = game:GetService("VirtualInputManager")
local gui = Instance.new("ScreenGui")
gui.Name = "AutoClickerUI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = gethui and gethui() or game:GetService("CoreGui")

local clickX, clickY = 0, 0
local isClicking = false
local delay = 0.1

-- MiniBtn khi thu nhỏ
local miniBtn = Instance.new("TextButton", gui)
miniBtn.Text = "📌 AutoClick Menu"
miniBtn.Size = UDim2.new(0, 160, 0, 30)
miniBtn.Position = UDim2.new(0, 10, 1, -40)
miniBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
miniBtn.TextColor3 = Color3.new(1, 1, 1)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextScaled = true
miniBtn.Visible = false
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 8)

-- GUI chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 230, 0, 310)
frame.Position = UDim2.new(0.02, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Nút đóng
local close = Instance.new("TextButton", frame)
close.Text = "X"
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0, 5)
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
minimize.Position = UDim2.new(1, -60, 0, 5)
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

-- Tiêu đề
local title = Instance.new("TextLabel", frame)
title.Text = "AutoClick UI"
title.Size = UDim2.new(1, -70, 0, 30)
title.Position = UDim2.new(0, 5, 0, 5)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Trạng thái
local status = Instance.new("TextLabel", frame)
status.Text = "📍 Chưa chọn vị trí"
status.Position = UDim2.new(0, 0, 0, 35)
status.Size = UDim2.new(1, 0, 0, 20)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.new(1, 1, 1)
status.Font = Enum.Font.Gotham
status.TextScaled = true

-- SCROLLING FRAME chứa nút
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0, 0, 0, 60)
scroll.Size = UDim2.new(1, 0, 1, -60)
scroll.CanvasSize = UDim2.new(0, 0, 0, 400)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout", scroll)
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Hàm tạo nút trong scroll
local function createBtn(text, callback, color)
	local btn = Instance.new("TextButton", scroll)
	btn.Text = text
	btn.Size = UDim2.new(0.9, 0, 0, 35)
	btn.AnchorPoint = Vector2.new(0.5, 0)
	btn.Position = UDim2.new(0.5, 0, 0, 0)
	btn.BackgroundColor3 = color or Color3.fromRGB(70, 70, 70)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Các nút chức năng
createBtn("🎯 Chọn vị trí", function()
	local layer = Instance.new("ScreenGui", gui)
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
			status.Text = "📍 Toạ độ: " .. x .. ", " .. y
			layer:Destroy()
		else
			status.Text = "👉 Nhấn lần 2 để xác nhận"
		end
	end)
end)

createBtn("🗑 Reset vị trí", function()
	clickX = 0
	clickY = 0
	status.Text = "📍 Đã reset toạ độ!"
end, Color3.fromRGB(150, 60, 60))

createBtn("➕ Tăng tốc độ", function()
	delay = math.max(0.01, delay - 0.01)
	status.Text = "⏱ Tốc độ: " .. string.format("%.2fs", delay)
end)

createBtn("➖ Giảm tốc độ", function()
	delay += 0.01
	status.Text = "⏱ Tốc độ: " .. string.format("%.2fs", delay)
end)

createBtn("🟢 Bật / Tắt Auto", function()
	isClicking = not isClicking
	if isClicking then
		status.Text = "🔁 Click tại: " .. clickX .. ", " .. clickY
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

createBtn("🔗 Join Discord", function()
	setclipboard("https://discord.gg/KdH2N2Gn")
	status.Text = "✅ Đã copy Discord!"
end, Color3.fromRGB(88, 101, 242))