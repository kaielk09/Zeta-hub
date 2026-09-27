local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

if game.CoreGui:FindFirstChild("ZetaHub") then
    game.CoreGui.ZetaHub:Destroy()
end

local Config = {
    Wallhack = false,
    ESPColor = Color3.fromRGB(255, 255, 255),
    SkeletonThickness = 2,
    ShowNicknames = false,
    ShowHealth = false,
    ShowBox = false,
    ShowChams = false,
    ShowSkeleton = true
}

local Themes = {
    Background = Color3.fromRGB(20, 20, 25),
    Sidebar = Color3.fromRGB(15, 15, 18),
    Accent = Color3.fromRGB(115, 75, 250),
    Text = Color3.fromRGB(240, 240, 245),
    TextMuted = Color3.fromRGB(140, 140, 150)
}

local ZetaHub = Instance.new("ScreenGui")
ZetaHub.Name = "ZetaHub"
ZetaHub.Parent = game.CoreGui
ZetaHub.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 680, 0, 420)
MainFrame.Position = UDim2.new(0.5, -340, 0.5, -210)
MainFrame.BackgroundColor3 = Themes.Background
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ZetaHub

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseBehavior or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 180, 1, 0)
Sidebar.BackgroundColor3 = Themes.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 60)
Title.Text = "⚡ ZETA HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Themes.Accent
Title.BackgroundTransparency = 1
Title.Parent = Sidebar

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 1, -80)
TabContainer.Position = UDim2.new(0, 10, 0, 60)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Sidebar

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 8)
TabLayout.Parent = TabContainer

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(250, 80, 80)
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0)}):Play()
    task.wait(0.3)
    ZetaHub:Destroy()
end)
local PagesContainer = Instance.new("Frame")
PagesContainer.Size = UDim2.new(1, -200, 1, -80)
PagesContainer.Position = UDim2.new(0, 190, 0, 60)
PagesContainer.BackgroundTransparency = 1
PagesContainer.Parent = MainFrame

local tabs = {}
local function CreateTab(name, id)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 40)
    TabBtn.BackgroundColor3 = Themes.Background
    TabBtn.Text = name
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextSize = 14
    TabBtn.TextColor3 = Themes.TextMuted
    TabBtn.Parent = TabContainer
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = TabBtn
    
    local Page = Instance.new("Frame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.Parent = PagesContainer
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            TweenService:Create(t.Btn, TweenInfo.new(0.2), {BackgroundColor3 = Themes.Background, TextColor3 = Themes.TextMuted}):Play()
            t.Page.Visible = false
        end
        TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Themes.Accent, TextColor3 = Themes.Text}):Play()
        Page.Visible = true
    end)
    
    tabs[id] = {Btn = TabBtn, Page = Page}
    return Page
end

local Page1 = CreateTab("1. Aimbot", "aimbot")
local Page2 = CreateTab("2. Visuals", "visuals")
local Page3 = CreateTab("3. Empty", "empty")

tabs["aimbot"].Btn.BackgroundColor3 = Themes.Accent
tabs["aimbot"].Btn.TextColor3 = Themes.Text
Page1.Visible = true

local aInfo = Instance.new("TextLabel")
aInfo.Size = UDim2.new(1,0,1,0)
aInfo.Text = "Aimbot Section - Coming Soon"
aInfo.Font = Enum.Font.Gotham
aInfo.TextColor3 = Themes.TextMuted
aInfo.BackgroundTransparency = 1
aInfo.Parent = Page1
local eInfo = Instance.new("TextLabel")
eInfo.Size = UDim2.new(1,0,1,0)
eInfo.Text = "Empty Section"
eInfo.Font = Enum.Font.Gotham
eInfo.TextColor3 = Themes.TextMuted
eInfo.BackgroundTransparency = 1
eInfo.Parent = Page3

local LeftPreview = Instance.new("Frame")
LeftPreview.Size = UDim2.new(0, 160, 1, 0)
LeftPreview.BackgroundColor3 = Themes.Sidebar
LeftPreview.Parent = Page2

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 8)
LeftCorner.Parent = LeftPreview

