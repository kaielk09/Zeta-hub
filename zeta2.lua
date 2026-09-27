--========================================================--
-- ZETA HUB
-- VISUALS GUI / PLAYER PREVIEW / RED SKY
-- LocalScript
--========================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--========================================================--
-- CONFIG
--========================================================--

local Config = {
	WH = false,
	RedSky = false,

	Box = true,
	Skeleton = true,
	Nickname = true,
	Health = true,
	Chams = false,

	Color = Color3.fromRGB(255, 55, 65),
	Thickness = 2
}

local Theme = {
	BG = Color3.fromRGB(9, 7, 12),
	Sidebar = Color3.fromRGB(15, 11, 19),
	Card = Color3.fromRGB(20, 14, 25),
	Card2 = Color3.fromRGB(29, 19, 34),

	Red = Color3.fromRGB(235, 35, 55),
	Red2 = Color3.fromRGB(130, 18, 32),

	Text = Color3.fromRGB(245, 240, 245),
	Muted = Color3.fromRGB(150, 135, 155),
	Off = Color3.fromRGB(50, 35, 53)
}

--========================================================--
-- COLORS
--========================================================--

local Colors = {
	{"Biały", Color3.fromRGB(255,255,255)},
	{"Czerwony", Color3.fromRGB(255,50,50)},
	{"Neon Red", Color3.fromRGB(255,0,20)},
	{"Zielony", Color3.fromRGB(50,255,80)},
	{"Limonkowy", Color3.fromRGB(170,255,40)},
	{"Niebieski", Color3.fromRGB(60,120,255)},
	{"Błękitny", Color3.fromRGB(0,235,255)},
	{"Turkusowy", Color3.fromRGB(0,255,190)},
	{"Żółty", Color3.fromRGB(255,240,50)},
	{"Złoty", Color3.fromRGB(255,185,30)},
	{"Pomarańcz", Color3.fromRGB(255,120,20)},
	{"Fioletowy", Color3.fromRGB(180,60,255)},
	{"Neon Purple", Color3.fromRGB(235,0,255)},
	{"Różowy", Color3.fromRGB(255,70,180)},
	{"Magenta", Color3.fromRGB(255,0,170)},
	{"Koralowy", Color3.fromRGB(255,95,85)},
	{"Lawenda", Color3.fromRGB(190,160,255)},
	{"Srebrny", Color3.fromRGB(195,200,210)}
}

--========================================================--
-- CLEAN
--========================================================--

local Old = PlayerGui:FindFirstChild("ZetaHub")

if Old then
	Old:Destroy()
end

--========================================================--
-- MAIN GUI
--========================================================--

local Gui = Instance.new("ScreenGui")
Gui.Name = "ZetaHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(900,540)
Main.Position = UDim2.new(.5,-450,.5,-270)
Main.BackgroundColor3 = Theme.BG
Main.BorderSizePixel = 0
Main.Parent = Gui

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,20)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(105,25,40)
MainStroke.Transparency = .25
MainStroke.Thickness = 1.5
MainStroke.Parent = Main

--========================================================--
-- TOP BAR
--========================================================--

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1,0,0,68)
Top.BackgroundTransparency = 1
Top.Parent = Main

local Logo = Instance.new("TextLabel")
Logo.Position = UDim2.fromOffset(28,10)
Logo.Size = UDim2.fromOffset(400,30)
Logo.BackgroundTransparency = 1
Logo.Text = "⚡ ZETA HUB"
Logo.Font = Enum.Font.GothamBlack
Logo.TextSize = 23
Logo.TextColor3 = Theme.Red
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = Top

local Subtitle = Instance.new("TextLabel")
Subtitle.Position = UDim2.fromOffset(30,39)
Subtitle.Size = UDim2.fromOffset(400,16)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "VISUAL CONTROL CENTER  •  PREMIUM UI"
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.TextSize = 9
Subtitle.TextColor3 = Theme.Muted
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Top

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(38,38)
Close.Position = UDim2.new(1,-52,0,15)
Close.BackgroundColor3 = Color3.fromRGB(75,20,30)
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 24
Close.TextColor3 = Theme.Text
Close.AutoButtonColor = false
Close.Parent = Top

