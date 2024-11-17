local everyClipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
function Lib()
local library = {}
local libalive = true
local holdingmouse = false
 
-- 17,856 pastebin views
-- as of 1/29/2023 @ 6:30 CST
 
local plr = game:GetService("Players").LocalPlayer
local mouse = plr:GetMouse()
local runs = game:GetService("RunService")
local us = game:GetService("UserInputService")
local screengui = Instance.new("ScreenGui",game.CoreGui)
local windowsopened = 0
 
local elementsize = 24
 
local font = Font.new(
    "rbxassetid://11702779517",
    Enum.FontWeight.Regular,
    Enum.FontStyle.Normal 
    )
 
local titlefont = Font.new(
    "rbxassetid://11702779517",
    Enum.FontWeight.Bold,
    Enum.FontStyle.Normal 
    )
 
local medfont = Font.new(
    "rbxassetid://11702779517",
    Enum.FontWeight.Medium,
    Enum.FontStyle.Normal 
    )
 
us.InputBegan:Connect(function(key,pro)
    if key.UserInputType == Enum.UserInputType.MouseButton1 then
        holdingmouse = true 
    end
end)
 
us.InputEnded:Connect(function(key,pro)
    if key.UserInputType == Enum.UserInputType.MouseButton1 then
        holdingmouse = false 
    end
end)
 
function draggable(obj) -- https://devforum.roblox.com/t/draggable-property-is-hidden-on-gui-objects/107689/4
    local UserInputService = game:GetService("UserInputService")
    local gui = obj
 
    local dragging
    local dragInput
    local dragStart
    local startPos
 
    local function update(input)
    	local delta = input.Position - dragStart
    	gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
 
    gui.InputBegan:Connect(function(input)
    	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    		dragging = true
    		dragStart = input.Position
    		startPos = gui.Position
 
    		input.Changed:Connect(function()
    			if input.UserInputState == Enum.UserInputState.End then
    				dragging = false
    			end
    		end)
    	end
    end)
 
    gui.InputChanged:Connect(function(input)
    	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
    		dragInput = input
    	end
    end)
 
    UserInputService.InputChanged:Connect(function(input)
    	if input == dragInput and dragging then
    		update(input)
    	end
    end) 
end
 
function hovercolor(b,idle,hover,clicked,included)
    local hovering = false
    local holding = false
 
    b.MouseEnter:Connect(function()
        hovering = true
    end)
 
    b.MouseLeave:Connect(function()
        hovering = false
    end)
 
    b.MouseButton1Down:Connect(function()
        holding = true
    end)
 
    b.MouseButton1Up:Connect(function()
        holding = false
    end)
 
    if included and typeof(included) == "table" and #included > 0 then
        for i,v in pairs(included) do
            b.Changed:Connect(function()
                v.BackgroundColor3 = b.BackgroundColor3
            end) 
        end
    end
 
    runs.RenderStepped:Connect(function()
        if hovering then
            if holding then
                b.BackgroundColor3 = clicked
            else
                b.BackgroundColor3 = hover
            end
        else
            b.BackgroundColor3 = idle
        end
    end)
end
 
