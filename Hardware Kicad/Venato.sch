EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L pspice:0 #GND?
U 1 1 615283C5
P 2000 4400
F 0 "#GND?" H 2000 4300 50  0001 C CNN
F 1 "0" H 2000 4489 50  0000 C CNN
F 2 "" H 2000 4400 50  0001 C CNN
F 3 "~" H 2000 4400 50  0001 C CNN
	1    2000 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 2300 2600 2300
$Comp
L Amplifier_Operational:MCP6002-xMC U1
U 1 1 61530CA8
P 2900 1650
F 0 "U1" H 2900 1283 50  0000 C CNN
F 1 "MCP6002-xMC" H 2900 1374 50  0000 C CNN
F 2 "Package_DFN_QFN:DFN-8-1EP_3x2mm_P0.5mm_EP1.75x1.45mm" H 2900 1650 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 2900 1650 50  0001 C CNN
	1    2900 1650
	1    0    0    1   
$EndComp
$Comp
L Amplifier_Operational:MCP6002-xMC U2
U 1 1 61531804
P 4250 1650
F 0 "U2" H 4250 1283 50  0000 C CNN
F 1 "MCP6002-xMC" H 4250 1374 50  0000 C CNN
F 2 "Package_DFN_QFN:DFN-8-1EP_3x2mm_P0.5mm_EP1.75x1.45mm" H 4250 1650 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 4250 1650 50  0001 C CNN
	1    4250 1650
	1    0    0    1   
$EndComp
$Comp
L Amplifier_Operational:MCP6002-xMC U3
U 1 1 615323F4
P 6200 1650
F 0 "U3" H 6200 1283 50  0000 C CNN
F 1 "MCP6002-xMC" H 6200 1374 50  0000 C CNN
F 2 "Package_DFN_QFN:DFN-8-1EP_3x2mm_P0.5mm_EP1.75x1.45mm" H 6200 1650 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 6200 1650 50  0001 C CNN
	1    6200 1650
	1    0    0    1   
$EndComp
$Comp
L Amplifier_Operational:MCP6002-xMC U4
U 2 1 61533082
P 2800 3750
F 0 "U4" H 2800 3383 50  0000 C CNN
F 1 "MCP6002-xMC" H 2800 3474 50  0000 C CNN
F 2 "Package_DFN_QFN:DFN-8-1EP_3x2mm_P0.5mm_EP1.75x1.45mm" H 2800 3750 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 2800 3750 50  0001 C CNN
	2    2800 3750
	1    0    0    1   
$EndComp
$Comp
L Amplifier_Operational:MCP6002-xMC U5
U 2 1 61533893
P 4400 3700
F 0 "U5" H 4400 3333 50  0000 C CNN
F 1 "MCP6002-xMC" H 4400 3424 50  0000 C CNN
F 2 "Package_DFN_QFN:DFN-8-1EP_3x2mm_P0.5mm_EP1.75x1.45mm" H 4400 3700 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 4400 3700 50  0001 C CNN
	2    4400 3700
	1    0    0    1   
$EndComp
$Comp
L Amplifier_Operational:MCP6002-xMC U6
U 2 1 61534082
P 6350 3750
F 0 "U6" H 6350 3383 50  0000 C CNN
F 1 "MCP6002-xMC" H 6350 3474 50  0000 C CNN
F 2 "Package_DFN_QFN:DFN-8-1EP_3x2mm_P0.5mm_EP1.75x1.45mm" H 6350 3750 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 6350 3750 50  0001 C CNN
	2    6350 3750
	1    0    0    1   
$EndComp
Wire Wire Line
	2500 3850 2500 4150
Connection ~ 2500 4150
Wire Wire Line
	2500 4150 4100 4150
Wire Wire Line
	4100 3800 4100 4150
Connection ~ 4100 4150
Wire Wire Line
	4100 4150 6050 4150
Wire Wire Line
	6050 3850 6050 4150
Wire Wire Line
	2600 1750 2600 2300
Connection ~ 2600 2300
Wire Wire Line
	2600 2300 3950 2300
Wire Wire Line
	3950 1750 3950 2300
Connection ~ 3950 2300
Wire Wire Line
	3950 2300 5900 2300
Wire Wire Line
	5900 1750 5900 2300
