local Players = game:GetService("Players") or cloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Section_Menu"
ScreenGui.Parent = PlayerGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "Connection_Label"
TextLabel.Parent = ScreenGui
TextLabel.AnchorPoint = Vector2.new(1, 1)
TextLabel.Position = UDim2.new(1, -200, 1, -850)
TextLabel.Size = UDim2.new(0, 150, 0, 50)
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BackgroundTransparency = 0.5
TextLabel.BorderSizePixel = 0
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "Loading..."

local Stats = game:GetService("Stats") or cloneref(game:GetService("Stats"))
getgenv().Ping_Statistics = true

local GetPing = function()
    return math.floor(Stats.PerformanceStats.Ping:GetValue())
end

task.spawn(function()
    while getgenv().Ping_Statistics do
        task.wait(1)
        local ping = GetPing()
        local status = ""

        if ping > 1000 then
            status = " [Lagging.]"
        elseif ping > 500 then
            status = " [Spiking.]"
        end

        TextLabel.Text = ping .. " ms" .. status
    end
end)
