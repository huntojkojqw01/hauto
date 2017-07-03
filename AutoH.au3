#include-once
#include "Functions.au3"
#include "GUI.au3"
While 1
   Sleep(100)
WEnd
Func thoat()
   Exit
EndFunc
Func pause()
   $g_bPaused = Not $g_bPaused
            While $g_bPaused
                Sleep(100)
                ToolTip('Script is "Paused"', 0, 0)
            WEnd
   tool()
EndFunc
Func dung()
   $g_stop=True
EndFunc
;==========================
Func help()
   MsgBox(0,"Hướng dẫn cơ bản","Xem kĩ hướng dẫn :"& @CRLF & _
		 "Phải để full màn hình"& @CRLF & _
		 "Ctrl+F2: auto tự sát kiếm xu"& @CRLF & _
		 "Ctrl+F5: auto bắn boss thế giới"& @CRLF & _
		 "Ctrl+F9: ăn nước kinh nghiệm"& @CRLF & _
		 "Ctrl+0 : tắt auto đang hoạt động"& @CRLF & _
		 "Ctrl+1 : bug châu báu cấp cao vào lỗ cấp 1"& @CRLF & _
		 "Pause  : tạm dừng auto đang hoạt động"& @CRLF & _
		 "Esc    : thoát chương trình",20)
EndFunc
