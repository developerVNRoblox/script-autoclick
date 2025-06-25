-- Grow a Garden - Pack Trần Quang Vinh Edition
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local vim = game:GetService("VirtualInputManager")
local rs = game:GetService("ReplicatedStorage")
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "QuangVinhGrowPack"

-- Cờ bật chức năng
local flags = {
    plant = false,
    harvest = false,
    buy = false,
    hatch = false,
    tpShop = false,
    antiAfk = false
}

-- Tạo UI khung chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 320)
frame.Position = UDim2.new(0.02, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Tiêu đề
local title = Instance.new("TextLabel", frame)
title.Text = "Grow Garden - Trần Quang Vinh"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 6)

-- Thanh cuộn chứa nút
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, 0, 1, -30)
scroll.Position = UDim2.new(0, 0, 0, 30)
scroll.CanvasSize = UDim2.new(0, 0, 0, 400)
scroll.ScrollBarThickness = 4
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Tạo nút toggle
local function makeBtn(txt, flagName)
	local btn = Instance.new("TextButton", scroll)
	btn.Size = UDim2.new(0.9, 0, 0, 35)
	btn.Position = UDim2.new(0.05, 0, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	btn.Text = txt
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	btn.MouseButton1Click:Connect(function()
		flags[flagName] = not flags[flagName]
		btn.BackgroundColor3 = flags[flagName] and Color3.fromRGB(0,150,0) or Color3.fromRGB(60,60,60)
	end)
end

makeBtn("🌱 Auto Plant", "plant")
makeBtn("💰 Auto Harvest & Sell", "harvest")
makeBtn("🥚 Auto Hatch Pet", "hatch")
makeBtn("🛒 Auto Buy Seeds", "buy")
makeBtn("📍 Teleport to Shop", "tpShop")
makeBtn("🌀 Anti AFK", "antiAfk")
makeBtn("📋 Copy Discord", "discord").MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/KdH2N2Gn")
end)

-- Logic chức năng
task.spawn(function()
	while true do
		if flags.plant then
			for _,v in ipairs(workspace.Plots:GetDescendants()) do
				if v:IsA("ClickDetector") then
					fireclickdetector(v)
				end
			end
		end
		if flags.harvest then
			rs.GameEvents.SellAll:FireServer()
		end
		if flags.hatch then
			local g = plr.PlayerGui:FindFirstChild("EggGui")
			if g then
				for _,b in ipairs(g:GetDescendants()) do
					if b.Name == "HatchBtn" and b:IsA("TextButton") then
						pcall(function() b.MouseButton1Click:Fire() end)
					end
				end
			end
		end
		if flags.buy then
			rs.GameEvents.BuySeed:FireServer("BasicSeed", 1)
		end
		if flags.tpShop then
			if char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.CFrame = CFrame.new(90, 1, 3)
			end
		end
		if flags.antiAfk then
			vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
		end
		task.wait(2)
	end
end)