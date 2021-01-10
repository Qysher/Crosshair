; Gui
c_top := true
c_bottom := true
c_left := true
c_right := true
c_dot := false
c_rainbow := false
c_r_red := 255
c_r_green := 0
c_r_blue := 0
c_r := 0
c_g := 0
c_b := 0
c_color := 0xff0000
nameGui := rand()
name1 := rand()
name2 := rand()
name3 := rand()
name4 := rand()
name5 := rand()
Gui, Add, Text, x2 y9 w60 h20 , Size:
Gui, Add, Text, x2 y39 w60 h20 , Width:
Gui, Add, Text, x2 y69 w60 h20 , Gap:
Gui, Add, Slider, x72 y9 w190 h20 gdrawCrosshair  AltSubmit +Range0-100 +ToolTip vsize, 1
Gui, Add, Slider, x72 y39 w190 h20 gdrawCrosshair AltSubmit +Range0-100 +ToolTip vwidth, 1
Gui, Add, Slider, x72 y69 w190 h20 gdrawCrosshair AltSubmit +Range0-100 +ToolTip vgap, 1
Gui, Add, Text, x2 y99 w60 h20 , Dot
Gui, Add, Button, x72 y99 w190 h20 gdot vdot_button, (Off)
Gui, Add, Text, x2 y129 w60 h20 , Toggle parts
Gui, Add, Button, x72 y129 w40 h20 gup, Top
Gui, Add, Button, x122 y129 w40 h20 gbottom, Bottom
Gui, Add, Button, x172 y129 w40 h20 gleft, Left
Gui, Add, Button, x222 y129 w40 h20 gright, Right
Gui, Add, Text, x2 y159 w60 h20, Rainbow
Gui, Add, Button, x72 y159 w190 h20 grainbow vrnb_btn, (Off)
Gui, Add, Text, x2 y189 w60 h20 , Red:
Gui, Add, Text, x2 y219 w60 h20 , Green:
Gui, Add, Text, x2 y249 w60 h20 , Blue:
Gui, Add, Slider, x72 y189 w95 h20 gupdateColor AltSubmit +Range1-51 +ToolTip vred, 51
Gui, Add, Slider, x72 y219 w95 h20 gupdateColor AltSubmit +Range1-51 +ToolTip vgreen, 0
Gui, Add, Slider, x72 y249 w95 h20 gupdateColor AltSubmit +Range1-51 +ToolTip vblue, 0
Gui, Add, Progress, x179 y189 w80 h80 +Background%c_color% vcolor_box, 0
Gui, Show, w269 h275, %nameGui%

global size
global width
global gap
global red
global green
global blue
global c_dot
global c_rainbow
global c_top
global c_bottom
global c_left
global c_right

configload()

Goto, updateColor
Goto, drawCrosshair
return

updateColor:
Gui, submit, nohide
c_color := RGB(red * 5, green * 5, blue * 5)
GuiControl,+Background%c_color%, color_box
Goto, drawCrosshair
return

rainbow:
c_rainbow := !c_rainbow
rainbow(c_rainbow)
return

rainbow(toggle) {
	if(toggle)
	{
		btn_str := "(On)"
		SetTimer, rainbow_loop, 10
	}
	else
	{
		btn_str := "(Off)"
		SetTimer, rainbow_loop, Off
	}
	GuiControl,, rnb_btn, %btn_str%
	return
}

dot:
c_dot := !c_dot
dot(c_dot)
Goto, drawCrosshair
return

dot(toggle) {
	if(c_dot)
		btn_str := "(On)"
	else
		btn_str := "(Off)"
	GuiControl,, dot_button, %btn_str%
}

up:
c_top := !c_top
Goto, drawCrosshair
return

bottom:
c_bottom := !c_bottom
Goto, drawCrosshair
return

left:
c_left := !c_left
Goto, drawCrosshair
return

right:
c_right := !c_right
Goto, drawCrosshair
return

rainbow_loop:
step := 1
if(c_r_green < 255 && c_r_red == 255 && c_r_blue == 0)
	c_r_green += step
else if(c_r_green == 255 && c_r_red > 0 && c_r_blue == 0)
	c_r_red -= step
else if(c_r_green == 255 && c_r_red == 0 && c_r_blue < 255)
	c_r_blue += step
else if(c_r_green > 0 && c_r_red == 0 && c_r_blue == 255)
	c_r_green -= step
else if(c_r_green == 0 && c_r_red < 255 && c_r_blue == 255)
	c_r_red += step
else if(c_r_green == 0 && c_r_red == 255 && c_r_blue > 0)
	c_r_blue -= step
c_color := RGB(c_r_red, c_r_green, c_r_blue)
Gui, 99:Color, %c_color%
Gui, 98:Color, %c_color%
Gui, 97:Color, %c_color%
Gui, 96:Color, %c_color%
Gui, 95:Color, %c_color%
GuiControl,+Background%c_color%, color_box
GuiControl,, red, % Floor(c_r_red / 5)
GuiControl,, green, % Floor(c_r_green / 5)
GuiControl,, blue, % Floor(c_r_blue / 5)
return

