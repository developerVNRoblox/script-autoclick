local vim = game:GetService("VirtualInputManager")
local cam = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TrumVinhClickGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 180)
frame.Position = UDim2.new(0.02, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Text = "AUTO CLICK - TrumVinh"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local status = Instance.new("TextLabel", frame)
status.Text = "Trạng thái: ❌ TẮT"
status.Position = UDim2.new(0, 0, 0, 30)
status.Size = UDim2.new(1, 0, 0, 25)
status.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.Font = Enum.Font.Gotham
status.TextScaled = true

local toggle = Instance.new("TextButton", frame)
toggle.Text = "Bật Auto Click"
toggle.Position = UDim2.new(0.1, 0, 1, -45)
toggle.Size = UDim2.new(0.8, 0, 0, 35)
toggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.TextScaled = true

local sliderFrame = Instance.new("Frame", frame)
sliderFrame.Position = UDim2.new(0.05, 0, 0, 60)
sliderFrame.Size = UDim2.new(0.9, 0, 0, 25)
sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
sliderFrame.BorderSizePixel = 0

local sliderBar = Instance.new("Frame", sliderFrame)
sliderBar.Size = UDim2.new(0.5, 0, 1, 0)
sliderBar.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
sliderBar.BorderSizePixel = 0

local clickDelay = 0.05 -- mặc định

local dragging = false

sliderFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
	end
end)

sliderFrame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging then
		local pos = math.clamp((input.Position.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
		sliderBar.Size = UDim2.new(pos, 0, 1, 0)
		clickDelay = 0.01 + (1 - pos) * 0.3 -- delay từ 0.01s tới 0.31s
	end
end)

-- Auto Click logic
local isClicking = false

toggle.MouseButton1Click:Connect(function()
	isClicking = not isClicking
	if isClicking then
		status.Text = "Trạng thái: ✅ ĐANG CLICK"
		toggle.Text = "Tắt Auto Click"
		toggle.BackgroundColor3 = Color3.fromRGB(180, 40, 0)

		coroutine.wrap(function()
			while isClicking do
				local x = cam.ViewportSize.X / 2
				local y = cam.ViewportSize.Y / 2
				vim:SendMouseButtonEvent(x, y, 0, true, game, 0)
				wait(0.02)
				vim:SendMouseButtonEvent(x, y, 0, false, game, 0)
				wait(clickDelay)
			end
		end)()
	else
		status.Text = "Trạng thái: ❌ TẮT"
		toggle.Text = "Bật Auto Click"
		toggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
	end
end)