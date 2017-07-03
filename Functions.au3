#include <GDIPlus.au3>
#include <WinAPI.au3>
#include <GUIConstantsEx.au3>
#include <Array.au3>
#include "VirtualKey.au3"
#include <MsgBoxConstants.au3>
#include <Date.au3>
Global $g_bPaused = False, $g_stop=False, $func=0, $reload=False,$ix,$iy,$mau[11],$x_goc=-1,$y_goc=-1
Local Const $tagSTRUCT1 = "struct;long var1;long var2;hwnd var3;char var4[128];long var5;char var6[40];endstruct"
Global $mang[200],$n=0,$chaubau[50],$sochaubau=0
Global $hx,$hy
Local Const $pi = 180/3.141592653589793
Const $WM_MOUSEMOVE= 0x200
Const $WM_LBUTTONDOWN   = 0x201
Const $WM_LBUTTONUP    = 0x202
Const $WM_MBUTTONDOWN  = 0x207
Const $WM_MBUTTONUP    = 0x208
Const $WM_RBUTTONDOWN  = 0x204
Const $WM_RBUTTONUP    = 0x205
Const $WM_NCLBUTTONDOWN  = 0xA1
Const $WM_LBUTTONDBLCLK  = 0x203
Const $WM_MBUTTONDBLCLK  = 0x209
Const $WM_RBUTTONDBLCLK  = 0x206
Const $MK_LBUTTON = 0x1
Const $MK_MBUTTON = 0x10
Const $MK_RBUTTON = 0x2
HotKeySet("^{f2}","autoxu")
HotKeySet("^{f5}","autoboss2")
HotKeySet("{f8}","getgoc")
HotKeySet("^{f9}","anexp")
HotKeySet("{f7}","get")
HotKeySet("^0","dung")
HotKeySet("^1","bugchaubau")
HotKeySet("{PAUSE}", "pause")
HotKeySet("{ESC}", "thoat")

Func dichuyen($huong,$hwnd)

   $bo=getInt($boboss)
   If $huong=0 Then
	  _WinAPI_PostMessage($hwnd,0x100,$VK_LEFT,0)
	  _WinAPI_PostMessage($hwnd,0x101,$VK_LEFT,0)
	  Sleep(100)
	  _WinAPI_PostMessage($hwnd,0x100,$VK_LEFT,0)
	  Sleep($bo)
	  _WinAPI_PostMessage($hwnd,0x101,$VK_LEFT,0)
	  _WinAPI_PostMessage($hwnd,0x100,$VK_RIGHT,0)
	  _WinAPI_PostMessage($hwnd,0x101,$VK_RIGHT,0)
	  Sleep(100)

	  return 1
   Else
	  _WinAPI_PostMessage($hwnd,0x100,$VK_RIGHT,0)
	  _WinAPI_PostMessage($hwnd,0x101,$VK_RIGHT,0)
	  Sleep(100)
	  _WinAPI_PostMessage($hwnd,0x100,$VK_RIGHT,0)
	  Sleep($bo)
	  _WinAPI_PostMessage($hwnd,0x101,$VK_RIGHT,0)
	  _WinAPI_PostMessage($hwnd,0x100,$VK_LEFT,0)
	  _WinAPI_PostMessage($hwnd,0x101,$VK_LEFT,0)
	  Sleep(100)

	  return 0
   EndIf

