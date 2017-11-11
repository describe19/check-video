@echo off
setlocal EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

echo This script requires ffmpeg.exe and will verify all video files in the directory the .bat is run.
pause
echo.
FOR %%G in (*.mkv *.mp4 *.mpg *.mpeg *.xvid *.webm *.m2v *.m4v *.3gp *.3g2 *.avi *.mov *.flv *.wmv) DO (
echo Verifying "%%G"
ffmpeg -v error -i "%%G" -map 0:1 -f null - 2>"%%G.log"
FOR %%F in ("%%G.log") DO (
if %%~zF equ 0 (del %%F && call :colour 0a "Video is good" && echo. && echo.) else (call :colour 0c "Error in video file:" && echo. && type %%F && call :colour 0e "This can be found in the video's .log file" && echo. && echo.)
))
call :colour 0a "Verifying complete!" && echo.
pause
exit /b

:colour
set "param=^%~2" !
set "param=!param:"=\"!"
rem Prepare a file "X" with only one dot
<nul > X set /p ".=."
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
rem Delete "X" file
del X
exit /b