local PreviewTitle = Instance.new("TextLabel")
PreviewTitle.Size = UDim2.new(1, 0, 0, 30)
PreviewTitle.Text = "PODGLĄD"
PreviewTitle.Font = Enum.Font.GothamBold
PreviewTitle.TextSize = 12
PreviewTitle.TextColor3 = Themes.TextMuted
PreviewTitle.BackgroundTransparency = 1
PreviewTitle.Parent = LeftPreview

local PreviewBox = Instance.new("Frame")
PreviewBox.Size = UDim2.new(0, 120, 0, 220)
PreviewBox.Position = UDim2.new(0.5, -60, 0.5, -90)
PreviewBox.BackgroundTransparency = 1
PreviewBox.Parent = LeftPreview

local PHead = Instance.new("Frame")
PHead.Size = UDim2.new(0, 24, 0, 24)
PHead.Position = UDim2.new(0.5, -12, 0, 10)
PHead.Parent = PreviewBox
Instance.new("UICorner", PHead).CornerRadius = UDim.new(1, 0)

local PSpine = Instance.new("Frame")
PSpine.Position = UDim2.new(0.5, -2, 0, 34)
PSpine.Parent = PreviewBox

local PLeftArm = Instance.new("Frame")
PLeftArm.Position = UDim2.new(0.5, -25, 0, 36)
PLeftArm.Parent = PreviewBox

local PRightArm = Instance.new("Frame")
PRightArm.Position = UDim2.new(0.5, 21, 0, 36)
PRightArm.Parent = PreviewBox

local PLeftLeg = Instance.new("Frame")
PLeftLeg.Position = UDim2.new(0.5, -12, 0, 114)
PLeftLeg.Parent = PreviewBox
local PRightLeg = Instance.new("Frame")
PRightLeg.Position = UDim2.new(0.5, 8, 0, 114)
PRightLeg.Parent = PreviewBox

local PHealthBar = Instance.new("Frame")
PHealthBar.Size = UDim2.new(0, 5, 0, 180)
PHealthBar.Position = UDim2.new(0, -15, 0, 10)
PHealthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
PHealthBar.Visible = false
PHealthBar.Parent = PreviewBox

local PName = Instance.new("TextLabel")
PName.Size = UDim2.new(1, 0, 0, 20)
PName.Position = UDim2.new(0, 0, 0, -15)
PName.Text = "Player123"
PName.Font = Enum.Font.GothamBold
PName.TextSize = 12
PName.TextColor3 = Color3.new(1,1,1)
PName.BackgroundTransparency = 1
PName.Visible = false
PName.Parent = PreviewBox

local function UpdateLivePreview()
    local c = Config.Wallhack and Config.ESPColor or Color3.fromRGB(50,50,55)
    local thick = Config.SkeletonThickness
    PHead.BackgroundColor3 = c
    PSpine.BackgroundColor3 = c
    PLeftArm.BackgroundColor3 = c
    PRightArm.BackgroundColor3 = c
    PLeftLeg.BackgroundColor3 = c
    PRightLeg.BackgroundColor3 = c
    PSpine.Size = UDim2.new(0, thick, 0, 80)
    PLeftArm.Size = UDim2.new(0, thick, 0, 70)
    PRightArm.Size = UDim2.new(0, thick, 0, 70)
    PLeftLeg.Size = UDim2.new(0, thick, 0, 80)
    PRightLeg.Size = UDim2.new(0, thick, 0, 80)
    PHealthBar.Visible = (Config.Wallhack and Config.ShowHealth)
    PName.Visible = (Config.Wallhack and Config.ShowNicknames)
end

local RightOptions = Instance.new("ScrollingFrame")
RightOptions.Size = UDim2.new(1, -170, 1, 0)
RightOptions.Position = UDim2.new(0, 170, 0, 0)
RightOptions.BackgroundTransparency = 1
RightOptions.CanvasSize = UDim2.new(0, 0, 0, 450)
RightOptions.ScrollBarThickness = 2
RightOptions.Parent = Page2

local RightLayout = Instance.new("UIListLayout")
RightLayout.Padding = UDim.new(0, 12)
RightLayout.Parent = RightOptions
local WHRow = Instance.new("Frame")
WHRow.Size = UDim2.new(1, 0, 0, 40)
WHRow.BackgroundTransparency = 1
WHRow.Parent = RightOptions

