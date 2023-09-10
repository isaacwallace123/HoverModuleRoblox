local Player = game:GetService("Players").LocalPlayer
local Camera = game.Workspace.CurrentCamera
local Mouse = Player:GetMouse()

local Hover = script.Title:Clone()
Hover.Parent = _G.Main

local function Vanish()
	_G.Tween:Create(Hover, TweenInfo.new(0.125, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
	_G.Tween:Create(Hover.UIStroke, TweenInfo.new(0.125, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 1}):Play()
end

local function Appear()
	_G.Tween:Create(Hover, TweenInfo.new(0.125, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
	_G.Tween:Create(Hover.UIStroke, TweenInfo.new(0.125, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0}):Play()
end

local DefaultColors = {
	TextColor = Hover.TextColor3,
	TextGradient = Hover.UIGradient.Color,

	TextFont = Hover.FontFace,

	StrokeColor = Hover.UIStroke.Color,
	StrokeGradient = Hover.UIStroke.UIGradient.Color,
}

local List = {Hovering = false, Text = "Testing", HoverObject = Hover}

local function GetSide()
	local X, Y = Mouse.X, Mouse.Y
	local W = Camera.ViewportSize / 2

	local Angle = math.atan2(Y - W.Y, X - W.X)

	if Angle <= 1 and Angle >= -1 then
		return Enum.TextXAlignment.Right
	end
	
	return Enum.TextXAlignment.Left
end

local function GetOffset()
	local OffsetX = (List.HoverObject.Size.X.Offset / 2)
	local OffsetY = (List.HoverObject.Size.Y.Offset / 2)
	
	if GetSide() == Enum.TextXAlignment.Right then
		OffsetX = -OffsetX - 30
	end
	
	return OffsetX, OffsetY
end

function List.SetData(Data)
	List.Hovering = Data[1] or false
	List.Text = Data[2] or ""
	List.HoverObject = Data [4] or Hover
	
	_G.SetColors(Hover, Data[3] or DefaultColors)

	return Hover
end

function List.Run()
	if not List.HoverObject then return end
	if List.Hovering then Appear() else Vanish() end
	
	local OffsetX, OffsetY = GetOffset()
	
	List.HoverObject.Position = UDim2.fromOffset(Mouse.X + OffsetX, Mouse.Y + OffsetY)
	List.HoverObject.Text = List.Text or "Testing"
	List.HoverObject.TextXAlignment = GetSide() or Enum.TextXAlignment.Right
end

return List