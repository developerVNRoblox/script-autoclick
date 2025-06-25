--=== TrumVinh Auto Click Mobile GUI - FIX FULL ===--

local vim = game:GetService("VirtualInputManager")
local cam = workspace.CurrentCamera

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TrumVinhAutoClick"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 130)
frame.Position = UDim2.new(0.02, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.25
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Text = "🔥 AUTO CLICKER 🔥"
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.fromRGB(255, 170, 0)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local status = Instance.new("TextLabel", frame)
status.Text = "Trạng thái: ❌ TẮT"
status.Position = UDim2.new(0, 0, 0, 35)
status.Size = UDim2.new(1, 0, 0, 30)
status.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
status.TextColor3 = Color3.fromRGB(255, 255, 100)
status.Font = Enum.Font.Gotham
status.TextScaled = true

local button = Instance.new("TextButton", frame)
button.Text = "Bật Auto Click"
button.Position = UDim2.new(0.1, 0, 1, -45)
button.Size = UDim2.new(0.8, 0, 0, 35)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.GothamBold
button.TextScaled = true

-- Logic Auto Click
local isClicking = false

button.MouseButton1Click:Connect(function()
	isClicking = not isClicking
	if isClicking then
		status.Text = "Trạng thái: ✅ ĐANG CLICK"
		button.Text = "Tắt Auto Click"
		button.BackgroundColor3 = Color3.fromRGB(180, 40, 0)

		coroutine.wrap(function()
			while isClicking do
				local x = cam.ViewportSize.X / 2
				local y = cam.ViewportSize.Y / 2
				vim:SendMouseButtonEvent(x, y, 0, true, game, 0)
				wait(0.05)
				vim:SendMouseButtonEvent(x, y, 0, false, game, 0)
				wait(0.05)
			end
		end)()
	else
		status.Text = "Trạng thái: ❌ TẮT"
		button.Text = "Bật Auto Click"
		button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
	end
end)