$Comp
L Device:R R?
U 1 1 61535978
P 2900 1050
F 0 "R?" V 2693 1050 50  0000 C CNN
F 1 "1000" V 2784 1050 50  0000 C CNN
F 2 "" V 2830 1050 50  0001 C CNN
F 3 "~" H 2900 1050 50  0001 C CNN
	1    2900 1050
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 615366D8
P 4200 1000
F 0 "R?" V 3993 1000 50  0000 C CNN
F 1 "1000" V 4084 1000 50  0000 C CNN
F 2 "" V 4130 1000 50  0001 C CNN
F 3 "~" H 4200 1000 50  0001 C CNN
	1    4200 1000
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 61536957
P 6100 1000
F 0 "R?" V 5893 1000 50  0000 C CNN
F 1 "1000" V 5984 1000 50  0000 C CNN
F 2 "" V 6030 1000 50  0001 C CNN
F 3 "~" H 6100 1000 50  0001 C CNN
	1    6100 1000
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 615370B9
P 2750 3350
F 0 "R?" V 2543 3350 50  0000 C CNN
F 1 "1000" V 2634 3350 50  0000 C CNN
F 2 "" V 2680 3350 50  0001 C CNN
F 3 "~" H 2750 3350 50  0001 C CNN
	1    2750 3350
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 615376AF
P 4400 3200
F 0 "R?" V 4193 3200 50  0000 C CNN
F 1 "1000" V 4284 3200 50  0000 C CNN
F 2 "" V 4330 3200 50  0001 C CNN
F 3 "~" H 4400 3200 50  0001 C CNN
	1    4400 3200
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 61537BBB
P 6300 3300
F 0 "R?" V 6093 3300 50  0000 C CNN
F 1 "R" V 6184 3300 50  0000 C CNN
F 2 "" V 6230 3300 50  0001 C CNN
F 3 "~" H 6300 3300 50  0001 C CNN
	1    6300 3300
	0    1    1    0   
$EndComp
Wire Wire Line
	2000 2300 2000 4150
Wire Wire Line
	2000 4150 2500 4150
Connection ~ 2000 4150
Wire Wire Line
	2000 4150 2000 4400
$Comp
L Device:C C?
U 1 1 6153E2B9
P 2800 3000
F 0 "C?" V 2548 3000 50  0000 C CNN
F 1 "47pF" V 2639 3000 50  0000 C CNN
F 2 "" H 2838 2850 50  0001 C CNN
F 3 "~" H 2800 3000 50  0001 C CNN
	1    2800 3000
	0    1    1    0   
$EndComp
$Comp
L Device:C C?
U 1 1 6153E9AD
P 4400 2750
F 0 "C?" V 4148 2750 50  0000 C CNN
F 1 "47pF" V 4239 2750 50  0000 C CNN
F 2 "" H 4438 2600 50  0001 C CNN
F 3 "~" H 4400 2750 50  0001 C CNN
	1    4400 2750
	0    1    1    0   
$EndComp
$Comp
L Device:C C?
U 1 1 6153EEC9
P 6300 2950
F 0 "C?" V 6048 2950 50  0000 C CNN
F 1 "47pF" V 6139 2950 50  0000 C CNN
F 2 "" H 6338 2800 50  0001 C CNN
F 3 "~" H 6300 2950 50  0001 C CNN
	1    6300 2950
	0    1    1    0   
$EndComp
$Comp
L Device:C C?
U 1 1 6153F382
P 6100 650
F 0 "C?" V 5848 650 50  0000 C CNN
F 1 "47pF" V 5939 650 50  0000 C CNN
F 2 "" H 6138 500 50  0001 C CNN
F 3 "~" H 6100 650 50  0001 C CNN
	1    6100 650 
	0    1    1    0   
$EndComp
$Comp
L Device:C C?
U 1 1 6153F821
P 4200 650
F 0 "C?" V 3948 650 50  0000 C CNN
F 1 "47pF" V 4039 650 50  0000 C CNN
F 2 "" H 4238 500 50  0001 C CNN
F 3 "~" H 4200 650 50  0001 C CNN
	1    4200 650 
	0    1    1    0   
$EndComp
$Comp
L Device:C C?
U 1 1 6153FB62
P 2900 700
F 0 "C?" V 2648 700 50  0000 C CNN
F 1 "47pF" V 2739 700 50  0000 C CNN
F 2 "" H 2938 550 50  0001 C CNN
F 3 "~" H 2900 700 50  0001 C CNN
	1    2900 700 
	0    1    1    0   
$EndComp
Wire Wire Line
	2600 1550 2600 1050
Wire Wire Line
	2600 1050 2750 1050
Wire Wire Line
	3050 1050 3200 1050
Wire Wire Line
	3200 1050 3200 1650
Wire Wire Line
	2600 1050 2600 700 
Wire Wire Line
	2600 700  2750 700 
Connection ~ 2600 1050
Wire Wire Line
	3050 700  3200 700 
Wire Wire Line
	3200 700  3200 1050
Connection ~ 3200 1050
Wire Wire Line
	4050 650  3950 650 
Wire Wire Line
	3950 650  3950 1000
Wire Wire Line
	4050 1000 3950 1000
Connection ~ 3950 1000
Wire Wire Line
	3950 1000 3950 1550
Wire Wire Line
	4350 650  4550 650 
Wire Wire Line
	4550 650  4550 1000
Wire Wire Line
	4350 1000 4550 1000
Connection ~ 4550 1000
Wire Wire Line
	4550 1000 4550 1650
