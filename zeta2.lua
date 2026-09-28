--========================================================--
-- ZETA HUB V4
-- VISUALS / AIMBOT / WH / HEALTH / TRAIL / RED SKY
-- LocalScript
--========================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--========================================================--
-- CONFIG
--========================================================--

local Config = {
	WH = false,
	Trail = false,
	RedSky = false,

	Aimbot = false,
	TriggerBot = false,

	Box = true,
	Skeleton = true,
	Nickname = true,
	Health = true,

	WHColor = Color3.fromRGB(255,55,65),
	TrailColor = Color3.fromRGB(255,55,65),

	TrailLifetime = 1.15
}

--========================================================--
-- THEME
--========================================================--

local Theme = {
	BG = Color3.fromRGB(7,6,10),
	Sidebar = Color3.fromRGB(12,10,16),

	Card = Color3.fromRGB(17,14,22),
	Card2 = Color3.fromRGB(25,19,31),
	Card3 = Color3.fromRGB(34,25,41),

	Red = Color3.fromRGB(235,35,55),
	RedBright = Color3.fromRGB(255,55,70),

	Text = Color3.fromRGB(248,245,248),
	Muted = Color3.fromRGB(145,133,150),

	Off = Color3.fromRGB(43,33,47),
	White = Color3.fromRGB(255,255,255)
}

--========================================================--
-- COLORS
--========================================================--

local Colors = {
	{"White",Color3.fromRGB(255,255,255)},
	{"Red",Color3.fromRGB(255,50,50)},
	{"Neon Red",Color3.fromRGB(255,0,20)},
	{"Green",Color3.fromRGB(50,255,80)},
	{"Lime",Color3.fromRGB(170,255,40)},
	{"Blue",Color3.fromRGB(60,120,255)},
	{"Cyan",Color3.fromRGB(0,235,255)},
	{"Turquoise",Color3.fromRGB(0,255,190)},
	{"Yellow",Color3.fromRGB(255,240,50)},
	{"Gold",Color3.fromRGB(255,185,30)},
	{"Orange",Color3.fromRGB(255,120,20)},
	{"Purple",Color3.fromRGB(180,60,255)},
	{"Neon Purple",Color3.fromRGB(235,0,255)},
	{"Pink",Color3.fromRGB(255,70,180)},
	{"Magenta",Color3.fromRGB(255,0,170)},
	{"Coral",Color3.fromRGB(255,95,85)},
	{"Lavender",Color3.fromRGB(190,160,255)},
	{"Silver",Color3.fromRGB(195,200,210)}
}

--========================================================--
-- CLEAN
--========================================================--

local Old = PlayerGui:FindFirstChild("ZetaHub")

if Old then
	Old:Destroy()
end

--========================================================--
-- GUI
--========================================================--

local Gui = Instance.new("ScreenGui")
Gui.Name = "ZetaHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(920,555)
Main.Position = UDim2.new(.5,-460,.5,-277)
Main.BackgroundColor3 = Theme.BG
Main.BorderSizePixel = 0
Main.Parent = Gui

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,19)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(110,22,40)
MainStroke.Transparency = .18
MainStroke.Thickness = 1.5
MainStroke.Parent = Main

--========================================================--
-- TOP BAR
--========================================================--

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1,0,0,70)
Top.BackgroundTransparency = 1
Top.Parent = Main

local Logo = Instance.new("TextLabel")
Logo.Position = UDim2.fromOffset(28,11)
Logo.Size = UDim2.fromOffset(450,30)
Logo.BackgroundTransparency = 1
Logo.Text = "⚡ ZETA HUB"
Logo.Font = Enum.Font.GothamBlack
Logo.TextSize = 24
Logo.TextColor3 = Theme.RedBright
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = Top

local Subtitle = Instance.new("TextLabel")
Subtitle.Position = UDim2.fromOffset(30,41)
Subtitle.Size = UDim2.fromOffset(500,16)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "VISUAL CONTROL CENTER  •  PREMIUM"
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.TextSize = 9
Subtitle.TextColor3 = Theme.Muted
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Top

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(40,40)
Close.Position = UDim2.new(1,-55,0,15)
Close.BackgroundColor3 = Color3.fromRGB(65,18,28)
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 25
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
Sidebar.Position = UDim2.fromOffset(15,82)
Sidebar.Size = UDim2.fromOffset(180,455)
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
VisualButton.Size = UDim2.new(1,-24,0,46)
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
SettingsButton.Size = UDim2.new(1,-24,0,46)
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
-- AIMBOT SIDEBAR BUTTON
--========================================================--

local AimbotButton = Instance.new("TextButton")
AimbotButton.Position = UDim2.fromOffset(12,160)
AimbotButton.Size = UDim2.new(1,-24,0,46)
AimbotButton.BackgroundColor3 = Theme.Card2
AimbotButton.Text = "◎   AIMBOT"
AimbotButton.Font = Enum.Font.GothamBold
AimbotButton.TextSize = 12
AimbotButton.TextColor3 = Theme.Muted
AimbotButton.TextXAlignment = Enum.TextXAlignment.Left
AimbotButton.AutoButtonColor = false
AimbotButton.Parent = Sidebar

Instance.new("UIPadding",AimbotButton).PaddingLeft = UDim.new(0,15)
Instance.new("UICorner",AimbotButton).CornerRadius = UDim.new(0,9)

--========================================================--
-- CONTENT
--========================================================--

local Content = Instance.new("Frame")
Content.Position = UDim2.fromOffset(210,82)
Content.Size = UDim2.new(1,-225,1,-97)
Content.BackgroundTransparency = 1
Content.Parent = Main

