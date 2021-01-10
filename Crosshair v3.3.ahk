;On Exit
OnExit, quit
;Check for lastused
IfNotExist, %A_AppData%\Crosshair v3.3\Configs\lastconfig.ini
{
	lastused=Rust_1||Rust_2|CSGO_1|CSGO_2
}
IfExist, %A_AppData%\Crosshair v3.3\Configs\lastconfig.ini
{
	IniRead, lastused, %A_AppData%\Crosshair v3.3\Configs\lastconfig.ini, LastConfig, Name
}
;Create Crosshair Directory
FileCreateDir, %A_AppData%\Crosshair v3.3\Crosshairs
;Options
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
;Create Variables
sw := A_ScreenWidth / 2
sh := A_ScreenHeight / 2
CustomColor := FF0000
guiname:=Crosshair v3.3 by Qysh
toggle := 0
;global Variables
global CustomColor
global guiname
global toggle
global dest
;Radio Group
Gui, Add, Radio, x22 y59 w90 h20 gRadioUpdate vModeSymbol, Symbol
Gui, Add, Radio, x392 y59 w90 h20 gRadioUpdate vModeImage, Image
;Create GUI
;Gui, Color, 404552
;Gui, Font, c0xD3DAE3
Gui, Add, Text, x132 y29 w90 h20 gUpdate, Symbol:
Gui, Add, Text, x132 y59 w90 h20 gUpdate, Font:
Gui, Add, Text, x132 y89 w90 h20 gUpdate, Size:
Gui, Add, Edit, x232 y29 w110 h20 gUpdate HwndEdit1 vSymbol, +
Gui, Add, Edit, x232 y59 w110 h20 gUpdate HwndEdit2 vFont, Arial
Gui, Add, Edit, x232 y89 w110 h20 gUpdate HwndEdit3 vFontSize, 22
Gui, Add, Text, x22 y119 w90 h20 gUpdate, Position-X:
Gui, Add, Text, x22 y149 w90 h20 gUpdate, Position-Y:
Gui, Add, Slider, x132 y119 w210 h20 AltSubmit gUpdate vPosX Range0-%A_ScreenWidth% +ToolTip, %sw%
Gui, Add, Slider, x132 y149 w210 h20 AltSubmit gUpdate vPosY Range0-%A_ScreenHeight% +ToolTip, %sh%
Gui, Add, Text, x22 y199 w90 h20 , Red:
Gui, Add, Text, x22 y229 w90 h20 , Green:
Gui, Add, Text, x22 y259 w90 h20 , Blue:
Gui, Add, Slider, x132 y199 w210 h20 AltSubmit gUpdate vRed Range0-255 +ToolTip,
Gui, Add, Slider, x132 y229 w210 h20 AltSubmit gUpdate vGreen Range0-255 +ToolTip,
Gui, Add, Slider, x132 y259 w210 h20 AltSubmit gUpdate vBlue Range0-255 +ToolTip,
Gui, Add, Text, x502 y59 w90 h20 , Image Path:
Gui, Add, Text, x392 y89 w90 h20 , Position-X:
Gui, Add, Text, x392 y119 w90 h20 , Position-Y:
Gui, Add, Text, x392 y149 w90 h20 , Size:
Gui, Add, Edit, x602 y59 w110 h20 vfilepath HwndEdit4, FilePath
Gui, Add, Slider, x502 y89 w210 h20 AltSubmit gUpdate vPicPosX Range0-%A_ScreenWidth% +ToolTip, %sw%
Gui, Add, Slider, x502 y119 w210 h20 AltSubmit gUpdate vPicPosY Range0-%A_ScreenHeight% +ToolTip, %sh%
Gui, Add, Slider, x502 y149 w210 h20 AltSubmit gUpdate vPicSize Range0-100 +ToolTip, 25
Gui, Add, Text, x392 y29 w320 h20 , Insert the file path. Example:(MyImages\img.png)
Gui, Add, GroupBox, x12 y9 w340 h290 , Symbol
Gui, Add, GroupBox, x382 y9 w340 h170 , Image
Gui, Add, DropDownList, x432 y228 w110 h80 vddl, %lastused%
Gui, Add, Button, x562 y229 w150 h20 vcheckbind gToggleBinds, EditHotkeys
Gui, Add, Text, x392 y230 w35 h20 , Game:
Gui, Add, GroupBox, x382 y199 w340 h100 , Config
Gui, Add, Button, x392 y259 w150 h20 gSaveConfig, Save
Gui, Add, Button, x562 y259 w150 h20 gLoadConfig, Load
Gui, +LastFound
GuiHwnd := WinExist()
Gui, Show, w741 h315, Crosshair v3.3
;ControlCol(Edit1, GuiHwnd, 0x404552, 0xD3DAE3)
;ControlCol(Edit2, GuiHwnd, 0x404552, 0xD3DAE3)
;ControlCol(Edit3, GuiHwnd, 0x404552, 0xD3DAE3)
;ControlCol(Edit4, GuiHwnd, 0x404552, 0xD3DAE3)
global ModeSymbol
global ModeImage
global Symbol
global Font
global FontSize
global PosX
global PosY
global Red
global Green
global Blue
global filepath
global PicPosX
global PicPosY
global PicSize
Gui, submit, nohide
IfExist, %A_AppData%\Crosshair v3.3\Configs\%ddl%.ini
{
	configload(ddl)
}
return