Instance.new("UICorner",Close).CornerRadius = UDim.new(0,10)

Close.MouseButton1Click:Connect(function()
	Gui:Destroy()
end)

--========================================================--
-- DRAG
--========================================================--

local Dragging = false
local DragStart
local StartPos

Top.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		Dragging = true
		DragStart = input.Position
		StartPos = Main.Position
	end
end)

Top.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		Dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

		local Delta = input.Position - DragStart

		Main.Position = UDim2.new(
			StartPos.X.Scale,
			StartPos.X.Offset + Delta.X,
			StartPos.Y.Scale,
			StartPos.Y.Offset + Delta.Y
		)
	end
end)

--========================================================--
-- SIDEBAR
--========================================================--

local Sidebar = Instance.new("Frame")
Sidebar.Position = UDim2.fromOffset(15,80)
Sidebar.Size = UDim2.fromOffset(175,445)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

Instance.new("UICorner",Sidebar).CornerRadius = UDim.new(0,15)

local MenuTitle = Instance.new("TextLabel")
MenuTitle.Position = UDim2.fromOffset(18,17)
MenuTitle.Size = UDim2.fromOffset(130,20)
MenuTitle.BackgroundTransparency = 1
MenuTitle.Text = "MENU"
MenuTitle.Font = Enum.Font.GothamBold
MenuTitle.TextSize = 10
MenuTitle.TextColor3 = Theme.Muted
MenuTitle.TextXAlignment = Enum.TextXAlignment.Left
MenuTitle.Parent = Sidebar

local VisualButton = Instance.new("TextButton")
VisualButton.Position = UDim2.fromOffset(12,52)
VisualButton.Size = UDim2.new(1,-24,0,45)
VisualButton.BackgroundColor3 = Theme.Red
VisualButton.Text = "◈   VISUALS"
VisualButton.Font = Enum.Font.GothamBold
VisualButton.TextSize = 12
VisualButton.TextColor3 = Theme.Text
VisualButton.TextXAlignment = Enum.TextXAlignment.Left
VisualButton.AutoButtonColor = false
VisualButton.Parent = Sidebar

Instance.new("UIPadding",VisualButton).PaddingLeft = UDim.new(0,15)
Instance.new("UICorner",VisualButton).CornerRadius = UDim.new(0,9)

local SettingsButton = Instance.new("TextButton")
SettingsButton.Position = UDim2.fromOffset(12,106)
SettingsButton.Size = UDim2.new(1,-24,0,45)
SettingsButton.BackgroundColor3 = Theme.Card2
SettingsButton.Text = "⚙   SETTINGS"
SettingsButton.Font = Enum.Font.GothamBold
SettingsButton.TextSize = 12
SettingsButton.TextColor3 = Theme.Muted
SettingsButton.TextXAlignment = Enum.TextXAlignment.Left
SettingsButton.AutoButtonColor = false
SettingsButton.Parent = Sidebar

Instance.new("UIPadding",SettingsButton).PaddingLeft = UDim.new(0,15)
Instance.new("UICorner",SettingsButton).CornerRadius = UDim.new(0,9)

--========================================================--
-- CONTENT
--========================================================--

local Content = Instance.new("Frame")
Content.Position = UDim2.fromOffset(205,80)
Content.Size = UDim2.new(1,-220,1,-95)
Content.BackgroundTransparency = 1
Content.Parent = Main

--========================================================--
-- PLAYER PREVIEW
--========================================================--

local PreviewCard = Instance.new("Frame")
PreviewCard.Size = UDim2.fromOffset(250,445)
PreviewCard.BackgroundColor3 = Theme.Card
PreviewCard.BorderSizePixel = 0
PreviewCard.Parent = Content

Instance.new("UICorner",PreviewCard).CornerRadius = UDim.new(0,15)