Wire Wire Line
	5950 650  5900 650 
Wire Wire Line
	5900 650  5900 1000
Wire Wire Line
	5950 1000 5900 1000
Connection ~ 5900 1000
Wire Wire Line
	5900 1000 5900 1550
Wire Wire Line
	6250 650  6500 650 
Wire Wire Line
	6500 650  6500 1000
Wire Wire Line
	6250 1000 6500 1000
Connection ~ 6500 1000
Wire Wire Line
	6500 1000 6500 1650
Wire Wire Line
	6150 2950 6050 2950
Wire Wire Line
	6050 2950 6050 3300
Wire Wire Line
	6150 3300 6050 3300
Connection ~ 6050 3300
Wire Wire Line
	6050 3300 6050 3650
Wire Wire Line
	6450 2950 6650 2950
Wire Wire Line
	6650 2950 6650 3300
Wire Wire Line
	6450 3300 6650 3300
Connection ~ 6650 3300
Wire Wire Line
	6650 3300 6650 3750
Wire Wire Line
	2850 3000 2950 3000
Wire Wire Line
	3100 3000 3100 3350
Wire Wire Line
	2900 3350 3100 3350
Connection ~ 3100 3350
Wire Wire Line
	3100 3350 3100 3750
Wire Wire Line
	2500 3000 2500 3350
Wire Wire Line
	2600 3350 2500 3350
Connection ~ 2500 3350
Wire Wire Line
	2500 3350 2500 3650
Connection ~ 2950 3000
Wire Wire Line
	2950 3000 3100 3000
Wire Wire Line
	2500 3000 2650 3000
Wire Wire Line
	4250 3200 4100 3200
Connection ~ 4100 3200
Wire Wire Line
	4550 3200 4700 3200
Connection ~ 4700 3200
Wire Wire Line
	4700 3200 4700 3700
Wire Wire Line
	4100 3200 4100 3600
Wire Wire Line
	4250 2750 4100 2750
Wire Wire Line
	4550 2750 4700 2750
Wire Wire Line
	4700 2750 4700 3200
Wire Wire Line
	4100 2750 4100 3200
$Comp
L Amplifier_Operational:MCP6002-xMC U?
U 3 1 61558409
P 7850 900
F 0 "U?" H 7808 946 50  0000 L CNN
F 1 "MCP6002-xMC" H 7808 855 50  0000 L CNN
F 2 "Package_DFN_QFN:DFN-8-1EP_3x2mm_P0.5mm_EP1.75x1.45mm" H 7850 900 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 7850 900 50  0001 C CNN
	3    7850 900 
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:MCP6002-xMC U?
U 3 1 61558880
P 7850 1750
F 0 "U?" H 7808 1796 50  0000 L CNN
F 1 "MCP6002-xMC" H 7808 1705 50  0000 L CNN
F 2 "Package_DFN_QFN:DFN-8-1EP_3x2mm_P0.5mm_EP1.75x1.45mm" H 7850 1750 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 7850 1750 50  0001 C CNN
	3    7850 1750
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:MCP6002-xMC U?
U 3 1 61559468
P 9100 900
F 0 "U?" H 9058 946 50  0000 L CNN
F 1 "MCP6002-xMC" H 9058 855 50  0000 L CNN
F 2 "Package_DFN_QFN:DFN-8-1EP_3x2mm_P0.5mm_EP1.75x1.45mm" H 9100 900 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 9100 900 50  0001 C CNN
	3    9100 900 
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:MCP6002-xMC U?
U 3 1 61559F48
P 9100 1800
F 0 "U?" H 9058 1846 50  0000 L CNN
F 1 "MCP6002-xMC" H 9058 1755 50  0000 L CNN
F 2 "Package_DFN_QFN:DFN-8-1EP_3x2mm_P0.5mm_EP1.75x1.45mm" H 9100 1800 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 9100 1800 50  0001 C CNN
	3    9100 1800
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:MCP6002-xMC U?
U 3 1 6155A2F9
P 10350 850
F 0 "U?" H 10308 896 50  0000 L CNN
F 1 "MCP6002-xMC" H 10308 805 50  0000 L CNN
F 2 "Package_DFN_QFN:DFN-8-1EP_3x2mm_P0.5mm_EP1.75x1.45mm" H 10350 850 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 10350 850 50  0001 C CNN
	3    10350 850 
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:MCP6002-xMC U?
U 3 1 6155A810
P 10350 1750
F 0 "U?" H 10308 1796 50  0000 L CNN
F 1 "MCP6002-xMC" H 10308 1705 50  0000 L CNN
F 2 "Package_DFN_QFN:DFN-8-1EP_3x2mm_P0.5mm_EP1.75x1.45mm" H 10350 1750 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21733j.pdf" H 10350 1750 50  0001 C CNN
	3    10350 1750
	1    0    0    -1  
$EndComp
$EndSCHEMATC