--========================================================--
-- PREVIEW
--========================================================--

local PreviewCard = Instance.new("Frame")
PreviewCard.Size = UDim2.fromOffset(265,455)
PreviewCard.BackgroundColor3 = Theme.Card
PreviewCard.BorderSizePixel = 0
PreviewCard.Parent = Content

Instance.new("UICorner",PreviewCard).CornerRadius = UDim.new(0,15)

local PreviewTitle = Instance.new("TextLabel")
PreviewTitle.Position = UDim2.fromOffset(18,15)
PreviewTitle.Size = UDim2.fromOffset(220,18)
PreviewTitle.BackgroundTransparency = 1
PreviewTitle.Text = "PLAYER PREVIEW"
PreviewTitle.Font = Enum.Font.GothamBold
PreviewTitle.TextSize = 10
PreviewTitle.TextColor3 = Theme.Muted
PreviewTitle.TextXAlignment = Enum.TextXAlignment.Left
PreviewTitle.Parent = PreviewCard

local PreviewName = Instance.new("TextLabel")
PreviewName.Position = UDim2.fromOffset(18,36)
PreviewName.Size = UDim2.fromOffset(220,22)
PreviewName.BackgroundTransparency = 1
PreviewName.Text = "ZETA HUB"
PreviewName.Font = Enum.Font.GothamBlack
PreviewName.TextSize = 15
PreviewName.TextColor3 = Theme.Text
PreviewName.TextXAlignment = Enum.TextXAlignment.Left
PreviewName.Parent = PreviewCard

local Preview = Instance.new("Frame")
Preview.Position = UDim2.fromOffset(20,72)
Preview.Size = UDim2.fromOffset(225,360)
Preview.BackgroundColor3 = Color3.fromRGB(9,8,13)
Preview.BorderSizePixel = 0
Preview.ClipsDescendants = true
Preview.Parent = PreviewCard

Instance.new("UICorner",Preview).CornerRadius = UDim.new(0,13)

--========================================================--
-- PREVIEW CHARACTER
--========================================================--

local function Part(Name,Size,Position)

	local Object = Instance.new("Frame")

	Object.Name = Name
	Object.Size = Size
	Object.Position = Position
	Object.BackgroundColor3 = Config.WHColor
	Object.BorderSizePixel = 0
	Object.Parent = Preview

	return Object
end

local Head = Part(
	"Head",
	UDim2.fromOffset(46,46),
	UDim2.new(.5,-23,0,48)
)

Instance.new("UICorner",Head).CornerRadius = UDim.new(1,0)

local Body = Part(
	"Body",
	UDim2.fromOffset(55,108),
	UDim2.new(.5,-27,0,98)
)

Instance.new("UICorner",Body).CornerRadius = UDim.new(0,7)

local LeftArm = Part(
	"LeftArm",
	UDim2.fromOffset(14,92),
	UDim2.new(.5,-56,0,104)
)

Instance.new("UICorner",LeftArm).CornerRadius = UDim.new(0,6)

local RightArm = Part(
	"RightArm",
	UDim2.fromOffset(14,92),
	UDim2.new(.5,42,0,104)
)

Instance.new("UICorner",RightArm).CornerRadius = UDim.new(0,6)

local LeftLeg = Part(
	"LeftLeg",
	UDim2.fromOffset(17,103),
	UDim2.new(.5,-22,0,198)
)

Instance.new("UICorner",LeftLeg).CornerRadius = UDim.new(0,6)

local RightLeg = Part(
	"RightLeg",
	UDim2.fromOffset(17,103),
	UDim2.new(.5,5,0,198)
)

Instance.new("UICorner",RightLeg).CornerRadius = UDim.new(0,6)

local PreviewNick = Instance.new("TextLabel")
PreviewNick.Position = UDim2.fromOffset(5,13)
PreviewNick.Size = UDim2.new(1,-10,0,22)
PreviewNick.BackgroundTransparency = 1
PreviewNick.Text = "ZETA HUB"
PreviewNick.Font = Enum.Font.GothamBlack
PreviewNick.TextSize = 12
PreviewNick.TextColor3 = Config.WHColor
PreviewNick.Parent = Preview

--========================================================--
-- SMALL PREVIEW HP
--========================================================--

local PreviewHealthBack = Instance.new("Frame")
PreviewHealthBack.Size = UDim2.fromOffset(5,145)
PreviewHealthBack.Position = UDim2.fromOffset(15,110)
PreviewHealthBack.BackgroundColor3 = Color3.fromRGB(40,24,30)
PreviewHealthBack.BorderSizePixel = 0
PreviewHealthBack.Parent = Preview

Instance.new("UICorner",PreviewHealthBack).CornerRadius = UDim.new(1,0)

local PreviewHealth = Instance.new("Frame")
PreviewHealth.Size = UDim2.new(1,0,.85,0)
PreviewHealth.Position = UDim2.new(0,0,1,0)
PreviewHealth.AnchorPoint = Vector2.new(0,1)
PreviewHealth.BackgroundColor3 = Color3.fromRGB(55,255,90)
PreviewHealth.BorderSizePixel = 0
PreviewHealth.Parent = PreviewHealthBack

Instance.new("UICorner",PreviewHealth).CornerRadius = UDim.new(1,0)

local PreviewBox = Instance.new("Frame")
PreviewBox.Size = UDim2.fromOffset(145,292)
PreviewBox.Position = UDim2.new(.5,-72,0,38)
PreviewBox.BackgroundTransparency = 1
PreviewBox.BorderSizePixel = 0
PreviewBox.Parent = Preview