local PreviewTitle = Instance.new("TextLabel")
PreviewTitle.Position = UDim2.fromOffset(18,15)
PreviewTitle.Size = UDim2.fromOffset(210,20)
PreviewTitle.BackgroundTransparency = 1
PreviewTitle.Text = "PLAYER PREVIEW"
PreviewTitle.Font = Enum.Font.GothamBold
PreviewTitle.TextSize = 10
PreviewTitle.TextColor3 = Theme.Muted
PreviewTitle.TextXAlignment = Enum.TextXAlignment.Left
PreviewTitle.Parent = PreviewCard

local PlayerName = Instance.new("TextLabel")
PlayerName.Position = UDim2.fromOffset(18,36)
PlayerName.Size = UDim2.fromOffset(210,20)
PlayerName.BackgroundTransparency = 1
PlayerName.Text = "ZETA HUB"
PlayerName.Font = Enum.Font.GothamBlack
PlayerName.TextSize = 14
PlayerName.TextColor3 = Theme.Text
PlayerName.TextXAlignment = Enum.TextXAlignment.Left
PlayerName.Parent = PreviewCard

local Preview = Instance.new("Frame")
Preview.Position = UDim2.fromOffset(20,70)
Preview.Size = UDim2.fromOffset(210,350)
Preview.BackgroundColor3 = Color3.fromRGB(12,9,15)
Preview.BorderSizePixel = 0
Preview.Parent = PreviewCard

Instance.new("UICorner",Preview).CornerRadius = UDim.new(0,13)

--========================================================--
-- PREVIEW CHARACTER
--========================================================--

local function Part(name,size,pos,color)
	local p = Instance.new("Frame")
	p.Name = name
	p.Size = size
	p.Position = pos
	p.BackgroundColor3 = color
	p.BorderSizePixel = 0
	p.Parent = Preview
	return p
end

local Head = Part(
	"Head",
	UDim2.fromOffset(45,45),
	UDim2.new(.5,-22,0,45),
	Config.Color
)

Instance.new("UICorner",Head).CornerRadius = UDim.new(1,0)

local Body = Part(
	"Body",
	UDim2.fromOffset(52,105),
	UDim2.new(.5,-26,0,93),
	Config.Color
)

Instance.new("UICorner",Body).CornerRadius = UDim.new(0,7)

local LeftArm = Part(
	"LeftArm",
	UDim2.fromOffset(13,92),
	UDim2.new(.5,-52,0,100),
	Config.Color
)

Instance.new("UICorner",LeftArm).CornerRadius = UDim.new(0,6)

local RightArm = Part(
	"RightArm",
	UDim2.fromOffset(13,92),
	UDim2.new(.5,39,0,100),
	Config.Color
)

Instance.new("UICorner",RightArm).CornerRadius = UDim.new(0,6)

local LeftLeg = Part(
	"LeftLeg",
	UDim2.fromOffset(16,100),
	UDim2.new(.5,-21,0,195),
	Config.Color
)

Instance.new("UICorner",LeftLeg).CornerRadius = UDim.new(0,6)

local RightLeg = Part(
	"RightLeg",
	UDim2.fromOffset(16,100),
	UDim2.new(.5,5,0,195),
	Config.Color
)

Instance.new("UICorner",RightLeg).CornerRadius = UDim.new(0,6)

local PreviewNick = Instance.new("TextLabel")
PreviewNick.Position = UDim2.fromOffset(5,12)
PreviewNick.Size = UDim2.new(1,-10,0,22)
PreviewNick.BackgroundTransparency = 1
PreviewNick.Text = "ZETA HUB"
PreviewNick.Font = Enum.Font.GothamBlack
PreviewNick.TextSize = 12
PreviewNick.TextColor3 = Config.Color
PreviewNick.Parent = Preview

