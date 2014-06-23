Prusa-Sketcher
==============

First off, if you want STL's, you'll have to compile OpenSCAD from the latest source (2014.06.18).

Dependencies:
Java 7
GIMP
ImageMagick
pstoedit
KISSlicer

USAGE:
=============
You'll have to recompile java programs with "javac "ScriptName.java"

CAMERA
============
1) Place your picture into "pics" folder (the script won't work if you don't do this).
2) Download KISSlicer and place into the "kiss" folder
3) Place the "script-fu-pencil-drawing.scm" into your GIMP plugin directory.
4) cd /java/camera
5) java PicToGCO "picname.ext" "median-value" 

DO NOT USE AN ABSOLUTE PATH. PLACE PIC IN "pics" FOLDER.

Median-value is used to simplify images with convert's -median argument. This is highly dependant on image size, and will be sccripted to a range for variable size in a future release. Default is 2.

CLOCK
===========
1) unzip Pronterface
1) cd /java/time
2) java ExecuteShellCommand (yes this is repurposed code from someone else)
