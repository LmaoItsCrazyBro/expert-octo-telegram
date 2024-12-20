local CoreGui
local Players
local RunService
local Stats

if cloneref then
    Players = cloneref(game:GetService("Players"))
    RunService = cloneref(game:GetService("RunService"))
    Stats = cloneref(game:GetService("Stats"))
else
    Players = game:GetService("Players")
    RunService = game:GetService("RunService")
    Stats = game:GetService("Stats")
end

task.wait(0.1)
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TopBarUI"
if get_hidden_gui or gethui then
    local hiddenUI = get_hidden_gui or gethui
    ScreenGui.Parent = hiddenUI()
else
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 150, 0, 30)
ToggleButton.Position = UDim2.new(1, -160, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.BorderSizePixel = 0
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextScaled = true
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "Toggle UI"

local UIContainer = Instance.new("Frame")
UIContainer.Name = "UIContainer"
UIContainer.Parent = ScreenGui
UIContainer.Size = UDim2.new(0, 700, 0, 30)
UIContainer.Position = UDim2.new(0.5, -350, 0, 0)
UIContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
UIContainer.BackgroundTransparency = 0.5
UIContainer.BorderSizePixel = 0
UIContainer.Visible = true

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Name = "TimeLabel"
TimeLabel.Parent = UIContainer
TimeLabel.Size = UDim2.new(0, 150, 1, 0)
TimeLabel.Position = UDim2.new(0, 0, 0, 0)
TimeLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TimeLabel.BackgroundTransparency = 1
TimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimeLabel.TextScaled = true
TimeLabel.Font = Enum.Font.SourceSansBold
TimeLabel.Text = "Loading..."

local PingLabel = Instance.new("TextLabel")
PingLabel.Name = "PingLabel"
PingLabel.Parent = UIContainer
PingLabel.Size = UDim2.new(0, 150, 1, 0)
PingLabel.Position = UDim2.new(0, 160, 0, 0)
PingLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
PingLabel.BackgroundTransparency = 1
PingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PingLabel.TextScaled = true
PingLabel.Font = Enum.Font.SourceSansBold
PingLabel.Text = "Loading..."

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Name = "FPSLabel"
FPSLabel.Parent = UIContainer
FPSLabel.Size = UDim2.new(0, 150, 1, 0)
FPSLabel.Position = UDim2.new(0, 320, 0, 0)
FPSLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FPSLabel.BackgroundTransparency = 1
FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FPSLabel.TextScaled = true
FPSLabel.Font = Enum.Font.SourceSansBold
FPSLabel.Text = "Loading..."

local ExecutorLabel = Instance.new("TextLabel")
ExecutorLabel.Name = "ExecutorLabel"
ExecutorLabel.Parent = UIContainer
ExecutorLabel.Size = UDim2.new(0, 200, 1, 0)
ExecutorLabel.Position = UDim2.new(0, 480, 0, 0)
ExecutorLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ExecutorLabel.BackgroundTransparency = 1
ExecutorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecutorLabel.TextScaled = true
ExecutorLabel.Font = Enum.Font.SourceSansBold
ExecutorLabel.Text = "Detecting Executor..."

local function detectExecutor()
    local executor = (identifyexecutor() or "Unknown"):lower()
    local executors = {
        wave = "Wave",
        xeno = "Xeno",
        fluxus = "Fluxus",
        synapse = "Synapse X",
        ["script-ware"] = "Script-Ware",
        krnl = "KRNL",
        solara = "Solara",
        jjsploit = "JJSploit",
        zorara = "Zorara",
        fluxteam = "FluxTeam",
        swift = "Swift",
    }
    for key, name in pairs(executors) do
        if executor:find(key) then
            return name
        end
    end
    return "Unknown Executor"
end

task.spawn(function()
    local executorName = detectExecutor()
    ExecutorLabel.Text = "Executor: " .. executorName
end)

local isUIVisible = true

ToggleButton.MouseButton1Click:Connect(function()
    isUIVisible = not isUIVisible
    UIContainer.Visible = isUIVisible
    ToggleButton.Text = isUIVisible and "Hide UI" or "Show UI"
end)

local timeZones = {
    ["-1200"] = "AoE", ["-1100"] = "SST", ["-1000"] = "HST", ["-0930"] = "MART",
    ["-0900"] = "AKST", ["-0800"] = "PST", ["-0700"] = "MST", ["-0600"] = "CST",
    ["-0500"] = "EST", ["-0400"] = "AST", ["-0330"] = "NST", ["-0300"] = "BRT",
    ["-0200"] = "GST", ["-0100"] = "AZOST", ["+0000"] = "UTC", ["+0100"] = "CET",
    ["+0200"] = "EET", ["+0300"] = "MSK", ["+0330"] = "IRST", ["+0400"] = "GST",
    ["+0430"] = "AFT", ["+0500"] = "PKT", ["+0530"] = "IST", ["+0545"] = "NPT",
    ["+0600"] = "BST", ["+0630"] = "MMT", ["+0700"] = "ICT", ["+0800"] = "CST",
    ["+0845"] = "ACWST", ["+0900"] = "JST", ["+0930"] = "ACST", ["+1000"] = "AEST",
    ["+1030"] = "LHST", ["+1100"] = "SBT", ["+1200"] = "NZST", ["+1245"] = "CHAST",
    ["+1300"] = "PHOT", ["+1400"] = "LINT"
}

local function updateTime()
    getgenv().tickingTime = true
    while getgenv().tickingTime == true do
        local currentTime = os.time()
        local offset = os.date("%z", currentTime)
        local regionTimeZone = timeZones[offset] or "Unknown Time Zone"
        local formattedTime = os.date("%I:%M:%S %p", currentTime):gsub("^0", "")
        TimeLabel.Text = string.format("%s (%s)", formattedTime, regionTimeZone)
        task.wait(1)
    end
end

task.spawn(updateTime)

local frameCount = 0
local timeElapsed = 0

RunService.Heartbeat:Connect(function(deltaTime)
    frameCount = frameCount + 1
    timeElapsed = timeElapsed + deltaTime
    if timeElapsed >= 1 then
        FPSLabel.Text = frameCount .. " FPS"
        frameCount = 0
        timeElapsed = 0
    end
end)

task.wait()

local function updatePing()
    getgenv().preserve_ping_tick = true
    while getgenv().preserve_ping_tick == true do
        local ping = math.floor(Stats.PerformanceStats.Ping:GetValue())
        PingLabel.Text = ping .. " ms"
        task.wait(0.3)
    end
end

task.spawn(updatePing)
