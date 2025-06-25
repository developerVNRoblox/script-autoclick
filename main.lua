local vim = game:GetService("VirtualInputManager")
local uis = game:GetService("UserInputService")
local cam = workspace.CurrentCamera

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "AutoClickerGUI"

-- Thông báo ban đầu
local intro = Instance.new("TextLabel", gui)
intro.Size = UDim2.new(0.6, 0, 0.1, 0)
intro.Position = UDim2.new(0.2, 0, 0.4, 0)
intro.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
intro.TextColor3 = Color3.new(1, 1, 1)
intro.Text = "👉 Hãy chạm 2 lần vào vùng bạn muốn auto click!"
intro.Font = Enum.Font.GothamBold
intro.TextScaled = true
intro.ZIndex = 999
Instance.new("UICorner", intro).CornerRadius = UDim.new(0, 12)

-- Frame chính (ẩn ban đầu)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 180, 0, 220)
frame.Position = UDim2.new(0.02, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Visible = false
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local clickX, clickY = 0, 0
local tapCount = 0

-- Chờ 2 lần tap
local conn
conn = uis.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		tapCount += 1
		if tapCount == 1 then
			intro.Text = "👉 Nhấn lần 2 vào cùng vùng!"
		elseif tapCount == 2 then
			clickX = input.Position.X
			clickY = math.clamp(input.Position.Y, 0, cam.ViewportSize.Y - 2)

			-- Chấm đỏ
			local dot = Instance.new("Frame", gui)
			dot.Size = UDim2.new(0, 10, 0, 10)
			dot.Position = UDim2.new(0, clickX - 5, 0, clickY - 5)
			dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			dot.BorderSizePixel = 0
			dot.ZIndex = 999
			Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

			intro:Destroy()
			frame.Visible = true
			conn:Disconnect()
		end
	end
end)

-- ===== PHẦN CÒN LẠI: GUI auto click như trước (rút gọn cho gọn đoạn dưới) =====
-- Mày gắn thêm phần GUI tốc độ click, nút + -, toggle auto click y như những bản trước tao làm.
-- Dùng biến `clickX`, `clickY` để gửi event auto click tại đó.
-- Đảm bảo không đổi tên GUI nào phía trên.

-- Nếu mày muốn tao ráp full bản GUI kèm auto click + tốc độ + toggle + fix này luôn
➡ hú tao phát tao dán liền nguyên file `main.lua` cho lẹ nha má 😎
---

Muốn gắn thêm:
- Lưu toạ độ?
- Hiện toạ độ đã chọn?
- Có nút đổi lại vùng click?

👉 Tao gắn tiếp cho, **build đến khi nào mày thấy phê mới thôi** 😤