local PreviewBoxStroke = Instance.new("UIStroke")
PreviewBoxStroke.Color = Config.WHColor
PreviewBoxStroke.Thickness = 2
PreviewBoxStroke.Parent = PreviewBox

--========================================================--
-- PREVIEW UPDATE
--========================================================--

local function UpdatePreview()

	local Objects = {
		Head,
		Body,
		LeftArm,
		RightArm,
		LeftLeg,
		RightLeg
	}

	for _,Object in ipairs(Objects) do

		Object.BackgroundColor3 = Config.WHColor
		Object.BackgroundTransparency = Config.WH and 0 or .55

	end

	PreviewNick.TextColor3 = Config.WHColor
	PreviewBoxStroke.Color = Config.WHColor

	PreviewNick.Visible = Config.Nickname
	PreviewHealthBack.Visible = Config.Health
	PreviewBox.Visible = Config.Box
end

--========================================================--
-- CONTROL AREA
--========================================================--

local Controls = Instance.new("Frame")
Controls.Position = UDim2.fromOffset(280,0)
Controls.Size = UDim2.new(1,-280,1,0)
Controls.BackgroundTransparency = 1
Controls.Parent = Content

local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1,0,0,28)
Header.BackgroundTransparency = 1
Header.Text = "VISUALS"
Header.Font = Enum.Font.GothamBlack
Header.TextSize = 18
Header.TextColor3 = Theme.Text
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = Controls

local Description = Instance.new("TextLabel")
Description.Position = UDim2.fromOffset(0,27)
Description.Size = UDim2.new(1,0,0,18)
Description.BackgroundTransparency = 1
Description.Text = "Control your visual effects"
Description.Font = Enum.Font.Gotham
Description.TextSize = 10
Description.TextColor3 = Theme.Muted
Description.TextXAlignment = Enum.TextXAlignment.Left
Description.Parent = Controls

--========================================================--
-- BUTTON CREATOR
--========================================================--

local function CreateButton(Text,PositionY)

	local Button = Instance.new("TextButton")

	Button.Position = UDim2.fromOffset(0,PositionY)
	Button.Size = UDim2.new(1,-58,0,48)
	Button.BackgroundColor3 = Theme.Off
	Button.Text = Text
	Button.Font = Enum.Font.GothamBold
	Button.TextSize = 11
	Button.TextColor3 = Theme.Muted
	Button.TextXAlignment = Enum.TextXAlignment.Left
	Button.AutoButtonColor = false
	Button.Parent = Controls

	Instance.new("UIPadding",Button).PaddingLeft = UDim.new(0,16)
	Instance.new("UICorner",Button).CornerRadius = UDim.new(0,10)

	return Button
end

local function CreateGear(PositionY)

	local Gear = Instance.new("TextButton")

	Gear.Position = UDim2.new(1,-48,0,PositionY)
	Gear.Size = UDim2.fromOffset(48,48)
	Gear.BackgroundColor3 = Theme.Card2
	Gear.Text = "⚙"
	Gear.Font = Enum.Font.GothamBold
	Gear.TextSize = 18
	Gear.TextColor3 = Theme.Text
	Gear.AutoButtonColor = false
	Gear.Parent = Controls

	Instance.new("UICorner",Gear).CornerRadius = UDim.new(0,10)

	return Gear
end

--========================================================--
-- WH / TRAIL / SKY BUTTONS
--========================================================--

local WHButton = CreateButton(
	"◈   WALLHACK  •  OFF",
	58
)

local WHGear = CreateGear(58)

local TrailButton = CreateButton(
	"✦   TRAIL  •  OFF",
	118
)

local TrailGear = CreateGear(118)

local SkyButton = Instance.new("TextButton")
SkyButton.Position = UDim2.fromOffset(0,178)
SkyButton.Size = UDim2.new(1,0,0,48)
SkyButton.BackgroundColor3 = Theme.Off
SkyButton.Text = "☾   RED SKY  •  OFF"
SkyButton.Font = Enum.Font.GothamBold
SkyButton.TextSize = 11
SkyButton.TextColor3 = Theme.Muted
SkyButton.TextXAlignment = Enum.TextXAlignment.Left
SkyButton.AutoButtonColor = false
SkyButton.Parent = Controls

Instance.new("UIPadding",SkyButton).PaddingLeft = UDim.new(0,16)
Instance.new("UICorner",SkyButton).CornerRadius = UDim.new(0,10)

--========================================================--
-- PANELS
--========================================================--

local WHPanel = Instance.new("Frame")
WHPanel.Position = UDim2.fromOffset(0,236)
WHPanel.Size = UDim2.new(1,0,0,165)
WHPanel.BackgroundColor3 = Theme.Card
WHPanel.BorderSizePixel = 0
WHPanel.Visible = false
WHPanel.Parent = Controls

Instance.new("UICorner",WHPanel).CornerRadius = UDim.new(0,12)

local WHPanelTitle = Instance.new("TextLabel")
WHPanelTitle.Position = UDim2.fromOffset(14,10)
WHPanelTitle.Size = UDim2.new(1,-28,0,20)
WHPanelTitle.BackgroundTransparency = 1
WHPanelTitle.Text = "WALLHACK SETTINGS"
WHPanelTitle.Font = Enum.Font.GothamBold
WHPanelTitle.TextSize = 10
WHPanelTitle.TextColor3 = Theme.Muted
WHPanelTitle.TextXAlignment = Enum.TextXAlignment.Left
WHPanelTitle.Parent = WHPanel