local HealthBack = Instance.new("Frame")
HealthBack.Size = UDim2.fromOffset(7,200)
HealthBack.Position = UDim2.fromOffset(15,100)
HealthBack.BackgroundColor3 = Color3.fromRGB(40,25,30)
HealthBack.BorderSizePixel = 0
HealthBack.Parent = Preview

Instance.new("UICorner",HealthBack).CornerRadius = UDim.new(1,0)

local Health = Instance.new("Frame")
Health.Size = UDim2.new(1,0,.85,0)
Health.Position = UDim2.new(0,0,1,0)
Health.AnchorPoint = Vector2.new(0,1)
Health.BackgroundColor3 = Color3.fromRGB(45,255,90)
Health.BorderSizePixel = 0
Health.Parent = HealthBack

Instance.new("UICorner",Health).CornerRadius = UDim.new(1,0)

local Box = Instance.new("Frame")
Box.Size = UDim2.fromOffset(130,285)
Box.Position = UDim2.new(.5,-65,0,35)
Box.BackgroundTransparency = 1
Box.BorderSizePixel = 0
Box.Parent = Preview

local BoxStroke = Instance.new("UIStroke")
BoxStroke.Color = Config.Color
BoxStroke.Thickness = 2
BoxStroke.Parent = Box

--========================================================--
-- PREVIEW UPDATE
--========================================================--

local function UpdatePreview()

	local objects = {
		Head,
		Body,
		LeftArm,
		RightArm,
		LeftLeg,
		RightLeg
	}

	for _,object in ipairs(objects) do
		object.BackgroundColor3 = Config.Color
	end

	PreviewNick.TextColor3 = Config.Color
	BoxStroke.Color = Config.Color

	PreviewNick.Visible = Config.Nickname
	HealthBack.Visible = Config.Health
	Box.Visible = Config.Box

	local transparency = Config.WH and 0 or .65

	for _,object in ipairs(objects) do
		object.BackgroundTransparency = transparency
	end
end

--========================================================--
-- CONTROL AREA
--========================================================--

local Controls = Instance.new("Frame")
Controls.Position = UDim2.fromOffset(265,0)
Controls.Size = UDim2.new(1,-265,1,0)
Controls.BackgroundTransparency = 1
Controls.Parent = Content

local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1,0,0,28)
Header.BackgroundTransparency = 1
Header.Text = "VISUALS"
Header.Font = Enum.Font.GothamBlack
Header.TextSize = 17
Header.TextColor3 = Theme.Text
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = Controls

local Description = Instance.new("TextLabel")
Description.Position = UDim2.fromOffset(0,25)
Description.Size = UDim2.new(1,0,0,20)
Description.BackgroundTransparency = 1
Description.Text = "Podgląd ustawień wizualnych"
Description.Font = Enum.Font.Gotham
Description.TextSize = 10
Description.TextColor3 = Theme.Muted
Description.TextXAlignment = Enum.TextXAlignment.Left
Description.Parent = Controls

--========================================================--
-- WH / GEAR / SKY
--========================================================--

local WH = Instance.new("TextButton")
WH.Position = UDim2.fromOffset(0,58)
WH.Size = UDim2.fromOffset(145,45)
WH.BackgroundColor3 = Theme.Off
WH.Text = "WH  •  OFF"
WH.Font = Enum.Font.GothamBold
WH.TextSize = 12
WH.TextColor3 = Theme.Muted
WH.AutoButtonColor = false
WH.Parent = Controls

Instance.new("UICorner",WH).CornerRadius = UDim.new(0,10)

local Gear = Instance.new("TextButton")
Gear.Position = UDim2.fromOffset(153,58)
Gear.Size = UDim2.fromOffset(45,45)
Gear.BackgroundColor3 = Theme.Card2
Gear.Text = "⚙"
Gear.Font = Enum.Font.GothamBold
Gear.TextSize = 19
Gear.TextColor3 = Theme.Text
Gear.AutoButtonColor = false
Gear.Parent = Controls

Instance.new("UICorner",Gear).CornerRadius = UDim.new(0,10)

