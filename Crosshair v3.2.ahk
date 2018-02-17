;On Exit
OnExit, quit
;Check for lastused
IfNotExist, C:\Configs\Crosshair v3\lastconfig.ini
{
	lastused=Rust_1||Rust_2|CSGO_1|CSGO_2
}
IfExist, C:\Configs\Crosshair v3\lastconfig.ini
{
	IniRead, lastused, C:\Configs\Crosshair v3\lastconfig.ini, LastConfig, Name
}
;Options
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
;Create Variables
sw := A_ScreenWidth / 2
sh := A_ScreenHeight / 2
CustomColor := FF0000
guiname:=Crosshair v3.2 by Qysh
toggle := 0
;global Variables
global CustomColor
global guiname
global toggle
global dest
;Radio Group
Gui, Add, Radio, x22 y59 w90 h20 gRadioUpdate vModeSymbol, Symbol
Gui, Add, Radio, x392 y59 w90 h20 gRadioUpdate vModePicture, Picture
;Create GUI
Gui, Color, 404552
Gui, Font, c0xD3DAE3
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
Gui, Add, Text, x502 y59 w90 h20 , Picture Path:
Gui, Add, Text, x392 y89 w90 h20 , Position-X:
Gui, Add, Text, x392 y119 w90 h20 , Position-Y:
Gui, Add, Text, x392 y149 w90 h20 , Size:
Gui, Add, Edit, x602 y59 w110 h20 vfilepath HwndEdit4, FilePath
Gui, Add, Slider, x502 y89 w210 h20 AltSubmit gUpdate vPicPosX Range0-%A_ScreenWidth% +ToolTip, %sw%
Gui, Add, Slider, x502 y119 w210 h20 AltSubmit gUpdate vPicPosY Range0-%A_ScreenHeight% +ToolTip, %sh%
Gui, Add, Slider, x502 y149 w210 h20 AltSubmit gUpdate vPicSize Range0-100 +ToolTip, 25
Gui, Add, Text, x392 y29 w320 h20 , Insert the file destination Example:(MyImages\img.png)
Gui, Add, GroupBox, x12 y9 w340 h290 , Symbol
Gui, Add, GroupBox, x382 y9 w340 h170 , Picture
Gui, Add, DropDownList, x432 y228 w110 h80 vddl, %lastused%
Gui, Add, Button, x562 y229 w150 h20 vcheckbind gToggleBinds, EditHotkeys
Gui, Add, Text, x392 y230 w35 h20 , Game:
Gui, Add, GroupBox, x382 y199 w340 h100 , Config
Gui, Add, Button, x392 y259 w150 h20 gSaveConfig, Save
Gui, Add, Button, x562 y259 w150 h20 gLoadConfig, Load
Gui, +LastFound
GuiHwnd := WinExist()
Gui, Show, w741 h315, Crosshair v3.2 by Qysh
ControlCol(Edit1, GuiHwnd, 0x404552, 0xD3DAE3)
ControlCol(Edit2, GuiHwnd, 0x404552, 0xD3DAE3)
ControlCol(Edit3, GuiHwnd, 0x404552, 0xD3DAE3)
ControlCol(Edit4, GuiHwnd, 0x404552, 0xD3DAE3)
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
IfExist, C:\Configs\Crosshair v3\%ddl%.ini
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
else if(ModePicture==1)
{
	chairpicture(PicPosX, PicPosY, PicSize, filepath, 0)
}
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
else if(ModePicture==1)
{
	chairpicture(PicPosX, PicPosY, PicSize, filepath, 1)
}
return

chairsymbol(x, y, symbol, color, size, Font)
{
	Gui, 2:destroy
	Gui, 2: -Caption +E0x80000 +LastFound +OwnDialogs +Owner +AlwaysOnTop +E0x20
	Gui, 2:Color, c%bgcolor%
	Gui, 2:Font, s%size% q1 c%color%, %Font%
	gui, 2:margin,, 0
	gui, 2:add, text,, %symbol%
	Gui, 2:Show, y%Y% x%X% NoActivate, ch
	WinSet, TransColor, c%bgcolor% 255
}

