--===[ GUI Auto Click by TrumVinh ]===--

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local Run = game:GetService("RunService")

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "TrumVinhAutoClick"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(0, 10, 0.4, 0)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Text = "🔥 Auto Click GUI 🔥"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

local Status = Instance.new("TextLabel", Frame)
Status.Text = "Trạng thái: TẮT"
Status.Position = UDim2.new(0, 0, 0, 30)
Status.Size = UDim2.new(1, 0, 0, 30)
Status.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Status.TextColor3 = Color3.fromRGB(255, 255, 0)
Status.TextScaled = true

local Toggle = Instance.new("TextButton", Frame)
Toggle.Text = "Bật Auto Click"
Toggle.Position = UDim2.new(0.1, 0, 0, 70)
Toggle.Size = UDim2.new(0.8, 0, 0, 35)
Toggle.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.TextScaled = true

-- Auto Click logic
local isClicking = false
local function doClick()
	while isClicking do
		mouse1click()
		wait(0.1) -- chỉnh tốc độ click ở đây
	end
end

Toggle.MouseButton1Click:Connect(function()
	isClicking = not isClicking
	if isClicking then
		Status.Text = "Trạng thái: ĐANG CLICK"
		Toggle.Text = "Tắt Auto Click"
		Toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 0)
		coroutine.wrap(doClick)()
	else
		Status.Text = "Trạng thái: TẮT"
		Toggle.Text = "Bật Auto Click"
		Toggle.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
	end
end)
