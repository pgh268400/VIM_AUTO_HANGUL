

;실행중의 스크립트가 또 하나 실행되었을 때, 자동적으로 기존의 프로세스를 종료해 새롭게 실행 개시한다
#SingleInstance force

; 핫키 앞에 물결표를 입력해줄 경우 그 키도 같이 쳐진다.
~$Esc::
    if(IME_CHECK("A"))
        Send, {VK15}    ;영문이라면 한영전환 키를 입력해준다.
    return


~^[::
	if(IME_CHECK("A"))
		Send, {VK15}    ;영문이라면 한영전환 키를 입력해준다.
	return


/*
  IME check
*/
IME_CHECK(WinTitle) {
  WinGet,hWnd,ID,%WinTitle%
  Return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd),0x005,"")
}
Send_ImeControl(DefaultIMEWnd, wParam, lParam) {
  DetectSave := A_DetectHiddenWindows
  DetectHiddenWindows,ON
   SendMessage 0x283, wParam,lParam,,ahk_id %DefaultIMEWnd%
  if (DetectSave <> A_DetectHiddenWindows)
      DetectHiddenWindows,%DetectSave%
  return ErrorLevel
}
ImmGetDefaultIMEWnd(hWnd) {
  return DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
}