local Sky = Instance.new("TextButton")
Sky.Position = UDim2.fromOffset(206,58)
Sky.Size = UDim2.fromOffset(150,45)
Sky.BackgroundColor3 = Theme.Off
Sky.Text = "☾  RED SKY"
Sky.Font = Enum.Font.GothamBold
Sky.TextSize = 11
Sky.TextColor3 = Theme.Muted
Sky.AutoButtonColor = false
Sky.Parent = Controls

Instance.new("UICorner",Sky).CornerRadius = UDim.new(0,10)

--========================================================--
-- OPTION PANEL
--========================================================--

local OptionPanel = Instance.new("ScrollingFrame")
OptionPanel.Position = UDim2.fromOffset(0,115)
OptionPanel.Size = UDim2.new(1,0,1,-115)
OptionPanel.BackgroundColor3 = Theme.Card
OptionPanel.BorderSizePixel = 0
OptionPanel.ScrollBarThickness = 3
OptionPanel.CanvasSize = UDim2.fromOffset(0,750)
OptionPanel.Visible = false
OptionPanel.Parent = Controls

Instance.new("UICorner",OptionPanel).CornerRadius = UDim.new(0,13)

local OptionPadding = Instance.new("UIPadding")
OptionPadding.PaddingTop = UDim.new(0,12)
OptionPadding.PaddingLeft = UDim.new(0,12)
OptionPadding.PaddingRight = UDim.new(0,12)
OptionPadding.Parent = OptionPanel

local OptionList = Instance.new("UIListLayout")
OptionList.Padding = UDim.new(0,8)
OptionList.Parent = OptionPanel

local function MakeToggle(text,initial,callback)

	local Row = Instance.new("Frame")
	Row.Size = UDim2.new(1,0,0,43)
	Row.BackgroundColor3 = Theme.Card2
	Row.BorderSizePixel = 0
	Row.Parent = OptionPanel

	Instance.new("UICorner",Row).CornerRadius = UDim.new(0,8)

	local Label = Instance.new("TextLabel")
	Label.Position = UDim2.fromOffset(12,0)
	Label.Size = UDim2.new(1,-75,1,0)
	Label.BackgroundTransparency = 1
	Label.Text = text
	Label.Font = Enum.Font.GothamSemibold
	Label.TextSize = 11
	Label.TextColor3 = Theme.Text
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = Row

	local Button = Instance.new("TextButton")
	Button.Size = UDim2.fromOffset(43,22)
	Button.Position = UDim2.new(1,-55,.5,-11)
	Button.BackgroundColor3 = initial and Theme.Red or Theme.Off
	Button.Text = ""
	Button.AutoButtonColor = false
	Button.Parent = Row

	Instance.new("UICorner",Button).CornerRadius = UDim.new(1,0)

	local Dot = Instance.new("Frame")
	Dot.Size = UDim2.fromOffset(16,16)
	Dot.Position = initial
		and UDim2.new(1,-19,.5,-8)
		or UDim2.fromOffset(3,3)
	Dot.BackgroundColor3 = Color3.new(1,1,1)
	Dot.Parent = Button

	Instance.new("UICorner",Dot).CornerRadius = UDim.new(1,0)

	local Value = initial

	Button.MouseButton1Click:Connect(function()

		Value = not Value

		TweenService:Create(
			Button,
			TweenInfo.new(.15),
			{
				BackgroundColor3 = Value and Theme.Red or Theme.Off
			}
		):Play()

		TweenService:Create(
			Dot,
			TweenInfo.new(.15),
			{
				Position = Value
					and UDim2.new(1,-19,.5,-8)
					or UDim2.fromOffset(3,3)
			}
		):Play()

		callback(Value)
	end)
end

MakeToggle("Box",Config.Box,function(v)
	Config.Box = v
	UpdatePreview()
end)

MakeToggle("Skeleton",Config.Skeleton,function(v)
	Config.Skeleton = v
	UpdatePreview()
end)

MakeToggle("Nickname",Config.Nickname,function(v)
	Config.Nickname = v
	UpdatePreview()
end)