EndFunc
;=================================================================
Func autoboss2()
   If $n=0 Then
		 MsgBox(0,"Chú ý","Xem kĩ hướng dẫn bắn boss:"& @CRLF & _
		 "Phải full màn hình"& @CRLF & _
		 "Dame: cách buff khi bắn"& @CRLF & _
		 "Bước 1: Vào game, chờ đến lượt bắn, bấm F7"& @CRLF & _
		 "Bước 2: Ctrl+F5 để bắt đầu chạy.",10)
		 Return False
   EndIf
   Local $e,$me,$i=0
   Local $time,$bo,$dame,$hwnd=DllStructGetData($mang[$n-1],"var3")
   $g_stop=False
   $func=5
   ToolTip('Auto bắn boss thế giới...',0,0)
   Sleep(1000)
   Local $huong=0
   While 1
	  If checkluot2() Then
		 Sleep(1000)
		 $kc=tim3dua()
		 If $kc=False Then
			;dame($hwnd,GUICtrlRead($dameboss),getInt($lucboss))
			_WinAPI_PostMessage($hwnd,0x100,$VK_RIGHT,0)
			_WinAPI_PostMessage($hwnd,0x101,$VK_RIGHT,0)
			Sleep(100)
			dame($hwnd,"124444",50)
			If $g_stop Then ExitLoop
			Sleep(3000)
		 Else
			If $kc<0 Then
			   _WinAPI_PostMessage($hwnd,0x100,$VK_RIGHT,0)
			   _WinAPI_PostMessage($hwnd,0x101,$VK_RIGHT,0)
			   $kc=-$kc
			Else
			   _WinAPI_PostMessage($hwnd,0x100,$VK_LEFT,0)
			   _WinAPI_PostMessage($hwnd,0x101,$VK_LEFT,0)
			EndIf
			If $kc<40 Then
			   $huong=dichuyen($huong,$hwnd)
			   If $g_stop Then ExitLoop
			   Sleep(100)
			   dame($hwnd,GUICtrlRead($dameboss),getInt($lucboss))
					 ;ToolTip("dame",10,10)
			   If $g_stop Then ExitLoop
			   Sleep(6000)
			Else
			   dame($hwnd,GUICtrlRead($dameboss),$kc/10)
			   If $g_stop Then ExitLoop
			   Sleep(3000)
			EndIf
		 EndIf
	  Else
		 If checkdie() Then
			;ToolTip("day",$hx+985,$hy+32)
			_WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,19595835)
			_WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,19595835)
			$huong=0
			If $g_stop Then ExitLoop
			Sleep(3000)
		 Else
			;ToolTip("not",$hx+985,$hy+32)
		 EndIf
	  EndIf
	  Sleep(100)
	  If $g_stop Then ExitLoop
   WEnd
   $func=0
   ToolTip('',0,0)
EndFunc
Func checkdie()
   Local $t=PixelSearch($hx+980,$hy+25,$hx+995,$hy+40,0xE65207,10);FF681C
   If Not @error Then
	  return 1
   Else
	  return 0
   EndIf
EndFunc

;========================================
Func autoxu()
   If $n=0 Then
		 MsgBox(0,"Chú ý","Xem kĩ hướng dẫn auto xu:"& @CRLF & _
		 "Phải để full màn hình"& @CRLF & _
		 "Dame: cách buff khi bắn"& @CRLF & _
		 "Bước 1: Vào trong game, chờ đến lượt bắn, bấm F7"& @CRLF & _
		 "Bước 2: Ctrl+F2 để bắt đầu chạy.",10)
		 Return False
   EndIf
   $g_stop=False
   $func=2
   Local $i, $begintime=-1, $hwnd=DllStructGetData($mang[$n-1],"var3"),$kc,$cur=0,$quaydau=0
   ToolTip('Auto kiếm xu...',0,0)
   Sleep(1000)
   While 1
	  If checkchien() Then
		 If $begintime=-1 Then $begintime=@MIN*60+@SEC
		 If @MIN*60+@SEC-$begintime>=120 Then
			   ;ToolTip(@MIN*60+@SEC&"_"&$begintime,10,10)
			   _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,852948)
			   _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,852948)
			   Sleep(1000)
			   _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,23265685)
			   _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,23265685)
			   Sleep(2000)
			   _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,33620669)
			   _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,33620669)
			   Sleep(2000)
			   _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,8454450)
			   _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,8454450)
			   Sleep(1000)
			   _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,20316468)
			   _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,20316468)
			   Sleep(1000)
			   _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,20316287)
			   _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,20316287)
			   Sleep(1000)
			   $begintime=-1
		 EndIf
		 If checkluot2() Then
			;ToolTip("den luot ban")
			Sleep(1000)
			ToolTip('Auto kiếm xu...',0,0)
			$quaydau+=1
			If $quaydau==3 Then
			   If $cur==0 Then
				  _WinAPI_PostMessage($hwnd,0x100,$VK_RIGHT,0)
				  _WinAPI_PostMessage($hwnd,0x101,$VK_RIGHT,0)
				  $cur=1
			   Else
				  _WinAPI_PostMessage($hwnd,0x100,$VK_LEFT,0)
				  _WinAPI_PostMessage($hwnd,0x101,$VK_LEFT,0)
				  $cur=0
			   EndIf
			   $quaydau=0
			EndIf
			;$kc=tim2dua()
			;If $kc=False Then
			   ;dame($hwnd,GUICtrlRead($dameboss),getInt($lucboss))
			   dame($hwnd,"12",1)
			   Sleep(3000)
			;Else
			   ;If $kc<0 Then
				  ;_WinAPI_PostMessage($hwnd,0x100,$VK_RIGHT,0)
				  ;_WinAPI_PostMessage($hwnd,0x101,$VK_RIGHT,0)
				  ;$kc=-$kc
			   ;Else
				  ;_WinAPI_PostMessage($hwnd,0x100,$VK_LEFT,0)
				  ;_WinAPI_PostMessage($hwnd,0x101,$VK_LEFT,0)
			   ;EndIf
			   ;dame($hwnd,GUICtrlRead($dameboss),$kc/10)
			   ;Sleep(3000)
			;EndIf
			If $g_stop Then ExitLoop
		 Else
		 EndIf
		 If $g_stop Then ExitLoop
	  Else
		 $tmp=PixelSearch($hx+532,$hy+573,$hx+536,$hy+577,0xFCF274,50)
		 If Not @error Then
			bamSS($hwnd)
		 Else
			$tmp=PixelSearch($hx+635,$hy+20,$hx+645,$hy+30,0xFFFFFF,10)
			If Not @error Then
			   click($hwnd,$hx+640,$hy+145)
			   Sleep(500)
			   click($hwnd,$hx+750,$hy+145)
			   Sleep(500)
			   click($hwnd,$hx+870,$hy+145)
			   Sleep(500)
			   click($hwnd,$hx+640,$hy+295)
			   Sleep(500)
			   click($hwnd,$hx+750,$hy+295)
			   Sleep(500)
			   click($hwnd,$hx+870,$hy+295)
			EndIf
		 EndIf
		 $begintime=-1
		 If $g_stop Then ExitLoop
	  EndIf
	  If $g_stop Then ExitLoop
	  Sleep(1000)
   WEnd
   $func=0
   ToolTip('',0,0)