drawCrosshair:
Gui, submit, nohide
/*
WinGetActiveTitle, a_title
WinGetPos, winX, winY, winW, winH, %a_title%
halfW := winX + winW / 2
halfH := winY + winH / 2
*/
halfW := A_ScreenWidth / 2
halfH := A_ScreenHeight / 2

tmpWidth := width
offset := 0

if(width == 0) {
	tmpWidth := 1
	offset := 1
}

if(c_left)
	drawBox(halfW - size - gap, halfH - tmpWidth, halfW - gap, halfH + tmpWidth - offset, c_color, 255, 99, name1)
else
	Gui, 99:destroy

if(c_right)
	drawBox(halfW + gap - offset, halfH - tmpWidth, halfW + gap + size - offset, halfH + tmpWidth - offset, c_color, 255, 98, name2)
else
	Gui, 98:destroy

if(c_top)
	drawBox(halfW - tmpWidth, halfH - size - gap, halfW + tmpWidth - offset, halfH - gap, c_color, 255, 97, name3)
else
	Gui, 97:destroy

if(c_bottom)
	drawBox(halfW - tmpWidth, halfH + gap - offset, halfW + tmpWidth - offset, halfH + size + gap - offset, c_color, 255, 96, name4)
else
	Gui, 96:destroy

if(c_dot)
	drawBox(halfW - tmpWidth, halfH - tmpWidth, halfW + tmpWidth - offset, halfH + tmpWidth - offset, c_color, 255, 95, name5)
else
	Gui, 95:destroy
return

rand()
{
	Random, rand, 1000000, 9999999
	return %rand%
}

drawBox(x, y, x2, y2, box_color, transparency, gui_count, gui_name)
{
	Gui, %gui_count%:destroy
	Gui, %gui_count%:Color, 0x0000ff
	Gui, %gui_count%: -Caption +E0x80000 +LastFound +OwnDialogs +Owner +AlwaysOnTop +E0x20
	gui, %gui_count%:margin,, 0
	w := x2 - x
	h := y2 - y
	Gui, %gui_count%:Show, x%x% y%y% w%w% h%h% NoActivate, %gui_name%
	WinSet, TransColor, c0000ff %transparency%, %gui_name%
	Gui, %gui_count%: Color, %box_color%
}

RGB(r, g, b) {
	var:=(r << 16) + (g << 8) + b
	Old := A_FormatInteger
	SetFormat, Integer, Hex
	var += 0
	SetFormat, Integer, %Old%
	return var
}

configsave()
{
	configPath = %A_AppData%\CustomCrosshair\config.ini
	Gui, Submit, nohide
	MouseGetPos, mouseX, mouseY
	FileCreateDir, %A_AppData%\CustomCrosshair\
	IniWrite, %size%, %configPath%, Crosshair, Size
	IniWrite, %width%, %configPath%, Crosshair, Width
	IniWrite, %gap%, %configPath%, Crosshair, Gap
	IniWrite, %red%, %configPath%, Crosshair, Red
	IniWrite, %green%, %configPath%, Crosshair, Green
	IniWrite, %blue%, %configPath%, Crosshair, Blue
	IniWrite, %c_dot%, %configPath%, Crosshair, Dot
	IniWrite, %c_rainbow%, %configPath%, Crosshair, Rainbow
	IniWrite, %c_top%, %configPath%, Crosshair, Top
	IniWrite, %c_bottom%, %configPath%, Crosshair, Bottom
	IniWrite, %c_left%, %configPath%, Crosshair, Left
	IniWrite, %c_right%, %configPath%, Crosshair, Right
	ToolTip
}

configload()
{
	configPath = %A_AppData%\CustomCrosshair\config.ini
	if(!FileExist(configPath)) {
		return
	}
	Gui, Submit, nohide
	MouseGetPos, mouseX, mouseY
	IniRead, IniSize, %configPath%, Crosshair, Size
	IniRead, IniWidth, %configPath%, Crosshair, Width
	IniRead, IniGap, %configPath%, Crosshair, Gap
	IniRead, IniRed, %configPath%, Crosshair, Red
	IniRead, IniGreen, %configPath%, Crosshair, Green
	IniRead, IniBlue, %configPath%, Crosshair, Blue
	IniRead, IniDot, %configPath%, Crosshair, Dot
	IniRead, IniRainbow, %configPath%, Crosshair, Rainbow
	IniRead, IniTop, %configPath%, Crosshair, Top
	IniRead, IniBottom, %configPath%, Crosshair, Bottom
	IniRead, IniLeft, %configPath%, Crosshair, Left
	IniRead, IniRight, %configPath%, Crosshair, Right

	c_top := IniTop == "1"
	c_bottom := IniBottom == "1"
	c_left := IniLeft == "1"
	c_right := IniRight == "1"
	c_dot := IniDot == "1"
	c_rainbow := IniRainbow == "1"

	GuiControl, 1:, size, %IniSize%
	GuiControl, 1:, width, %IniWidth%
	GuiControl, 1:, gap, %IniGap%
	GuiControl, 1:, red, %IniRed%
	GuiControl, 1:, green, %IniGreen%
	GuiControl, 1:, blue, %IniBlue%

	rainbow(c_rainbow)
	dot(c_dot)
}

GuiClose:
	Gui, Hide
	configsave()
	ExitApp