library.window = function(text)
    local windowalive = true
    local frame = Instance.new("TextLabel",screengui)
    frame.Position = UDim2.new(0.016+windowsopened/12,0,0.009,0)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,20)
    --frame.AutomaticSize = Enum.AutomaticSize.Y
    frame.BorderSizePixel = 0
    --frame.Active = true
    --frame.Draggable = true
    local list = Instance.new("UIListLayout",frame)
    list.HorizontalAlignment = "Center"
    list.Padding = UDim.new(0,3)
    list.SortOrder = Enum.SortOrder.LayoutOrder
	draggable(frame)
 
	windowsopened = windowsopened + 1
 
    local header = Instance.new("Frame",frame)
    header.BackgroundColor3 = Color3.fromRGB(55,55,60)
    header.Size = UDim2.new(1,0,0,32)
    header.BorderSizePixel = 0
 
    local separator = Instance.new("Frame",header)
    separator.BackgroundColor3 = Color3.fromRGB(55,55,60)
    separator.Size = UDim2.new(1,0,0.4,0)
    separator.Position = UDim2.new(0,0,0.6,0)
    separator.BorderSizePixel = 0
 
    Instance.new("UICorner",frame)
    Instance.new("UICorner",header)
 
    local title = Instance.new("TextLabel",header)
    title.TextScaled = true
    title.Text = tostring(text)
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Size = UDim2.new(1,0,1,0)
    title.FontFace = titlefont
    title.BorderSizePixel = 0
    title.BackgroundTransparency = 1
 
    frame.Size = UDim2.new(0.08,0,0.0335,0)
    local gui = {}
 
    local elements = 0
    gui.label = function(text,extrasize)
        extrasize = extrasize or 0
 
        local b = Instance.new("TextLabel",frame)
        b.LayoutOrder = 0
        b.TextScaled = true
        b.BackgroundTransparency = 1
        b.Text = tostring(text)
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.Size = UDim2.new(0.96,0,0,elementsize+extrasize)
        b.FontFace = font
        b.BorderSizePixel = 0
 
        elements = elements + 1
        frame.Size = frame.Size + UDim2.new(0,0,0,elementsize+3+extrasize)
 
        local subgui = {}
 
        subgui.changetext = function(txt)
            b.Text = tostring(txt)
        end
 
        return subgui
    end
    gui.copy = function(text,extrasize)
        extrasize = extrasize or 0
        local b = Instance.new("TextButton",frame)
        b.LayoutOrder = 0
        b.TextScaled = true
        b.BackgroundColor3 = Color3.fromRGB(35,35,40)
        b.Text = tostring(text)
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.Size = UDim2.new(0.96,0,0,elementsize+extrasize)
        b.FontFace = font
        b.BorderSizePixel = 0
        b.AutoButtonColor = false
        b.ZIndex = 10
        elements = elements + 1
        frame.Size = frame.Size + UDim2.new(0,0,0,elementsize+3+extrasize)
 
        local subgui = {}
        b.MouseButton1Down:Connect(function()
        if everyClipboard and b.Text == tostring(text) then
            everyClipboard("UID:3546671562623445")
            b.Text = "Copyed!"
            task.wait(1)
            b.Text = tostring(text)
            end
        end)
        subgui.changetext = function(txt)
            b.Text = tostring(txt)
        end
        return subgui
    end
 
    gui.button = function(text,onclick)
        local el = Instance.new("Frame",frame)
        el.LayoutOrder = 0
        el.Size = UDim2.new(0.96,0,0,elementsize)
        el.BorderSizePixel = 0
        el.BackgroundTransparency = 1
 
        local b = Instance.new("TextButton",el)
        b.LayoutOrder = 0
        b.TextScaled = true
        b.BackgroundColor3 = Color3.fromRGB(35,35,40)
        b.Text = tostring(text)
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.Size = UDim2.new(1,0,1,0)
        b.FontFace = font
        b.BorderSizePixel = 0
        b.AutoButtonColor = false
        b.ZIndex = 10
 
        local top = Instance.new("Frame",el)
        top.Size = UDim2.new(1,0,0.4,0)
        top.Position = UDim2.new(0,0,0,0)
        top.BorderSizePixel = 0
 
        local bot = Instance.new("Frame",el)
        bot.Size = UDim2.new(1,0,0.4,0)
        bot.Position = UDim2.new(0,0,0.6,0)
        bot.BorderSizePixel = 0
 
        local thiselement = elements+1
        hovercolor(b,Color3.fromRGB(35,35,40),Color3.fromRGB(45,45,50),Color3.fromRGB(25,25,30),{top,bot})
        elements = elements + 1
        Instance.new("UICorner",b).CornerRadius = UDim.new(0,5)
 
        spawn(function()
            while b do
                bot.Visible = (elements>thiselement)
                task.wait() 
            end
        end)
 
        frame.Size = frame.Size + UDim2.new(0,0,0,elementsize+3)
        b.MouseButton1Down:Connect(onclick)
    end
 
    gui.toggle = function(text,default,onclick)
        local enabled = default or false
        local el = Instance.new("Frame",frame)
        el.LayoutOrder = 0
        el.Size = UDim2.new(0.96,0,0,elementsize)
        el.BorderSizePixel = 0
        el.BackgroundTransparency = 1
 
        local b = Instance.new("TextButton",el)
        b.LayoutOrder = 0
        b.TextScaled = true
        b.BackgroundColor3 = Color3.fromRGB(35,35,40)
        b.Text = tostring(text)
        b.TextColor3 = enabled and Color3.new(0,1,0) or Color3.new(1,0,0)
        b.Size = UDim2.new(1,0,1,0)
        b.FontFace = font
        b.BorderSizePixel = 0
        b.AutoButtonColor = false
        b.ZIndex = 10
 
        local top = Instance.new("Frame",el)
        top.Size = UDim2.new(1,0,0.4,0)
        top.Position = UDim2.new(0,0,0,0)
        top.BorderSizePixel = 0
 
        local bot = Instance.new("Frame",el)
        bot.Size = UDim2.new(1,0,0.4,0)
        bot.Position = UDim2.new(0,0,0.6,0)
        bot.BorderSizePixel = 0
 
        local thiselement = elements+1
        hovercolor(b,Color3.fromRGB(35,35,40),Color3.fromRGB(45,45,50),Color3.fromRGB(25,25,30),{top,bot})
        elements = elements + 1
        Instance.new("UICorner",b).CornerRadius = UDim.new(0,5)
 
        spawn(function()
            while b do
                bot.Visible = (elements>thiselement)
                task.wait() 
            end
        end)
 
        frame.Size = frame.Size + UDim2.new(0,0,0,elementsize+3)
        b.MouseButton1Down:Connect(function()
            enabled = not enabled
            b.TextColor3 = enabled and Color3.new(0,1,0) or Color3.new(1,0,0)
            onclick(enabled)
        end)
 
        local subgui = {}
 
        subgui.set = function(bool)
            enabled = bool
            b.TextColor3 = enabled and Color3.new(0,1,0) or Color3.new(1,0,0)
            onclick(enabled)
        end
 
        return subgui
    end
 
    gui.textbox = function(text,unfocused)
        local el = Instance.new("Frame",frame)
        el.LayoutOrder = 0
        el.Size = UDim2.new(0.96,0,0,elementsize)
        el.BorderSizePixel = 0
        el.BackgroundTransparency = 1
 
        local b = Instance.new("TextBox",el)
        b.LayoutOrder = 0
        b.TextScaled = true
        b.BackgroundColor3 = Color3.fromRGB(35,35,40)
        b.PlaceholderText = tostring(text)
        b.PlaceholderColor3 = Color3.fromRGB(80,80,80)
        b.Text = ""
        b.TextColor3 = Color3.fromRGB(125,200,255)
        b.Size = UDim2.new(1,0,1,0)
        b.FontFace = font
        b.BorderSizePixel = 0
        b.ZIndex = 10
 
        local top = Instance.new("Frame",el)
        top.Size = UDim2.new(1,0,0.4,0)
        top.Position = UDim2.new(0,0,0,0)
        top.BorderSizePixel = 0
        top.BackgroundColor3 = b.BackgroundColor3
 
        local bot = Instance.new("Frame",el)
        bot.Size = UDim2.new(1,0,0.4,0)
        bot.Position = UDim2.new(0,0,0.6,0)
        bot.BorderSizePixel = 0
        bot.BackgroundColor3 = b.BackgroundColor3
 
        local thiselement = elements+1
        elements = elements + 1
        Instance.new("UICorner",b).CornerRadius = UDim.new(0,5)
 
        task.spawn(function()
            while b do
                bot.Visible = (elements>thiselement)
                task.wait() 
            end
        end)
 
        frame.Size = frame.Size + UDim2.new(0,0,0,elementsize+3)
        b.FocusLost:Connect(function()
            unfocused(b.Text) 
        end)
 
		local subgui = {}
 
        subgui.text = function()
            return b.Text 
        end
 
        subgui.changetext = function(newtext)
            b.Text = newtext
        end
 
        return subgui
    end
 
    local coldropdown = nil
    gui.dropdown = function(text,contents)
        local el = Instance.new("Frame",frame)
        el.LayoutOrder = 0
        el.Size = UDim2.new(0.96,0,0,elementsize)
        el.BorderSizePixel = 0
        el.BackgroundTransparency = 1
        el.ZIndex = 2
 
        local b = Instance.new("TextButton",el)
        b.LayoutOrder = 0
        b.TextScaled = true
        b.BackgroundColor3 = Color3.fromRGB(35,35,40)
        b.Text = tostring(text) .." >"
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.Size = UDim2.new(1,0,1,0)
        b.FontFace = font
        b.BorderSizePixel = 0
        b.AutoButtonColor = false
        b.ZIndex = 2
        local d = Instance.new("Frame",b)
        d.AnchorPoint = Vector2.new(0.5,0)
        d.Position = UDim2.new(0.5,0,0.72,0)
        d.Size = UDim2.new(1.04,0,0,9)
        d.BackgroundColor3 = Color3.fromRGB(15,15,20)
        d.AutomaticSize = Enum.AutomaticSize.Y
        d.BorderSizePixel = 0
        d.Visible = false
        d.ZIndex = 2
        local dlist = Instance.new("UIListLayout",d)
        dlist.HorizontalAlignment = "Center"
        dlist.Padding = UDim.new(0,3)
        dlist.SortOrder = Enum.SortOrder.LayoutOrder
 
        local separator = Instance.new("Frame",d)
        separator.BackgroundTransparency = 1
        separator.Size = UDim2.new(1,0,0,6)
 
        local top = Instance.new("Frame",el)
        top.Size = UDim2.new(1,0,0.4,0)
        top.Position = UDim2.new(0,0,0,0)
        top.BorderSizePixel = 0
 
        local bot = Instance.new("Frame",el)
        bot.Size = UDim2.new(1,0,0.4,0)
        bot.Position = UDim2.new(0,0,0.6,0)
        bot.BorderSizePixel = 0
 
        local thiselement = elements+1
        hovercolor(b,Color3.fromRGB(35,35,40),Color3.fromRGB(45,45,50),Color3.fromRGB(25,25,30),{top,bot})
        elements = elements + 1
        Instance.new("UICorner",b).CornerRadius = UDim.new(0,5)
        Instance.new("UICorner",d)
 
        spawn(function()
            while b do
                bot.Visible = (elements>thiselement)
                task.wait() 
            end
        end)
 
        frame.Size = frame.Size + UDim2.new(0,0,0,elementsize+3)
 
        local search = ""
        local selected = nil
        local function addcontent(name)
            if typeof(name) == "Instance" then
                name = name.Name 
            end
 
            local e = Instance.new("TextButton",d)
            e.LayoutOrder = 0
            e.TextScaled = true
            e.BackgroundColor3 = Color3.fromRGB(75,75,80)
            e.Text = tostring(name)
            e.TextColor3 = Color3.fromRGB(255,255,255)
            e.Size = UDim2.new(0.96,0,0,elementsize)
            e.FontFace = font
            e.BorderSizePixel = 0
            e.Name = name
            e.ZIndex = 35-elements
 
            Instance.new("UICorner",e)
            d.Size = d.Size + UDim2.new(0,0,0,25)
 
            e.MouseButton1Down:Connect(function()
                d.Visible = false
                b.ZIndex = 2
                b.Text = tostring(name).." >"
                b.TextColor3 = Color3.fromRGB(200,255,200)
                selected = name
            end)
 
            spawn(function()
                while task.wait() do
                    local s = search:lower()
 
                    if s ~= "" then
                        if tostring(name):lower():find(s) then
                            e.Visible = true
                        else
                            e.Visible = false
                        end
                    else
                        e.Visible = true
                    end
                end
            end)
        end
 
        for i,v in pairs(contents) do
            addcontent(v) 
        end
 
        b.MouseButton1Down:Connect(function()
            d.Visible = not d.Visible 
            el.ZIndex = d.Visible and 10 or 12
            b.ZIndex = d.Visible and 22 or 10
            coldropdown = d.Visible and el or nil
 
            if not selected then
                b.Text = d.Visible and tostring(text).." <" or tostring(text).." >"
            else
                b.Text = d.Visible and tostring(selected).." <" or tostring(selected).." >"
            end
 
            repeat task.wait() until coldropdown ~= el
 
            d.Visible = false
            el.ZIndex = d.Visible and 10 or 12
            b.ZIndex = d.Visible and 22 or 10
        end)
 
        local subgui = {}
 
        subgui.get = function()
            return selected
        end
 
        subgui.add = function(txt)
            addcontent(txt) 
        end
 
        subgui.search = function(txt)
            search = tostring(txt)
 
            d.Size = UDim2.new(1.04,0,0,0)
            task.wait()
            local items = 0
            for i,v in pairs(d:GetChildren()) do
                if v:IsA("TextButton") and v.Visible then
                    i = i + 1
                    d.Size = d.Size + UDim2.new(0,0,0,25)
                end
            end
        end
 
        subgui.delete = function(txt)
            if d:FindFirstChild(txt) then
                d:FindFirstChild(txt):Destroy()
                d.Size = d.Size - UDim2.new(0,0,0,25)
 
                if selected == txt then
                    b.TextColor3 = Color3.fromRGB(255,255,255)
                    b.Text = tostring(text).." >"
                    selected = nil
                end
            end
        end
 
        subgui.clear = function()
            for i,v in pairs(d:GetChildren()) do
                if v:IsA("TextButton") then
                    v:Destroy() 
                    d.Size = d.Size - UDim2.new(0,0,0,25)
                end
            end
            b.TextColor3 = Color3.fromRGB(255,255,255)
            b.Text = tostring(text).." >"
            selected = nil
        end
 
        return subgui
    end
 
    gui.slider = function(text,min,max,roundto,default,onchange)
        local el = Instance.new("Frame",frame)
        el.LayoutOrder = 0
        el.Size = UDim2.new(0.96,0,0,elementsize+5)
        el.BorderSizePixel = 0
        el.BackgroundTransparency = 1
 
        local b = Instance.new("Frame",el)
        b.LayoutOrder = 0
        b.BackgroundColor3 = Color3.fromRGB(35,35,40)
        b.Size = UDim2.new(1,0,1,0)
        b.BorderSizePixel = 0
        b.ZIndex = 10
 
        local txtholder = Instance.new("TextLabel",b)
        txtholder.TextScaled = true
        txtholder.BackgroundColor3 = Color3.fromRGB(35,35,40)
        txtholder.Text = tostring(text).." [".. tostring(default).."]"
        txtholder.TextColor3 = Color3.fromRGB(255,255,255)
        txtholder.Size = UDim2.new(1,0,0.7,0)
        txtholder.FontFace = medfont
        txtholder.BorderSizePixel = 0
        txtholder.ZIndex = 10
 
        local slidepart = Instance.new("Frame",b)
        slidepart.BackgroundColor3 = Color3.fromRGB(255,255,255)
        slidepart.Size = UDim2.new(0.9,0,0.05,0)
        slidepart.Position = UDim2.new(0.05,0,0.8,0)
        slidepart.BorderSizePixel = 0
        slidepart.ZIndex = 10
 
        local slideball = Instance.new("ImageLabel",slidepart)
        slideball.AnchorPoint = Vector2.new(0.5,0.5)
        slideball.BackgroundTransparency = 1
        slideball.Size = UDim2.new(0.055,0,5,0)
        slideball.Position = UDim2.new(0,0,0.5,0)
        slideball.Image = "rbxassetid://6755657357"
        slideball.BorderSizePixel = 0
        slideball.ZIndex = 12
 
        local button = Instance.new("TextButton",b)
        button.BackgroundTransparency = 1
        button.Text = ""
        button.Size = UDim2.new(1,0,1,0)
        button.ZIndex = 35
 
        local top = Instance.new("Frame",el)
        top.Size = UDim2.new(1,0,0.4,0)
        top.Position = UDim2.new(0,0,0,0)
        top.BorderSizePixel = 0
        top.BackgroundColor3 = b.BackgroundColor3
 
        local bot = Instance.new("Frame",el)
        bot.Size = UDim2.new(1,0,0.4,0)
        bot.Position = UDim2.new(0,0,0.6,0)
        bot.BorderSizePixel = 0
        bot.BackgroundColor3 = b.BackgroundColor3
 
        local thiselement = elements+1
        elements = elements + 1
        Instance.new("UICorner",b).CornerRadius = UDim.new(0,5)
 
        task.spawn(function()
            while b do
                bot.Visible = (elements>thiselement)
                task.wait() 
            end
        end)
 
        local slidervalue
        local function setslider(value)
            local trueval = math.floor(value/roundto)*roundto
            local norm = (trueval-min)/(max-min)
            slideball.Position = UDim2.new(norm,0,0.5,0)
            txtholder.Text = tostring(text).." [".. tostring(math.floor(trueval*100)/100).."]"
 
            slidervalue = trueval
            onchange(trueval)
        end
 
        local holding = false
        button.MouseButton1Down:Connect(function()
            holdingmouse = true
 
            task.spawn(function()
                while holdingmouse and windowalive and libalive do
                    local abpos = slidepart.AbsolutePosition
                    local absize = slidepart.AbsoluteSize
                    local x = mouse.X
 
                    local p = math.clamp((x-abpos.X)/(absize.X),0,1)
                    local value = p*max+(1-p)*min
 
                    setslider(value)
                    task.wait() 
                end 
            end)
        end)
 
        button.MouseButton1Up:Connect(function()
            holding = false
            holdingmouse = false
        end)
        game:GetService("UserInputService").TouchEnded:Connect(function()
            if holdingmouse or holding then
                holding = false
                holdingmouse = false
            end
        end)
        frame.Size = frame.Size + UDim2.new(0,0,0,elementsize+3+5)
        setslider(default)
 
        local subgui = {}
 
        subgui.get = function(val)
            return slidervalue
        end
 
        subgui.setvalue = function(val)
            setslider(val)
        end
 
        subgui.setmin = function(val)
            min = val
            setslider(slidervalue)
        end
 
        subgui.setmax = function(val)
            max = val
            setslider(slidervalue)
        end
 
        return subgui
    end
 
    gui.hide = function()
        frame.Visible = false
    end
 
    gui.show = function()
        frame.Visible = true 
    end
 
    gui.delete = function()
        windowalive = false
        gui:Destroy() 
    end
 
    return gui
