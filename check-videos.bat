@echo off
pushd E:\Downloads\test

setlocal EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

echo Windows .bat script that checks video file integrity using ffmpeg.exe. 
echo.
echo Before you start the integrity check for the first time, you must edit the .bat script and replace the folder-adress in the second command line with the network- or desktop-folder address of your video folder. Then copy ffmpeg.exe into this video folder (get it here: https://ffmpeg.zeranoe.com/builds/ ). 
echo.
echo When you start the .bat script, all video files in your video folder and its subfolders will be checked and a log file will be created for each corrupted video file. To speed processing, ffmpeg.exe checks the audio stream for errors, instead of processing the entire file. This is usually enough to determine if a video is corrupt due to a stopped download, extraction or something similar. 
echo.
echo Punctuations in the file names may give false positives. If you have many video files, starting could take a few minutes.
pause
echo.

FOR /F "delims=*" %%G in ('dir /b /s *.mkv *.mp4 *.mpg *.mpeg *.xvid *.webm *.m2v *.m4v *.3gp *.3g2 *.avi *.mov *.flv *.wmv') DO (
	echo Verifying "%%G"
	ffmpeg -v error -i "%%G" -map 0:1 -f null - 2>"%%G.log"
	FOR %%F in ("%%G.log") DO (
		if %%~zF equ 0 (
			del %%F
			call :colour 0a "Video is good"
			echo.
			echo. 
		) else (
			call :colour 0c "Error in video file:"
			echo.
			type %%F
			call :colour 0e "This can be found in the video's .log file"
			echo.
			echo.
		)
	)
)
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