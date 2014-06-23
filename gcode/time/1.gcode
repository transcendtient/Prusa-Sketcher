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
G1 X3.81 Y22.33 Z0 E0 F3000
G1 E1;Write
G92 E0;Write numbers/colon set location
G1 X3.37 Y22.79 E0 F6000
G1 X3.28 Y22.7 E0
G1 X3.28 Y12.93 E0
G1 X4.65 Y6.36 E0
G1 X5.24 Y3.53 E0
G1 X11.46 Y3.53 E0
G1 X11.61 Y3.56 E0
G1 X9.76 Y12.53 E0
G1 X9.7 Y12.81 E0
G1 X9.8 Y13.21 E0
G1 X10 Y13.41 E0
G1 X10.38 Y13.47 E0
G1 X35.74 Y13.47 E0
G1 X37.67 Y13.47 E0
G1 X37.92 Y13.41 E0
G1 X38.13 Y13.19 E0
G1 X38.22 Y12.81 E0
G1 X38.22 Y3.93 E0
G1 X38.26 Y3.79 E0
G1 X44.56 Y3.79 E0
G1 X44.72 Y3.81 E0
G1 X44.72 Y23.82 E0
G1 X44.72 Y32.35 E0
G1 X44.67 Y32.47 E0
G1 X38.35 Y32.47 E0
G1 X38.22 Y32.42 E0
G1 X38.22 Y23.45 E0
G1 X38.2 Y23.28 E0
G1 X38.02 Y22.94 E0
G1 X37.72 Y22.79 E0
G1 X35.29 Y22.79 E0
G1 X8.89 Y22.79 E0
G1 X3.37 Y22.79 E0
G1 X3.37 Y22.79 E0
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

;
; *** G-code Postfix ***
;
G1 F6000 X0Y31;Write move numbers next place
G92 X0Y0Z0;Set 0