EndFunc;==>autokiemxu
;==========================
Func anexp()
   If $n=0 Then
		 MsgBox(0,"Chú ý","Xem kĩ hướng dẫn:"& @CRLF & _
		 "F7 chọn cửa sổ "& @CRLF & _
		 "Ctrl+F9 để bắt đầu chạy.",10)
		 Return False
   EndIf
   Local $i=0,$dem=getInt($solan),$t=getInt($time),$hwnd=DllStructGetData($mang[$n-1],"var3")
   ToolTip('Đang auto ăn exp...',0,0)
   $g_stop=False
   $func=7
   For $i=1 To $dem
	  _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,7995958)
	  _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,7995958)
	  Sleep(500)
	  _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,11534885)
	  _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,11534885)
	  Sleep(500)
	  _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,12780085)
	  _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,12780085)
	  Sleep(500)
	  Sleep($t)
	  If $g_stop Then ExitLoop
   Next
   $func=0
   ToolTip('',0,0)
EndFunc
;=====================================
Func bugchaubau()
   If $n=0 Then
		 MsgBox(0,"Chú ý","Xem kĩ hướng dẫn:"& @CRLF & _
		 "F7 chọn châu báu gốc "& @CRLF & _
		 "Ctrl+1 để bắt đầu bug.",5)
		 Return False
   EndIf
   Local $tmp=DllStructCreate($tagPoint)
   DllStructSetData($tmp, "x", MouseGetPos(0))
   DllStructSetData($tmp, "y", MouseGetPos(1))
   $hwnd = _WinAPI_WindowFromPoint($tmp)
   _WinAPI_ScreenToClient($hwnd,$tmp)
   Local $x=DllStructGetData($tmp,"x")
   Local $y=DllStructGetData($tmp,"y")
   Sleep(700)
   click($hwnd,$x,$y,'Left Click')
   Sleep(700)
   click($hwnd,$x_goc,$y_goc,'Mouse Move')
   Sleep(2000)
   click($hwnd,$x_goc,$y_goc,'Left Click')
   Sleep(1)
   click($hwnd,$x_goc,$y_goc,'Left Click')
   Sleep(1)
   click($hwnd,$x_goc,$y_goc,'Left Click')
   $x_goc=$x
   $y_goc=$y
   Sleep(1000)