end
 
library.delete = function()
    libalive = false
	screengui:Destroy()
end
 
return library
end
function randomstring()
local a = math.random(10,40)
local args = {}
    for i=1,a do
        args[i] = string.char(math.random(16,128))
    end
    return table.concat(args)
end
local library = Lib()
local originalNC
function message(text)
    local msg = Instance.new("Message",workspace)
    msg.Text = tostring(text)
    task.wait(2)
    msg:Destroy()
end
function message2(text)
game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Notify";
	Text = tostring(text);
	Icon = "";
	Duration = 4;
})
end
local function printerror(error)
    print("error print: "..tostring(error))
end
local esptable = {zombies={},runner={},barrel={},sapper={},shambler={},players={},Igniter={},friends={}}
local Folder = Instance.new("Folder", game:GetService("Workspace"))
Folder.Name = randomstring()
local speed = Instance.new("NumberValue",Folder)
speed.Name = randomstring()
speed.Value = 16.2
function textesp(color,core,name,offset)
local bill
if core and name then
        bill = Instance.new("BillboardGui",game.CoreGui)
        bill.AlwaysOnTop = true
        bill.Size = UDim2.new(0,400,0,100)
        bill.Adornee = core
        bill.MaxDistance = 2000
 
        local mid = Instance.new("Frame",bill)
        mid.AnchorPoint = Vector2.new(0.5,0.5)
        mid.BackgroundColor3 = color
        mid.Size = UDim2.new(0,8,0,8)
        mid.Position = UDim2.new(0.5+offset,0,0.5+offset,0)
        Instance.new("UICorner",mid).CornerRadius = UDim.new(1,0)
        Instance.new("UIStroke",mid)
 
        local txt = Instance.new("TextLabel",bill)
        txt.AnchorPoint = Vector2.new(0.5,0.5)
        txt.BackgroundTransparency = 1
        txt.BackgroundColor3 = color
        txt.TextColor3 = color
        txt.Size = UDim2.new(1,0,0,20)
        txt.Position = UDim2.new(0.5,0,0.7,0)
        txt.Text = name
        Instance.new("UIStroke",txt)
 
        task.spawn(function()
            while bill do
                if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                    bill.Enabled = false
                    bill.Adornee = nil
                    bill:Destroy() 
                end  
                task.wait()
            end
        end)
    end
 
    local ret = {}
 
    ret.delete = function()
 
        if bill then
            bill.Enabled = false
            bill.Adornee = nil
            bill:Destroy() 
        end
    end
 
    return ret
