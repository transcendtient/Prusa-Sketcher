Prusa-Sketcher
===========

This project is to make use of an old Mendel Prusa. The drawing is done by attaching a marker to the geared extruder, with retract settings moving the marker. The erasing is done by attaching an eraser to the extruder bottom. Here's a few videos to show the process.

https://www.youtube.com/watch?v=Uwju1ZsioHg&list=PLpUQGHNn5fr99E_rIrnBQkx1aEkpmByK0

If you're willing to try the software the awesome thing is that any geared extruder will work for a drawing. If not, you can still generate flat STL's for impressions.

I'll add a variant that uses the z-level to pick up the marker in a future release for those without a geared extruder on the hot end. It will require looking for destring in the gcode and chopping the file manually.

***Dependencies*** 

1. Java 7
2. GIMP
3. ImageMagick
4. pstoedit 
5. librxtx-java *(Version 2.2+)*
6. KISSlicer 
7. OpenSCAD *(2013.06)*

PicToGCO
===========
***Homing***

1. Home the printer.
2. Raise the extruder 10mm.
3. Place the marker so it contacts the print surface.

***Operation***

1. Download KISSlicer http://www.kisslicer.com/download.html and place into the "kiss" folder.
2. untar Printrun-master into the main directory. "tar -xvf /Dependencies/Printrun-master.tar.gz ./"
3. Place the "/Dependencies/script-fu-pencil-drawing.scm" into your GIMP plugin directory (/usr/lib/gimp/2.0/plug-ins/).
4. cd PicToGCO
5. The first time you run the script you'll need to recompile it. "javac PicToGCO.java"
6. java PicToGCO "picABSOLUTEpath.ext" "median-value" "drawVal1 drawVal2"

Median-value is used to simplify images with convert's -median argument. This is highly dependant on image size, and will be scripted to a range for variable size in a future release. Default is 2.

CLOCK
===========
***Homing***

1. Home the printer.
2. Raise the extruder 10mm.
3. Place the marker so it contacts the print surface.

***Operation***

1. untar Printrun-master into the main directory. "tar -xvf /Dependencies/Printrun-master.tar.gz ./"
2. cd Clock
3. The first time you run the script you'll need to recompile it. "javac -classpath .:/usr/share/java/RXTXcomm.jar PicToGCO.java"
3. sudo java -classpath .:/usr/share/java/RXTXcomm.jar -Djava.library.path="/usr/lib/jni/" Clock

*If you don't want to mess with permissions, just run the script as sudo.*

BUGS/ISSUES
===========
***PicToGCO*** 

1. ~~Script overwrites original picture if it is a jpg.~~ Script makes a copy of the picture now.
2. ~~Script drags marker to the first position. Place retract in "prefix.gcode".~~ Untested but should be fixed.
3. ~~Enable use of an absolute path for the file name.~~
4. ~~Properly handle null arguments.~~
5. Enable exporting surfaces for true 3D models.
6. Detect image size, automatically set a desirable value for "median-value".
7. Resize image with "convert" to make them more uniform in appearance (possibly).

***Clock***

1. ~~Rename module.~~
2. ~~Clean up variables, comment code.~~
3. Implement PicToGCO and randomize the font number used.
4. Use different numbering systems (binary...)

***General***

1. ~~Simplify file structure (less directories).~~
2. ~~Comment scripts better.~~
3. ~~Remove submodule Pronterface from repository.~~
4. Unify clock and camera to allow interrupt and pause before placing paper.
5. ~~Automatically determine serial port for ATMEGA communication (currently hardcoded).~~ 
