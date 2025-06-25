local vim = game:GetService("VirtualInputManager")
local cam = workspace.CurrentCamera

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FB:TranQuangVinh"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 180, 0, 170)
frame.Position = UDim2.new(0.02, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Text = "AUTO CLICK"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

local status = Instance.new("TextLabel", frame)
status.Text = "Trạng thái: ❌ TẮT"
status.Position = UDim2.new(0, 0, 0, 30)
status.Size = UDim2.new(1, 0, 0, 20)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.new(1, 1, 1)
status.Font = Enum.Font.Gotham
status.TextScaled = true

-- Tốc độ
local delay = 0.1
local delayLabel = Instance.new("TextLabel", frame)
delayLabel.Text = "Tốc độ: 0.10s"
delayLabel.Position = UDim2.new(0, 0, 0, 55)
delayLabel.Size = UDim2.new(1, 0, 0, 20)
delayLabel.BackgroundTransparency = 1
delayLabel.TextColor3 = Color3.new(1, 1, 1)
delayLabel.Font = Enum.Font.Gotham
delayLabel.TextScaled = true

local minus = Instance.new("TextButton", frame)
minus.Text = "-"
minus.Position = UDim2.new(0.1, 0, 0, 80)
minus.Size = UDim2.new(0.2, 0, 0, 25)
minus.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
minus.TextColor3 = Color3.new(1, 1, 1)
minus.Font = Enum.Font.GothamBold
minus.TextScaled = true
Instance.new("UICorner", minus).CornerRadius = UDim.new(0, 8)

local plus = Instance.new("TextButton", frame)
plus.Text = "+"
plus.Position = UDim2.new(0.7, 0, 0, 80)
plus.Size = UDim2.new(0.2, 0, 0, 25)
plus.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
plus.TextColor3 = Color3.new(1, 1, 1)
plus.Font = Enum.Font.GothamBold
plus.TextScaled = true
Instance.new("UICorner", plus).CornerRadius = UDim.new(0, 8)

local setBtn = Instance.new("TextButton", frame)
setBtn.Text = "Đặt tốc độ"
setBtn.Position = UDim2.new(0.1, 0, 0, 110)
setBtn.Size = UDim2.new(0.8, 0, 0, 25)
setBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
setBtn.TextColor3 = Color3.new(1, 1, 1)
setBtn.Font = Enum.Font.GothamBold
setBtn.TextScaled = true
Instance.new("UICorner", setBtn).CornerRadius = UDim.new(0, 8)

local toggle = Instance.new("TextButton", frame)
toggle.Text = "Bật Auto Click"
toggle.Position = UDim2.new(0.1, 0, 1, -30)
toggle.Size = UDim2.new(0.8, 0, 0, 25)
toggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.TextScaled = true
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)

-- Logic tăng giảm
minus.MouseButton1Click:Connect(function()
	delay = math.min(delay + 0.01, 1)
	delayLabel.Text = string.format("Tốc độ: %.2fs", delay)
end)

plus.MouseButton1Click:Connect(function()
	delay = math.max(delay - 0.01, 0.01)
	delayLabel.Text = string.format("Tốc độ: %.2fs", delay)
end)

-- Auto Click
local isClicking = false

setBtn.MouseButton1Click:Connect(function()
	delayLabel.Text = string.format("Tốc độ: %.2fs", delay)
end)

toggle.MouseButton1Click:Connect(function()
	isClicking = not isClicking
	if isClicking then
		status.Text = "Trạng thái: ✅ ĐANG CLICK"
		toggle.Text = "Tắt Auto Click"
		toggle.BackgroundColor3 = Color3.fromRGB(180, 50, 0)

		coroutine.wrap(function()
			while isClicking do
				local x = cam.ViewportSize.X / 2
				local y = cam.ViewportSize.Y / 2
				vim:SendMouseButtonEvent(x, y, 0, true, game, 0)
				wait(0.02)
				vim:SendMouseButtonEvent(x, y, 0, false, game, 0)
				wait(delay)
			end
		end)()
	else
		status.Text = "Trạng thái: ❌ TẮT"
		toggle.Text = "Bật Auto Click"
		toggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
	end
end)