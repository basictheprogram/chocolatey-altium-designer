Func Install($config)
    Local $install = $config.Item("install")
    ; Run installation program
    Run($install)
 
    ; Welcome to Altium Designer Installer
    ;
    WinWaitActive("Altium Designer 17 Installer")
    Send("!n")

    ; License Agreement
    ;
    WinWaitActive("Altium Designer 17 Installer", "English")
    ControlCommand("Altium Designer 17 Installer", "", "[CLASS:TXPRadioButton; INSTANCE:1]", "Check", "")
    Send("!n")

    ; Log In
    ;
    WinWait("", "Login")
    Send("")
    Send("{TAB}")
    Send("")
    Send("{TAB}")
    Send("{Enter}")

    ; Select Design Functionality
    ;
    Send("!n")
 
    ; Destination Folders
    ;
    Send("!n")

    ; Ready To Install
    Send("!n")
 
    ; Installation Complete
    WinWait("Altium Designer 17 Installer", "Installation Complete")
    Send("!n")

    WinClose("Altium Designer 17 Install!")
 EndFunc
 
; Q: Why are you using AutoIt! to install Altium Designer?
; A: https://techdocs.altium.com/display/ALEG/Altium+Designer+Installation+-+FAQs#AltiumDesignerInstallation-FAQs-Isitpossibletouseasilent/scriptedinstallationsotheITdepartmentcaninstallAltiumDesignercomfortableonmultiplePCs?
;
 Local $config = ObjCreate("Scripting.Dictionary")
 $config.Add("install", $CmdLine[1])
 
 Install($config)
 ConsoleWrite("End of AutoIt Script!" & @LF)