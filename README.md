# check-video
Windows .bat script that checks video file integrity using ffmpeg.exe. 

Before you start the integrity check for the first time, you must edit the .bat script and replace the folder-adress in the second command line with the network- or desktop-folder address of your video folder. Then copy ffmpeg.exe into this video folder (get it here: https://ffmpeg.zeranoe.com/builds/ ). 

When you start the .bat script, all video files in your video folder and its subfolders will be checked and a log file will be created for each corrupted video file. To speed processing, ffmpeg.exe checks the audio stream for errors, instead of processing the entire file. This is usually enough to determine if a video is corrupt due to a stopped download, extraction or something similar. 

Punctuations in the file names may give false positives. If you have many video files, starting could take a few minutes.
