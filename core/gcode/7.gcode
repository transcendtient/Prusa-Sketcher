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
G1 X4.76 Y32.19 Z0 E0 F3000
G1 E1;Write
G92 E0;Write numbers/colon set location
G1 X4.12 Y32.44 E0 F6000
G1 X4.12 Y15.95 E0
G1 X4.12 Y15.33 E0
G1 X4.12 Y14.76 E0
G1 X4.12 Y3.62 E0
G1 X4.21 Y3.53 E0
G1 X10.51 Y3.53 E0
G1 X10.61 Y3.6 E0
G1 X10.61 Y5.41 E0
G1 X10.61 Y21.61 E0
G1 X10.62 Y22.07 E0
G1 X10.72 Y22.42 E0
G1 X11.02 Y22.66 E0
G1 X11.46 Y22.6 E0
G1 X13.63 Y21.61 E0
G1 X14.17 Y21.36 E0
G1 X17.42 Y19.89 E0
G1 X18.77 Y19.27 E0
G1 X42.75 Y8.35 E0
G1 X42.88 Y8.41 E0
G1 X42.88 Y17.08 E0
G1 X42.8 Y17.17 E0
G1 X40.91 Y18.04 E0
G1 X40.78 Y18.09 E0
G1 X25.36 Y25.14 E0
G1 X25.23 Y25.18 E0
G1 X24.54 Y25.5 E0
G1 X9.81 Y32.23 E0
G1 X9.21 Y32.47 E0
G1 X4.25 Y32.47 E0
G1 X4.12 Y32.44 E0
G1 X4.52 Y31.88 E0
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
G1 F6000 X0Y31;Write move numbers next place
G92 X0Y0Z0;Set 0