chairpicture(x, y, size, picture, test)
{
	if(test==1)
		{
		IfNotExist, %picture%
		{
			MsgBox, Picture "%picture%" doesn't exist!
		}
	}
	IfExist, %picture%
	{
		Gui, 2:destroy
		Gui 2: -Caption +E0x80000 +LastFound +OwnDialogs +Owner +AlwaysOnTop +E0x20
		Gui, 2:Color, 0x404552
		Gui, 2:margin,, 0
		Gui, 2:add, picture, x0 y0 w%size% h%size% +BackgroundTrans, %picture%
		Gui, 2:Show, y%y% x%x% NoActivate, ch
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
Gui, submit, nohide
	if(ModeSymbol==1 && toggle==1)
	{
		GuiControl,1:, PosY, +-1
	}
	else if(ModePicture==1 && toggle==1)
	{
		GuiControl,1:, PicPosY, +-1
	}
	Goto, Update
return

^Down::
Gui, submit, nohide
	if(ModeSymbol==1 && toggle==1)
	{
		GuiControl,1:, PosY, +1
	}
	else if(ModePicture==1 && toggle==1)
	{
		GuiControl,1:, PicPosY, +1
	}
Goto, Update
return

^Left::
Gui, submit, nohide
	if(ModeSymbol==1 && toggle==1)
	{
		GuiControl,1:, PosX, +-1
	}
	else if(ModePicture==1 && toggle==1)
	{
		GuiControl,1:, PicPosX, +-1
	}
Goto, Update
return

^Right::
Gui, submit, nohide
	if(ModeSymbol==1 && toggle==1)
	{
		GuiControl,1:, PosX, +1
	}
	else if(ModePicture==1 && toggle==1)
	{
		GuiControl,1:, PicPosX, +1
	}
Goto, Update
return

~$*Enter::
	IfWinActive, Crosshair v3.2 by Qysh
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
	FileCreateDir, C:\Configs\Crosshair v3\
	IniWrite, %Symbol%, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, Symbol
	IniWrite, %Font%, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, Font
	IniWrite, %FontSize%, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, FontSize
	IniWrite, %PosX%, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, PosX
	IniWrite, %PosY%, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, PosY
	IniWrite, %Red%, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, Red
	IniWrite, %Green%, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, Green
	IniWrite, %Blue%, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, Blue
	IniWrite, %filepath%, C:\Configs\Crosshair v3\%configname%.ini, PictureCross, filepath
	IniWrite, %PicPosX%, C:\Configs\Crosshair v3\%configname%.ini, PictureCross, PicPosX
	IniWrite, %PicPosY%, C:\Configs\Crosshair v3\%configname%.ini, PictureCross, PicPosY
	IniWrite, %PicSize%, C:\Configs\Crosshair v3\%configname%.ini, PictureCross, PicSize
	Sleep, 500
	ToolTip
}

configload(configname)
{
	Gui, Submit, nohide
	MouseGetPos, mouseX, mouseY
	ToolTip, Loading.., %mouseX%, %mouseY%
	IniRead, IniSymbol, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, Symbol
	IniRead, IniFont, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, Font
	IniRead, IniFontSize, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, FontSize
	IniRead, IniPosX, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, PosX
	IniRead, IniPosY, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, PosY
	IniRead, IniRed, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, Red
	IniRead, IniGreen, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, Green
	IniRead, IniBlue, C:\Configs\Crosshair v3\%configname%.ini, SymbolCross, Blue
	IniRead, Inifilepath, C:\Configs\Crosshair v3\%configname%.ini, PictureCross, filepath
	IniRead, IniPicPosX, C:\Configs\Crosshair v3\%configname%.ini, PictureCross, PicPosX
	IniRead, IniPicPosY, C:\Configs\Crosshair v3\%configname%.ini, PictureCross, PicPosY
	IniRead, IniPicSize, C:\Configs\Crosshair v3\%configname%.ini, PictureCross, PicSize
	Sleep, 500
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

ControlCol(Control, Window, bc="", tc="", redraw=1) {
    a := {}
    a["c"]  := Control
    a["g"]  := Window
    a["bc"] := (bc="")?"":(((bc&255)<<16)+(((bc>>8)&255)<<8)+(bc>>16))
    a["tc"] := (tc="")?"":((tc&255)<<16)+(((tc>>8)&255)<<8)+(tc>>16)
    WindowProc("Set", a, "", "")
    If redraw
    {
        SizeOfWINDOWINFO := 60
        VarSetCapacity(WINDOWINFO, SizeOfWINDOWINFO, 0)
        NumPut(SizeOfWINDOWINFO, WINDOWINFO, "UInt")
        DllCall("GetWindowInfo",  "Ptr", Control, "Ptr", &WINDOWINFO)
        DllCall("ScreenToClient", "Ptr", Window,  "Ptr", &WINDOWINFO+20)
        DllCall("ScreenToClient", "Ptr", Window,  "Ptr", &WINDOWINFO+28)
        DllCall("RedrawWindow"
        , "Ptr",  Window
        , "UInt", &WINDOWINFO+20
        , "UInt", 0
        , "UInt", 0x101)
    }
    
}

WindowProc(hwnd, uMsg, wParam, lParam)
{
    Static Win := {}
    Critical
    If uMsg between 0x132 and 0x138
    If  Win[hwnd].HasKey(lparam)
    {
        If tc := Win[hwnd, lparam, "tc"]
        DllCall("SetTextColor", "UInt", wParam, "UInt", tc)
        If bc := Win[hwnd, lparam, "bc"]
        DllCall("SetBkColor",   "UInt", wParam, "UInt", bc)
        
        return Win[hwnd, lparam, "Brush"]
    }
    If (hwnd = "Set")
    {
        a := uMsg
        Win[a.g, a.c] := a
        If (Win[a.g, a.c, "tc"] = "") and (Win[a.g, a.c, "bc"] = "")
            Win[a.g].Remove(a.c, "")
        If not Win[a.g, "WindowProcOld"]
            Win[a.g,"WindowProcOld"] := DllCall("SetWindowLong", "Ptr", a.g, "Int", -4, "Int", RegisterCallback("WindowProc", "", 4), "UInt")
        If Win[a.g, a.c, "Brush"]
            DllCall("DeleteObject", "Ptr", Brush)
        If (Win[a.g, a.c, "bc"] != "")
            Win[a.g, a.c, "Brush"] := DllCall("CreateSolidBrush", "UInt", a.bc)
        return
    }
    return DllCall("CallWindowProcA", "UInt", Win[hwnd, "WindowProcOld"], "UInt", hwnd, "UInt", uMsg, "UInt", wParam, "UInt", lParam)
}

quit:
	Gui, 1:submit, nohide
	if(ddl=="Rust_1")
	{
		IniWrite, Rust_1||Rust_2|CSGO_1|CSGO_2, C:\Configs\Crosshair v3\lastconfig.ini, LastConfig, Name
	}
	else if(ddl=="Rust_2")
	{
		IniWrite, Rust_1|Rust_2||CSGO_1|CSGO_2, C:\Configs\Crosshair v3\lastconfig.ini, LastConfig, Name
	}
	else if(ddl=="CSGO_1")
	{
		IniWrite, Rust_1|Rust_2|CSGO_1||CSGO_2, C:\Configs\Crosshair v3\lastconfig.ini, LastConfig, Name
	}
	else if(ddl=="CSGO_2")
	{
		IniWrite, Rust_1|Rust_2|CSGO_1|CSGO_2||, C:\Configs\Crosshair v3\lastconfig.ini, LastConfig, Name
	}
	MouseGetPos, mouseX, mouseY
	ToolTip, Saving.., %mouseX%, %mouseY%
	Sleep, 500
	ExitApp
return

GuiClose:
ExitApp