end
function esp(what,color,core,name,offset)
    local parts
 
    if typeof(what) == "Instance" then
        if what:IsA("Model") then
            parts = what:GetChildren()
        elseif what:IsA("BasePart") then
            parts = {what,table.unpack(what:GetChildren())}
        end
    elseif typeof(what) == "table" then
        parts = what
    end
 
    local bill
    local boxes = {}
 
    for i,v in pairs(parts) do
        if v:IsA("BasePart") then
            local box = Instance.new("BoxHandleAdornment")
            box.Size = v.Size
            box.AlwaysOnTop = true
            box.ZIndex = 1
            box.AdornCullingMode = Enum.AdornCullingMode.Never
            box.Color3 = color
            box.Transparency = 0.8
            box.Adornee = v
            box.Parent = game.CoreGui
 
            table.insert(boxes,box)
 
            task.spawn(function()
                while box do
                    if box.Adornee == nil or not box.Adornee:IsDescendantOf(workspace) then
                        box.Adornee = nil
                        box.Visible = false
                        box:Destroy()
                    end  
                    task.wait()
                end
            end)
        end
    end
 
    if core and name then
        bill = Instance.new("BillboardGui",game.CoreGui)
        bill.AlwaysOnTop = true
        bill.Size = UDim2.new(0,400,0,100)
        bill.Adornee = core
        bill.MaxDistance = 2000
 
        local mid = Instance.new("Frame",bill)
        mid.AnchorPoint = Vector2.new(0.5,0.5)
        mid.BackgroundColor3 = color
        mid.Size = UDim2.new(0,8,0,8)
        mid.Position = UDim2.new(0.5+offset,0,0.5+offset,0)
        Instance.new("UICorner",mid).CornerRadius = UDim.new(1,0)
        Instance.new("UIStroke",mid)
 
        local txt = Instance.new("TextLabel",bill)
        txt.AnchorPoint = Vector2.new(0.5,0.5)
        txt.BackgroundTransparency = 1
        txt.BackgroundColor3 = color
        txt.TextColor3 = color
        txt.Size = UDim2.new(1,0,0,20)
        txt.Position = UDim2.new(0.5,0,0.7,0)
        txt.Text = name
        Instance.new("UIStroke",txt)
 
        task.spawn(function()
            while bill do
                if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                    bill.Enabled = false
                    bill.Adornee = nil
                    bill:Destroy() 
                end  
                task.wait()
            end
        end)
    end
 
    local ret = {}
 
    ret.delete = function()
        for i,v in pairs(boxes) do
            v.Adornee = nil
            v.Visible = false
            v:Destroy()
        end
 
        if bill then
            bill.Enabled = false
            bill.Adornee = nil
            bill:Destroy() 
        end
    end
 
    return ret 
end
if not hookmetamethod or not workspace:FindFirstChild("Zombies") then
if not hookmetamethod then
library.delete()
game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Notification";
	Text = "Missing hookmetamethod";
	Icon = "";
	Duration = 4;
})
else
    library.delete()
    game:GetService("StarterGui"):SetCore("SendNotification", {
    	Title = "Notification";
    	Text = "e";
    	Icon = "";
    	Duration = 4;
    })
end
return
end
local plr = game:GetService("Players").LocalPlayer
local char
local connect
connect = plr.CharacterAdded:Connect(function(c)
char = c
end)
function isfriend(name)
    for i,v in pairs(esptable.friends) do
        if v and v == name then
            return true
        end
    end
    return false
end
function getMelee()
for i,bool in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
  if bool:GetAttribute("Melee") then
   return bool
  end
end
 
 for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
  if v:GetAttribute("Melee") then
   return v
  end
end
 
end
 
function Distance(what)
if not char then
return 1145141919810
end
local Position = what.HumanoidRootPart.CFrame.Position
return (Position - char.HumanoidRootPart.CFrame.Position).magnitude
end
function CPlayer()
local distance = 0
local player = nil
for i,v in pairs(game.Players:GetPlayers()) do 
 if v ~= plr then
   if v.Character then
     if v.Character:FindFirstChild("HumanoidRootPart") then
     local humanoid = v.Character:FindFirstChildOfClass("Humanoid") or v.Character:FindFirstChildOfClass("AnimationController")
     for i,an in next, humanoid:GetPlayingAnimationTracks() do
     if tostring(an) == "Use" then
        return v
        end
     end
     if v.Character.Name == "Do12Kr" or v.Character:GetAttribute("BaseSpeed") < 10 or (v.Character.Humanoid.Health < 35 and v.Character.Humanoid.Health > 0) then
     return v
     end
     if v.Character.Humanoid.Health > 0 then
      local dice = (char.HumanoidRootPart.CFrame.Position - v.Character.HumanoidRootPart.CFrame.Position).magnitude
       if dice > distance then
        distance = dice
       player = v
       end
      end
     end
    end
   end
  end
 return player
end
 
local function zombieup(zombie)
local hum = zombie:FindFirstChildOfClass("Humanoid")
hum.WalkSpeed = 0.001
hum.PlatformStand = true
zombie.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,2000,0)
end
local function zombiereset(zombie)
local hum = zombie:FindFirstChildOfClass("Humanoid")
hum.WalkSpeed = 1
zombie.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
end
local function zombieupspin(zombie)
local hum = zombie:FindFirstChildOfClass("Humanoid")
hum.WalkSpeed = 0.00001
hum.PlatformStand = true
zombie.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,2000+math.random(100,200),0)
local Spin = Instance.new("BodyAngularVelocity")
Spin.Name = "Spinning"
Spin.Parent = zombie.HumanoidRootPart
Spin.MaxTorque = Vector3.new(0, math.huge, 0)
Spin.AngularVelocity = Vector3.new(0,114514,0)
zombie.HumanoidRootPart.CanCollide = false
end
local function zombiedown(zombie)
local hum = zombie:FindFirstChildOfClass("Humanoid")
hum:MoveTo(Vector3.new(math.random(10,20),0,math.random(10,20)))
hum.WalkSpeed = 0.0001
hum.PlatformStand = true
zombie.HumanoidRootPart.CanCollide = false
zombie.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,-5000,0)
end
local function zombietp2plr(zombie)
local cframe = CPlayer()
for i=1,5 do
--zombie.HumanoidRootPart.CFrame = cframe
zombie.HumanoidRootPart.CFrame = cframe.Character.HumanoidRootPart.CFrame --+ PartE.CFrame.LookVector
   end
end
local function getnotpikeMelee()
for i,bool in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
    if bool:GetAttribute("Melee") and bool.Name ~= "Pike" then
        return bool
    end
end
for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    if v:GetAttribute("Melee") and v.Name ~= "Pike" then
                return v
            end
        end
    return false
end
local function swing()
local item = getnotpikeMelee()
if item and item.Parent ~= char then
item.Parent = char
end
item.RemoteEvent:FireServer("Swing","Side")
end
local function getnotpikeMelee()
for i,bool in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
    if bool:GetAttribute("Melee") and bool.Name ~= "Pike" then
        return bool
    end