local WHToggle = Instance.new("TextButton")
WHToggle.Size = UDim2.new(0, 120, 1, 0)
WHToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
WHToggle.Text = "Wallhack: OFF"
WHToggle.Font = Enum.Font.GothamBold
WHToggle.TextSize = 13
WHToggle.TextColor3 = Themes.TextMuted
WHToggle.Parent = WHRow
Instance.new("UICorner", WHToggle).CornerRadius = UDim.new(0, 6)

local GearBtn = Instance.new("TextButton")
GearBtn.Size = UDim2.new(0, 40, 0, 40)
GearBtn.Position = UDim2.new(0, 140, 0, 0)
GearBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
GearBtn.Text = "⚙️"
GearBtn.Font = Enum.Font.Gotham
GearBtn.TextSize = 16
GearBtn.TextColor3 = Themes.Text
GearBtn.Parent = WHRow
Instance.new("UICorner", GearBtn).CornerRadius = UDim.new(0, 6)

local ConfigPanel = Instance.new("Frame")
ConfigPanel.Size = UDim2.new(1, 0, 0, 0)
ConfigPanel.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
ConfigPanel.ClipsDescendants = true
ConfigPanel.Parent = RightOptions
local ConfigPanelCorner = Instance.new("UICorner")
ConfigPanelCorner.CornerRadius = UDim.new(0, 8)
ConfigPanelCorner.Parent = ConfigPanel

local ConfigLayout = Instance.new("UIListLayout")
ConfigLayout.Padding = UDim.new(0, 10)
ConfigLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ConfigLayout.VerticalAlignment = Enum.VerticalAlignment.Center
ConfigLayout.Parent = ConfigPanel

local ColorRow = Instance.new("Frame")
ColorRow.Size = UDim2.new(0, 260, 0, 30)
ColorRow.BackgroundTransparency = 1
ColorRow.Parent = ConfigPanel

local ColorLabel = Instance.new("TextLabel")
ColorLabel.Size = UDim2.new(0, 120, 1, 0)
ColorLabel.Text = "Kolor ESP:"
ColorLabel.Font = Enum.Font.Gotham
ColorLabel.TextSize = 13
ColorLabel.TextColor3 = Themes.Text
ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
ColorLabel.BackgroundTransparency = 1
ColorLabel.Parent = ColorRow
local ColorDropdown = Instance.new("TextButton")
ColorDropdown.Size = UDim2.new(0, 120, 1, 0)
ColorDropdown.Position = UDim2.new(0, 140, 0, 0)
ColorDropdown.BackgroundColor3 = Color3.new(1,1,1)
ColorDropdown.Text = "Biały 🤍"
ColorDropdown.Font = Enum.Font.GothamBold
ColorDropdown.TextSize = 12
ColorDropdown.TextColor3 = Color3.new(0,0,0)
ColorDropdown.Parent = ColorRow
Instance.new("UICorner", ColorDropdown).CornerRadius = UDim.new(0, 4)

local colorsList = {
    {Name = "Biały 🤍", Color = Color3.fromRGB(255,255,255)},
    {Name = "Czerwony ❤️", Color = Color3.fromRGB(255,70,70)},
    {Name = "Zielony 💚", Color = Color3.fromRGB(70,255,70)},
    {Name = "Niebieski 💙", Color = Color3.fromRGB(70,140,255)},
    {Name = "Żółty 💛", Color = Color3.fromRGB(255,255,70)},
    {Name = "Fioletowy 💜", Color = Color3.fromRGB(180,70,255)},
    {Name = "Różowy 💗", Color = Color3.fromRGB(255,105,180)},
    {Name = "Pomarańcz 🧡", Color = Color3.fromRGB(255,140,0)},
    {Name = "Błękitny 🩵", Color = Color3.fromRGB(0,238,255)},
    {Name = "Złoty 🔱", Color = Color3.fromRGB(212,175,55)}
}
local currentColorIndex = 1
ColorDropdown.MouseButton1Click:Connect(function()
    currentColorIndex = currentColorIndex + 1
    if currentColorIndex > #colorsList then currentColorIndex = 1 end
    local current = colorsList[currentColorIndex]
    Config.ESPColor = current.Color
    ColorDropdown.Text = current.Name
    ColorDropdown.BackgroundColor3 = current.Color
    ColorDropdown.TextColor3 = (current.Color.R + current.Color.G + current.Color.B) > 1.5 and Color3.new(0,0,0) or Color3.new(1,1,1)
    UpdateLivePreview()
end)