local TrailPanel = Instance.new("Frame")
TrailPanel.Position = UDim2.fromOffset(0,236)
TrailPanel.Size = UDim2.new(1,0,0,165)
TrailPanel.BackgroundColor3 = Theme.Card
TrailPanel.BorderSizePixel = 0
TrailPanel.Visible = false
TrailPanel.Parent = Controls

Instance.new("UICorner",TrailPanel).CornerRadius = UDim.new(0,12)

local TrailPanelTitle = Instance.new("TextLabel")
TrailPanelTitle.Position = UDim2.fromOffset(14,10)
TrailPanelTitle.Size = UDim2.new(1,-28,0,20)
TrailPanelTitle.BackgroundTransparency = 1
TrailPanelTitle.Text = "TRAIL SETTINGS"
TrailPanelTitle.Font = Enum.Font.GothamBold
TrailPanelTitle.TextSize = 10
TrailPanelTitle.TextColor3 = Theme.Muted
TrailPanelTitle.TextXAlignment = Enum.TextXAlignment.Left
TrailPanelTitle.Parent = TrailPanel

--========================================================--
-- COLOR PICKER
--========================================================--

local function CreateColorPicker(Parent,PositionY,Name,Default,Callback)

	local Button = Instance.new("TextButton")

	Button.Position = UDim2.fromOffset(14,PositionY)
	Button.Size = UDim2.new(1,-28,0,38)
	Button.BackgroundColor3 = Default
	Button.Text = Name.."   ▼"
	Button.Font = Enum.Font.GothamBold
	Button.TextSize = 10
	Button.TextColor3 = Theme.White
	Button.AutoButtonColor = false
	Button.Parent = Parent

	Instance.new("UICorner",Button).CornerRadius = UDim.new(0,8)

	local List = Instance.new("ScrollingFrame")

	List.Position = UDim2.fromOffset(14,PositionY+43)
	List.Size = UDim2.new(1,-28,0,105)
	List.BackgroundColor3 = Theme.Card3
	List.BorderSizePixel = 0
	List.ScrollBarThickness = 3
	List.Visible = false
	List.ZIndex = 50
	List.Parent = Parent

	Instance.new("UICorner",List).CornerRadius = UDim.new(0,8)

	local Grid = Instance.new("UIGridLayout")
	Grid.CellSize = UDim2.fromOffset(100,28)
	Grid.CellPadding = UDim2.fromOffset(4,4)
	Grid.Parent = List

	for _,Data in ipairs(Colors) do

		local ColorButton = Instance.new("TextButton")

		ColorButton.BackgroundColor3 = Data[2]
		ColorButton.Text = Data[1]
		ColorButton.Font = Enum.Font.GothamBold
		ColorButton.TextSize = 8
		ColorButton.TextColor3 = Theme.White
		ColorButton.AutoButtonColor = false
		ColorButton.ZIndex = 51
		ColorButton.Parent = List

		Instance.new("UICorner",ColorButton).CornerRadius = UDim.new(0,6)

		ColorButton.MouseButton1Click:Connect(function()

			Button.Text = Data[1].."   ▼"
			Button.BackgroundColor3 = Data[2]

			List.Visible = false

			Callback(Data[2])
		end)
	end

	Button.MouseButton1Click:Connect(function()
		List.Visible = not List.Visible
	end)
end

CreateColorPicker(
	WHPanel,
	40,
	"Red",
	Config.WHColor,
	function(Color)

		Config.WHColor = Color
		UpdatePreview()

	end
)

CreateColorPicker(
	TrailPanel,
	40,
	"Red",
	Config.TrailColor,
	function(Color)

		Config.TrailColor = Color

	end
)

--========================================================--
-- WH OPTIONS
--========================================================--

local function MakeToggle(Parent,Text,PositionY,Initial,Callback)

	local Row = Instance.new("Frame")

	Row.Position = UDim2.fromOffset(14,PositionY)
	Row.Size = UDim2.new(1,-28,0,32)
	Row.BackgroundColor3 = Theme.Card2
	Row.BorderSizePixel = 0
	Row.Parent = Parent

	Instance.new("UICorner",Row).CornerRadius = UDim.new(0,7)

	local Label = Instance.new("TextLabel")

	Label.Position = UDim2.fromOffset(10,0)
	Label.Size = UDim2.new(1,-55,1,0)
	Label.BackgroundTransparency = 1
	Label.Text = Text
	Label.Font = Enum.Font.GothamSemibold
	Label.TextSize = 9
	Label.TextColor3 = Theme.Text
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = Row

	local Toggle = Instance.new("TextButton")

	Toggle.Size = UDim2.fromOffset(34,18)
	Toggle.Position = UDim2.new(1,-44,.5,-9)
	Toggle.BackgroundColor3 = Initial and Theme.Red or Theme.Off
	Toggle.Text = ""
	Toggle.AutoButtonColor = false
	Toggle.Parent = Row

	Instance.new("UICorner",Toggle).CornerRadius = UDim.new(1,0)

	local Dot = Instance.new("Frame")

	Dot.Size = UDim2.fromOffset(12,12)
	Dot.Position = Initial
		and UDim2.new(1,-15,.5,-6)
		or UDim2.fromOffset(3,3)

	Dot.BackgroundColor3 = Theme.White
	Dot.Parent = Toggle

	Instance.new("UICorner",Dot).CornerRadius = UDim.new(1,0)

	local State = Initial

	Toggle.MouseButton1Click:Connect(function()

		State = not State

		TweenService:Create(
			Toggle,
			TweenInfo.new(.15),
			{
				BackgroundColor3 = State and Theme.Red or Theme.Off
			}
		):Play()

		TweenService:Create(
			Dot,
			TweenInfo.new(.15),
			{
				Position = State
					and UDim2.new(1,-15,.5,-6)
					or UDim2.fromOffset(3,3)
			}
		):Play()

		Callback(State)
	end)