EndFunc
;==================================================
Func get()
   Local $aPos, $button='Left click', $text="hero",$tmp=DllStructCreate($tagPoint)
   	DllStructSetData($tmp, "x", MouseGetPos(0))
    DllStructSetData($tmp, "y", MouseGetPos(1))
	$hwnd = _WinAPI_WindowFromPoint($tmp)
	_WinAPI_ScreenToClient($hwnd,$tmp)
	$x=DllStructGetData($tmp,"x")
	$y=DllStructGetData($tmp,"y")
	$x_goc=$x
	$y_goc=$y

;Local $iColor = PixelGetColor(MouseGetPos(0), MouseGetPos(1))
;ToolTip($x&","&$y&","&Hex($iColor, 6))
	Local $aPos = WinGetPos($hwnd)
	$hx=$aPos[0]
	$hy=$aPos[1]
   For $i=0 To 9
	  $mau[$i]=PixelGetColor($hx+$i+50,$hy+$i+54)
   Next
   $mau[10]=1
   $mau1=PixelGetColor($hx+969,$hy+145)
   $mau2=PixelGetColor($hx+972,$hy+189)
   $mau3=PixelGetColor($hx+970,$hy+225)
    ;MsgBox($MB_SYSTEMMODAL, "", "X-Pos: " & $aPos[0] & @CRLF & _
          ;  "Y-Pos: " & $aPos[1] & @CRLF & _
         ;  "Width: " & $aPos[2] & @CRLF & _
          ;  "Height: " & $aPos[3]& @CRLF & _
		;	"Mouleft: " & $x& @CRLF & _
		;	"Mourig: " & $y,15)
   Local $t=DllStructCreate($tagSTRUCT1)
   DllStructSetData($t, "var1", $x)
   DllStructSetData($t, "var2", $y)
   DllStructSetData($t, "var3", $hwnd)
   DllStructSetData($t, "var4", $text)
   DllStructSetData($t, "var5", 1000)
   DllStructSetData($t, "var6", $button)
    $mang[$n]=$t
	$n=$n+1
EndFunc
;==================================================
;==========================================================
Func click($hwnd,$x=0,$y=0,$button='Left Click')
$lParam = ($y * 65536) + ($x)
	Switch $button
        Case $button='Left Click'
            _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,$lParam)
        Case $button='Left Double Click'
            _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_LBUTTONDBLCLK, $MK_LBUTTON,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,$lParam)
        Case $button='Middle Click'
            _WinAPI_PostMessage($hwnd, $WM_MBUTTONDOWN, $MK_MBUTTON,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_MBUTTONUP, 0,$lParam)
        Case $button='Middle Double Click'
            _WinAPI_PostMessage($hwnd, $WM_MBUTTONDOWN, $MK_MBUTTON,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_MBUTTONUP, 0,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_MBUTTONDBLCLK, $MK_MBUTTON,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_MBUTTONUP, 0,$lParam)
        Case $button='Right Click'
            _WinAPI_PostMessage($hwnd, $WM_RBUTTONDOWN, $MK_RBUTTON,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_RBUTTONUP, 0,$lParam)
        Case $button='Right Double Click'
            _WinAPI_PostMessage($hwnd, $WM_RBUTTONDOWN, $MK_RBUTTON,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_RBUTTONUP, 0,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_RBUTTONDBLCLK, $MK_RBUTTON,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_RBUTTONUP, 0,$lParam)
        Case $button='Mouse Move'
            _WinAPI_PostMessage($hwnd, $WM_MOUSEMOVE, 0,$lParam)
            _WinAPI_PostMessage($hwnd, $WM_MOUSEMOVE, 0,$lParam)

    EndSwitch
EndFunc;==>click
Func getInt($x)
   Local $tmp=GUICtrlRead($x)
	  If $tmp="" Then return 0
	  Return Int($tmp)
EndFunc;getInt
Func sendKey($whandle, $text,$timeKeyDown=1000)
   If $text = "" Then Return
   Local $l, $l2, $len=StringLen($text), $sendnow
   For $l=1 To $len
	  $sendnow = StringMid($text,$l,1)
	  If $sendnow="{" Then
	  $sendnow = ""
	  While 1
	  $l += 1
	  $l2 = StringMid( $text,$l,1)
	  If $l2="}" Or $l>$len Then ExitLoop
	  $sendnow &= $l2
	  WEnd
	  EndIf
	  _WinAPI_PostMessage($whandle, 0x100, Eval( "VK_" & StringUpper($sendnow)), 0) ;keydown
	  Sleep( $timeKeyDown)
	  ;_WinAPI_PostMessage($whandle, 0x101, Eval( "VK_" & StringUpper($sendnow)), 0 ) ;keyup
   Next
