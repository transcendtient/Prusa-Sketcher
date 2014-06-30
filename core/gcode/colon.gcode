; *** G-code Prefix ***
;
G21
;
; *** Main G-code ***
;
; BEGIN_LAYER_OBJECT z=0.55
;
; *** Warming Extruder 1 to 10 C ***
; Select extruder, warm, purge
; BfB-style
M104 S10
M542
M551 P32000 S900
M543
; 5D-style
T0
;
; 'Perimeter', 0.0 [feed mm/s], 18.2 [head mm/s]
G1 X7.56 Y7.21 Z0 E0 F3000
G1 E1;Write
G92 E0;Write numbers/colon set location
G1 X7.75 Y7.74 E0 F6000
G1 X7.23 Y8.16 E0
G1 X6.51 Y8.43 E0
G1 X5.85 Y8.48 E0
G1 X5.25 Y8.36 E0
G1 X4.74 Y8.13 E0
G1 X4.26 Y7.77 E0
G1 X3.84 Y7.23 E0
G1 X3.57 Y6.51 E0
G1 X3.52 Y5.85 E0
G1 X3.64 Y5.25 E0
G1 X3.87 Y4.74 E0
G1 X4.23 Y4.26 E0
G1 X4.77 Y3.84 E0
G1 X5.49 Y3.57 E0
G1 X6.15 Y3.52 E0
G1 X6.75 Y3.64 E0
G1 X7.26 Y3.87 E0
G1 X7.74 Y4.23 E0
G1 X8.15 Y4.76 E0
G1 X8.4 Y5.39 E0
G1 X8.48 Y6 E0
G1 X8.41 Y6.6 E0
G1 X8.2 Y7.16 E0
G1 X7.75 Y7.74 E0
G1 X7.21 Y7.57 E0
G1 E-1;Write
G92 E0;Write numbers/colon set location
;
; 'Perimeter', 0.0 [feed mm/s], 18.2 [head mm/s]
G1 X37.56 Y7.21 E0 E3000
G1 E1;Write
G92 E0;Write numbers/colon set location
G1 X37.75 Y7.74 E0 F6000
G1 X37.23 Y8.16 E0
G1 X36.51 Y8.43 E0
G1 X35.85 Y8.48 E0
G1 X35.25 Y8.36 E0
G1 X34.73 Y8.13 E0
G1 X34.23 Y7.74 E0
G1 X33.83 Y7.21 E0
G1 X33.57 Y6.51 E0
G1 X33.52 Y5.85 E0
G1 X33.64 Y5.25 E0
G1 X33.87 Y4.74 E0
G1 X34.23 Y4.26 E0
G1 X34.77 Y3.84 E0
G1 X35.49 Y3.57 E0
G1 X36.15 Y3.52 E0
G1 X36.75 Y3.64 E0
G1 X37.27 Y3.87 E0
G1 X37.77 Y4.26 E0
G1 X38.16 Y4.78 E0
G1 X38.4 Y5.39 E0
G1 X38.48 Y6 E0
G1 X38.41 Y6.6 E0
G1 X38.2 Y7.16 E0
G1 X37.75 Y7.74 E0
G1 X37.21 Y7.57 E0
G1 E-1;Write
G92 E0;Write numbers/colon set location
;
; END_LAYER_OBJECT z=0.55
;
; *** Cooling Extruder 1 to 0 C ***
; Guaranteed same extruder, cooling down
; BfB-style
M104 S0
; 5D-style
M104 S0

; *** G-code Postfix ***
;
G1 F6000 X0Y8;Write move numbers next place
G92 X0Y0Z0;Set 0