end
for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    if v:GetAttribute("Melee") and v.Name ~= "Pike" then
                return v
            end
        end
    return false
end
function Attack(Item,SwitchItem,SwitchBack,Zombie,AttackHead)
if Distance(Zombie) >= 4 then
    return
end
local Back = Item.Parent
local Switched = false
 
local AttackPos = Zombie.HumanoidRootPart.CFrame.Position
local Head = {
    [1] = "HitZombie",
    [2] = Zombie,
    [3] = Zombie.Head.Position + char.Head.CFrame.LookVector * 2.55,
    [4] = true
}
local Legs = {
    [1] = "HitZombie",
    [2] = Zombie,
    [3] = Zombie.L.CFrame.Position + char.Head.CFrame.LookVector * 2.55,
    [4] = false
}
if not char:FindFirstChild(Item.Name) and SwitchItem then
    Item.Parent = char
    Switched = true
end
task.wait()
local pos = Zombie.PrimaryPart.Position
char.PrimaryPart.CFrame = CFrame.lookAt(char.PrimaryPart.Position, Vector3.new(pos.X,char.PrimaryPart.Position.Y,pos.Z))
Item.RemoteEvent:FireServer("Swing","Over")
if AttackHead then
Item.RemoteEvent:FireServer(unpack(Head))
else
Item.RemoteEvent:FireServer(unpack(Legs))
end
task.wait()
if Switched and SwitchBack then
Item.Parent = Back
    end
end
local flags = {
  esphumans = false,
  zombies = false,
  runneresp = false,
  barrelesp = false,
  sapperesp = false,
  igniteresp = false,
  shambleresp = false,
  backpack = false,
  modzombie = false,
  silentaura = false,
  attackhead = false,
  cancel = false,
  fastdrum = false,
  rotation = false,
  modifyzombies = false,
  flinghambler = false,
  flingrunner = false,
  flingsapper = false,
  tpshambler = false,
  tprunner = false,
  tpsapper = false,
  noslow = false,
  slowzombie = false,
  runneranim = false,
  loopspeed = false
}
local gui = true
local DELFLAGS = {table.unpack(flags)}
local gui = library.window("GUI")
local window_esp = library.window("渲染类")
local window_combat = library.window("攻击类")
local window_player = library.window("玩家类")
local silentaura = library.window("杀戮光环设置")
local fling = library.window("修改僵尸设置")
fling.hide()
silentaura.hide()
local friendscheck
task.spawn(function()
friendscheck = game.Players.PlayerAdded:Connect(function(player)
    task.wait()
    if player:IsFriendsWith(plr.UserId) then
        table.insert(esptable.friends,player.Name)
    end
end)
for i,v in pairs(game.Players:GetPlayers()) do
    task.wait()
    if v ~= plr and v:IsFriendsWith(plr.UserId) then
            table.insert(esptable.friends,v.Name)
        end
    end
end)
window_player.toggle("保持物品栏",false,function(val)
    flags.backpack = val
    if val then
    local backchange
    local characteradd
         characteradd = plr.CharacterAdded:Connect(function()
         backchange = plr.PlayerGui.BackpackGui:GetPropertyChangedSignal("Enabled"):Connect(function()
         plr.PlayerGui:FindFirstChild("BackpackGui").Enabled = true
         end)
    end)
        if char then
            plr.PlayerGui:FindFirstChild("BackpackGui").Enabled = true
            backchange = plr.PlayerGui.BackpackGui:GetPropertyChangedSignal("Enabled"):Connect(function()
            plr.PlayerGui:FindFirstChild("BackpackGui").Enabled = true
            end)
        end
    repeat task.wait() until not flags.backpack
    if backchange then
    backchange:Disconnect()
    end
    characteradd:Disconnect()
    end
end)
window_player.toggle("Loop speed",false,function(val)
    flags.loopspeed = val
        if val then
        local ch
        ch = speed.Changed:Connect(function()
            pcall(function()
                if char then
                    char.Humanoid.WalkSpeed = speed.Value
                end
            end)
        end)
        local change
        local characteradded
        characteradded = plr.CharacterAdded:Connect(function()
            repeat task.wait() until char:FindFirstChild("Humanoid")
            char.Humanoid.WalkSpeed = speed.Value
            change = char.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                char.Humanoid.WalkSpeed = speed.Value
            end)
        end)
        if char then
        char.Humanoid.WalkSpeed = speed.Value
            change = char:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            char.Humanoid.WalkSpeed = speed.Value
            end)
        end
        repeat task.wait() until not flags.loopspeed
         if change then
         change:Disconnect()
         end
         if ch then
         ch:Disconnect()
         end
         characteradded:Disconnect()
     end
end)
window_player.toggle("无减速",false,function(val)
    flags.noslow = val
    if val then
        local change
        local characteradded
        characteradded = plr.CharacterAdded:Connect(function()
        if not flags.loopspeed then
            repeat task.wait() until char:FindFirstChild("Humanoid")
            change = char.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                if char.Humanoid.WalkSpeed < 16 and not flags.loopspeed then
                        char.Humanoid.WalkSpeed = 16
                    end
                end)
            end
        end)
        if char and not flags.loopspeed then
        char.Humanoid.WalkSpeed = 16
                change = char:FindFirstChildOfClass("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                if char.Humanoid.WalkSpeed < 16 and not flags.loopspeed then
                    char.Humanoid.WalkSpeed = 16
                end
            end)
        end
        repeat task.wait() until not flags.noslow
        if change then
        change:Disconnect()
        end
        characteradded:Disconnect()
    end
end)
window_combat.toggle("近战攻击头部",false,function(val)
    flags.alwayshead = val
end)
window_player.toggle("取消攻击炸药桶",false,function(val)
    flags.cancel = val
end)
window_player.toggle("静默演奏",false,function(val)
    flags.fastdrum = val
end)
window_combat.toggle("僵尸倒地",false,function(val)
    flags.modzombie = val
    if val then
        while flags.modzombie do
            task.wait()
            for i,v in pairs(workspace.Zombies:GetChildren()) do
             pcall(function()
              if v:IsA("Model") and v.Name == "Agent" and v:IsDescendantOf(workspace.Zombies) then
               if Distance(v) <= 10 then
                 if v:GetAttribute("Type") ~= "Barrel" and v:GetAttribute("Type") ~= "Igniter" then
                 local hum = v:FindFirstChildOfClass("Humanoid")
                     if v:GetAttribute("Type") == "Fast" then
                    hum.PlatformStand = true
                    hum.WalkSpeed = 0
                 end
                  if v:GetAttribute("Type") == "Sapper" then
                    hum.PlatformStand = true
                    hum.WalkSpeed = 0
                 end
                  if v:GetAttribute("Type") == "Normal" and Distance(v) <= 8 then
                    if v:FindFirstChild("State").Value == "Slash" or v:FindFirstChild("State").Value == "Claw" then
                    hum.PlatformStand = true
                    hum.WalkSpeed = 0
                   end
                  end
                  v.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0,-20,0)
                end
              end
            end
          end)
        end
      end
    end
