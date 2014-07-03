Prusa-Sketcher
===========

This project is to make use of an old Mendel Prusa. The drawing is done by attaching a marker to the geared extruder, with retract settings moving the marker. The erasing is done by attaching an eraser to the extruder bottom. Here's a few videos to show the process.

https://www.youtube.com/watch?v=Uwju1ZsioHg&list=PLpUQGHNn5fr99E_rIrnBQkx1aEkpmByK0

If you don't have a printer you can still generate flat STL's for impressions, and after the script finishes you can use OpenSCAD to manipulate them.

***Dependencies*** 

1. Java 7
2. GIMP
3. convert 
4. pstoedit 
5. potrace
6. KISSlicer 
7. OpenSCAD *(2013.06.18)*
8. librxtx-java *(Version 2.2+)*

The scripts in the main folder will likely get all your dependencies installed.
*The script will MAKE FROM SOURCE OpenSCAD on Debian like systems (Ubuntu, Mint, etc...) with X86 or X64 architecture.*

PicToGCO
===========
***Homing***

1. Home the printer.
2. Raise the extruder 10mm.
3. Place the marker so it contacts the print surface.

***Operation***

Until I add a script to launch from the main directory.

1. cd /core/java/
2. java PicToGCO "picname.ext" "median-value" "GIMPDraw1 GIMPDraw2"

Median-value is used to simplify images with convert's -median argument. This is highly dependant on image size, and will be scripted to a range for variable size in a future release. Default is 2 GIMPDraw values are explained at the plugin source below.

http://registry.gimp.org/node/25042

CLOCK
===========
***Homing***

1. Home the printer.
2. Raise the extruder 10mm.
3. Place the marker so it contacts the print surface.

***Operation***

1. unzip Pronterface
2. cd /core/java/
3. sudo java -classpath .:/usr/share/java/RXTXcomm.jar -Djava.library.path="/usr/lib/jni/" Clock

*If you don't want to mess with permissions, just run the script as sudo.*

BUGS/ISSUES
===========
***PicToGCO*** 

1. Script drags marker to the first position. Place retract in "prefix.gcode".
2. Enable exporting surfaces for true 3D models.
3. Detect image size, automatically set a desirable value for "median-value".
4. Resize image with "convert" to make them more uniform in appearance (possibly).

***Clock***

1. Implement PicToGCO and randomize the font number used.
2. Use different numbering systems (binary...)

***General***

1. Unify clock and camera to allow interrupt and pause before placing paper.
2. Automatically determine serial port for ATMEGA communication (currently hardcoded).
