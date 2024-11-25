local Players = game:GetService("Players") or cloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Section_Menu"
ScreenGui.Parent = PlayerGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "Time_Label"
TextLabel.Parent = ScreenGui
TextLabel.AnchorPoint = Vector2.new(1, 1)
TextLabel.Position = UDim2.new(1, -200, 1, -780)
TextLabel.Size = UDim2.new(0, 200, 0, 50)
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BackgroundTransparency = 0.5
TextLabel.BorderSizePixel = 0
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "Loading..."

local timeZones = {
    ["-1200"] = "AoE",
    ["-1100"] = "SST",
    ["-1000"] = "HST",
    ["-0930"] = "MART",
    ["-0900"] = "AKST",
    ["-0800"] = "PST",
    ["-0700"] = "MST",
    ["-0600"] = "CST",
    ["-0500"] = "EST",
    ["-0400"] = "AST",
    ["-0330"] = "NST",
    ["-0300"] = "BRT",
    ["-0200"] = "GST",
    ["-0100"] = "AZOST",
    ["+0000"] = "UTC",
    ["+0100"] = "CET",
    ["+0200"] = "EET",
    ["+0300"] = "MSK",
    ["+0330"] = "IRST",
    ["+0400"] = "GST",
    ["+0430"] = "AFT",
    ["+0500"] = "PKT",
    ["+0530"] = "IST",
    ["+0545"] = "NPT",
    ["+0600"] = "BST",
    ["+0630"] = "MMT",
    ["+0700"] = "ICT",
    ["+0800"] = "CST",
    ["+0845"] = "ACWST",
    ["+0900"] = "JST",
    ["+0930"] = "ACST",
    ["+1000"] = "AEST",
    ["+1030"] = "LHST",
    ["+1100"] = "SBT",
    ["+1200"] = "NZST",
    ["+1245"] = "CHAST",
    ["+1300"] = "PHOT",
    ["+1400"] = "LINT"
}

local function updateTime()
    getgenv().get_time_update = true
    while getgenv().get_time_update == true do
        local currentTime = os.time()
        local offset = os.date("%z", currentTime)
        local regionTimeZone = timeZones[offset] or "Unknown Time Zone"
        local formattedTime = os.date("%I:%M:%S %p", currentTime):gsub("^0", "")
        TextLabel.Text = string.format("%s (%s)", formattedTime, regionTimeZone)
        task.wait(1)
    end
end

task.spawn(updateTime)
task.wait(.1)
local Players = game:GetService("Players") or cloneref(game:GetService("Players"))
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PingDisplay"
ScreenGui.Parent = PlayerGui
ScreenGui.IgnoreGuiInSet = true
ScreenGui.ResetOnSpawn = false

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "PingLabel"
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

local lastPing = GetPing()
local frozenTime = 0
local frozenThreshold = 15

task.spawn(function()
    while getgenv().Ping_Statistics do
        task.wait(1)
        local ping = GetPing()
        local status = ""

        if ping == lastPing then
            frozenTime = frozenTime + 1
            if frozenTime >= frozenThreshold then
                status = " [Freezing.]"
            end
        else
            frozenTime = 0
        end

        if frozenTime < frozenThreshold then
            if ping > 1000 then
                status = " [Lagging.]"
            elseif ping > 500 then
                status = " [Spiking.]"
            end
        end

        TextLabel.Text = ping .. " ms" .. status
        lastPing = ping
    end
end)
