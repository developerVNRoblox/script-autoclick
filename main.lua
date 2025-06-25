--===[ Auto Click GUI for Mobile - by TrumVinh ]===--

local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TrumVinhAutoClick"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 140)
frame.Position = UDim2.new(0.02, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🔥 AUTO CLICKER 🔥"
title.BackgroundColor3 = Color3.fromRGB(255, 70, 0)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, 0, 0, 30)
status.Position = UDim2.new(0, 0, 0, 35)
status.Text = "Trạng thái: TẮT"
status.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
status.TextColor3 = Color3.new(1, 1, 0)
status.Font = Enum.Font.Gotham
status.TextScaled = true

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.8, 0, 0, 40)
toggle.Position = UDim2.new(0.1, 0, 1, -45)
toggle.Text = "Bật Auto Click"
toggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.TextScaled = true

-- Auto click logic cho mobile
local isClicking = false

toggle.MouseButton1Click:Connect(function()
	isClicking = not isClicking
	if isClicking then
		status.Text = "Trạng thái: ĐANG CLICK"
		toggle.Text = "Tắt Auto Click"
		toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 0)

		coroutine.wrap(function()
			while isClicking do
				VirtualInputManager:SendMouseButtonEvent(
					workspace.CurrentCamera.ViewportSize.X / 2, -- giữa màn hình
					workspace.CurrentCamera.ViewportSize.Y / 2,
					0, -- MouseButton1
					true,
					game,
					0
				)
				wait(0.05)
				VirtualInputManager:SendMouseButtonEvent(
					workspace.CurrentCamera.ViewportSize.X / 2,
					workspace.CurrentCamera.ViewportSize.Y / 2,
					0,
					false,
					game,
					0
				)
				wait(0.05)
			end
		end)()

	else
		status.Text = "Trạng thái: TẮT"
		toggle.Text = "Bật Auto Click"
		toggle.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
	end
end)