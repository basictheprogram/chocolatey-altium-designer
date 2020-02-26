Const $text = "Altium Designer 18 Installer"

Func Install($config)
    Local $install = $config.Item("install")
    ConsoleWrite("Install: " & $install & @LF)

    ; Run installation program
    Run($install)

    ; Welcome to Altium Designer Installer
    ;
	ConsoleWrite("Welcome" & @LF)
    WinWaitActive($text)
	Sleep(1000)
    Send("!n")

    ; License Agreement
    ;
	ConsoleWrite("License" & @LF)
    WinWait($text, "ALTIUM LLC END-USER LICENSE AGREEMENT")
    ControlCommand($text, "", "[CLASS:TXPRadioButton; INSTANCE:1]", "Check", "")
	Sleep(1000)
    Send("!n")

    ; Select Design Functionality
    ;
	ConsoleWrite("Select Design Functionality" & @LF)
    WinWait($text, "Next")
    Send("!n")

    ; Destination Folders
	ConsoleWrite("Destination Folders" & @LF)
	WinWait($text, "Program Files")
    Send("!n")

    ; Ready To Install
	ConsoleWrite("Ready To Install" & @LF)
	WinWait($text, "Next")
    Send("!n")

    ; Installation Complete
	WinWait($text, "Run Altium Designer")
    ;ControlCommand($text, "", "[CLASS:TXPCheckBox; INSTANCE:1]", "UnCheck", "")
	Send("!r")
	ConsoleWrite("Complete" & @LF)
    Send("!f")
	ConsoleWrite("Finish" & @LF)

    WinClose($text)
 EndFunc

ConsoleWrite("Starting" & @LF)

Local $config = ObjCreate("Scripting.Dictionary")
$config.Add("install", $CmdLine[1])

#RequireAdmin
Install($config)
ConsoleWrite("End of Install!" & @LF)