end

MakeToggle(
	WHPanel,
	"Box",
	83,
	Config.Box,
	function(Value)

		Config.Box = Value
		UpdatePreview()

	end
)

MakeToggle(
	WHPanel,
	"Nickname",
	119,
	Config.Nickname,
	function(Value)

		Config.Nickname = Value
		UpdatePreview()

	end
)

--========================================================--
-- AIMBOT PAGE
--========================================================--

local AimbotPage = Instance.new("Frame")

AimbotPage.Position = UDim2.fromOffset(0,0)
AimbotPage.Size = UDim2.new(1,0,1,0)
AimbotPage.BackgroundColor3 = Theme.Card
AimbotPage.BorderSizePixel = 0
AimbotPage.Visible = false
AimbotPage.Parent = Controls

Instance.new("UICorner",AimbotPage).CornerRadius = UDim.new(0,15)

local AimbotTitle = Instance.new("TextLabel")
AimbotTitle.Position = UDim2.fromOffset(20,20)
AimbotTitle.Size = UDim2.new(1,-40,0,28)
AimbotTitle.BackgroundTransparency = 1
AimbotTitle.Text = "AIMBOT"
AimbotTitle.Font = Enum.Font.GothamBlack
AimbotTitle.TextSize = 18
AimbotTitle.TextColor3 = Theme.Text
AimbotTitle.TextXAlignment = Enum.TextXAlignment.Left
AimbotTitle.Parent = AimbotPage

local AimbotDescription = Instance.new("TextLabel")
AimbotDescription.Position = UDim2.fromOffset(20,48)
AimbotDescription.Size = UDim2.new(1,-40,0,20)
AimbotDescription.BackgroundTransparency = 1
AimbotDescription.Text = "Aimbot and trigger bot controls"
AimbotDescription.Font = Enum.Font.Gotham
AimbotDescription.TextSize = 10
AimbotDescription.TextColor3 = Theme.Muted
AimbotDescription.TextXAlignment = Enum.TextXAlignment.Left
AimbotDescription.Parent = AimbotPage

MakeToggle(
	AimbotPage,
	"Aimbot",
	90,
	false,
	function(Value)

		Config.Aimbot = Value

		--==================================================--
		-- AIMBOT — TWÓJ OSOBNY SKRYPT
		-- WSTAW GO TUTAJ
		--==================================================--

	end
)

MakeToggle(
	AimbotPage,
	"Trigger Bot",
	128,
	false,
	function(Value)

		Config.TriggerBot = Value

		--==================================================--
		-- TRIGGER BOT — TWÓJ OSOBNY SKRYPT
		-- WSTAW GO TUTAJ
		--==================================================--

	end
)

--========================================================--
-- AIMBOT SCRIPT — WSTAW SWÓJ OSOBNY SKRYPT TUTAJ
--========================================================--

-- TU WKLEJASZ SWÓJ SKRYPT AIMBOT


--========================================================--
-- TRIGGER BOT SCRIPT — WSTAW SWÓJ OSOBNY SKRYPT TUTAJ
--========================================================--

-- TU WKLEJASZ SWÓJ SKRYPT TRIGGER BOT


--========================================================--
-- PANEL OPEN / CLOSE
--========================================================--

WHGear.MouseButton1Click:Connect(function()

	WHPanel.Visible = not WHPanel.Visible
	TrailPanel.Visible = false

	WHGear.BackgroundColor3 =
		WHPanel.Visible and Theme.Red or Theme.Card2

	TrailGear.BackgroundColor3 = Theme.Card2
end)

TrailGear.MouseButton1Click:Connect(function()

	TrailPanel.Visible = not TrailPanel.Visible
	WHPanel.Visible = false

	TrailGear.BackgroundColor3 =
		TrailPanel.Visible and Theme.Red or Theme.Card2

	WHGear.BackgroundColor3 = Theme.Card2
end)

--========================================================--
-- WALLHACK
--========================================================--

local Highlights = {}

local function RemoveWH()

	for Target,Highlight in pairs(Highlights) do

		if Highlight then
			Highlight:Destroy()
		end

		Highlights[Target] = nil
	end
end

local function AddHighlight(Target)

	if Target == Player then
		return
	end

	if not Config.WH then
		return
	end

	local Character = Target.Character

	if not Character then
		return
	end

	local OldHighlight = Highlights[Target]

	if OldHighlight then
		OldHighlight:Destroy()
	end

	local Highlight = Instance.new("Highlight")

	Highlight.Name = "ZetaWH"
	Highlight.Adornee = Character
	Highlight.FillColor = Config.WHColor
	Highlight.OutlineColor = Config.WHColor
	Highlight.FillTransparency = .65
	Highlight.OutlineTransparency = 0
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.Parent = Character

	Highlights[Target] = Highlight
end

--========================================================--
-- HEALTH ESP
--========================================================--

local HealthESP = {}

local function RemoveHealth(Target)

	local Data = HealthESP[Target]

	if Data then

		if Data.Gui then
			Data.Gui:Destroy()
		end

		HealthESP[Target] = nil
	end
end

