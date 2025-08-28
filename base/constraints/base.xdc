# Copyright (C) 2025 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

################################################################################
## Video Constraints
################################################################################
set_property PACKAGE_PIN L14 [get_ports IIC_0_0_sda_io]
set_property PACKAGE_PIN K14 [get_ports IIC_0_0_scl_io]
set_property IOSTANDARD LVCMOS18 [get_ports IIC_0_0_scl_io]
set_property IOSTANDARD LVCMOS18 [get_ports IIC_0_0_sda_io]

set_property PACKAGE_PIN J14 [get_ports rpi_enb[0]]
set_property IOSTANDARD LVCMOS18 [get_ports rpi_enb[0]]

set_property PULLUP true [get_ports IIC_0_0_scl_io]
set_property PULLUP true [get_ports IIC_0_0_sda_io]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]

################################################################################
## Audio Constraints
################################################################################
## Audio I2C
set_property PACKAGE_PIN F5 [get_ports i2c_aic_scl_io]
set_property PACKAGE_PIN G5 [get_ports i2c_aic_sda_io]
set_property IOSTANDARD LVCMOS18 [get_ports i2c_aic*]
## Audio Codec Reset (Active low) driven by GPIO
set_property PACKAGE_PIN E2 [get_ports {AIC_nRST[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {AIC_nRST[0]}]
## FPGA's sdata Output to AIC Codec's sdata Input
set_property PACKAGE_PIN G3 [get_ports AIC_sdata_o]
set_property IOSTANDARD LVCMOS18 [get_ports AIC_sdata_o]
## AIC Codec's sdata Output to FPGA sdata Input
set_property PACKAGE_PIN G4 [get_ports AIC_sdata_i]                   
set_property IOSTANDARD LVCMOS18 [get_ports AIC_sdata_i]
## FPGA sclk out to AIC Codec
set_property PACKAGE_PIN G1 [get_ports AIC_sclk_o]
set_property IOSTANDARD LVCMOS18 [get_ports AIC_sclk_o]
## FPGA lrclk out to AIC codec
set_property PACKAGE_PIN F2 [get_ports AIC_lrclk_o]
set_property IOSTANDARD LVCMOS18 [get_ports AIC_lrclk_o]
## FPGA mclk out to AIC codec
set_property PACKAGE_PIN F3 [get_ports AIC_mclk_o]
set_property IOSTANDARD LVCMOS18 [get_ports AIC_mclk_o]

################################################################################
## White LEDS (8 outputs)
## AGS: Modified to use LED[7] as Heartbeat for Audio Test (above)
################################################################################
set_property PACKAGE_PIN AF5 [get_ports {PL_USER_LED_tri_o[0]}]
set_property PACKAGE_PIN AE7 [get_ports {PL_USER_LED_tri_o[1]}]
set_property PACKAGE_PIN AH2 [get_ports {PL_USER_LED_tri_o[2]}]
set_property PACKAGE_PIN AE5 [get_ports {PL_USER_LED_tri_o[3]}]
set_property PACKAGE_PIN AH1 [get_ports {PL_USER_LED_tri_o[4]}]
set_property PACKAGE_PIN AE4 [get_ports {PL_USER_LED_tri_o[5]}]
set_property PACKAGE_PIN AG1 [get_ports {PL_USER_LED_tri_o[6]}]
set_property PACKAGE_PIN AF2 [get_ports {PL_USER_LED_tri_o[7]}]
set_property IOSTANDARD LVCMOS12 [get_ports PL_USER_LED*]

################################################################################
## RGB LEDS (12 outputs)
################################################################################
set_property PACKAGE_PIN AD7 [get_ports {PL_LEDRGB0_tri_o[0]}]
set_property PACKAGE_PIN AD9 [get_ports {PL_LEDRGB0_tri_o[1]}]
set_property PACKAGE_PIN AE9 [get_ports {PL_LEDRGB0_tri_o[2]}]

set_property PACKAGE_PIN AG9 [get_ports {PL_LEDRGB1_tri_o[0]}]
set_property PACKAGE_PIN AE8 [get_ports {PL_LEDRGB1_tri_o[1]}]
set_property PACKAGE_PIN AF8 [get_ports {PL_LEDRGB1_tri_o[2]}]

set_property PACKAGE_PIN AF7 [get_ports {PL_LEDRGB2_tri_o[0]}]
set_property PACKAGE_PIN AG8 [get_ports {PL_LEDRGB2_tri_o[1]}]
set_property PACKAGE_PIN AG6 [get_ports {PL_LEDRGB2_tri_o[2]}]

set_property PACKAGE_PIN AF6 [get_ports {PL_LEDRGB3_tri_o[0]}]
set_property PACKAGE_PIN AH6 [get_ports {PL_LEDRGB3_tri_o[1]}]
set_property PACKAGE_PIN AG5 [get_ports {PL_LEDRGB3_tri_o[2]}]
set_property IOSTANDARD LVCMOS12 [get_ports PL_LEDRGB*]

################################################################################
## Pushbutton Switches (4 inputs)
################################################################################
set_property PACKAGE_PIN AB6 [get_ports {PL_USER_PB_tri_i[0]}]
set_property PACKAGE_PIN AB7 [get_ports {PL_USER_PB_tri_i[1]}]
set_property PACKAGE_PIN AB2 [get_ports {PL_USER_PB_tri_i[2]}]
set_property PACKAGE_PIN AC6 [get_ports {PL_USER_PB_tri_i[3]}]
set_property IOSTANDARD LVCMOS12 [get_ports PL_USER_PB*]

################################################################################
## Slide Switches (8 inputs)
################################################################################
set_property PACKAGE_PIN AB1 [get_ports {PL_USER_SW_tri_i[0]}]
set_property PACKAGE_PIN AF1 [get_ports {PL_USER_SW_tri_i[1]}]
set_property PACKAGE_PIN AE3 [get_ports {PL_USER_SW_tri_i[2]}]
set_property PACKAGE_PIN AC2 [get_ports {PL_USER_SW_tri_i[3]}]
set_property PACKAGE_PIN AC1 [get_ports {PL_USER_SW_tri_i[4]}]
set_property PACKAGE_PIN AD6 [get_ports {PL_USER_SW_tri_i[5]}]
set_property PACKAGE_PIN AD1 [get_ports {PL_USER_SW_tri_i[6]}]
set_property PACKAGE_PIN AD2 [get_ports {PL_USER_SW_tri_i[7]}]
set_property IOSTANDARD LVCMOS12 [get_ports PL_USER_SW*]

################################################################################
## PMODS (22 pins)
################################################################################
set_property PACKAGE_PIN J12 [get_ports {iop_pmod0[0]}]
set_property PACKAGE_PIN H12 [get_ports {iop_pmod0[1]}]
set_property PACKAGE_PIN H11 [get_ports {iop_pmod0[2]}]
set_property PACKAGE_PIN G10 [get_ports {iop_pmod0[3]}]
set_property PACKAGE_PIN K13 [get_ports {iop_pmod0[4]}]
set_property PACKAGE_PIN K12 [get_ports {iop_pmod0[5]}]
set_property PACKAGE_PIN J11 [get_ports {iop_pmod0[6]}]
set_property PACKAGE_PIN J10 [get_ports {iop_pmod0[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports iop_pmod0*]
set_property PULLUP true [get_ports {iop_pmod0[2]}]
set_property PULLUP true [get_ports {iop_pmod0[3]}]
set_property PULLUP true [get_ports {iop_pmod0[6]}]
set_property PULLUP true [get_ports {iop_pmod0[7]}]

set_property PACKAGE_PIN E12 [get_ports {iop_pmod1[0]}]
set_property PACKAGE_PIN D11 [get_ports {iop_pmod1[1]}]
set_property PACKAGE_PIN B11 [get_ports {iop_pmod1[2]}]
set_property PACKAGE_PIN A10 [get_ports {iop_pmod1[3]}]
set_property PACKAGE_PIN C11 [get_ports {iop_pmod1[4]}]
set_property PACKAGE_PIN B10 [get_ports {iop_pmod1[5]}]
set_property PACKAGE_PIN A12 [get_ports {iop_pmod1[6]}]
set_property PACKAGE_PIN A11 [get_ports {iop_pmod1[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports iop_pmod1*]
set_property PULLUP true [get_ports {iop_pmod1[2]}]
set_property PULLUP true [get_ports {iop_pmod1[3]}]
set_property PULLUP true [get_ports {iop_pmod1[6]}]
set_property PULLUP true [get_ports {iop_pmod1[7]}]

#set_property PACKAGE_PIN G11 [get_ports {JAB_tri_io[1]}]
#set_property PACKAGE_PIN E10 [get_ports {JAB_tri_io[2]}]
#set_property PACKAGE_PIN D10 [get_ports {JAB_tri_io[3]}]
#set_property PACKAGE_PIN F10 [get_ports {JAB_tri_io[4]}]
#set_property PACKAGE_PIN F11 [get_ports {JAB_tri_io[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports JAB_tri_io*]

################################################################################
## Rasbery PI Headers
################################################################################
set_property PACKAGE_PIN AF10 [get_ports {iop_rpi0[0]}]
set_property PACKAGE_PIN AG10 [get_ports {iop_rpi0[1]}]
set_property PACKAGE_PIN AC12 [get_ports {iop_rpi0[2]}]
set_property PACKAGE_PIN AD12 [get_ports {iop_rpi0[3]}]
set_property PACKAGE_PIN AE12 [get_ports {iop_rpi0[4]}]
set_property PACKAGE_PIN AE10 [get_ports {iop_rpi0[5]}]
set_property PACKAGE_PIN AB11 [get_ports {iop_rpi0[6]}]
set_property PACKAGE_PIN AD11 [get_ports {iop_rpi0[7]}]
set_property PACKAGE_PIN AG11 [get_ports {iop_rpi0[8]}]
set_property PACKAGE_PIN AH11 [get_ports {iop_rpi0[9]}]
set_property PACKAGE_PIN AH12 [get_ports {iop_rpi0[10]}]
set_property PACKAGE_PIN AH10 [get_ports {iop_rpi0[11]}]
set_property PACKAGE_PIN AD10 [get_ports {iop_rpi0[12]}]
set_property PACKAGE_PIN AA11 [get_ports {iop_rpi0[13]}]
set_property PACKAGE_PIN AE15 [get_ports {iop_rpi0[14]}]
set_property PACKAGE_PIN AF13 [get_ports {iop_rpi0[15]}]
set_property PACKAGE_PIN AB10 [get_ports {iop_rpi0[16]}]
set_property PACKAGE_PIN AG14 [get_ports {iop_rpi0[17]}]
set_property PACKAGE_PIN AC11 [get_ports {iop_rpi0[18]}]
set_property PACKAGE_PIN AB9 [get_ports {iop_rpi0[19]}]
set_property PACKAGE_PIN AA10 [get_ports {iop_rpi0[20]}]
set_property PACKAGE_PIN Y9 [get_ports {iop_rpi0[21]}]
set_property PACKAGE_PIN AH13 [get_ports {iop_rpi0[22]}]
set_property PACKAGE_PIN AG13 [get_ports {iop_rpi0[23]}]
set_property PACKAGE_PIN AF12 [get_ports {iop_rpi0[24]}]
set_property PACKAGE_PIN AF11 [get_ports {iop_rpi0[25]}]
set_property PACKAGE_PIN AA8 [get_ports {iop_rpi0[26]}]
set_property PACKAGE_PIN AH14 [get_ports {iop_rpi0[27]}]

set_property PULLUP TRUE [get_ports {iop_rpi0[17]}]; 
set_property PULLUP TRUE [get_ports {iop_rpi0[18]}]; 

set_property IOSTANDARD LVCMOS33 [get_ports {iop_rpi0[*]}]; 

    
################################################################################
## Grove PL
################################################################################
set_property PACKAGE_PIN AE14 [get_ports {iop_grove0[0]}]
set_property PACKAGE_PIN AE13 [get_ports {iop_grove0[1]}]

set_property PACKAGE_PIN AD15 [get_ports {iop_grove0[2]}]
set_property PACKAGE_PIN AD14 [get_ports {iop_grove0[3]}]

set_property PULLUP TRUE [get_ports {iop_grove0[*]}]; 

set_property IOSTANDARD LVCMOS33 [get_ports iop_grove0*]

################################################################################
## Joystick Selection
################################################################################
set_property PACKAGE_PIN AC13 [get_ports {SEL_JOYSTICK_tri_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports SEL_JOYSTICK*]


set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]
set_property BITSTREAM.CONFIG.OVERTEMPSHUTDOWN ENABLE [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

