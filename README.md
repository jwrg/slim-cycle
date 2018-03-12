# SLiM-cycle
This is a simple slim theme that comes with more than one wallpaper and a 
script that changes the background for the next login.

## Usage
The script, cycle.sh, is used to randomize the background the theme on login.
It uses the `$RANDOM` environment variable to choose from the files fitting
the pattern `background##.jpg` where ## is one or more digits. That file gets
changed to background.jpg after the old one gets its numbered filename
restored.

The script, cycle.sh, requires root permission if the theme is owned by root
or in a location owned by root (duh).  Other hackery such as `sudo chmod 777 
*.jpg` should suffice.

To get a randomized wallpaper, run the script on login using .xinitrc or some
such script run at login that you prefer.  The script currently only supports
the manipulation of .jpg files.  More to come.

## Legal
All photographs were taken by myself.  Therefore I hold the copyright on all
photographs found in this theme; please don't reuse them without my permission
(it's illegal and not very nice).  Personal use on your PC login screen is OK.

The script, cycle.sh, is licensed as GPLv3.
