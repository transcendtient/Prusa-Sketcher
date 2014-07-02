Prusa-Sketcher
===========

This project is to make use of an old Mendel Prusa. The drawing is done by attaching a marker to the geared extruder, with retract settings moving the marker. The erasing is done by attaching an eraser to the extruder bottom. Here's a few videos to show the process.

https://www.youtube.com/watch?v=Uwju1ZsioHg&list=PLpUQGHNn5fr99E_rIrnBQkx1aEkpmByK0

If you're willing to try the software the awesome thing is that any geared extruder will work for a drawing. If not, you can still generate flat STL's for impressions.

***Dependencies*** 

1. Java 7
2. GIMP
3. convert 
4. pstoedit 
5. KISSlicer 
6. OpenSCAD *(2014.06.18)*
7. librxtx-java *(Version 2.2+)*

PicToGCO
===========
***Homing***

1. Home the printer.
2. Raise the extruder 10mm.
3. Place the marker so it contacts the print surface.

***Operation***

1. Place your picture into "pics" folder (the script won't work if you don't do this).
2. Download KISSlicer and place into the "kiss" folder.
3. Place the "script-fu-pencil-drawing.scm" into your GIMP plugin directory.
4. cd /java/camera
5. The first time you run the script you'll need to recompile it. "javac PicToGCO.java"
5. java PicToGCO "picname.ext" "median-value" 

DO NOT USE AN ABSOLUTE PATH. PLACE PIC IN "pics" FOLDER.

Median-value is used to simplify images with convert's -median argument. This is highly dependant on image size, and will be scripted to a range for variable size in a future release. ~~Default is 2~~ Default should be 2, but crashes if no argument is passed.

CLOCK
===========
***Homing***

1. Home the printer.
2. Raise the extruder 10mm.
3. Place the marker so it contacts the print surface.

***Operation***

1. unzip Pronterface
2. cd /java/time
3. sudo java ExecuteShellCommand (yes this is repurposed code from someone else)

*If you don't want to mess with permissions, just run the script as sudo.*

BUGS/ISSUES
===========
***PicToGCO*** 

1. Script overwrites original picture if it is a jpg.
2. Script drags marker to the first position. Place retract in "prefix.gcode".
3. Enable use of an absolute path for the file name.
4. Properly handle null arguments.
5. Enable exporting surfaces for true 3D models.
6. Detect image size, automatically set a desirable value for "median-value".
7. Resize image with "convert" to make them more uniform in appearance (possibly).

***Clock***

1. Rename module.
2. Clean up variables, comment code.
3. Implement PicToGCO and randomize the font number used.
4. Use different numbering systems (binary...)

***General***

1. Simplify file structure (less directories).
2. Comment scripts better.
3. Remove submodule Pronterface from repository.
4. Unify clock and camera to allow interrupt and pause before placing paper.
5. Automatically determine serial port for ATMEGA communication (currently hardcoded).