MakeToggle("Health",Config.Health,function(v)
	Config.Health = v
	UpdatePreview()
end)

MakeToggle("Chams Preview",Config.Chams,function(v)
	Config.Chams = v
	UpdatePreview()
end)

--========================================================--
-- COLOR SELECTOR
--========================================================--

local ColorTitle = Instance.new("TextLabel")
ColorTitle.Size = UDim2.new(1,0,0,24)
ColorTitle.BackgroundTransparency = 1
ColorTitle.Text = "ESP COLOR"
ColorTitle.Font = Enum.Font.GothamBold
ColorTitle.TextSize = 10
ColorTitle.TextColor3 = Theme.Muted
ColorTitle.TextXAlignment = Enum.TextXAlignment.Left
ColorTitle.Parent = OptionPanel

local ColorButton = Instance.new("TextButton")
ColorButton.Size = UDim2.new(1,0,0,40)
ColorButton.BackgroundColor3 = Config.Color
ColorButton.Text = "Czerwony  ▼"
ColorButton.Font = Enum.Font.GothamBold
ColorButton.TextSize = 11
ColorButton.TextColor3 = Color3.new(1,1,1)
ColorButton.AutoButtonColor = false
ColorButton.Parent = OptionPanel

Instance.new("UICorner",ColorButton).CornerRadius = UDim.new(0,8)

local ColorList = Instance.new("ScrollingFrame")
ColorList.Size = UDim2.new(1,0,0,160)
ColorList.BackgroundColor3 = Theme.Card2
ColorList.BorderSizePixel = 0
ColorList.ScrollBarThickness = 3
ColorList.Visible = false
ColorList.Parent = OptionPanel

Instance.new("UICorner",ColorList).CornerRadius = UDim.new(0,8)

local Grid = Instance.new("UIGridLayout")
Grid.CellSize = UDim2.fromOffset(105,30)
Grid.CellPadding = UDim2.fromOffset(5,5)
Grid.Parent = ColorList

for _,data in ipairs(Colors) do

	local Button = Instance.new("TextButton")
	Button.BackgroundColor3 = data[2]
	Button.Text = data[1]
	Button.Font = Enum.Font.GothamBold
	Button.TextSize = 8
	Button.TextColor3 = Color3.new(1,1,1)
	Button.AutoButtonColor = false
	Button.Parent = ColorList

	Instance.new("UICorner",Button).CornerRadius = UDim.new(0,6)

	Button.MouseButton1Click:Connect(function()

		Config.Color = data[2]

		ColorButton.Text = data[1] .. "  ▼"
		ColorButton.BackgroundColor3 = data[2]

		ColorList.Visible = false

		UpdatePreview()
	end)
end

ColorButton.MouseButton1Click:Connect(function()
	ColorList.Visible = not ColorList.Visible
end)

--========================================================--
-- WH PREVIEW BUTTON
--========================================================--

WH.MouseButton1Click:Connect(function()

	Config.WH = not Config.WH

	if Config.WH then
		WH.Text = "WH  •  ON"
		WH.BackgroundColor3 = Theme.Red
		WH.TextColor3 = Theme.Text
	else
		WH.Text = "WH  •  OFF"
		WH.BackgroundColor3 = Theme.Off
		WH.TextColor3 = Theme.Muted
	end

	UpdatePreview()
end)

--========================================================--
-- RED SKY
--========================================================--

local OldClock = Lighting.ClockTime
local OldBrightness = Lighting.Brightness
local OldAmbient = Lighting.Ambient
local OldOutdoor = Lighting.OutdoorAmbient
local OldFogColor = Lighting.FogColor
local OldFogEnd = Lighting.FogEnd

local RedSkyObject

