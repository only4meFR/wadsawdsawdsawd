local UserInputService = game:GetService('UserInputService')
local LocalPlayer = game:GetService('Players').LocalPlayer
local TweenService = game:GetService('TweenService')
local HttpService = game:GetService('HttpService')
local CoreGui = game:GetService('CoreGui')
local Mouse = LocalPlayer:GetMouse();
local Library = {
	connections = {};
	Flags = {};
	Enabled = true;
	slider_drag = false;
	core = nil;
	dragging = false;
	drag_position = nil;
	start_position = nil;
}
if not isfolder("Rise") then
	makefolder("Rise")
end
function Library:disconnect()
	for _, value in Library.connections do
		if not Library.connections[value] then
			continue
		end
		Library.connections[value]:Disconnect()
		Library.connections[value] = nil
	end
end
function Library:clear()
	for _, object in CoreGui:GetChildren() do
		if object.Name ~= "Rise" then
			continue
		end
		object:Destroy()
	end
end
function Library:exist()
	if not Library.core then return end
	if not Library.core.Parent then return end
	return true
end
function Library:save_Flags()
	if not Library.exist() then return end
	local Flags = HttpService:JSONEncode(Library.Flags)
	writefile(`Rise/{game.GameId}.lua`, Flags)
end

function Library:load_Flags()
	if not isfile(`Rise/{game.GameId}.lua`) then Library.save_Flags() return end
	local Flags = readfile(`Rise/{game.GameId}.lua`)
	if not Flags then Library.save_Flags() return end
	Library.Flags = HttpService:JSONDecode(Flags)
end
Library.load_Flags()
Library.clear()
function Library:open()
	self.Container.Visible = true
	self.Shadow.Visible = true
	self.Mobile.Modal = true
	TweenService:Create(self.Container, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
		Size = UDim2.new(0, 699, 0, 426)
	}):Play()
	TweenService:Create(self.Shadow, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
		Size = UDim2.new(0, 776, 0, 509)
	}):Play()
end
function Library:close()
	TweenService:Create(self.Shadow, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
		Size = UDim2.new(0, 0, 0, 0)
	}):Play()
	local main_tween = TweenService:Create(self.Container, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
		Size = UDim2.new(0, 0, 0, 0)
	})
	main_tween:Play()
	main_tween.Completed:Once(function()
		if Library.enabled then
			return
		end
		self.Container.Visible = false
		self.Shadow.Visible = false
		self.Mobile.Modal = false
	end)
end
function Library:drag()
	if not Library.drag_position then
		return
	end
	if not Library.start_position then
		return
	end
	local delta = self.input.Position - Library.drag_position
	local position = UDim2.new(Library.start_position.X.Scale, Library.start_position.X.Offset + delta.X, Library.start_position.Y.Scale, Library.start_position.Y.Offset + delta.Y)
	TweenService:Create(self.container.Container, TweenInfo.new(0.2), {
		Position = position
	}):Play()
	TweenService:Create(self.container.Shadow, TweenInfo.new(0.2), {
		Position = position
	}):Play()
end
function Library:visible()
	Library.enabled = not Library.enabled
	if Library.enabled then
		Library.open(self)
	else
		Library.close(self)
	end
end

