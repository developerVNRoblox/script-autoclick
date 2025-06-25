--// ✅ AUTO CLICKER GUI CHO MOBILE (FULL, GỌN GÀNG) --// 👉 Bo góc, màu tối, chọn toạ độ bằng lớp GUI riêng, reset và offset toà độ

local vim = game:GetService("VirtualInputManager") local cam = workspace.CurrentCamera local gui = Instance.new("ScreenGui", game.CoreGui)

local clickX, clickY = 0, 0 local offsetX, offsetY = 0, 0 local delay = 0.1 local isClicking = false

--// GUI CHÍNH local f = Instance.new("Frame", gui) f.Size = UDim2.new(0,180,0,210) f.Position = UDim2.new(0.02,0,0.4,0) f.BackgroundColor3 = Color3.fromRGB(30,30,30) f.BackgroundTransparency = 0.2 f.BorderSizePixel = 0 f.Active = true f.Draggable = true Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

local function createBtn(txt, posY, color) local b = Instance.new("TextButton", f) b.Text = txt b.Size = UDim2.new(0.8, 0, 0, 25) b.Position = UDim2.new(0.1, 0, 0, posY) b.BackgroundColor3 = color or Color3.fromRGB(80, 80, 80) b.TextColor3 = Color3.new(1, 1, 1) b.Font = Enum.Font.GothamBold b.TextScaled = true Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8) return b end

local title = Instance.new("TextLabel", f) title.Text = "AUTO CLICK" title.Size = UDim2.new(1, 0, 0, 30) title.BackgroundColor3 = Color3.fromRGB(45, 45, 45) title.TextColor3 = Color3.new(1, 1, 1) title.Font = Enum.Font.GothamBold title.TextScaled = true Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

title.Position = UDim2.new(0, 0, 0, 0)

local status = Instance.new("TextLabel", f) status.Text = "📍 Chưa chọn" status.Position = UDim2.new(0, 0, 0, 30) status.Size = UDim2.new(1, 0, 0, 20) status.BackgroundTransparency = 1 status.TextColor3 = Color3.new(1, 1, 1) status.Font = Enum.Font.Gotham status.TextScaled = true

local delayLabel = Instance.new("TextLabel", f) delayLabel.Text = "Tốc độ: 0.10s" delayLabel.Position = UDim2.new(0, 0, 0, 50) delayLabel.Size = UDim2.new(1, 0, 0, 20) delayLabel.BackgroundTransparency = 1 delayLabel.TextColor3 = Color3.new(1, 1, 1) delayLabel.Font = Enum.Font.Gotham delayLabel.TextScaled = true

local toggle = createBtn("Bật Auto", 75, Color3.fromRGB(0,180,0)) local choose = createBtn("Chọn vùng", 105, Color3.fromRGB(100,100,255)) local reset = createBtn("🗑 Reset", 135, Color3.fromRGB(200,50,50))

--// OFFSET CHÌNH LỆCH TOẠ ĐỘ local offsetTxt = Instance.new("TextLabel", f) offsetTxt.Text = "Offset: 0, 0" offsetTxt.Position = UDim2.new(0,0,0,165) offsetTxt.Size = UDim2.new(1,0,0,20) offsetTxt.BackgroundTransparency = 1 offsetTxt.TextColor3 = Color3.new(1,1,1) offsetTxt.Font = Enum.Font.Gotham offsetTxt.TextScaled = true

--// CHọn TOẠ ĐỘ QUA LỚp GUI choose.MouseButton1Click:Connect(function() local cgui = Instance.new("ScreenGui", game.CoreGui) local full = Instance.new("TextButton", cgui) full.Size = UDim2.new(1, 0, 1, 0) full.BackgroundTransparency = 1 full.Text = "" local tap = 0 full.MouseButton1Down:Connect(function(x, y) tap += 1 if tap == 2 then clickX, clickY = x, y status.Text = "📍 Vị trí: "..x..","..y cgui:Destroy() end end) end)

--// RESET reset.MouseButton1Click:Connect(function() clickX, clickY = 0, 0 offsetX, offsetY = 0, 0 status.Text = "📍 Chưa chọn" offsetTxt.Text = "Offset: 0, 0" end)

--// Bấm CHạy AUTO CLICK local function doClick() vim:SendMouseButtonEvent(clickX + offsetX, clickY + offsetY, 0, true, game, 0) wait(0.02) vim:SendMouseButtonEvent(clickX + offsetX, clickY + offsetY, 0, false, game, 0) end

toggle.MouseButton1Click:Connect(function() isClicking = not isClicking toggle.Text = isClicking and "Tắt Auto" or "Bật Auto" toggle.BackgroundColor3 = isClicking and Color3.fromRGB(180,50,0) or Color3.fromRGB(0,180,0) if isClicking then spawn(function() while isClicking do doClick() wait(delay) end end) end end)

--// OFFSET

