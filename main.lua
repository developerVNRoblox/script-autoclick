local delay = 1 -- thời gian chờ giữa mỗi lần click (giây)

function findAndClickRollButton()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("TextButton") and v.Visible and (v.Text:lower():find("roll") or v.Name:lower():find("roll")) then
            print("🎯 Đã tìm thấy nút: " .. v.Name .. " / " .. v.Text)
            v:Activate() -- an toàn hơn MouseButton1Click
            return true
        end
    end
    return false
end

while true do
    local ok = findAndClickRollButton()
    if not ok then
        warn("❌ Không tìm thấy nút Roll! Mở UI hoặc đợi chút...")
    end
    wait(delay)
end