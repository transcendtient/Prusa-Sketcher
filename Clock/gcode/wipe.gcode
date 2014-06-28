;Prefix
G28 X0Y0	;Stay at same height
G1 F6000 X70	;Move out of the way
G0 E-4		;retract marker
G28		;home

;Wipe
G1 F6000 X0Y0
G1 F6000 Y110
G1 F6000 Y0
G1 F6000 X30
G1 F6000 Y110
G1 F6000 Y0

;postfix
G28		;home
G0 Z10		;move to writing height