EndFunc
;=========================================
Func tool()
   Switch $func
			Case 0
			   ToolTip('',0,0)
			Case 1
			   ToolTip('Đang auto click...',0,0)
			Case 2
			   ToolTip('Auto kiếm xu...',0,0)
			Case 3
			   ToolTip('Đang auto thuyền rồng...',0,0)
			Case 4
			   ToolTip('Auto di theo trong phó bản...',0,0)
			Case 5
			   ToolTip('Auto bắn boss thế giới...',0,0)
			Case 6
			   ToolTip('Auto mở rương...',0,0)
			Case 7
			   ToolTip('Auto an exp...',0,0)
			Case 8
			   ToolTip('Auto hợp thành châu báu...',0,0)
   EndSwitch
EndFunc
;=================================================
Func tim2dua()
   Local $tmp,$m=$hx+990,$n=$hy+590,$x=$hx+10,$y=$hy+10
   Local $iColor1=PixelSearch($x,$y,$m,$n,0x0057FF);0x0057FF:xanh, 0x4A0000: do
   If Not @error Then
	  Local $iColor2=PixelSearch($x,$y,$m,$n,0x4A0000);
	  If Not @error Then
		 Return $iColor1[0]-$iColor2[0]
	  Else
		 Return False
	  EndIf
   Else
	  Return False
   EndIf
EndFunc
Func tim3dua()
   Local $tmp,$m=$hx+990,$n=$hy+550,$x=$hx+10,$y=$hy+450
   Local $iColor1=PixelSearch($x,$y,$m,$n,0x0057FF);0x0057FF:xanh, 0x4A0000: do
   If Not @error Then
	  Local $iColor2=PixelSearch($x,$y,$m,$n,0x4A0000);
	  If Not @error Then
			Return $iColor1[0]-$iColor2[0]
	  Else
		 Return False
	  EndIf
   Else
	  Return False
   EndIf
EndFunc
;=================================================
Global $mau1,$mau2,$mau3
Func checkluot2();nhan dang theo dao cu
   Local $t
   $t=PixelSearch($hx+967,$hy+143,$hx+971,$hy+147,$mau1,5)
   If @error Then
		 ;ToolTip("ko thay",$hx+969,$hy+145)
		 ;Sleep(1000)
		 return 0
   Else
		 $t=PixelSearch($hx+970,$hy+187,$hx+974,$hy+191,$mau2,5)
		 If @error Then
			;ToolTip("ko thay",$hx+972,$hy+189)
			;Sleep(1000)
			return 0
		 Else
			$t=PixelSearch($hx+968,$hy+223,$hx+972,$hy+227,$mau3,5)
			If @error Then
			   ;ToolTip("ko thay",$hx+970,$hy+225)
			   ;Sleep(1000)
			   return 0
			Else
			   return 1
			EndIf
		 EndIf
   EndIf
EndFunc
;==================================================
Func checkchien()
   Local $t,$i
   $t=PixelSearch($hx+975,$hy+10,1+$hx+990,1+$hy+20,0xB60000,5)
   If @error Then
		 return 0
   Else
		 return 1
   EndIf
EndFunc
;===============
Func bamP($hwnd)
   _WinAPI_PostMessage($hwnd,0x100,0x50,0)
   _WinAPI_PostMessage($hwnd,0x101,0x50,0)
EndFunc;==bamP
;==================
Func bamSS($hwnd)
   _WinAPI_PostMessage($hwnd, $WM_LBUTTONDOWN, $MK_LBUTTON,32113615)
   _WinAPI_PostMessage($hwnd, $WM_LBUTTONUP, 0,32113615)
EndFunc; bamSS
;=================================
Func dame($whandle,$text,$luc=100)
   sendKey($whandle,$text,200)
   _WinAPI_PostMessage($whandle, 0x100, $VK_SPACE, 0) ;keydown
   Sleep($luc*40)
   _WinAPI_PostMessage($whandle, 0x101, $VK_SPACE, 0) ;keyup
   EndFunc