local ThickRow = Instance.new("Frame")
ThickRow.Size = UDim2.new(0, 260, 0, 30)
ThickRow.BackgroundTransparency = 1
ThickRow.Parent = ConfigPanel

local ThickLabel = Instance.new("TextLabel")
ThickLabel.Size = UDim2.new(0, 120, 1, 0)
ThickLabel.Text = "Grubość linii:"
ThickLabel.Font = Enum.Font.Gotham
ThickLabel.TextSize = 13
ThickLabel.TextColor3 = Themes.Text
ThickLabel.TextXAlignment = Enum.TextXAlignment.Left
ThickLabel.BackgroundTransparency = 1
ThickLabel.Parent = ThickRow
local ThickBtn = Instance.new("TextButton")
ThickBtn.Size = UDim2.new(0, 120, 1, 0)
ThickBtn.Position = UDim2.new(0, 140, 0, 0)
ThickBtn.BackgroundColor3 = Color3.fromRGB(45,45,50)
ThickBtn.Text = "2 px"
ThickBtn.Font = Enum.Font.GothamBold
ThickBtn.TextSize = 13
ThickBtn.TextColor3 = Themes.Text
ThickBtn.Parent = ThickRow
Instance.new("UICorner", ThickBtn).CornerRadius = UDim.new(0, 4)
ThickBtn.MouseButton1Click:Connect(function()
    if Config.SkeletonThickness == 2 then Config.SkeletonThickness = 4
    elseif Config.SkeletonThickness == 4 then Config.SkeletonThickness = 6
    else Config.SkeletonThickness = 2 end
    ThickBtn.Text = tostring(Config.SkeletonThickness).." px"
    UpdateLivePreview()
end)

