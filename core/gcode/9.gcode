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
G1 X10.81 Y21.91 Z0 E0 F3000
G1 E1;Write
G92 E0;Write numbers/colon set location
G1 X10.98 Y21.38 E0 F6000
G1 X10.32 Y20.59 E0
G1 X9.87 Y19.65 E0
G1 X9.62 Y18.64 E0
G1 X9.53 Y17.49 E0
G1 X9.62 Y16.4 E0
G1 X9.83 Y15.48 E0
G1 X10.29 Y14.47 E0
G1 X10.84 Y13.75 E0
G1 X11.33 Y13.31 E0
G1 X11.96 Y12.88 E0
G1 X12.55 Y12.58 E0
G1 X13.32 Y12.29 E0
G1 X14.36 Y12.03 E0
G1 X15.77 Y11.87 E0
G1 X17.44 Y11.86 E0
G1 X19.04 Y12.03 E0
G1 X20.33 Y12.36 E0
G1 X21.41 Y12.86 E0
G1 X22.24 Y13.45 E0
G1 X22.9 Y14.18 E0
G1 X23.35 Y14.96 E0
G1 X23.66 Y15.86 E0
G1 X23.83 Y16.98 E0
G1 X23.83 Y18.04 E0
G1 X23.68 Y19.06 E0
G1 X23.38 Y19.96 E0
G1 X22.98 Y20.7 E0
G1 X22.35 Y21.46 E0
G1 X21.45 Y22.13 E0
G1 X20.34 Y22.63 E0
G1 X19.07 Y22.96 E0
G1 X17.6 Y23.13 E0
G1 X15.94 Y23.13 E0
G1 X14.65 Y23.01 E0
G1 X13.45 Y22.76 E0
G1 X12.37 Y22.35 E0
G1 X11.64 Y21.93 E0
G1 X10.98 Y21.38 E0
G1 X10.46 Y21.56 E0
G1 E-1;Write
G92 E0;Write numbers/colon set location
;
; 'Perimeter', 0.0 [feed mm/s], 18.2 [head mm/s]
G1 X8.81 Y27.48 E0 F3000
G1 E1;Write
G92 E0;Write numbers/colon set location
G1 X8.27 Y27.66 E0 F6000
G1 X7.2 Y26.46 E0
G1 X6.41 Y25.28 E0
G1 X5.62 Y23.78 E0
G1 X5.06 Y22.17 E0
G1 X4.69 Y20.48 E0
G1 X4.5 Y18.61 E0
G1 X4.5 Y16.44 E0
G1 X4.68 Y14.59 E0
G1 X5 Y12.96 E0
G1 X5.5 Y11.35 E0
G1 X6.2 Y9.83 E0
G1 X7.02 Y8.51 E0
G1 X7.98 Y7.33 E0
G1 X9.16 Y6.2 E0
G1 X10.39 Y5.33 E0
G1 X11.7 Y4.63 E0
G1 X13.21 Y4.08 E0
G1 X14.76 Y3.72 E0
G1 X16.44 Y3.54 E0
G1 X18.31 Y3.54 E0
G1 X20.01 Y3.75 E0
G1 X21.43 Y4.12 E0
G1 X22.94 Y4.7 E0
G1 X24.17 Y5.43 E0
G1 X25.2 Y6.24 E0
G1 X26.29 Y7.35 E0
G1 X27.15 Y8.5 E0
G1 X27.88 Y9.8 E0
G1 X28.41 Y11.14 E0
G1 X28.81 Y12.64 E0
G1 X29.04 Y14.22 E0
G1 X29.12 Y16.03 E0
G1 X29 Y17.78 E0
G1 X28.67 Y19.4 E0
G1 X28.21 Y20.74 E0
G1 X27.49 Y22.23 E0
G1 X26.66 Y23.5 E0
G1 X26.59 Y23.76 E0
G1 X26.67 Y24.02 E0
G1 X26.88 Y24.23 E0
G1 X27.34 Y24.28 E0
G1 X28.96 Y24.04 E0
G1 X30.59 Y23.63 E0
G1 X31.66 Y23.25 E0
G1 X32.94 Y22.62 E0
G1 X34.07 Y21.82 E0
G1 X35 Y20.92 E0
G1 X35.79 Y19.85 E0
G1 X36.36 Y18.78 E0
G1 X36.8 Y17.55 E0
G1 X37.09 Y16.14 E0
G1 X37.21 Y14.66 E0
G1 X37.18 Y12.81 E0
G1 X36.93 Y11.04 E0
G1 X36.43 Y9 E0
G1 X35.97 Y7.58 E0
G1 X35.4 Y6.18 E0
G1 X35.39 Y6.03 E0
G1 X41.06 Y6.03 E0
G1 X41.26 Y6.53 E0
G1 X41.81 Y8.65 E0
G1 X42.22 Y10.89 E0
G1 X42.45 Y13.12 E0
G1 X42.53 Y15.45 E0
G1 X42.42 Y17.57 E0
G1 X42.12 Y19.58 E0
G1 X41.6 Y21.5 E0
G1 X40.96 Y23.1 E0
G1 X40.24 Y24.45 E0
G1 X39.33 Y25.8 E0
G1 X38.26 Y27.03 E0
G1 X37.08 Y28.14 E0
G1 X35.77 Y29.13 E0
G1 X34.8 Y29.75 E0
G1 X34.33 Y30.01 E0
G1 X32.78 Y30.75 E0
G1 X31.24 Y31.32 E0
G1 X30.14 Y31.64 E0
G1 X28.3 Y32.04 E0
G1 X26.48 Y32.3 E0
G1 X24.36 Y32.46 E0
G1 X21.97 Y32.47 E0
G1 X19.49 Y32.32 E0
G1 X17.15 Y31.98 E0
G1 X15.02 Y31.48 E0
G1 X13.2 Y30.85 E0
G1 X11.81 Y30.21 E0
G1 X10.42 Y29.41 E0
G1 X9.28 Y28.58 E0
G1 X8.27 Y27.66 E0
G1 X8.45 Y27.12 E0
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