RadioUpdate:
if(ModeSymbol==1)
{
	hexcolor := RgbToHex(Red, Green, Blue)
	chairsymbol(PosX, PosY, Symbol, hexcolor, FontSize, Font)
}
else if(ModeImage==1)
{
	chairimage(PicPosX, PicPosY, PicSize, filepath, 0)
}
Goto, Update
return

Update:
Gui, submit, nohide
if(ModeSymbol==1)
{
	hexcolor := RgbToHex(Red, Green, Blue)
	bgRed := Red / 2
	bgGreen := Green / 2
	bgBlue := Blue / 2
	bgcolor := RgbToHex(bgRed, bgGreen, bgBlue)
	chairsymbol(PosX, PosY, Symbol, hexcolor, FontSize, Font)
}
else if(ModeImage==1)
{
	chairimage(PicPosX, PicPosY, PicSize, filepath, 1)
}
return

chairsymbol(x, y, symbol, color, size, Font)
{
	name := rand()
	Gui, 2:destroy
	Gui, 2: -Caption +E0x80000 +LastFound +OwnDialogs +Owner +AlwaysOnTop +E0x20
	Gui, 2:Color, c%bgcolor%
	Gui, 2:Font, s%size% q1 c%color%, %Font%
	gui, 2:margin,, 0
	gui, 2:add, text,, %symbol%
	Gui, 2:Show, y%Y% x%X% NoActivate, %name%
	WinSet, TransColor, c%bgcolor% 255
}

chairimage(x, y, size, image, test)
{
	image = %A_AppData%\Crosshair v3.3\Crosshairs\%image%
	if(test==1)
		{
		IfNotExist, %image%
		{
			MsgBox, Image "%image%" doesn't exist!
		}
	}
	IfExist, %image%
	{
		name := rand()
		calcX := x - size / 2
		calcY := y - size / 2
		Gui, 2:destroy
		Gui, 2: -Caption +E0x80000 +LastFound +OwnDialogs +Owner +AlwaysOnTop +E0x20
		Gui, 2:Color, 0x404552
		Gui, 2:margin,, 0
		Gui, 2:add, picture, x0 y0 w%size% h%size% +BackgroundTrans, %image%
		Gui, 2:Show, y%calcY% x%calcX% NoActivate, %name%
		WinSet, TransColor, 0x404552 255
	}
}

RgbToHex(r, g, b) {
	var:=(r << 16) + (g << 8) + b
	OldFormat := A_FormatInteger
	SetFormat, Integer, Hex
	var += 0
	SetFormat, Integer, %OldFormat%
	return var
}

ToggleBinds:
	if(toggle==0)
	{
		toggle = 1
	}
	else
	{
		toggle = 0
	}
return

^Up::
if(toggle!=1) return
Gui, submit, nohide
	if(ModeSymbol==1)
	{
		GuiControl,1:, PosY, +-1
	}
	else if(ModeImage==1)
	{
		GuiControl,1:, PicPosY, +-1
	}
	Goto, Update
return

^Down::
if(toggle!=1) return
Gui, submit, nohide
	if(ModeSymbol==1)
	{
		GuiControl,1:, PosY, +1
	}
	else if(ModeImage==1)
	{
		GuiControl,1:, PicPosY, +1
	}
Goto, Update
return

^Left::
if(toggle!=1) return
Gui, submit, nohide
	if(ModeSymbol==1)
	{
		GuiControl,1:, PosX, +-1
	}
	else if(ModeImage==1)
	{
		GuiControl,1:, PicPosX, +-1
	}
Goto, Update
return

^Right::
if(toggle!=1) return
Gui, submit, nohide
	if(ModeSymbol==1)
	{
		GuiControl,1:, PosX, +1
	}
	else if(ModeImage==1)
	{
		GuiControl,1:, PicPosX, +1
	}
