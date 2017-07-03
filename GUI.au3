#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
;#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=c:\users\hungnd\documents\hauto\maingui.kxf
$MainGUI = GUICreate("東方不敗", 320, 151, 1022, 530)
GUISetOnEvent($GUI_EVENT_CLOSE, "thoat")
$Tab1 = GUICtrlCreateTab(8, 8, 305, 137)
$TabSheet6 = GUICtrlCreateTabItem("Gunny")
$Label10 = GUICtrlCreateLabel("Dame", 16, 48, 32, 17)
$dameboss = GUICtrlCreateInput("124", 56, 45, 73, 21)
$Label11 = GUICtrlCreateLabel("Thời gian chờ", 152, 48, 69, 17)
$time= GUICtrlCreateInput("1000", 240, 45, 49, 21)
$Label12 = GUICtrlCreateLabel("Khoảng cách bò", 152, 72, 83, 17)
$boboss = GUICtrlCreateInput("2100", 242, 70, 49, 21)
$Label13 = GUICtrlCreateLabel("Lực bắn", 16, 72, 43, 17)
$lucboss = GUICtrlCreateInput("20", 80, 69, 49, 21)
$Label15 = GUICtrlCreateLabel("Số lần", 17, 106, 34, 17)
$solan = GUICtrlCreateInput("10", 65, 106, 65, 21)
$Button1 = GUICtrlCreateButton("Help", 224, 112, 75, 25)
GUICtrlSetOnEvent(-1, "help")
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