local function CreateHealth(Target)

	if Target == Player then
		return
	end

	if not Config.WH or not Config.Health then
		return
	end

	local Character = Target.Character

	if not Character then
		return
	end

	local Head = Character:FindFirstChild("Head")
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Head or not Humanoid then
		return
	end

	RemoveHealth(Target)

	local Billboard = Instance.new("BillboardGui")

	Billboard.Name = "ZetaHealth"
	Billboard.Adornee = Head
	Billboard.Size = UDim2.fromOffset(7,90)
	Billboard.StudsOffset = Vector3.new(-3.1,0,0)
	Billboard.AlwaysOnTop = true
	Billboard.MaxDistance = 10000
	Billboard.Parent = Head

	local Background = Instance.new("Frame")

	Background.Size = UDim2.fromScale(1,1)
	Background.BackgroundColor3 = Color3.fromRGB(30,18,22)
	Background.BorderSizePixel = 0
	Background.Parent = Billboard

	Instance.new("UICorner",Background).CornerRadius = UDim.new(1,0)

	local Fill = Instance.new("Frame")

	Fill.AnchorPoint = Vector2.new(0,1)
	Fill.Position = UDim2.fromScale(0,1)
	Fill.Size = UDim2.fromScale(1,1)
	Fill.BackgroundColor3 = Color3.fromRGB(50,255,80)
	Fill.BorderSizePixel = 0
	Fill.Parent = Background

	Instance.new("UICorner",Fill).CornerRadius = UDim.new(1,0)

	local Value = Instance.new("TextLabel")

	Value.Position = UDim2.new(0,10,0,-8)
	Value.Size = UDim2.fromOffset(45,18)
	Value.BackgroundTransparency = 1
	Value.Text = "100"
	Value.Font = Enum.Font.GothamBold
	Value.TextSize = 9
	Value.TextColor3 = Theme.White
	Value.TextStrokeTransparency = 0
	Value.TextStrokeColor3 = Color3.new(0,0,0)
	Value.Parent = Billboard

	HealthESP[Target] = {
		Gui = Billboard,
		Fill = Fill,
		Value = Value,
		Humanoid = Humanoid
	}
end

local function UpdateHealth(Data)

	if not Data then
		return
	end

	local Humanoid = Data.Humanoid

	if not Humanoid or not Humanoid.Parent then
		return
	end

	local Percent = math.clamp(
		Humanoid.Health / math.max(Humanoid.MaxHealth,1),
		0,
		1
	)

	Data.Fill.Size = UDim2.fromScale(1,Percent)
	Data.Value.Text = tostring(math.floor(Humanoid.Health))

	if Percent > .6 then

		Data.Fill.BackgroundColor3 =
			Color3.fromRGB(50,255,80)

	elseif Percent > .3 then

		Data.Fill.BackgroundColor3 =
			Color3.fromRGB(255,210,45)

	else

		Data.Fill.BackgroundColor3 =
			Color3.fromRGB(255,45,55)

	end
end

local function UpdateWH()

	RemoveWH()

	for Target in pairs(HealthESP) do
		RemoveHealth(Target)
	end

	if not Config.WH then
		return
	end

	for _,Target in ipairs(Players:GetPlayers()) do

		if Target ~= Player then

			AddHighlight(Target)
			CreateHealth(Target)

		end
	end
end

WHButton.MouseButton1Click:Connect(function()

	Config.WH = not Config.WH

	if Config.WH then

		WHButton.Text = "◈   WALLHACK  •  ON"
		WHButton.BackgroundColor3 = Theme.Red
		WHButton.TextColor3 = Theme.Text

	else

		WHButton.Text = "◈   WALLHACK  •  OFF"
		WHButton.BackgroundColor3 = Theme.Off
		WHButton.TextColor3 = Theme.Muted

	end

	UpdateWH()
end)

--========================================================--
-- PLAYER EVENTS
--========================================================--

local function SetupPlayer(Target)

	if Target == Player then
		return
	end

	Target.CharacterAdded:Connect(function()

		task.wait(.5)

		if Config.WH then

			AddHighlight(Target)
			CreateHealth(Target)

		end
	end)
end

for _,Target in ipairs(Players:GetPlayers()) do
	SetupPlayer(Target)
end

Players.PlayerAdded:Connect(SetupPlayer)

Players.PlayerRemoving:Connect(function(Target)

	RemoveHealth(Target)

	local Highlight = Highlights[Target]

	if Highlight then
		Highlight:Destroy()
	end

	Highlights[Target] = nil
end)

--========================================================--
-- TRAIL
--========================================================--

local TrailObjects = {}

local function RemoveTrail()

	for _,Object in ipairs(TrailObjects) do

		if Object and Object.Parent then
			Object:Destroy()
		end

	end

	table.clear(TrailObjects)
end

local function CreateTrail()

	RemoveTrail()

	if not Config.Trail then
		return
	end

	local Character = Player.Character

	if not Character then
		return
	end

	local Root = Character:FindFirstChild("HumanoidRootPart")

	if not Root then
		return
	end

	local A0 = Instance.new("Attachment")

	A0.Name = "ZetaTrailTop"
	A0.Position = Vector3.new(0,1.7,0)
	A0.Parent = Root

	local A1 = Instance.new("Attachment")

	A1.Name = "ZetaTrailBottom"
	A1.Position = Vector3.new(0,-1.7,0)
	A1.Parent = Root

	local Trail = Instance.new("Trail")

	Trail.Name = "ZetaTrail"
	Trail.Attachment0 = A0
	Trail.Attachment1 = A1
	Trail.Color = ColorSequence.new(Config.TrailColor)

	Trail.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0,0),
		NumberSequenceKeypoint.new(.7,.2),
		NumberSequenceKeypoint.new(1,1)
	})

	Trail.Lifetime = Config.TrailLifetime
	Trail.MinLength = .05
	Trail.FaceCamera = true
	Trail.LightEmission = 1
	Trail.Parent = Root

	table.insert(TrailObjects,A0)
	table.insert(TrailObjects,A1)
	table.insert(TrailObjects,Trail)
