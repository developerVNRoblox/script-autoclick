-- Grow a Garden - Pack TrầnQuangVinh Edition
local plr = game:GetService("Players").LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local vim = game:GetService("VirtualInputManager")
local rs = game:GetService("ReplicatedStorage")
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "QV_GrowGardenPack"

-- Flags ON/OFF
local flags = {plant=false, harvest=false, buy=false, hatch=false, tp=false, afk=false}

-- UI chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 360)
frame.Position = UDim2.new(0, 20, 0, 60)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active, frame.Draggable = true, true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

-- Title + close + minimize
local title = Instance.new("TextLabel", frame)
title.Text = "Grow a Garden • TrầnQuangVinh"
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.TextColor3 = Color3.new(1,1,1)
title.Font, title.TextScaled = Enum.Font.GothamBold, true
Instance.new("UICorner", title).CornerRadius = UDim.new(0,6)

local close = Instance.new("TextButton", frame)
close.Text, close.Size, close.Position = "X", UDim2.new(0,25,0,25), UDim2.new(1,-30,0,2)
close.BackgroundColor3, close.Font = Color3.fromRGB(200,50,50), Enum.Font.GothamBold
Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)
close.Parent = frame
close.MouseButton1Click:Connect(function() gui:Destroy() end)

local mini = Instance.new("TextButton", frame)
mini.Text, mini.Size, mini.Position = "-", UDim2.new(0,25,0,25), UDim2.new(1,-60,0,2)
mini.BackgroundColor3, mini.Font = Color3.fromRGB(100,100,100), Enum.Font.GothamBold
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)
mini.Parent = frame

local miniBtn = Instance.new("TextButton", gui)
miniBtn.Text = "📌 Gồm Garden"
miniBtn.Size, miniBtn.Position = UDim2.new(0,160,0,30), UDim2.new(0,10,1,-40)
miniBtn.BackgroundColor3, miniBtn.Font = Color3.fromRGB(60,60,60), Enum.Font.GothamBold
miniBtn.TextColor3 = Color3.new(1,1,1); miniBtn.TextScaled=true
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0,8)
miniBtn.Visible = false

mini.MouseButton1Click:Connect(function()
	frame.Visible = false; miniBtn.Visible = true
end)
miniBtn.MouseButton1Click:Connect(function()
	frame.Visible = true; miniBtn.Visible = false
end)

-- Scrolling nút
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Position = UDim2.new(0,0,0,36)
scroll.Size = UDim2.new(1,0,1,-36)
scroll.CanvasSize (UDim2) = UDim2.new(0,0,0,440)
scroll.ScrollBarThickness = 6
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,4)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Sinh nút toggle
local function makeBtn(txt, key)
	local b = Instance.new("TextButton", scroll)
	b.Size = UDim2.new(0.9,0,0,36); b.Position = UDim2.new(0.05,0,0,0)
	b.BackgroundColor3 = Color3.fromRGB(60,60,60); b.TextColor3 = Color3.new(1,1,1)
	b.Font, b.TextScaled = Enum.Font.GothamBold, true; b.Text = txt
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
	b.MouseButton1Click:Connect(function()
		flags[key] = not flags[key]
		b.BackgroundColor3 = flags[key] and Color3.fromRGB(0,150,0) or Color3.fromRGB(60,60,60)
	end)
	return b
end

makeBtn("🌱 Auto Plant", "plant")
makeBtn("💰 Auto Sell/Harvest", "harvest")
makeBtn("🥚 Auto Hatch", "hatch")
makeBtn("🛒 Auto Buy Seeds", "buy")
makeBtn("🔀 Teleport Shop", "tp")
makeBtn("🌀 Anti-AFK", "afk")
makeBtn("🔗 Copy Discord", "disc").MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/KdH2N2Gn")
end)

-- Logic các chức năng
spawn(function()
	while task.wait(0.5) do
		if flags.plant then
			for _,cd in ipairs(workspace:WaitForChild("Plots"):GetDescendants()) do
				if cd:IsA("ClickDetector") then fireclickdetector(cd) end
			end
		end
		if flags.harvest then
			local ev = rs:FindFirstChild("GameEvents") and rs.GameEvents:FindFirstChild("SellAll")
			if ev then ev:FireServer() end
		end
		if flags.hatch then
			local g = plr.PlayerGui:FindFirstChild("EggGui")
			if g then
				for _,btn in ipairs(g:GetDescendants()) do
					if btn.Name=="HatchBtn" and btn:IsA("TextButton") then pcall(function() btn.MouseButton1Click:Fire() end) end
				end
			end
		end
		if flags.buy then
			local ev = rs:FindFirstChild("GameEvents") and rs.GameEvents:FindFirstChild("BuySeed")
			if ev then ev:FireServer("BasicSeed",1) end
		end
		if flags.tp then
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if hrp then hrp.CFrame = CFrame.new(90,1,3) end
		end
		if flags.afk then
			vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
		end
	end
end)