end)
window_player.toggle("Runner移动动画",false,function(val)
    flags.runneranim = val
    if val then
    local walk = false
    local idle = false
    local try = false
        while flags.runneranim do
            wait(0.0005)
            if char then
            local Hum = char:FindFirstChildOfClass("Humanoid") or char:FindFirstChildOfClass("AnimationController")
                for i,hold in next, Hum:GetPlayingAnimationTracks() do
                if tostring(hold) == "Hold" or tostring(hold) == "WalkAnim" then
	                hold:Stop()
	                end
	            if idle and tostring(hold) == "RunnerIdle" and not try then
	                local Anim = Instance.new("Animation")
                    Anim.Name = "RunnerIdle"
                    Anim.AnimationId = "rbxassetid://12581784105"
                    local k = char:FindFirstChildOfClass("Humanoid"):LoadAnimation(Anim)
                    task.wait(0.005)
                    k:Play()
                    task.wait(0.1)
                    k:Play()
                    try = true
	                end
                end
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid.MoveDirection.X == 0 and humanoid.MoveDirection.Z == 0 then
                for i,v in next, Hum:GetPlayingAnimationTracks() do
                    if tostring(v) == "RunnerWalk" then
		            v:Stop()
		            walk = false
                        end
                    end
                    if not idle then
                    repeat task.wait() until humanoid.MoveDirection.X == 0 and humanoid.MoveDirection.Z == 0
                    local Anim = Instance.new("Animation")
                    Anim.Name = "RunnerIdle"
                    Anim.AnimationId = "rbxassetid://12581784105"
                    local k = char:FindFirstChildOfClass("Humanoid"):LoadAnimation(Anim)
                    task.wait(0.01)
                    k:Play()
                    idle = true
                    end
                elseif not walk then
                for i,v in next, Hum:GetPlayingAnimationTracks() do
                    if tostring(v) == "RunnerIdle" then
		            v:Stop()
		            idle = false
		            try = false
                        end
                    end
                    local walks5 = {"12581786940","12581785298","12581788539"}
                    local Anim = Instance.new("Animation")
                    Anim.Name = "RunnerWalk"
                    Anim.AnimationId = "rbxassetid://"..walks5[math.random(1, #walks5)]
                    local k = char:FindFirstChildOfClass("Humanoid"):LoadAnimation(Anim)
                    k:Play()
                    walk = true
                    try = false
                end
            end
        end
        repeat task.wait() until not flags.runneranim
        local Hum = char:FindFirstChildOfClass("Humanoid") or char:FindFirstChildOfClass("AnimationController")
       for i,v in next, Hum:GetPlayingAnimationTracks() do
       if tostring(v) == "RunnerWalk" then
		    v:Stop()
	   elseif tostring(v) == "RunnerIdle" then
	        v:Stop()
	        end
	    end
    end
end)
window_player.toggle("工兵僵尸走路动画",false,function(val)
    flags.zapperwalk = val
    if val then
    local walk = false
    local idle = false
        while flags.zapperwalk do
            wait(0.0005)
            if char then
            local Hum = char:FindFirstChildOfClass("Humanoid") or char:FindFirstChildOfClass("AnimationController")
                for i,hold in next, Hum:GetPlayingAnimationTracks() do
                if tostring(hold) == "Hold" or tostring(hold) == "WalkAnim" then
	                hold:Stop()
	                end
                end
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid.MoveDirection.X == 0 or humanoid.MoveDirection.Z == 0 then
                for i,v in next, Hum:GetPlayingAnimationTracks() do
                    if tostring(v) == "ZapperWalk" then
		            v:Stop()
		            walk = false
                        end
                    end
                    if not idle then
                    local Anim = Instance.new("Animation")
                    Anim.Name = "ZapperIdle"
                    Anim.AnimationId = "rbxassetid://14498563473"
                    local k = char:FindFirstChildOfClass("Humanoid"):LoadAnimation(Anim)
                    k:Play()
                    idle = true
                    end
                elseif not walk then
                for i,v in next, Hum:GetPlayingAnimationTracks() do
                    if tostring(v) == "ZapperIdle" then
		            v:Stop()
		            idle = false
                        end
                    end
                    local Anim = Instance.new("Animation")
                    Anim.Name = "ZapperWalk"
                    Anim.AnimationId = "rbxassetid://14498289874"
                    local k = char:FindFirstChildOfClass("Humanoid"):LoadAnimation(Anim)
                    k:Play()
                    walk = true
                end
            end
        end
        repeat task.wait() until not flags.zapperwalk
        local Hum = char:FindFirstChildOfClass("Humanoid") or char:FindFirstChildOfClass("AnimationController")
       for i,v in next, Hum:GetPlayingAnimationTracks() do
       if tostring(v) == "ZapperWalk" then
		    v:Stop()
	   elseif tostring(v) == "ZapperIdle" then
	        v:Stop()
	        end
	    end
    end
end)
local zombiesesp = library.window("僵尸透视类型")
zombiesesp.hide()
window_esp.toggle("僵尸透视",false,function(val)
    flags.zombies = val
    if val then
    zombiesesp.show()
    repeat task.wait() until not flags.zombies
    zombiesesp.hide()
    end
end)
zombiesesp.toggle("runner透视",false,function(val)
    flags.runneresp = val
    if val then
    local function zombie(v)
    if v:isA("Model") and v.Name == "Agent" then
    if v:GetAttribute("Type") == "Fast" then
    local root = v:WaitForChild("HumanoidRootPart")
    task.wait()
    local h = textesp(Color3.fromRGB(255,51,51),root,"Runner",0.0)
    table.insert(esptable.runner,h)
     end
   end
end
    local addconnect
         addconnect = workspace.Zombies.ChildAdded:Connect(function(s)
         zombie(s)
    end)
    for i,v in pairs(workspace.Zombies:GetChildren()) do
    zombie(v)
 end
    repeat task.wait() until not flags.runneresp
    addconnect:Disconnect()
 
    for i,v in pairs(esptable.runner) do
    v.delete()
    end
  end
end)
zombiesesp.toggle("爆炸桶透视",false,function(val)
    flags.barrelesp = val
    if val then
    local function zombie(v)
    if v:isA("Model") and v.Name == "Agent" then
    if v:GetAttribute("Type") == "Barrel" then
    local root = v:WaitForChild("HumanoidRootPart")
    task.wait()
    local h = esp(v,Color3.fromRGB(255,128,0),root,"Bomber",0.0)
    table.insert(esptable.barrel,h)
     end
   end
end
    local addconnect
         addconnect = workspace.Zombies.ChildAdded:Connect(function(s)
         zombie(s)
    end)
    for i,v in pairs(workspace.Zombies:GetChildren()) do
    zombie(v)
 end
    repeat task.wait() until not flags.barrelesp
    addconnect:Disconnect()
 
    for i,v in pairs(esptable.barrel) do
    v.delete()
    end
  end
end)
zombiesesp.toggle("工兵僵尸透视",false,function(val)
    flags.sapperesp = val
    if val then
    local function zombie(v)
    if v:isA("Model") and v.Name == "Agent" then
    if v:GetAttribute("Type") == "Sapper" then
    local root = v:WaitForChild("HumanoidRootPart")
    task.wait()
    local h = textesp(Color3.fromRGB(0,204,204),root,"Sapper",0.8)
    table.insert(esptable.sapper,h)
     end
   end
end
    local addconnect
         addconnect = workspace.Zombies.ChildAdded:Connect(function(s)
         zombie(s)
    end)
    for i,v in pairs(workspace.Zombies:GetChildren()) do
    zombie(v)
 end
    repeat task.wait() until not flags.sapperesp
    addconnect:Disconnect()
 
    for i,v in pairs(esptable.sapper) do
    v.delete()
    end
  end
end)
zombiesesp.toggle("焚火者透视",false,function(val)
    flags.Igniteresp = val
    if val then
    local function zombie(v)
    if v:isA("Model") and v.Name == "Agent" then
    if v:GetAttribute("Type") == "Igniter" then
    local root = v:WaitForChild("HumanoidRootPart")
    task.wait()
    local h = textesp(Color3.fromRGB(204,204,0),root,"Lighter",0.0)
    --我不管我不管它就叫打火机:(
    table.insert(esptable.Igniter,h)
     end
   end
end
    local addconnect
         addconnect = workspace.Zombies.ChildAdded:Connect(function(s)
         zombie(s)
    end)
    for i,v in pairs(workspace.Zombies:GetChildren()) do
    zombie(v)
 end
    repeat task.wait() until not flags.Igniteresp
    addconnect:Disconnect()
 
    for i,v in pairs(esptable.Igniter) do
    v.delete()
    end
  end
end)
window_esp.toggle("玩家透视",false,function(val)
    flags.esphumans = val
    if val then
         local function playeresp(v)
           if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChild("Torso") then
                local torso = v:WaitForChild("Torso")
                if not isfriend(v.Name) then
                local h = esp(v,Color3.fromRGB(255,255,255),torso,v.Name,0.0)
                table.insert(esptable.players,h)
                     else
                         local h = esp(v,Color3.fromRGB(53,238,135),torso,v.Name,0.0)
                         table.insert(esptable.players,h)
                     end
                 end
             end
        local addconnect
        addconnect = workspace.Players.ChildAdded:Connect(function(pl)
        if pl ~= char then
        playeresp(pl)
            end
        end)
 
        for i,v in pairs(workspace.Players:GetChildren()) do
            if v ~= char then
            task.wait()
                playeresp(v) 
            end
        end
 
        repeat task.wait() until not flags.esphumans
        addconnect:Disconnect()
 
        for i,v in pairs(esptable.players) do
            v.delete()
        end 
    end
end)
window_combat.toggle("Fling Zombies",false,function(val)
    flags.modifyzombies = val
    if val then
    fling.show()
    local LastPosition
    while flags.modifyzombies do
        task.wait()
          pcall(function()
           --start Fling Zombies
           for i,v in pairs(workspace.Zombies:GetChildren()) do
               if v.PrimaryPart and v:FindFirstChildOfClass("Humanoid") and Distance(v) < 10 then
                       local humroot = v.PrimaryPart
                       local hum = v:FindFirstChildOfClass("Humanoid")
                       local state = v.State.Value
                       if flags.slowzombie then
                       hum.WalkSpeed = 4.5
                       end
                       -- Normal Modify --
                          if v:GetAttribute("Type") == "Normal" and flags.flingshambler then
                              if Distance(v) <= 6 and state ~= "Struggle" then
                                swing()
                                humroot.CanCollide = false
                                  if state == "Slash" or state == "Claw" then
                                  swing()
                                  local player = CPlayer()
                                  if flags.tpnormal then
                                      if player then
                                          humroot.CFrame = player.Character.HumanoidRootPart.CFrame
                                      end
                                  end
                                  if not flags.tpnormal or not player then
                                      zombieupspin(v)
                                  end
                              end
                          end
                      end
                      -- Normal Modify end --
               if v:GetAttribute("Type") == "Fast" and flags.flingrunner then
               if state == "Charge" or state == "FollowPath" then
               local player = CPlayer()
                  if flags.tprunner then
                       if player then
                          zombietp2plr(v)
                      end
                  end
                  if not flags.tprunner or not player then
                          zombiedown(v)
                      end
                  end
              end
              if v:GetAttribute("Type") == "Sapper" and flags.flingsapper then
                 if state == "Swing" then
                     local player = CPlayer()
                         if flags.tpsapper then
                             if player then
                                 zombietp2plr(v)
                             end
                         end
                             if not flags.tpsapper or not player then
                                    zombieupspin(v)
                                end
                            end
                        end
                    end
                end
           --end Fling Zombies
            end)
        end
    repeat task.wait() until not flags.modifyzombies
    fling.hide()
    end
end)
 
fling.toggle("shambler遁地",false,function(val)
    flags.flingshambler = val
end)
fling.toggle("runner遁地",false,function(val)
    flags.flingrunner = val
end)
fling.toggle("sapper飞天",false,function(val)
     flags.flingsapper = val
end)
fling.toggle("传送runner",false,function(val)
    flags.tprunner = val
end)
fling.toggle("传送sapper",false,function(val)
    flags.tpsapper = val
end)
fling.toggle("传送shambler",false,function(val)
    flags.tpnormal = val
end)
fling.button("隐藏修改僵尸设置",function()
fling.hide()
end)
 
window_combat.toggle("杀戮光环",false,function(val)
    flags.silentaura = val
    if val then
    silentaura.show()
    local function Attack(v,item,head)
        local Head = {
             [1] = "HitZombie",
             [2] = v,
             [3] = v.Head.Position + char.Head.CFrame.LookVector * 2.55,
             [4] = true
        }
        local Legs = {
             [1] = "HitZombie",
             [2] = v,
             [3] = v.L.CFrame.Position + char.Head.CFrame.LookVector * 2.55,
             [4] = false
        }
        if item.Parent ~= char then
        item.Parent = char
        end
        item.RemoteEvent:FireServer("Swing","Side")
        if head and v:GetAttribute("Type") ~= "barrel" then
            item.RemoteEvent:FireServer(unpack(Head))
        else
            item.RemoteEvent:FireServer(unpack(Legs))
        end
    end
      local AutoRotate = false
      local lookrange = 10
      local attackrange = 10
      local waittime = 0.01
        while flags.silentaura do
            task.wait(0.0055)
            pcall(function()
            attacking = false
            for i,v in pairs(workspace.Zombies:GetChildren()) do
                if v and v.PrimaryPart and v:FindFirstChildOfClass("Humanoid") and char and not attacking then
                    if v.State and v.State.Value ~= "Spawn" and char:FindFirstChildOfClass("Humanoid") and char:FindFirstChildOfClass("Humanoid").Health > 0 then
                        if Distance(v) <= 19 then
                        local barrel = false
                        if v:GetAttribute("Type") == "Barrel" and not flags.barrel then
                            barrel = true
                            end
                            attackrange = 10
                            lookrange = 10
                            local item
                            if v:GetAttribute("Type") == "Barrel" and flags.barrel and not barrel then
                            item = getPike()
                            if not item then
                                item = getMelee()
                                end
                            else
                            item = getnotpikeMelee()
                            end
                            if item.Name == "Pike" then
                                attackrange = 17
                                lookrange = 17
                            elseif item.Name == "Axe" then
                                attackrange = 8
                                lookrange = 8
                            end
                            --start run
                                    if Distance(v) <= lookrange and flags.rotation and ((v:GetAttribute("Type") ~= "Barrel" and not barrel) or flags.barrel) then
                                        AutoRotate = char.Humanoid.AutoRotate
                                        if AutoRotate then
                                        char.Humanoid.AutoRotate = false
                                        end
                                        local pos = v.PrimaryPart.CFrame.Position
                                        char.PrimaryPart.CFrame = CFrame.lookAt(char.HumanoidRootPart.CFrame.Position, Vector3.new(pos.X,char.HumanoidRootPart.CFrame.Position.Y,pos.Z))
                                        char.Humanoid.AutoRotate = AutoRotate
                                    end
                                if Distance(v) <= attackrange and (not barrel and not flags.barrel) then
                                    Attack(v,item,flags.attackhead)
                               elseif Distance(v) <= attackrange and flags.barrel then
                                    attacking = true
                                    Attack(v,item,false)
                                end
                            --end run
                            end
                        end
                    end
                end
            end)
        end
        repeat task.wait() until not flags.silentaura
        silentaura.hide()
    end
end)
window_combat.toggle("杀戮光环2",false,function(val)
    flags.silentaura = val
    if val then
    silentaura.show()
    --摆烂了
    local swing = false
    local function Attack(v,item,head)
        local Head = {
             [1] = "HitZombie",
             [2] = v,
             [3] = v.Head.Position + char.Head.CFrame.LookVector * 2.55,
             [4] = true
        }
        local Legs = {
             [1] = "HitZombie",
             [2] = v,
             [3] = v.L.CFrame.Position + char.Head.CFrame.LookVector * 2.55,
             [4] = false
        }
    if item.Parent ~= char then
        item.Parent = char
    end
    if not swing then
        item.RemoteEvent:FireServer("Swing","Side")
        swing = true
    end
    if head and v:GetAttribute("Type") ~= "barrel" then
            item.RemoteEvent:FireServer(unpack(Head))
        else
            item.RemoteEvent:FireServer(unpack(Legs))
        end
        attacking = false
    end
    local attackrange = 10
    local lookrange = 10
    local zombies = {}
    silentaura.show()
    local spin = Instance.new("Part",Folder)
    spin.Name = randomstring()
    local velocity = Instance.new("BodyAngularVelocity",spin)
    velocity.Name = randomstring()
    local position = Instance.new("BodyPosition",spin)
    spin.Transparency = 1
    position.Name = randomstring()
    position.D = 20000
    position.MaxForce = Vector3.new(999999999,999999999,999999999)
    position.P = 1000000000
    velocity.MaxTorque = Vector3.new(999999999, 999999999, 999999999)
    velocity.AngularVelocity = Vector3.new(0,20,0)
    spin.CanCollide = false
        while flags.silentaura do
        xpcall(function()
        task.wait()
            if char and char.PrimaryPart and char:FindFirstChildOfClass("Humanoid") then
            position.Position = char.PrimaryPart.Position
            local dir = spin.CFrame.LookVector * 19
            local raycastparams = RaycastParams.new()
            raycastparams.FilterDescendantsInstances = {workspace.Zombies}
            raycastparams.FilterType = Enum.RaycastFilterType.Include
            raycastparams.IgnoreWater = true
            local ray = workspace:Raycast(char.PrimaryPart.Position,dir,raycastparams)
            if ray then
               if ray.Instance:IsA("BasePart") then
                        if not table.find(zombies,ray.Instance.Parent) then
                            table.insert(zombies,ray.Instance.Parent)
                        end
                    end
                end
            end
        for i,v in pairs(zombies) do
        swing = false
            if v and v.PrimaryPart and Distance(v) <= 20 then
                --ffffffffffff--
                    if v.State and v.State.Value ~= "Spawn" and char:FindFirstChildOfClass("Humanoid") and char:FindFirstChildOfClass("Humanoid").Health > 0 then
                        local barrel = false
                        if v:GetAttribute("Type") == "Barrel" and not flags.barrel then
                            barrel = true
                            end
                            attackrange = 10
                            lookrange = 10
                            local item
                            if v:GetAttribute("Type") == "Barrel" and flags.barrel and not barrel then
                            item = getPike()
                            if not item then
                                    item = getMelee()
                                end
                            else
                                item = getnotpikeMelee()
                            end
                        if item.Name == "Pike" then
                            attackrange = 17
                            lookrange = 17
                        elseif item.Name == "Axe" then
                            attackrange = 8
                            lookrange = 8
                        end
                        if Distance(v) <= lookrange and flags.rotation and ((v:GetAttribute("Type") ~= "Barrel" and not barrel) or flags.barrel) then
                            AutoRotate = char.Humanoid.AutoRotate
                            if AutoRotate then
                                char.Humanoid.AutoRotate = false
                            end
                            local pos = v.PrimaryPart.CFrame.Position
                            char.PrimaryPart.CFrame = CFrame.lookAt(char.HumanoidRootPart.CFrame.Position, Vector3.new(pos.X,char.HumanoidRootPart.CFrame.Position.Y,pos.Z))
                            char.Humanoid.AutoRotate = AutoRotate
                        end
                        if Distance(v) <= attackrange and (not barrel and not flags.barrel) then
                                Attack(v,item,flags.attackhead)
                            elseif Distance(v) <= attackrange and flags.barrel and not attacking then
                                attacking = true
                                Attack(v,item,false)
                            end
                        end
                    end
                end
            end,printerror)
        end
        repeat task.wait() until not flags.silentaura
        silentaura.hide()
        spin:Destroy()
    end
end)
silentaura.toggle("转向僵尸",false,function(val)
     flags.rotation = val
end)
silentaura.toggle("攻击头部",false,function(val)
    flags.attackhead = val
end)
silentaura.toggle("攻击炸药桶",false,function(val)
    flags.barrel = val
end)
gui.button("显示/隐藏",function()
    if gui then
    window_esp.hide()
    window_combat.hide()
    window_player.hide()
    fling.hide()
    silentaura.hide()
    zombiesesp.hide()
    gui = false
    else
    window_esp.show()
    window_combat.show()
    window_player.show()
    gui = true
    end
end)
silentaura.button("隐藏功能设置",function()
silentaura.hide()
end)
gui.button("水桶灭火",function()
if not char then
return
end
local bucket = char:FindFirstChild("Water Bucket")
if not bucket then
 for i,v in pairs(plr.Backpack:GetChildren()) do
  if v.Name == "Water Bucket" then
   bucket = v
   v.Parent = char
  end
 end
end
if bucket then
  bucket.RemoteEvent:FireServer("Throw")
  bucket.Parent = plr.Backpack
 end 
end)
gui.button("工兵僵尸武器挥舞动画",function()
    if char then
        local tool = char:FindFirstChild("Axe") or char:FindFirstChild("Pickaxe") or char:FindFirstChild("Pike") or plr.Backpack:FindFirstChild("Axe") or plr.Backpack:FindFirstChild("Pickaxe") or plr.Backpack:FindFirstChild("Pike") 
        if tool.Parent ~= char then
        tool.Parent = char
        end
        local Handle = Instance.new("Part", tool)
        Handle.Name = "Handle"
        if tool.Name == "Pike" then
        Handle.Size = Vector3.new(13,0.05,0.888)
        else
        Handle.Size = Vector3.new(0.888, 7, 0.888)
        end
        Handle.CanCollide = false
        Handle.Transparency = 1
        task.spawn(function() 
        task.wait(2.5)
        Handle:Destroy()
        end)
        task.spawn(function()
            repeat
            task.wait()
            pcall(function()
            if tool.Name ~= "Pike" then
            Handle.CFrame = char.Model.Blade.CFrame
            else
            Handle.CFrame = char.Model.Handle.CFrame
            end
            end)
            until not Handle
        end)
        local Anim = Instance.new("Animation")
        Anim.Name = "Zapper Swing"
        Anim.AnimationId = "rbxassetid://14499470197"
        local k = char:FindFirstChildOfClass("Humanoid"):LoadAnimation(Anim)
        k:Play()
        Handle.Touched:Connect(function(Hit)
        pcall(function()
        if Hit.Parent ~= char and Hit.Parent ~= Model and Hit.Parent.Name ~= "3D_Clothing" then
               if Hit.Parent.Zombie then
               local Head = {
               [1] = "HitZombie",
               [2] = Hit.Parent,
               [3] = Hit.Parent.Head.CFrame.Position,
               [4] = true
               }
               tool.RemoteEvent:FireServer("Swing","Over")
               tool.RemoteEvent:FireServer(unpack(Head))
                    end
                end
            end)
        end)
    end
end)
gui.button("扑倒自sha(bushi)",function()
if char then
 local item = getMelee()
 for _,v in pairs(workspace.Zombies:GetChildren()) do
 pcall(function()
  if v:GetAttribute("Type") ~= "Barrel" then
   if v:FindFirstChild("HumanoidRootPart") then
    Attack(item,true,true,v,true)
     end
    end
   end)
  end
 end
end)
gui.slider("Loop Speed Value",16,40,1,16,function(val)
    speed.Value = val
end)
window_combat.label("本脚本仅用于讨论,封号概不负责!!!!!!!")
window_combat.label("imblood")
window_combat.label("B站账号:Super明月清风")
window_combat.copy("UID:3546671562623445")
window_combat.label("B站账号:imblood")
window_combat.copy("UlD:666694240")
window_esp.button("关闭界面",function()
    flags = DELFLAGS
    newfling = {table.unpack(newfling)}
    connect:Disconnect()
    Folder:Destroy()
    task.wait()
    hookmetamethod(game,"__namecall",originalNC)
    library.delete()
end)
originalNC = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
     local name = tostring(self)
     local args = {...}
     local method = getnamecallmethod()
     if flags.fastdrum and args[1] == "UpdateAccuracy" then
             args[2] = 100
             return originalNC(self,unpack(args))
         end
     if args[1] == "HitZombie" then
     task.spawn(function()
     local zombie = args[2]
     if flags.alwayshead and not flags.silentaura and args and zombie and zombie:GetAttribute("Type") ~= "Barrel" and string.lower(method) == "fireserver" then
         args[3] = zombie.Head.Position
         args[4] = true
         return originalNC(self,unpack(args))
     elseif not flags.silentaura and flags.cancel and args and zombie and zombie:GetAttribute("Type") == "Barrel" and string.lower(method) == "fireserver" then
         args[2] = "nil"
         args[3] = Vector3.new(math.huge,math.huge,math.huge)
         return originalNC(self,unpack(args))
         end
         end)
     end
     return originalNC(self,unpack(args))
end))
char = plr.Character or plr.CharacterAdded:Wait()