end

TrailButton.MouseButton1Click:Connect(function()

	Config.Trail = not Config.Trail

	if Config.Trail then

		TrailButton.Text = "✦   TRAIL  •  ON"
		TrailButton.BackgroundColor3 = Theme.Red
		TrailButton.TextColor3 = Theme.Text

		CreateTrail()

	else

		TrailButton.Text = "✦   TRAIL  •  OFF"
		TrailButton.BackgroundColor3 = Theme.Off
		TrailButton.TextColor3 = Theme.Muted

		RemoveTrail()

	end
end)

Player.CharacterRemoving:Connect(function()
	RemoveTrail()
end)

Player.CharacterAdded:Connect(function()

	task.wait(.5)

	if Config.Trail then
		CreateTrail()
	end
end)

--========================================================--
-- RED SKY
--========================================================--

local SkyObject
local ColorCorrection
local Atmosphere
local Bloom

local SavedLighting = {
	ClockTime = Lighting.ClockTime,
	Brightness = Lighting.Brightness,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	FogColor = Lighting.FogColor,
	FogEnd = Lighting.FogEnd
}

local SavedSkies = {}

for _,Object in ipairs(Lighting:GetChildren()) do

	if Object:IsA("Sky") then
		table.insert(SavedSkies,Object:Clone())
	end

end

local function RemoveAllSkies()

	for _,Object in ipairs(Lighting:GetChildren()) do

		if Object:IsA("Sky") then
			Object:Destroy()
		end

	end
end

local function EnableRedSky()

	Config.RedSky = true

	RemoveAllSkies()

	SkyObject = Instance.new("Sky")

	SkyObject.Name = "ZetaRedSky"

	SkyObject.SkyboxBk = "rbxassetid://159454299"
	SkyObject.SkyboxDn = "rbxassetid://159454296"
	SkyObject.SkyboxFt = "rbxassetid://159454293"
	SkyObject.SkyboxLf = "rbxassetid://159454286"
	SkyObject.SkyboxRt = "rbxassetid://159454300"
	SkyObject.SkyboxUp = "rbxassetid://159454288"

	SkyObject.CelestialBodiesShown = false
	SkyObject.StarCount = 12000
	SkyObject.MoonAngularSize = 18

	SkyObject.Parent = Lighting

	Lighting.ClockTime = 0
	Lighting.Brightness = 1.75

	Lighting.Ambient = Color3.fromRGB(
		50,
		28,
		95
	)

	Lighting.OutdoorAmbient = Color3.fromRGB(
		28,
		20,
		65
	)

	Lighting.FogColor = Color3.fromRGB(
		35,
		18,
		80
	)

	Lighting.FogEnd = 100000

	Atmosphere = Instance.new("Atmosphere")

	Atmosphere.Name = "ZetaAtmosphere"

	Atmosphere.Color = Color3.fromRGB(
		90,
		55,
		145
	)

	Atmosphere.Decay = Color3.fromRGB(
		35,
		10,
		75
	)

	Atmosphere.Density = .16
	Atmosphere.Offset = .15
	Atmosphere.Glare = .12
	Atmosphere.Haze = .55

	Atmosphere.Parent = Lighting

	ColorCorrection = Instance.new("ColorCorrectionEffect")

	ColorCorrection.Name = "ZetaColor"

	ColorCorrection.TintColor = Color3.fromRGB(
		205,
		145,
		255
	)

	ColorCorrection.Brightness = .05
	ColorCorrection.Contrast = .15
	ColorCorrection.Saturation = .22

	ColorCorrection.Parent = Lighting

	Bloom = Instance.new("BloomEffect")

	Bloom.Name = "ZetaBloom"

	Bloom.Intensity = .18
	Bloom.Size = 24
	Bloom.Threshold = 1.1

	Bloom.Parent = Lighting

	SkyButton.Text = "☾   RED SKY  •  ON"
	SkyButton.BackgroundColor3 = Theme.Red
	SkyButton.TextColor3 = Theme.Text
end

local function DisableRedSky()

	Config.RedSky = false

	if SkyObject then
		SkyObject:Destroy()
		SkyObject = nil
	end

	if ColorCorrection then
		ColorCorrection:Destroy()
		ColorCorrection = nil
	end

	if Atmosphere then
		Atmosphere:Destroy()
		Atmosphere = nil
	end

	if Bloom then
		Bloom:Destroy()
		Bloom = nil
	end

	RemoveAllSkies()

	for _,SavedSky in ipairs(SavedSkies) do
		SavedSky:Clone().Parent = Lighting
	end

	Lighting.ClockTime = SavedLighting.ClockTime
	Lighting.Brightness = SavedLighting.Brightness
	Lighting.Ambient = SavedLighting.Ambient
	Lighting.OutdoorAmbient = SavedLighting.OutdoorAmbient
	Lighting.FogColor = SavedLighting.FogColor
	Lighting.FogEnd = SavedLighting.FogEnd

	SkyButton.Text = "☾   RED SKY  •  OFF"
	SkyButton.BackgroundColor3 = Theme.Off
	SkyButton.TextColor3 = Theme.Muted
