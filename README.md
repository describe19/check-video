# check-video
Windows .bat script that checks video file integrity using ffmpeg.

This script will find video files in the same directory as the .bat and individually check them for errors, creating and displaying a log file for any video that contains errors.

To speed processing it checks the audio stream for errors, instead of processing the entire file. This is usually enough to determine if a video is corrupt to a stopped download, extraction or something similar.