local configOpen = false
GearBtn.MouseButton1Click:Connect(function()
    configOpen = not configOpen
    local targetSize = configOpen and UDim2.new(1, 0, 0, 90) or UDim2.new(1, 0, 0, 0)
    TweenService:Create(ConfigPanel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
end)

local ModeBtn = Instance.new("TextButton")
ModeBtn.Size = UDim2.new(0, 160, 0, 35)
ModeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ModeBtn.Text = "Tryb: Wszystko"
ModeBtn.Font = Enum.Font.Gotham
ModeBtn.TextSize = 13
ModeBtn.TextColor3 = Themes.Text
ModeBtn.Parent = RightOptions
Instance.new("UICorner", ModeBtn).CornerRadius = UDim.new(0, 6)
ModeBtn.MouseButton1Click:Connect(function()
    if Config.ShowSkeleton and not Config.ShowBox and not Config.ShowChams then
        Config.ShowSkeleton = false; Config.ShowBox = true; Config.ShowChams = false
        ModeBtn.Text = "Tryb: Kwadrat (Box)"
    elseif Config.ShowBox then
        Config.ShowSkeleton = false; Config.ShowBox = false; Config.ShowChams = true
        ModeBtn.Text = "Tryb: Postać (Chams)"
    elseif Config.ShowChams then
        Config.ShowSkeleton = true; Config.ShowBox = true; Config.ShowChams = false
        ModeBtn.Text = "Tryb: Wszystko"
    else
        Config.ShowSkeleton = true; Config.ShowBox = false; Config.ShowChams = false
        ModeBtn.Text = "Tryb: Szkielet"
    end
end)

local NickToggle = Instance.new("TextButton")
NickToggle.Size = UDim2.new(0, 160, 0, 35)
NickToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
NickToggle.Text = "1. Nickname: OFF"
NickToggle.Font = Enum.Font.Gotham
NickToggle.TextSize = 13
NickToggle.TextColor3 = Themes.TextMuted
NickToggle.Parent = RightOptions
Instance.new("UICorner", NickToggle).CornerRadius = UDim.new(0, 6)
NickToggle.MouseButton1Click:Connect(function()
    Config.ShowNicknames = not Config.ShowNicknames
    NickToggle.Text = Config.ShowNicknames and "1. Nickname: ON" or "1. Nickname: OFF"
    NickToggle.TextColor3 = Config.ShowNicknames and Themes.Text or Themes.TextMuted
    NickToggle.BackgroundColor3 = Config.ShowNicknames and Themes.Accent or Color3.fromRGB(40, 40, 45)
    UpdateLivePreview()
end)

local HealthToggle = Instance.new("TextButton")
HealthToggle.Size = UDim2.new(0, 160, 0, 35)
HealthToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
HealthToggle.Text = "2. Pasek Życia: OFF"
HealthToggle.Font = Enum.Font.Gotham
HealthToggle.TextSize = 13
HealthToggle.TextColor3 = Themes.TextMuted
HealthToggle.Parent = RightOptions
Instance.new("UICorner", HealthToggle).CornerRadius = UDim.new(0, 6)
HealthToggle.MouseButton1Click:Connect(function()
    Config.ShowHealth = not Config.ShowHealth
    HealthToggle.Text = Config.ShowHealth and "2. Pasek Życia: ON" or "2. Pasek Życia: OFF"
    HealthToggle.TextColor3 = Config.ShowHealth and Themes.Text or Themes.TextMuted
    HealthToggle.BackgroundColor3 = Config.ShowHealth and Themes.Accent or Color3.fromRGB(40, 40, 45)
    UpdateLivePreview()
end)

WHToggle.MouseButton1Click:Connect(function()
    Config.Wallhack = not Config.Wallhack
    WHToggle.Text = Config.Wallhack and "Wallhack: ON" or "Wallhack: OFF"
    WHToggle.TextColor3 = Config.Wallhack and Themes.Text or Themes.TextMuted
    WHToggle.BackgroundColor3 = Config.Wallhack and Themes.Accent or Color3.fromRGB(40, 40, 45)
    UpdateLivePreview()
end)

local cache = {}
local function createEspElements(plr)
    local s = {Lines = {}, Name = Drawing.new("Text"), HealthBar = Drawing.new("Line"), Box = Drawing.new("Square"), Highlight = nil}
    for i = 1, 9 do
        local l = Drawing.new("Line")
        l.Thickness = Config.SkeletonThickness
        l.Transparency = 1
        s.Lines[i] = l
    end
    s.Name.Size = 13; s.Name.Center = true; s.Name.Outline = true; s.Name.OutlineColor = Color3.new(0,0,0)
    s.HealthBar.Thickness = 2
    s.Box.Thickness = 2; s.Box.Filled = false
    pcall(function()
        if plr and plr.Character then
            local hl = Instance.new("Highlight")
            hl.Name = "ZetaChams"
            hl.Parent = game.CoreGui
            s.Highlight = hl
        end
    end)
    return s
end

local function removeEsp(plr)
    if cache[plr] then
        for _, line in pairs(cache[plr].Lines) do pcall(function() line:Remove() end) end
        pcall(function() cache[plr].Name:Remove() end)
        pcall(function() cache[plr].HealthBar:Remove() end)
        pcall(function() cache[plr].Box:Remove() end)
        pcall(function() if cache[plr].Highlight then cache[plr].Highlight:Destroy() end end)
        cache[plr] = nil
    end
end

RunService.RenderStepped:Connect(function()
    if not Config.Wallhack then
        for _, p in pairs(Players:GetPlayers()) do removeEsp(p) end
        return
    end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local char = plr.Character
            local hp, maxHp = 100, 100
            local hum = char and (char:FindFirstChildOfClass("Humanoid") or char:FindFirstChild("Health"))
            if hum then
                if hum:IsA("Humanoid") then hp, maxHp = hum.Health, hum.MaxHealth else hp = hum.Value end
            end
            if char and char:FindFirstChild("Head") and char:FindFirstChild("HumanoidRootPart") and hp > 0 then
                if not cache[plr] then cache[plr] = createEspElements(plr) end
                local esp = cache[plr]
                if esp.Highlight and esp.Highlight.Adornee ~= char then esp.Highlight.Adornee = char end
                if Config.ShowChams then
                    esp.Highlight.Enabled = true; esp.Highlight.FillColor = Config.ESPColor; esp.Highlight.OutlineColor = Config.ESPColor
                    esp.Highlight.FillTransparency = 0.5; esp.Highlight.OutlineTransparency = 0
                else
                    if esp.Highlight then esp.Highlight.Enabled = false end
                end
                local pos, onScreen = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
                if onScreen then
                    local headPos = Camera:WorldToViewportPoint(char.Head.Position)
                    local legPos = Camera:WorldToViewportPoint((char:FindFirstChild("LeftLowerLeg") or char:FindFirstChild("Left Leg") or char.HumanoidRootPart).Position)
                    local height = math.abs(headPos.Y - legPos.Y) + 10
                    local width = height / 1.5
                    if Config.ShowBox then
                        esp.Box.Size = Vector2.new(width, height)
                        esp.Box.Position = Vector2.new(pos.X - width/2, pos.Y - height/2)
                        esp.Box.Color = Config.ESPColor; esp.Box.Visible = true
                    else esp.Box.Visible = false end
                    local parts = {
                        Head = char.Head, UpperTorso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"),
                        LowerTorso = char:FindFirstChild("LowerTorso") or char:FindFirstChild("Torso"),
                        LeftUpperArm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm"),
                        LeftLowerArm = char:FindFirstChild("LeftLowerArm") or char:FindFirstChild("Left Arm"),
                        RightUpperArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm"),
                        RightLowerArm = char:FindFirstChild("RightLowerArm") or char:FindFirstChild("Right Arm"),
                        LeftUpperLeg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg"),
                        LeftLowerLeg = char:FindFirstChild("LeftLowerLeg") or char:FindFirstChild("Left Leg"),
                        RightUpperLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg"),
                        RightLowerLeg = char:FindFirstChild("RightLowerLeg") or char:FindFirstChild("Right Leg")
                    }
                    local coords = {}
                    local v = true
                    for name, part in pairs(parts) do
                        local pPos, pOn = Camera:WorldToViewportPoint(part.Position)
                        if not pOn then v = false break end
                        coords[name] = Vector2.new(pPos.X, pPos.Y)
                    end
                    if v and Config.ShowSkeleton then
                        for _, line in pairs(esp.Lines) do line.Color = Config.ESPColor; line.Thickness = Config.SkeletonThickness; line.Visible = true end
                        esp.Lines.From, esp.Lines.To = coords.Head, coords.UpperTorso
                        esp.Lines.From, esp.Lines.To = coords.UpperTorso, coords.LeftUpperArm
                        esp.Lines.From, esp.Lines.To = coords.LeftUpperArm, coords.LeftLowerArm
                        esp.Lines.From, esp.Lines.To = coords.UpperTorso, coords.RightUpperArm
                        esp.Lines.From, esp.Lines.To = coords.RightUpperArm, coords.RightLowerArm
                        esp.Lines.From, esp.Lines.To = coords.UpperTorso, coords.LowerTorso
                        esp.Lines.From, esp.Lines.To = coords.LowerTorso, coords.LeftUpperLeg
                    esp.Lines.From, esp.Lines.To = coords.LowerTorso, coords.RightUpperLeg
                    if coords.LeftLowerLeg and coords.RightLowerLeg then
                        esp.Lines.From, esp.Lines.To = coords.LeftUpperLeg, coords.LeftLowerLeg
                        esp.Lines.Visible = true
                    else 
                        esp.Lines.Visible = false 
                    end
                else
                    for _, line in pairs(esp.Lines) do line.Visible = false end
                end
                if Config.ShowNicknames then
                    esp.Name.Position = Vector2.new(pos.X, pos.Y - height/2 - 15)
                    esp.Name.Text = plr.Name
                    esp.Name.Color = Config.ESPColor
                    esp.Name.Visible = true
                else 
                    esp.Name.Visible = false 
                end
                if Config.ShowHealth then
                    local barHeight = height * (hp / maxHp)
                    esp.HealthBar.From = Vector2.new(pos.X - width/2 - 6, pos.Y + height/2)
                    esp.HealthBar.To = Vector2.new(pos.X - width/2 - 6, pos.Y + height/2 - barHeight)
                    esp.HealthBar.Color = Color3.fromRGB(255 - (2.55 * hp), 2.55 * hp, 0)
                    esp.HealthBar.Visible = true
                else 
                    esp.HealthBar.Visible = false 
                end
            else 
                removeEsp(plr) 
            end
        else 
            removeEsp(plr) 
        end
    end
end)
Players.PlayerRemoving:Connect(removeEsp)
UpdateLivePreview()
  