end

SkyButton.MouseButton1Click:Connect(function()

	if Config.RedSky then
		DisableRedSky()
	else
		EnableRedSky()
	end
end)

--========================================================--
-- SETTINGS PAGE
--========================================================--

local SettingsPage = Instance.new("Frame")

SettingsPage.Position = UDim2.fromOffset(0,0)
SettingsPage.Size = UDim2.new(1,0,1,0)
SettingsPage.BackgroundColor3 = Theme.Card
SettingsPage.BorderSizePixel = 0
SettingsPage.Visible = false
SettingsPage.Parent = Controls

Instance.new("UICorner",SettingsPage).CornerRadius = UDim.new(0,15)

local SettingsTitle = Instance.new("TextLabel")

SettingsTitle.Position = UDim2.fromOffset(20,20)
SettingsTitle.Size = UDim2.new(1,-40,0,28)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "SETTINGS"
SettingsTitle.Font = Enum.Font.GothamBlack
SettingsTitle.TextSize = 18
SettingsTitle.TextColor3 = Theme.Text
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsTitle.Parent = SettingsPage

local SettingsDescription = Instance.new("TextLabel")

SettingsDescription.Position = UDim2.fromOffset(20,48)
SettingsDescription.Size = UDim2.new(1,-40,0,20)
SettingsDescription.BackgroundTransparency = 1
SettingsDescription.Text = "Zeta Hub configuration"
SettingsDescription.Font = Enum.Font.Gotham
SettingsDescription.TextSize = 10
SettingsDescription.TextColor3 = Theme.Muted
SettingsDescription.TextXAlignment = Enum.TextXAlignment.Left
SettingsDescription.Parent = SettingsPage

local Info = Instance.new("TextLabel")

Info.Position = UDim2.fromOffset(20,90)
Info.Size = UDim2.new(1,-40,0,110)
Info.BackgroundColor3 = Theme.Card2
Info.BorderSizePixel = 0
Info.Text =
	"ZETA HUB V4\n\n" ..
	"RightShift  •  Show / Hide GUI\n\n" ..
	"WH and Trail have separate settings.\n" ..
	"Aimbot and Trigger Bot are separate scripts."

Info.Font = Enum.Font.GothamMedium
Info.TextSize = 11
Info.TextColor3 = Theme.Text
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.TextYAlignment = Enum.TextYAlignment.Top
Info.Parent = SettingsPage

Instance.new("UIPadding",Info).PaddingTop = UDim.new(0,15)
Instance.new("UIPadding",Info).PaddingLeft = UDim.new(0,15)
Instance.new("UICorner",Info).CornerRadius = UDim.new(0,10)

--========================================================--
-- PAGE SWITCHING
--========================================================--

local function ResetPages()

	SettingsPage.Visible = false
	AimbotPage.Visible = false
	PreviewCard.Visible = true

	Header.Visible = true
	Description.Visible = true

	VisualButton.BackgroundColor3 = Theme.Card2
	VisualButton.TextColor3 = Theme.Muted

	SettingsButton.BackgroundColor3 = Theme.Card2
	SettingsButton.TextColor3 = Theme.Muted

	AimbotButton.BackgroundColor3 = Theme.Card2
	AimbotButton.TextColor3 = Theme.Muted
end

local function ShowVisuals()

	ResetPages()

	VisualButton.BackgroundColor3 = Theme.Red
	VisualButton.TextColor3 = Theme.Text
end

local function ShowSettings()

	ResetPages()

	SettingsPage.Visible = true
	PreviewCard.Visible = false

	Header.Visible = false
	Description.Visible = false

	SettingsButton.BackgroundColor3 = Theme.Red
	SettingsButton.TextColor3 = Theme.Text
end

local function ShowAimbot()

	ResetPages()

	AimbotPage.Visible = true
	PreviewCard.Visible = false

	Header.Visible = false
	Description.Visible = false

	AimbotButton.BackgroundColor3 = Theme.Red
	AimbotButton.TextColor3 = Theme.Text
end

VisualButton.MouseButton1Click:Connect(ShowVisuals)
SettingsButton.MouseButton1Click:Connect(ShowSettings)
AimbotButton.MouseButton1Click:Connect(ShowAimbot)

--========================================================--
-- UPDATE LOOP
--========================================================--

RunService.Heartbeat:Connect(function()

	-- WH
	if Config.WH then

		for Target,Highlight in pairs(Highlights) do

			if Highlight and Highlight.Parent then

				Highlight.FillColor = Config.WHColor
				Highlight.OutlineColor = Config.WHColor

			end
		end

		for Target,Data in pairs(HealthESP) do

			if Data
				and Data.Gui
				and Data.Gui.Parent
				and Data.Humanoid
				and Data.Humanoid.Parent then

				UpdateHealth(Data)

			end
		end
	end

	-- Trail
	if Config.Trail then

		for _,Object in ipairs(TrailObjects) do

			if Object
				and Object:IsA("Trail")
				and Object.Parent then

				Object.Color =
					ColorSequence.new(Config.TrailColor)

			end
		end
	end
end)

--========================================================--
-- RIGHT SHIFT
--========================================================--

UserInputService.InputBegan:Connect(function(Input,Processed)

	if Processed then
		return
	end

	if Input.KeyCode == Enum.KeyCode.RightShift then
		Gui.Enabled = not Gui.Enabled
	end
end)

--========================================================--
-- START
--========================================================--

UpdatePreview()

print("[ZetaHub V4] Loaded successfully")