local function EnableRedSky()

	Config.RedSky = true

	Lighting.ClockTime = 0
	Lighting.Brightness = 1.5
	Lighting.Ambient = Color3.fromRGB(90,8,18)
	Lighting.OutdoorAmbient = Color3.fromRGB(70,5,12)
	Lighting.FogColor = Color3.fromRGB(120,8,20)
	Lighting.FogEnd = 100000

	if Lighting:FindFirstChild("ZetaRedSky") then
		Lighting.ZetaRedSky:Destroy()
	end

	RedSkyObject = Instance.new("Sky")
	RedSkyObject.Name = "ZetaRedSky"

	RedSkyObject.SkyboxBk = "rbxassetid://159454299"
	RedSkyObject.SkyboxDn = "rbxassetid://159454296"
	RedSkyObject.SkyboxFt = "rbxassetid://159454293"
	RedSkyObject.SkyboxLf = "rbxassetid://159454286"
	RedSkyObject.SkyboxRt = "rbxassetid://159454300"
	RedSkyObject.SkyboxUp = "rbxassetid://159454288"

	RedSkyObject.StarCount = 3000
	RedSkyObject.MoonAngularSize = 11
	RedSkyObject.CelestialBodiesShown = true
	RedSkyObject.Parent = Lighting

	Sky.Text = "☾  RED SKY  •  ON"
	Sky.BackgroundColor3 = Theme.Red
	Sky.TextColor3 = Theme.Text
end

local function DisableRedSky()

	Config.RedSky = false

	if RedSkyObject then
		RedSkyObject:Destroy()
		RedSkyObject = nil
	end

	Lighting.ClockTime = OldClock
	Lighting.Brightness = OldBrightness
	Lighting.Ambient = OldAmbient
	Lighting.OutdoorAmbient = OldOutdoor
	Lighting.FogColor = OldFogColor
	Lighting.FogEnd = OldFogEnd

	Sky.Text = "☾  RED SKY"
	Sky.BackgroundColor3 = Theme.Off
	Sky.TextColor3 = Theme.Muted
end

Sky.MouseButton1Click:Connect(function()

	if Config.RedSky then
		DisableRedSky()
	else
		EnableRedSky()
	end
end)

--========================================================--
-- GEAR
--========================================================--

Gear.MouseButton1Click:Connect(function()

	OptionPanel.Visible = not OptionPanel.Visible

	if OptionPanel.Visible then
		Gear.BackgroundColor3 = Theme.Red
	else
		Gear.BackgroundColor3 = Theme.Card2
	end
end)

--========================================================--
-- SETTINGS PAGE
--========================================================--

local function ShowVisuals()
	PreviewCard.Visible = true
	WH.Visible = true
	Gear.Visible = true
	Sky.Visible = true
	Header.Visible = true
	Description.Visible = true

	VisualButton.BackgroundColor3 = Theme.Red
	VisualButton.TextColor3 = Theme.Text

	SettingsButton.BackgroundColor3 = Theme.Card2
	SettingsButton.TextColor3 = Theme.Muted
end

local function ShowSettings()

	OptionPanel.Visible = false
	PreviewCard.Visible = false

	WH.Visible = false
	Gear.Visible = false
	Sky.Visible = false

	Header.Text = "SETTINGS"
	Description.Text = "Zeta Hub configuration"

	VisualButton.BackgroundColor3 = Theme.Card2
	VisualButton.TextColor3 = Theme.Muted

	SettingsButton.BackgroundColor3 = Theme.Red
	SettingsButton.TextColor3 = Theme.Text
end

VisualButton.MouseButton1Click:Connect(function()

	Header.Text = "VISUALS"
	Description.Text = "Podgląd ustawień wizualnych"

	ShowVisuals()
end)

SettingsButton.MouseButton1Click:Connect(function()
	ShowSettings()
end)

--========================================================--
-- RIGHT SHIFT
--========================================================--

UserInputService.InputBegan:Connect(function(input,processed)

	if processed then
		return
	end

	if input.KeyCode == Enum.KeyCode.RightShift then
		Gui.Enabled = not Gui.Enabled
	end
end)

--========================================================--
-- START
--========================================================--

UpdatePreview()

print("[ZetaHub] Loaded successfully")