Goto, Update
return

~$*Enter::
	IfWinActive, Crosshair v3.3 by Qysh
	{
		Goto, Update
	}
return

SaveConfig:
Gui, submit, nohide
configsave(ddl)
return

LoadConfig:
Gui, submit, nohide
configload(ddl)
return

configsave(configname)
{
	Gui, Submit, nohide
	MouseGetPos, mouseX, mouseY
	ToolTip, Saving.., %mouseX%, %mouseY%
	FileCreateDir, %A_AppData%\Crosshair v3.3\Configs\
	IniWrite, %ModeSymbol%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, Crosshair, IsSymbolCrosshair
	IniWrite, %Symbol%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, Symbol
	IniWrite, %Font%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, Font
	IniWrite, %FontSize%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, FontSize
	IniWrite, %PosX%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, PosX
	IniWrite, %PosY%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, PosY
	IniWrite, %Red%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, Red
	IniWrite, %Green%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, Green
	IniWrite, %Blue%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, Blue
	IniWrite, %filepath%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, ImageCross, Filepath
	IniWrite, %PicPosX%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, ImageCross, PicPosX
	IniWrite, %PicPosY%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, ImageCross, PicPosY
	IniWrite, %PicSize%, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, ImageCross, PicSize
	Sleep, 100
	ToolTip
}

configload(configname)
{
	Gui, Submit, nohide
	MouseGetPos, mouseX, mouseY
	ToolTip, Loading.., %mouseX%, %mouseY%
	IniRead, IsSymbolCrosshair, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, Crosshair, IsSymbolCrosshair
	IniRead, IniSymbol, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, Symbol
	IniRead, IniFont, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, Font
	IniRead, IniFontSize, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, FontSize
	IniRead, IniPosX, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, PosX
	IniRead, IniPosY, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, PosY
	IniRead, IniRed, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, Red
	IniRead, IniGreen, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, Green
	IniRead, IniBlue, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, SymbolCross, Blue
	IniRead, Inifilepath, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, ImageCross, Filepath
	IniRead, IniPicPosX, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, ImageCross, PicPosX
	IniRead, IniPicPosY, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, ImageCross, PicPosY
	IniRead, IniPicSize, %A_AppData%\Crosshair v3.3\Configs\%configname%.ini, ImageCross, PicSize
	Sleep, 100
	IsSymbolCrosshair := IsSymbolCrosshair == "1"
	IsImageCrosshair := !IsSymbolCrosshair
	GuiControl, 1:, ModeSymbol, %IsSymbolCrosshair%
	GuiControl, 1:, ModeImage, %IsImageCrosshair%
	GuiControl, 1:, Symbol, %IniSymbol%
	GuiControl, 1:, Font, %IniFont%
	GuiControl, 1:, FontSize, %IniFontSize%
	GuiControl, 1:, PosX, %IniPosX%
	GuiControl, 1:, PosY, %IniPosY%
	GuiControl, 1:, Red, %IniRed%
	GuiControl, 1:, Green, %IniGreen%
	GuiControl, 1:, Blue, %IniBlue%
	GuiControl, 1:, filepath, %Inifilepath%
	GuiControl, 1:, PicPosX, %IniPicPosX%
	GuiControl, 1:, PicPosY, %IniPicPosY%
	GuiControl, 1:, PicSize, %IniPicSize%
	ToolTip
}

rand()
{
	Random, rand, 1000000, 9999999
	return %rand%
}

quit:
	Gui, 1:submit, nohide
	if(ddl=="Rust_1")
	{
		IniWrite, Rust_1||Rust_2|CSGO_1|CSGO_2, %A_AppData%\Crosshair v3.3\Configs\lastconfig.ini, LastConfig, Name
	}
	else if(ddl=="Rust_2")
	{
		IniWrite, Rust_1|Rust_2||CSGO_1|CSGO_2, %A_AppData%\Crosshair v3.3\Configs\lastconfig.ini, LastConfig, Name
	}
	else if(ddl=="CSGO_1")
	{
		IniWrite, Rust_1|Rust_2|CSGO_1||CSGO_2, %A_AppData%\Crosshair v3.3\Configs\lastconfig.ini, LastConfig, Name
	}
	else if(ddl=="CSGO_2")
	{
		IniWrite, Rust_1|Rust_2|CSGO_1|CSGO_2||, %A_AppData%\Crosshair v3.3\Configs\lastconfig.ini, LastConfig, Name
	}
	MouseGetPos, mouseX, mouseY
	ToolTip, Saving.., %mouseX%, %mouseY%
	Sleep, 100
	ExitApp
return

GuiClose:
ExitApp