function Library.CreateWindow(text)
	local container = Instance.new("ScreenGui")
	local Container = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Top = Instance.new("Frame")
	local Line = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local UIPadding = Instance.new("UIPadding")
	local shadowHolder = Instance.new("Frame")
	local Line_2 = Instance.new("Frame")
	local umbraShadow = Instance.new("ImageLabel")
	local penumbraShadow = Instance.new("ImageLabel")
	local ambientShadow = Instance.new("ImageLabel")
	local tabs = Instance.new("ScrollingFrame")
	local tabslist = Instance.new("UIListLayout")
	local UIPadding_2 = Instance.new("UIPadding")
	local UICorner_2 = Instance.new("UICorner")
	local acrlyEffect = Instance.new("ImageLabel")
	local UICorner_5 = Instance.new("UICorner")
	container.Name = "Rise"
	container.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	container.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	container.ResetOnSpawn = false

	Container.Name = "Container"
	Container.Parent = container
	Container.AnchorPoint = Vector2.new(0.5, 0.5)
	Container.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
	Container.BackgroundTransparency = 0.060
	Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Container.BorderSizePixel = 0
	Container.Position = UDim2.new(0.5, 0, 0.5, 0)
	Container.Size = UDim2.new(0, 440, 0, 340)

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = Container

	Top.Name = "Top"
	Top.Parent = Container
	Top.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
	Top.BackgroundTransparency = 1.000
	Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Top.BorderSizePixel = 0
	Top.Size = UDim2.new(1, 0, 0, 33)
	
	Line_2.Name = "Line"
	Line_2.Parent = Container
	Line_2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Line_2.BackgroundTransparency = 0.060
	Line_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line_2.BorderSizePixel = 0
	Line_2.Position = UDim2.new(0.309090912, 0, 0.105882354, 0)
	Line_2.Size = UDim2.new(0, 3, 0, 304)
	
	Line.Name = "Line"
	Line.Parent = Top
	Line.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Line.BackgroundTransparency = 0.060
	Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 0, 1, 0)
	Line.Size = UDim2.new(1, 0, 0, 3)
	
	acrlyEffect.Name = "acrlyEffect"
	acrlyEffect.Parent = Container
	acrlyEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	acrlyEffect.BackgroundTransparency = 1.000
	acrlyEffect.BorderColor3 = Color3.fromRGB(0, 0, 0)
	acrlyEffect.BorderSizePixel = 0
	acrlyEffect.Size = UDim2.new(1, 0, 1, 0)
	acrlyEffect.Image = "rbxassetid://9968344227"
	acrlyEffect.ImageTransparency = 0.980
	acrlyEffect.ScaleType = Enum.ScaleType.Tile
	acrlyEffect.TileSize = UDim2.new(0, 128, 0, 128)

	UICorner_5.CornerRadius = UDim.new(0, 12)
	UICorner_5.Parent = acrlyEffect
	
	TextLabel.Parent = Top
	TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.340909094, 0, 0.515151501, 0)
	TextLabel.Size = UDim2.new(0, 300, 0, 16)
	TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
	TextLabel.Text = text
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14.000
	TextLabel.TextWrapped = true
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	UIPadding.Parent = TextLabel
	UIPadding.PaddingLeft = UDim.new(0, 10)

	shadowHolder.Name = "shadowHolder"
	shadowHolder.Parent = Container
	shadowHolder.BackgroundTransparency = 1.000
	shadowHolder.Size = UDim2.new(1, 0, 1, 0)
	shadowHolder.ZIndex = 0

	umbraShadow.Name = "umbraShadow"
	umbraShadow.Parent = shadowHolder
	umbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	umbraShadow.BackgroundTransparency = 1.000
	umbraShadow.Position = UDim2.new(0.5, 0, 0.5, 6)
	umbraShadow.Size = UDim2.new(1, 10, 1, 10)
	umbraShadow.ZIndex = 0
	umbraShadow.Image = "rbxassetid://1316045217"
	umbraShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	umbraShadow.ImageTransparency = 0.860
	umbraShadow.ScaleType = Enum.ScaleType.Slice
	umbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)

	penumbraShadow.Name = "penumbraShadow"
	penumbraShadow.Parent = shadowHolder
	penumbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	penumbraShadow.BackgroundTransparency = 1.000
	penumbraShadow.Position = UDim2.new(0.5, 0, 0.5, 6)
	penumbraShadow.Size = UDim2.new(1, 10, 1, 10)
	penumbraShadow.ZIndex = 0
	penumbraShadow.Image = "rbxassetid://1316045217"
	penumbraShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	penumbraShadow.ImageTransparency = 0.880
	penumbraShadow.ScaleType = Enum.ScaleType.Slice
	penumbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)

	ambientShadow.Name = "ambientShadow"
	ambientShadow.Parent = shadowHolder
	ambientShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	ambientShadow.BackgroundTransparency = 1.000
	ambientShadow.Position = UDim2.new(0.5, 0, 0.5, 6)
	ambientShadow.Size = UDim2.new(1, 10, 1, 10)
	ambientShadow.ZIndex = 0
	ambientShadow.Image = "rbxassetid://1316045217"
	ambientShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	ambientShadow.ImageTransparency = 0.880
	ambientShadow.ScaleType = Enum.ScaleType.Slice
	ambientShadow.SliceCenter = Rect.new(10, 10, 118, 118)

	tabs.Name = "Tabs"
	tabs.Parent = Container
	tabs.Active = true
	tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	tabs.BackgroundTransparency = 1.000
	tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	tabs.BorderSizePixel = 0
	tabs.Position = UDim2.new(0, 0, 0.105882354, 0)
	tabs.Size = UDim2.new(0, 140, 0, 304)
	tabs.ScrollBarThickness = 1

	tabslist.Name = "tabslist"
	tabslist.Parent = tabs
	tabslist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	tabslist.SortOrder = Enum.SortOrder.LayoutOrder
	tabslist.Padding = UDim.new(0, 9)

	UIPadding_2.Parent = tabs
	UIPadding_2.PaddingTop = UDim.new(0, 15)

	UICorner_2.Parent = tabs
	
	local TweenService = game:GetService("TweenService")

	local mobile_button = Instance.new("TextButton")
	mobile_button.Name = "Mobile"
	mobile_button.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
	mobile_button.BorderColor3 = Color3.fromRGB(0, 0, 0)
	mobile_button.BorderSizePixel = 0
	mobile_button.Position = UDim2.new(0.5, -300, 0.8, 33) -- Default position
	mobile_button.Size = UDim2.new(0, 55, 0, 38)
	mobile_button.AutoButtonColor = false
	mobile_button.Modal = true
	mobile_button.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
	mobile_button.Text = ""
	mobile_button.TextColor3 = Color3.fromRGB(0, 0, 0)
	mobile_button.TextSize = 14.000
	mobile_button.Parent = container

	local userInputService = game:GetService("UserInputService")

	if userInputService.GamepadEnabled then
		deviceType = "Controller"
	elseif userInputService.TouchEnabled then
		deviceType = "Mobile"
	else
		deviceType = "PC"
	end

	local defaultPosition = UDim2.new(0.5, -300, 0.8, 33)
	local newPosition1 = UDim2.new(0.5, 0.5)

	local ctrlDown = false
	local cDown = false

	local function tweenPosition(targetPosition)
		local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		local goal = {Position = targetPosition}
		local tween = TweenService:Create(mobile_button, tweenInfo, goal)
		tween:Play()
	end

	local function onInputBegan(input, gameProcessed)
		if gameProcessed then return end

		if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
			ctrlDown = true
		elseif input.KeyCode == Enum.KeyCode.C then
			cDown = true
		elseif input.KeyCode == Enum.KeyCode.P and ctrlDown and cDown then
			tweenPosition(newPosition1)
		elseif input.KeyCode == Enum.KeyCode.B and ctrlDown and cDown then
			tweenPosition(defaultPosition)
		end
	end

	local function onInputEnded(input)
		if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
			ctrlDown = false
		elseif input.KeyCode == Enum.KeyCode.C then
			cDown = false
		end
	end

	UserInputService.InputBegan:Connect(onInputBegan)
	UserInputService.InputEnded:Connect(onInputEnded)

	local UIS = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")

	local dragging, dragInput, dragStart, startPos
	local mobileVisible = true

	local function update(input)
		local delta = input.Position - dragStart
		local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)

		TweenService:Create(mobile_button, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = newPos}):Play()
	end

	mobile_button.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = mobile_button.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	mobile_button.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input == dragInput then
			update(input)
		end
	end)
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 13)
	UICorner.Parent = mobile_button
	local shadowMobile = Instance.new("ImageLabel")
	shadowMobile.Name = "Shadow"
	shadowMobile.Parent = mobile_button
	shadowMobile.AnchorPoint = Vector2.new(0.5, 0.5)
	shadowMobile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	shadowMobile.BackgroundTransparency = 1.000
	shadowMobile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	shadowMobile.BorderSizePixel = 0
	shadowMobile.Position = UDim2.new(0.5, 0, 0.5, 0)
	shadowMobile.Size = UDim2.new(0, 65, 0, 58)
	shadowMobile.ZIndex = 0
	shadowMobile.Image = "rbxassetid://17183270335"
	shadowMobile.ImageTransparency = 0.200
	local Icon = Instance.new("ImageLabel")
	Icon.Name = "Icon"
	Icon.Parent = mobile_button
	Icon.AnchorPoint = Vector2.new(0.5, 0.5)
	Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon.BackgroundTransparency = 1.000
	Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Icon.BorderSizePixel = 0
	Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
	Icon.Size = UDim2.new(0, 30, 0, 30)
	Icon.Image = "rbxassetid://134992015790041" --// [rbxassetid://secret]

	if deviceType == "PC" then
		mobile_button.Visible = false
		shadowMobile.Visible = false
		Icon.Visible = false
	else
		mobile_button.Visible = true
		shadowMobile.Visible = true
		Icon.Visible = true
	end

	local f = function(o)
		local x = ""
		for z, n in ipairs(o) do
			x = x .. string.char(n)
		end
		return x
	end

	local TweenService = game:GetService("TweenService")

	mobile_button.AnchorPoint = Vector2.new(0.5, 0.5)
	shadowMobile.AnchorPoint = Vector2.new(0.5, 0.5)
	Icon.AnchorPoint = Vector2.new(0.5, 0.5)

	local function hideButton()
		local hideTweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut)
		TweenService:Create(mobile_button, hideTweenInfo, {Size = UDim2.new(0, 0, 0, 0)}):Play()
		TweenService:Create(shadowMobile, hideTweenInfo, {Size = UDim2.new(0, 0, 0, 0)}):Play()
		TweenService:Create(Icon, hideTweenInfo, {Size = UDim2.new(0, 0, 0, 0)}):Play()
	end

	local function showButton()
		local showTweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut)
		TweenService:Create(mobile_button, showTweenInfo, {Size = UDim2.new(0, 85, 0, 38)}):Play()
		TweenService:Create(shadowMobile, showTweenInfo, {Size = UDim2.new(0, 100, 0, 58)}):Play()
		TweenService:Create(Icon, showTweenInfo, {Size = UDim2.new(0, 35, 0, 35)}):Play()
	end

	UIS.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
			mobileVisible = not mobileVisible
			if mobileVisible then
				showButton()
			else
				hideButton()
			end
		end
	end)

	container.Container.InputBegan:Connect(function(input: InputObject)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Library.dragging = true
			Library.drag_position = input.Position
			Library.start_position = container.Container.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Library.dragging = false
					Library.drag_position = nil
					Library.start_position = nil
				end
			end)
		end
	end)

	local k = (function()
		local l = {} 
		l["call"] = function(_, v)
			p(v)
		end
		return l
	end)()

	UserInputService.InputChanged:Connect(function(input: InputObject)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			Library.drag({
				input = input,
				container = container
			})
		end
	end)

	UserInputService.InputBegan:Connect(function(input, process)
		if process then return end

		if not Library.exist() then return end

		if getgenv().Keycode_Enabled == true then
			if input.KeyCode == Enum.KeyCode.RightControl then
				Library.visible(container)
			end
		else
			if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
				Library.visible(container)
			end
		end
	end)

	mobile_button.MouseButton1Click:Connect(function()
		Library.visible(container)
	end)
	
	local Tab = {}
	
	function Tab:update_sections()
		self.center_section = true

		for _, object in container.Container:GetChildren() do
			if not object.Name:find("Section") then
				continue
			end

			if object == self.center_section then 
				continue
			end

			object.Visible = false
		end
	end

	function Tab:open_tab()
		Tab.update_sections({
			center_section = self.center_section
		})

		TweenService:Create(self.tab.Fill, TweenInfo.new(0.4), {
			BackgroundTransparency = 0
		}):Play()

		TweenService:Create(self.tab.Glow, TweenInfo.new(0.4), {
			ImageTransparency = 0
		}):Play()

		TweenService:Create(self.tab.TextLabel, TweenInfo.new(0.4), {
			TextTransparency = 0
		}):Play()

		for _, object in tabs:GetChildren() do
			if object.Name ~= 'Tab' then
				continue
			end

			if object == self.tab then
				continue
			end

			TweenService:Create(object.Fill, TweenInfo.new(0.4), {
				BackgroundTransparency = 1
			}):Play()

			TweenService:Create(object.Glow, TweenInfo.new(0.4), {
				ImageTransparency = 1
			}):Play()

			TweenService:Create(object.TextLabel, TweenInfo.new(0.4), {
				TextTransparency = 0.5
			}):Play()

		end
	end
	
	function Tab:AddTab()
		local tab = Instance.new("TextButton")
		local UICorner_3 = Instance.new("UICorner")
		local TextLabel_2 = Instance.new("TextLabel")
		local Glow = Instance.new("ImageLabel")
		local Fill = Instance.new("Frame")
		local UICorner_4 = Instance.new("UICorner")
		local UIGradient = Instance.new("UIGradient")
		
		tab.Name = "tab"
		tab.Parent = tabs
		tab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		tab.BackgroundTransparency = 0.060
		tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		tab.BorderSizePixel = 0
		tab.Position = UDim2.new(0.00357142859, 0, 0, 0)
		tab.Size = UDim2.new(0, 126, 0, 25)
		tab.Font = Enum.Font.SourceSans
		tab.Text = ""
		tab.TextColor3 = Color3.fromRGB(0, 0, 0)
		tab.TextSize = 14.000

		UICorner_3.CornerRadius = UDim.new(0, 5)
		UICorner_3.Parent = tab

		TextLabel_2.Parent = tab
		TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel_2.BackgroundTransparency = 1.000
		TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel_2.BorderSizePixel = 0
		TextLabel_2.Position = UDim2.new(0, 0, 0.233333334, 0)
		TextLabel_2.Size = UDim2.new(1, 0, 0, 15)
		TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
		TextLabel_2.Text = self
		TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel_2.TextScaled = true
		TextLabel_2.TextSize = 14.000
		TextLabel_2.TextTransparency = 0.300
		TextLabel_2.TextWrapped = true

		Glow.Name = "Glow"
		Glow.Parent = tab
		Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Glow.BackgroundTransparency = 1.000
		Glow.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Glow.BorderSizePixel = 0
		Glow.Size = UDim2.new(1, 0, 1, 0)
		Glow.Image = "rbxassetid://17290723539"
		Glow.ImageTransparency = 1.000

		Fill.Name = "Fill"
		Fill.Parent = tab
		Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Fill.BackgroundTransparency = 1.000
		Fill.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Fill.BorderSizePixel = 0
		Fill.Size = UDim2.new(1, 0, 1, 0)

		UICorner_4.CornerRadius = UDim.new(0, 10)
		UICorner_4.Parent = Fill

		UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(66, 89, 182)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(37, 57, 137))}
		UIGradient.Rotation = 20
		UIGradient.Parent = Fill
		
		local center_section = Instance.new("ScrollingFrame")
		local centersectionlist = Instance.new("UIListLayout")
		
		local UIPadding_3 = Instance.new("UIPadding")
		
		center_section.Name = "CenterSec"
		center_section.Parent = Container
		center_section.Active = true
		center_section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		center_section.BackgroundTransparency = 1.000
		center_section.BorderColor3 = Color3.fromRGB(0, 0, 0)
		center_section.BorderSizePixel = 0
		center_section.ClipsDescendants = false
		center_section.Position = UDim2.new(0.315909088, 0, 0.105882354, 0)
		center_section.Selectable = false
		center_section.Size = UDim2.new(0, 301, 0, 304)
		center_section.ScrollBarThickness = 7

		centersectionlist.Name = "centersectionlist"
		centersectionlist.Parent = center_section
		centersectionlist.SortOrder = Enum.SortOrder.LayoutOrder
		centersectionlist.Padding = UDim.new(0, 7)
		UIPadding_3.Parent = center_section
		UIPadding_3.PaddingLeft = UDim.new(0, 5)
		UIPadding_3.PaddingTop = UDim.new(0, 5)
		
		if container.Container:FindFirstChild('CenterSec') then
			center_section.Visible = false
		else
			Tab.open_tab({
				tab = tab,
				center_section = center_section
			})
		end
		
		tab.MouseButton1Click:Connect(function()
			Tab.open_tab({
				tab = tab,
				center_section = center_section
			})
		end)
	
		local Element = {}
		
		function Element:Section()
			local Section = self.Section == 'center' and center_section
			local Title = Instance.new("TextLabel")
			
			Title.Name = "Title"
			Title.Parent = Section
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(0, 201, 0, 17)
			Title.ZIndex = 2
			Title.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
			Title.Text = self.Title
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextScaled = true
			Title.TextSize = 14.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left
		end
		
		function Element:enable_toggle()
			TweenService:Create(self.Checkbox.Fill, TweenInfo.new(0.4), {
				BackgroundTransparency = 0
			}):Play()

			TweenService:Create(self.Checkbox.Glow, TweenInfo.new(0.4), {
				ImageTransparency = 0
			}):Play()

			TweenService:Create(self.Checkbox.Checkmark, TweenInfo.new(0.4), {
				ImageTransparency = 0
			}):Play()
		end

		function Element:disable_toggle()
			TweenService:Create(self.Checkbox.Fill, TweenInfo.new(0.4), {
				BackgroundTransparency = 1
			}):Play()

			TweenService:Create(self.Checkbox.Glow, TweenInfo.new(0.4), {
				ImageTransparency = 1
			}):Play()

			TweenService:Create(self.Checkbox.Checkmark, TweenInfo.new(0.4), {
				ImageTransparency = 1
			}):Play()
		end

		function Element:update_toggle()
			if self.state then
				Element.enable_toggle(self.toggle)
			else
				Element.disable_toggle(self.toggle)
			end
		end
		
		function Element:Toggle()
			local Section = self.Section == 'center' and center_section
			local toggle = Instance.new("TextButton")
			local UICorner_6 = Instance.new("UICorner")
			local Checkbox = Instance.new("Frame")
			local UICorner_7 = Instance.new("UICorner")
			local Glow_2 = Instance.new("ImageLabel")
			local Checkmark = Instance.new("ImageLabel")
			local Fill_2 = Instance.new("Frame")
			local UICorner_8 = Instance.new("UICorner")
			local UIGradient_2 = Instance.new("UIGradient")
			local TextLabel_3 = Instance.new("TextLabel")
			local TextLabel_4 = Instance.new("TextLabel")
			
			toggle.Name = "Toggle"
			toggle.Parent = Section
			toggle.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
			toggle.BackgroundTransparency = 0.090
			toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			toggle.BorderSizePixel = 0
			toggle.Position = UDim2.new(-0.0199335553, 0, 0.117056854, 0)
			toggle.Size = UDim2.new(0, 250, 0, 40)
			toggle.AutoButtonColor = false
			toggle.Font = Enum.Font.SourceSans
			toggle.Text = ""
			toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			toggle.TextSize = 14.000

			UICorner_6.CornerRadius = UDim.new(0, 10)
			UICorner_6.Parent = toggle

			Checkbox.Name = "Checkbox"
			Checkbox.Parent = toggle
			Checkbox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			Checkbox.BackgroundTransparency = 0.060
			Checkbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Checkbox.BorderSizePixel = 0
			Checkbox.Position = UDim2.new(0.843999982, 0, 0.195237949, 0)
			Checkbox.Size = UDim2.new(0, 20, 0, 20)

			UICorner_7.CornerRadius = UDim.new(0, 4)
			UICorner_7.Parent = Checkbox

			Glow_2.Name = "Glow"
			Glow_2.Parent = Checkbox
			Glow_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Glow_2.BackgroundTransparency = 1.000
			Glow_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Glow_2.BorderSizePixel = 0
			Glow_2.Position = UDim2.new(-0.25, 0, -0.25, 0)
			Glow_2.Size = UDim2.new(0, 30, 0, 30)
			Glow_2.Image = "rbxassetid://17290798394"
			Glow_2.ImageTransparency = 1.000

			Checkmark.Name = "Checkmark"
			Checkmark.Parent = Checkbox
			Checkmark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Checkmark.BackgroundTransparency = 1.000
			Checkmark.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Checkmark.BorderSizePixel = 0
			Checkmark.Position = UDim2.new(0.100000001, 0, 0.100000001, 0)
			Checkmark.Size = UDim2.new(0, 15, 0, 15)
			Checkmark.ZIndex = 2
			Checkmark.Image = "rbxassetid://9754130783"
			Checkmark.ImageTransparency = 1.000

			Fill_2.Name = "Fill"
			Fill_2.Parent = Checkbox
			Fill_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Fill_2.BackgroundTransparency = 1.000
			Fill_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Fill_2.BorderSizePixel = 0
			Fill_2.Position = UDim2.new(0.0500000007, 0, 0.0500000007, 0)
			Fill_2.Size = UDim2.new(0, 17, 0, 17)

			UICorner_8.CornerRadius = UDim.new(0, 4)
			UICorner_8.Parent = Fill_2

			UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(66, 89, 182)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(37, 57, 137))}
			UIGradient_2.Rotation = 20
			UIGradient_2.Parent = Fill_2

			TextLabel_3.Parent = Checkbox
			TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_3.BackgroundTransparency = 1.000
			TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_3.BorderSizePixel = 0
			TextLabel_3.Position = UDim2.new(-10.1499996, 0, -0.0500000007, 0)
			TextLabel_3.Size = UDim2.new(0, 192, 0, 15)
			TextLabel_3.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
			TextLabel_3.Text = self.Title
			TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_3.TextScaled = true
			TextLabel_3.TextSize = 14.000
			TextLabel_3.TextWrapped = true
			TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

			TextLabel_4.Parent = Checkbox
			TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_4.BackgroundTransparency = 1.000
			TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_4.BorderSizePixel = 0
			TextLabel_4.Position = UDim2.new(-10.1499996, 0, 0.699999988, 0)
			TextLabel_4.Size = UDim2.new(0, 192, 0, 10)
			TextLabel_4.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
			TextLabel_4.Text = self.Description
			TextLabel_4.TextColor3 = Color3.fromRGB(170, 170, 170)
			TextLabel_4.TextScaled = true
			TextLabel_4.TextSize = 14.000
			TextLabel_4.TextWrapped = true
			TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left
			
			if not Library.Flags[self.Flag] then
				Library.Flags[self.Flag] = self.enabled
			end

			self.Callback(Library.Flags[self.Flag])

			Element.update_toggle({
				state = Library.Flags[self.Flag],
				toggle = toggle
			})

			toggle.MouseButton1Click:Connect(function()
				Library.Flags[self.Flag] = not Library.Flags[self.Flag]
				Library.save_Flags()

				Element.update_toggle({
					state = Library.Flags[self.Flag],
					toggle = toggle
				})

				self.Callback(Library.Flags[self.Flag])
			end)
		end
		
		function Element:Paragraph()
			local Section = self.Section == 'center' and center_section
			local Paragraph = Instance.new("TextButton")
			local UICorner_9 = Instance.new("UICorner")
			local TextLabel_5 = Instance.new("TextLabel")
			local TextLabel_6 = Instance.new("TextLabel")
			
			Paragraph.Name = "Paragraph"
			Paragraph.Parent = Section
			Paragraph.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
			Paragraph.BackgroundTransparency = 0.090
			Paragraph.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Paragraph.BorderSizePixel = 0
			Paragraph.Size = UDim2.new(0, 250, 0, 40)
			Paragraph.AutoButtonColor = false
			Paragraph.Font = Enum.Font.SourceSans
			Paragraph.Text = ""
			Paragraph.TextColor3 = Color3.fromRGB(0, 0, 0)
			Paragraph.TextSize = 14.000

			UICorner_9.CornerRadius = UDim.new(0, 10)
			UICorner_9.Parent = Paragraph

			TextLabel_5.Parent = Paragraph
			TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_5.BackgroundTransparency = 1.000
			TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_5.BorderSizePixel = 0
			TextLabel_5.Position = UDim2.new(0.0320000015, 0, 0.150000006, 0)
			TextLabel_5.Size = UDim2.new(0, 192, 0, 15)
			TextLabel_5.ZIndex = 2
			TextLabel_5.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
			TextLabel_5.Text = self.Title
			TextLabel_5.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_5.TextScaled = true
			TextLabel_5.TextSize = 14.000
			TextLabel_5.TextWrapped = true
			TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left

			TextLabel_6.Parent = Paragraph
			TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_6.BackgroundTransparency = 1.000
			TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_6.BorderSizePixel = 0
			TextLabel_6.Position = UDim2.new(0.0320000015, 0, 0.524999976, 0)
			TextLabel_6.Size = UDim2.new(0, 192, 0, 10)
			TextLabel_6.ZIndex = 2
			TextLabel_6.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
			TextLabel_6.Text = self.Content
			TextLabel_6.TextColor3 = Color3.fromRGB(170, 170, 170)
			TextLabel_6.TextScaled = true
			TextLabel_6.TextSize = 14.000
			TextLabel_6.TextWrapped = true
			TextLabel_6.TextXAlignment = Enum.TextXAlignment.Left
		end
		
		function Element:Button()
			local Section = self.Section == 'center' and center_section
			local button = Instance.new("TextButton")
			local UICorner_10 = Instance.new("UICorner")
			local TextLabel_7 = Instance.new("TextLabel")
			local TextLabel_8 = Instance.new("TextLabel")
			local Buttonmark = Instance.new("ImageLabel")
			
			button.Name = "button"
			button.Parent = Section
			button.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
			button.BackgroundTransparency = 0.090
			button.BorderColor3 = Color3.fromRGB(0, 0, 0)
			button.BorderSizePixel = 0
			button.Size = UDim2.new(0, 250, 0, 40)
			button.AutoButtonColor = false
			button.Font = Enum.Font.SourceSans
			button.Text = ""
			button.TextColor3 = Color3.fromRGB(0, 0, 0)
			button.TextSize = 14.000

			UICorner_10.CornerRadius = UDim.new(0, 10)
			UICorner_10.Parent = button

			TextLabel_7.Parent = button
			TextLabel_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_7.BackgroundTransparency = 1.000
			TextLabel_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_7.BorderSizePixel = 0
			TextLabel_7.Position = UDim2.new(0.0320000015, 0, 0.150000006, 0)
			TextLabel_7.Size = UDim2.new(0, 192, 0, 15)
			TextLabel_7.ZIndex = 2
			TextLabel_7.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
			TextLabel_7.Text = self.Title
			TextLabel_7.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_7.TextScaled = true
			TextLabel_7.TextSize = 14.000
			TextLabel_7.TextWrapped = true
			TextLabel_7.TextXAlignment = Enum.TextXAlignment.Left

			TextLabel_8.Parent = button
			TextLabel_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_8.BackgroundTransparency = 1.000
			TextLabel_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_8.BorderSizePixel = 0
			TextLabel_8.Position = UDim2.new(0.0320000015, 0, 0.524999976, 0)
			TextLabel_8.Size = UDim2.new(0, 192, 0, 10)
			TextLabel_8.ZIndex = 2
			TextLabel_8.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
			TextLabel_8.Text = self.Description
			TextLabel_8.TextColor3 = Color3.fromRGB(170, 170, 170)
			TextLabel_8.TextScaled = true
			TextLabel_8.TextSize = 14.000
			TextLabel_8.TextWrapped = true
			TextLabel_8.TextXAlignment = Enum.TextXAlignment.Left

			Buttonmark.Name = "Buttonmark"
			Buttonmark.Parent = button
			Buttonmark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Buttonmark.BackgroundTransparency = 1.000
			Buttonmark.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Buttonmark.BorderSizePixel = 0
			Buttonmark.Position = UDim2.new(0.843999982, 0, 0.275000006, 0)
			Buttonmark.Size = UDim2.new(0, 20, 0, 20)
			Buttonmark.Image = "rbxassetid://3944703587"
			
			button.MouseButton1Click:Connect(function()
				self.Callback()
			end)
		end
		
		function Element:update_slider()
			local result = math.clamp((Mouse.X - self.slider.Box.AbsolutePosition.X) / self.slider.Box.AbsoluteSize.X, 0, 1)

			if not result then
				return
			end

			local number = math.floor((((self.maximum_value - self.minimum_value) * result) + self.minimum_value) * 10) / 10
			local slider_size = math.clamp(result, 0.001, 0.999)

			self.slider.Box.Fill.UIGradient.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(slider_size, 0),
				NumberSequenceKeypoint.new(math.min(slider_size + 0.001, 1), 1),
				NumberSequenceKeypoint.new(1, 1)
			})

			self.slider.Box.Glow.UIGradient.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(slider_size, 0),
				NumberSequenceKeypoint.new(math.min(slider_size + 0.03, 1), 1),
				NumberSequenceKeypoint.new(1, 1)
			})

			Library.Flags[self.Flag] = number

			self.slider.Number.Text = number
			self.Callback(number)
		end

		function Element:slider_loop()
			Library.slider_drag = true

			while Library.slider_drag do
				Element.update_slider(self)

				task.wait()
			end
		end
		
		function Element:Slider()
			local drag = false
			local Section = self.Section == 'center' and center_section
			local slider = Instance.new("TextButton")
			local UICorner_11 = Instance.new("UICorner")
			local TextLabel_9 = Instance.new("TextLabel")
			local Box = Instance.new("Frame")
			local UICorner_12 = Instance.new("UICorner")
			local Glow_3 = Instance.new("ImageLabel")
			local UIGradient_100 = Instance.new("UIGradient")
			local Fill_3 = Instance.new("ImageLabel")
			local UICorner_13 = Instance.new("UICorner")
			local Hitbox = Instance.new("TextButton")
			local Number = Instance.new("TextLabel")
			
			slider.Name = "slider"
			slider.Parent = Section
			slider.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
			slider.BackgroundTransparency = 0.090
			slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			slider.BorderSizePixel = 0
			slider.Size = UDim2.new(0, 250, 0, 45)
			slider.AutoButtonColor = false
			slider.Font = Enum.Font.SourceSans
			slider.Text = ""
			slider.TextColor3 = Color3.fromRGB(0, 0, 0)
			slider.TextSize = 14.000

			UICorner_11.CornerRadius = UDim.new(0, 10)
			UICorner_11.Parent = slider

			TextLabel_9.Parent = slider
			TextLabel_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_9.BackgroundTransparency = 1.000
			TextLabel_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_9.BorderSizePixel = 0
			TextLabel_9.Position = UDim2.new(0.0320000015, 0, 0.150000006, 0)
			TextLabel_9.Size = UDim2.new(0, 192, 0, 15)
			TextLabel_9.ZIndex = 2
			TextLabel_9.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
			TextLabel_9.Text = self.Title
			TextLabel_9.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_9.TextScaled = true
			TextLabel_9.TextSize = 14.000
			TextLabel_9.TextWrapped = true
			TextLabel_9.TextXAlignment = Enum.TextXAlignment.Left

			Box.Name = "Box"
			Box.Parent = slider
			Box.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Box.BorderSizePixel = 0
			Box.Position = UDim2.new(0.0320000015, 0, 0.616666675, 0)
			Box.Size = UDim2.new(0, 223, 0, 8)

			UICorner_12.CornerRadius = UDim.new(0, 15)
			UICorner_12.Parent = Box

			Glow_3.Name = "Glow"
			Glow_3.Parent = Box
			Glow_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Glow_3.BackgroundTransparency = 1.000
			Glow_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Glow_3.BorderSizePixel = 0
			Glow_3.Size = UDim2.new(1, 0, 1, 0)
			Glow_3.Image = "rbxassetid://17381990533"
		
			UIGradient_100.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(0.53, 1.00), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient.Parent = Glow_3
			Fill_3.Name = "Fill"
			Fill_3.Parent = Box
			Fill_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Fill_3.BackgroundTransparency = 1.000
			Fill_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Fill_3.BorderSizePixel = 0
			Fill_3.Size = UDim2.new(1, 0, 1, 0)
			Fill_3.Image = "rbxassetid://17382033116"

			UICorner_13.CornerRadius = UDim.new(0, 4)
			UICorner_13.Parent = Fill_3
			
			local UIGradient_300 = Instance.new("UIGradient")
			UIGradient_300.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(0.50, 1.00), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient_300.Parent = Fill
			Hitbox.Name = "Hitbox"
			Hitbox.Parent = Box
			Hitbox.AnchorPoint = Vector2.new(0.5, 0.5)
			Hitbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Hitbox.BackgroundTransparency = 1.000
			Hitbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Hitbox.BorderSizePixel = 0
			Hitbox.Position = UDim2.new(0.5, 0, 0.5, 0)
			Hitbox.Size = UDim2.new(0, 200, 0, 13)
			Hitbox.ZIndex = 3
			Hitbox.AutoButtonColor = false
			Hitbox.Font = Enum.Font.SourceSans
			Hitbox.Text = ""
			Hitbox.TextColor3 = Color3.fromRGB(0, 0, 0)
			Hitbox.TextSize = 14.000

			Number.Name = "Number"
			Number.Parent = slider
			Number.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Number.BackgroundTransparency = 1.000
			Number.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Number.BorderSizePixel = 0
			Number.Position = UDim2.new(0.772000015, 0, 0.13333334, 0)
			Number.Size = UDim2.new(0, 38, 0, 12)
			Number.ZIndex = 2
			Number.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
			Number.Text = self.Value
			Number.TextColor3 = Color3.fromRGB(255, 255, 255)
			Number.TextScaled = true
			Number.TextSize = 14.000
			Number.TextWrapped = true
			
			if not Library.Flags[self.Flag] then
				Library.Flags[self.Flag] = self.Value
			end

			slider.Number.Text = Library.Flags[self.Flag]
			self.Callback(Library.Flags[self.Flag])

			slider.Box.Hitbox.MouseButton1Down:Connect(function()
				if Library.slider_drag then
					return
				end

				Element.slider_loop({
					slider = slider,
					Flag = self.Flag,
					Callback = self.Callback,

					Max = self.Max,
					Min = self.Min,
				})
			end)

			UserInputService.InputEnded:Connect(function(input: InputObject, process: boolean)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					Library.slider_drag = false
					Library.save_Flags()
				end
			end)
		end
		
		function Element:Dropdown()
			local open = false
			local list_size = 6
			local Section = self.Section == 'center' and center_section
			
			local option = Instance.new("TextButton")
			local dropdown = Instance.new("TextButton")
			local UICorner_14 = Instance.new("UICorner")
			local Box_2 = Instance.new("Frame")
			local UICorner_15 = Instance.new("UICorner")
			local Options = Instance.new("Frame")
			local UICorner_16 = Instance.new("UICorner")
			local UIPadding_4 = Instance.new("UIPadding")
			local UIListLayout = Instance.new("UIListLayout")
			local TextLabel_10 = Instance.new("TextLabel")
			local UIPadding_5 = Instance.new("UIPadding")
			local Arrow = Instance.new("ImageLabel")
			local UIListLayout_2 = Instance.new("UIListLayout")
			local UIPadding_6 = Instance.new("UIPadding")
			
			option.Name = "option"
			option.Parent = Section
			option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			option.BackgroundTransparency = 1.000
			option.BorderColor3 = Color3.fromRGB(0, 0, 0)
			option.BorderSizePixel = 0
			option.Size = UDim2.new(0, 250, 0, 40)
			option.ZIndex = 2
			option.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
			option.Text = ""
			option.TextColor3 = Color3.fromRGB(255, 255, 255)
			option.TextScaled = true
			option.TextSize = 14.000
			option.TextWrapped = true

			dropdown.Name = "dropdown"
			dropdown.Parent = option
			dropdown.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
			dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			dropdown.BorderSizePixel = 0
			dropdown.Size = UDim2.new(0, 250, 0, 40)
			dropdown.AutoButtonColor = false
			dropdown.Font = Enum.Font.SourceSans
			dropdown.Text = ""
			dropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
			dropdown.TextSize = 14.000

			UICorner_14.CornerRadius = UDim.new(0, 10)
			UICorner_14.Parent = dropdown

			Box_2.Name = "Box"
			Box_2.Parent = dropdown
			Box_2.AnchorPoint = Vector2.new(0.5, 0.5)
			Box_2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Box_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Box_2.BorderSizePixel = 0
			Box_2.Position = UDim2.new(0.5, 0, 0.150000006, 0)
			Box_2.Size = UDim2.new(0, 235, 0, 30)
			Box_2.ZIndex = 2

			UICorner_15.CornerRadius = UDim.new(0, 6)
			UICorner_15.Parent = Box_2

			Options.Name = "Options"
			Options.Parent = Box_2
			Options.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Options.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Options.BorderSizePixel = 0
			Options.ClipsDescendants = true
			Options.Position = UDim2.new(0, 0, 1, 0)
			Options.Size = UDim2.new(0, 202, 0, 0)

			UICorner_16.CornerRadius = UDim.new(0, 6)
			UICorner_16.Parent = Options

			UIPadding_4.Parent = Options
			UIPadding_4.PaddingLeft = UDim.new(0, 15)
			UIPadding_4.PaddingTop = UDim.new(0, 10)

			UIListLayout.Parent = Options
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 10)

			TextLabel_10.Parent = Box_2
			TextLabel_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_10.BackgroundTransparency = 1.000
			TextLabel_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_10.BorderSizePixel = 0
			TextLabel_10.Position = UDim2.new(0.0198019799, 0, 0.239999995, 0)
			TextLabel_10.Size = UDim2.new(0, 151, 0, 13)
			TextLabel_10.ZIndex = 2
			TextLabel_10.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
			TextLabel_10.Text = self.Title
			TextLabel_10.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel_10.TextSize = 14.000
			TextLabel_10.TextWrapped = true
			TextLabel_10.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding_5.Parent = TextLabel_10
			UIPadding_5.PaddingLeft = UDim.new(0, 3)

			Arrow.Name = "Arrow"
			Arrow.Parent = Box_2
			Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Arrow.BackgroundTransparency = 1.000
			Arrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Arrow.BorderSizePixel = 0
			Arrow.Position = UDim2.new(0.851485133, 0, 0.239999995, 0)
			Arrow.Size = UDim2.new(0, 15, 0, 15)
			Arrow.Image = "rbxassetid://17400678941"

			UIListLayout_2.Parent = dropdown
			UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

			UIPadding_6.Parent = dropdown
			UIPadding_6.PaddingTop = UDim.new(0, 6)
			
			local Dropdown = {}

			function Dropdown:open()
				dropdown.Box.TextLabel_10.Text = Library.Flags[self.Flag]

				TweenService:Create(dropdown.Box.Options, TweenInfo.new(0.4), {
					Size = UDim2.new(0, 202, 0, list_size)
				}):Play()

				TweenService:Create(dropdown, TweenInfo.new(0.4), {
					Size = UDim2.new(0, 215, 0, 30 + list_size)
				}):Play()

				TweenService:Create(dropdown.Box.Arrow, TweenInfo.new(0.4), {
					Rotation = 180
				}):Play()
			end

			function Dropdown:close()
				dropdown.Box.TextLabel_10.Text = self.Title
				TweenService:Create(dropdown.Box.Options, TweenInfo.new(0.4), {
					Size = UDim2.new(0, 202, 0, 0)
				}):Play()

				TweenService:Create(dropdown, TweenInfo.new(0.4), {
					Size = UDim2.new(0, 215, 0, 36)
				}):Play()

				TweenService:Create(dropdown.Box.Arrow, TweenInfo.new(0.4), {
					Rotation = 0
				}):Play()
			end

			function Dropdown:clear()
				for _, object in dropdown.Box.Options:GetChildren() do
					if object.Name ~= 'Option' then
						continue
					end

					object:Destroy()
				end
			end

			function Dropdown:select_option()
				TweenService:Create(self.new_option, TweenInfo.new(0.4), {
					TextTransparency = 0
				}):Play()

				for _, object in dropdown.Box.Options:GetChildren() do
					if object.Name ~= 'Option' then
						continue
					end

					if object.Text == Library.Flags[self.Flag] then
						continue
					end

					TweenService:Create(object, TweenInfo.new(0.4), {
						TextTransparency = 0.5
					}):Play()
				end

				dropdown.Box.TextLabel_10.Text = self.new_option.Text
			end

			function Dropdown:update()
				Dropdown.clear()

				for _, value in self.Options do
					list_size += 23

					local new_option = option:Clone()
					new_option.Parent = dropdown.Box.Options
					new_option.Text = value

					if value == Library.Flags[self.Flag] then
						new_option.TextTransparency = 0
					end

					new_option.MouseButton1Click:Connect(function()
						Library.Flags[self.Flag] = value

						if list_open then
							dropdown.Box.TextLabel_10.Text = Library.Flags[self.Flag]
						end
						self.Callback(Library.Flags[self.Flag])
						Library.save_Flags()

						Dropdown.select_option({
							new_option = new_option,
							flag = self.Flag
						})
					end)
				end
			end

			if not Library.Flags[self.Flag] then
				Library.Flags[self.Flag] = self.Option
			end

			self.Callback(Library.Flags[self.Flag])
			Dropdown.update(self)

			dropdown.MouseButton1Click:Connect(function()
				open = not open

				if open then
					Dropdown.open(self)
				else
					Dropdown.close(self)
				end
			end)

			return Dropdown
		end
		
		function Element:Input()
			local Section = self.Section == "center" and center_section
			local textbox = Instance.new("TextButton")
			local UICorner_17 = Instance.new("UICorner")
			local UIListLayout_3 = Instance.new("UIListLayout")
			local UIPadding_7 = Instance.new("UIPadding")
			local Box_3 = Instance.new("Frame")
			local UICorner_18 = Instance.new("UICorner")
			local TextHolder = Instance.new("TextBox")
			textbox.Name = "textbox"
			textbox.Parent = Section
			textbox.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
			textbox.BackgroundTransparency = 0.090
			textbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			textbox.BorderSizePixel = 0
			textbox.Size = UDim2.new(0, 250, 0, 36)
			textbox.AutoButtonColor = false
			textbox.Font = Enum.Font.SourceSans
			textbox.Text = ""
			textbox.TextColor3 = Color3.fromRGB(0, 0, 0)
			textbox.TextSize = 14.000

			UICorner_17.CornerRadius = UDim.new(0, 10)
			UICorner_17.Parent = textbox

			UIListLayout_3.Parent = textbox
			UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder

			UIPadding_7.Parent = textbox
			UIPadding_7.PaddingTop = UDim.new(0, 6)

			Box_3.Name = "Box"
			Box_3.Parent = textbox
			Box_3.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Box_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Box_3.BorderSizePixel = 0
			Box_3.Size = UDim2.new(0, 202, 0, 25)
			Box_3.ZIndex = 2

			UICorner_18.CornerRadius = UDim.new(0, 6)
			UICorner_18.Parent = Box_3

			TextHolder.Name = "TextHolder"
			TextHolder.Parent = Box_3
			TextHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			TextHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextHolder.BorderSizePixel = 0
			TextHolder.Position = UDim2.new(0.0445544571, 0, 0.239999995, 0)
			TextHolder.Size = UDim2.new(0, 182, 0, 13)
			TextHolder.ZIndex = 2
			TextHolder.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
			TextHolder.Text = self.Title
			TextHolder.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextHolder.TextSize = 14.000
			TextHolder.TextXAlignment = Enum.TextXAlignment.Left
			
			local Textbox = {}
			if not Library.Flags[self.Flag] then
				Library.Flags[self.Flag] = self.Value
			else
				textbox.Box.TextHolder.Text = Library.Flags[self.Flag]
			end

			self.callback(Library.Flags[self.Flag])
			textbox.Box.TextHolder.FocusLost:Connect(function()
				self.callback(textbox.Box.TextHolder.Text)
				Library.save_Flags()
			end)

			function Textbox:update(text)
				textbox.Box.TextHolder.Text = text
				self.Callback(text)
			end

			return Textbox;
		end
		return Element
	end
	return Tab
end
return Library
