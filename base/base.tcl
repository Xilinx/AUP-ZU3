# Copyright (C) 2025 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

################################################################
# This is a generated script based on design: base
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
    proc get_script_folder {} {
	set script_path [file normalize [info script]]
	set script_folder [file dirname $script_path]
	return $script_folder
    }
}
variable script_folder
set script_folder [_tcl::get_script_folder]

# Get the first command-line argument for DDR4 configuration (8 = 8G; 4 = 4GB)
variable ddr4_config
set ddr4_config [lindex $argv 0]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2024.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
puts ""
if { [string compare $scripts_vivado_version $current_vivado_version] > 0 } {
    catch {common::send_gid_msg -ssname BD::TCL -id 2042 -severity "ERROR" " This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Sourcing the script failed since it was created with a future version of Vivado."}

} else {
    catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

}

return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source base_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.
# CHANGE DESIGN NAME HERE
variable design_name
set design_name base


set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
create_project $design_name $design_name -part xczu3eg-sfvc784-2-e -force
}

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
# USE CASES:
#    1) Design_name not set

set errMsg "Please set the variable <design_name> to a non-empty value."
set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
# USE CASES:
#    2): Current design opened AND is empty AND names same.
#    3): Current design opened AND is empty AND names diff; design_name NOT in project.
#    4): Current design opened AND is empty AND names diff; design_name exists in project.

if { $cur_design ne $design_name } {
    common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
    set design_name [get_property NAME $cur_design]
}
common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
# USE CASES:
#    5) Current design opened AND has components AND same names.

set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
# USE CASES: 
#    6) Current opened design, has components, but diff names, design_name exists in project.
#    7) No opened design, design_name exists in project.

set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
set nRet 2

} else {
# USE CASES:
#    8) No opened design, design_name not in project.
#    9) Current opened design, has components, but diff names, design_name not in project.

common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

create_bd_design $design_name

common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
return $nRet
}

set_property ip_repo_paths {../pynq/boards/ip} [current_project]
update_ip_catalog

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
set list_check_ips "\ 
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:system_management_wiz:1.3\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:zynq_ultra_ps_e:3.5\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:i2s_receiver:1.0\
xilinx.com:ip:i2s_transmitter:1.0\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:axi_iic:2.1\
xilinx.com:ip:v_tc:6.2\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:v_gamma_lut:1.1\
xilinx.com:ip:axis_subset_converter:1.1\
xilinx.com:ip:mipi_csi2_rx_subsystem:6.0\
xilinx.com:ip:v_axi4s_vid_out:4.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:v_demosaic:1.1\
xilinx.com:ip:axi_vdma:6.3\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:v_proc_ss:2.3\
xilinx.com:hls:pixel_pack_2:1.0\
"

set list_ips_missing ""
common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

foreach ip_vlnv $list_check_ips {
    set ip_obj [get_ipdefs -all $ip_vlnv]
    if { $ip_obj eq "" } {
	lappend list_ips_missing $ip_vlnv
    }
}

if { $list_ips_missing ne "" } {
    catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
    set bCheckIPsPassed 0
}

}

if { $bCheckIPsPassed != 1 } {
common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
return 3
}

##################################################################
# DESIGN PROCs
##################################################################

# Hierarchical cell: audio
proc create_hier_cell_audio { parentCell nameHier } {

    variable script_folder

    if { $parentCell eq "" || $nameHier eq "" } {
	catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_audio() - Empty argument(s)!"}
	return
    }

    # Get object for parentCell
    set parentObj [get_bd_cells $parentCell]
    if { $parentObj == "" } {
	catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
	return
    }

    # Make sure parentObj is hier blk
    set parentType [get_property TYPE $parentObj]
    if { $parentType ne "hier" } {
	catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
	return
    }

    # Save current instance; Restore later
    set oldCurInst [current_bd_instance .]

    # Set parent object as current
    current_bd_instance $parentObj

    # Create cell and set as current instance
    set hier_obj [create_bd_cell -type hier $nameHier]
    current_bd_instance $hier_obj

    # Create interface pins
    create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 i2s_rx_s_axi_ctrl_i

    create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 i2s_tx_s_axi_ctrl_i

    create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 AIC_nRST

    create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 axi_gpio_ctrl_i

    create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 i2c_aic

    create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 axi_i2c_ctrl_i


    # Create pins
    create_bd_pin -dir I axi_ctrl_clk_i
    create_bd_pin -dir O -type intr i2s_rx_irq_o
    create_bd_pin -dir O -type intr i2s_tx_irq_o
    create_bd_pin -dir O i2s_tx_sdata_o
    create_bd_pin -dir I i2s_rx_sdata_i
    create_bd_pin -dir I axi_ctrl_nrst_i
    create_bd_pin -dir O lrclk_o
    create_bd_pin -dir O sclk_o
    create_bd_pin -dir O -type intr iic2intc_irpt
    create_bd_pin -dir O AIC_mclk_o

    # Create instance: i2s_receiver_0, and set properties
    set i2s_receiver_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:i2s_receiver:1.0 i2s_receiver_0 ]
    set_property CONFIG.C_DWIDTH {16} $i2s_receiver_0


    # Create instance: i2s_transmitter_0, and set properties
    set i2s_transmitter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:i2s_transmitter:1.0 i2s_transmitter_0 ]
    set_property -dict [list \
			    CONFIG.C_DWIDTH {16} \
			    CONFIG.C_IS_MASTER {0} \
			   ] $i2s_transmitter_0


    # Create instance: mclk_wiz_0, and set properties
    set mclk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 mclk_wiz_0 ]
    set_property -dict [list \
			    CONFIG.CLKOUT1_JITTER {401.141} \
			    CONFIG.CLKOUT1_PHASE_ERROR {474.126} \
			    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {12.288} \
			    CONFIG.MMCM_CLKFBOUT_MULT_F {88.750} \
			    CONFIG.MMCM_CLKOUT0_DIVIDE_F {80.250} \
			    CONFIG.MMCM_DIVCLK_DIVIDE {9} \
			    CONFIG.RESET_PORT {resetn} \
			    CONFIG.RESET_TYPE {ACTIVE_LOW} \
			   ] $mclk_wiz_0


    # Create instance: proc_sys_reset_0, and set properties
    set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

    # Create instance: axi_gpio_0, and set properties
    set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
    set_property -dict [list \
			    CONFIG.C_ALL_OUTPUTS {1} \
			    CONFIG.C_GPIO_WIDTH {1} \
			   ] $axi_gpio_0


    # Create instance: axi_iic_aic, and set properties
    set axi_iic_aic [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_aic ]

    # Create interface connections
    connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins i2s_receiver_0/s_axi_ctrl] [get_bd_intf_pins i2s_rx_s_axi_ctrl_i]
    connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins i2s_transmitter_0/s_axi_ctrl] [get_bd_intf_pins i2s_tx_s_axi_ctrl_i]
    connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins axi_gpio_0/GPIO] [get_bd_intf_pins AIC_nRST]
    connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins axi_gpio_ctrl_i]
    connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins axi_iic_aic/IIC] [get_bd_intf_pins i2c_aic]
    connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins axi_iic_aic/S_AXI] [get_bd_intf_pins axi_i2c_ctrl_i]
    connect_bd_intf_net -intf_net i2s_receiver_0_m_axis_aud [get_bd_intf_pins i2s_receiver_0/m_axis_aud] [get_bd_intf_pins i2s_transmitter_0/s_axis_aud]

    # Create port connections
    connect_bd_net -net Net  [get_bd_pins axi_ctrl_clk_i] \
	[get_bd_pins i2s_transmitter_0/s_axis_aud_aclk] \
	[get_bd_pins i2s_receiver_0/m_axis_aud_aclk] \
	[get_bd_pins i2s_transmitter_0/s_axi_ctrl_aclk] \
	[get_bd_pins i2s_receiver_0/s_axi_ctrl_aclk] \
	[get_bd_pins mclk_wiz_0/clk_in1] \
	[get_bd_pins axi_gpio_0/s_axi_aclk] \
	[get_bd_pins axi_iic_aic/s_axi_aclk]
    connect_bd_net -net Net1  [get_bd_pins axi_ctrl_nrst_i] \
	[get_bd_pins i2s_transmitter_0/s_axis_aud_aresetn] \
	[get_bd_pins i2s_transmitter_0/s_axi_ctrl_aresetn] \
	[get_bd_pins i2s_receiver_0/m_axis_aud_aresetn] \
	[get_bd_pins i2s_receiver_0/s_axi_ctrl_aresetn] \
	[get_bd_pins proc_sys_reset_0/ext_reset_in] \
	[get_bd_pins mclk_wiz_0/resetn] \
	[get_bd_pins axi_gpio_0/s_axi_aresetn] \
	[get_bd_pins axi_iic_aic/s_axi_aresetn]
    connect_bd_net -net aud_mrst_0_1  [get_bd_pins proc_sys_reset_0/peripheral_reset] \
	[get_bd_pins i2s_receiver_0/aud_mrst] \
	[get_bd_pins i2s_transmitter_0/aud_mrst]
    connect_bd_net -net axi_iic_aic_iic2intc_irpt  [get_bd_pins axi_iic_aic/iic2intc_irpt] \
	[get_bd_pins iic2intc_irpt]
    connect_bd_net -net i2s_receiver_0_irq  [get_bd_pins i2s_receiver_0/irq] \
	[get_bd_pins i2s_rx_irq_o]
    connect_bd_net -net i2s_receiver_0_lrclk_out  [get_bd_pins i2s_receiver_0/lrclk_out] \
	[get_bd_pins lrclk_o] \
	[get_bd_pins i2s_transmitter_0/lrclk_in]
    connect_bd_net -net i2s_receiver_0_sclk_out  [get_bd_pins i2s_receiver_0/sclk_out] \
	[get_bd_pins sclk_o] \
	[get_bd_pins i2s_transmitter_0/sclk_in]
    connect_bd_net -net i2s_transmitter_0_irq  [get_bd_pins i2s_transmitter_0/irq] \
	[get_bd_pins i2s_tx_irq_o]
    connect_bd_net -net i2s_transmitter_0_sdata_0_out  [get_bd_pins i2s_transmitter_0/sdata_0_out] \
	[get_bd_pins i2s_tx_sdata_o]
    connect_bd_net -net mclk_wiz_0_clk_out1  [get_bd_pins mclk_wiz_0/clk_out1] \
	[get_bd_pins proc_sys_reset_0/slowest_sync_clk] \
	[get_bd_pins i2s_receiver_0/aud_mclk] \
	[get_bd_pins i2s_transmitter_0/aud_mclk] \
	[get_bd_pins AIC_mclk_o]
    connect_bd_net -net sdata_0_in_0_1  [get_bd_pins i2s_rx_sdata_i] \
	[get_bd_pins i2s_receiver_0/sdata_0_in]

    # Restore current instance
    current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

    variable script_folder
    variable design_name
    variable ddr4_config    

    if { $parentCell eq "" } {
	set parentCell [get_bd_cells /]
    }

    # Get object for parentCell
    set parentObj [get_bd_cells $parentCell]
    if { $parentObj == "" } {
	catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
	return
    }

    # Make sure parentObj is hier blk
    set parentType [get_property TYPE $parentObj]
    if { $parentType ne "hier" } {
	catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
	return
    }

    # Save current instance; Restore later
    set oldCurInst [current_bd_instance .]

    # Set parent object as current
    current_bd_instance $parentObj


    # Create interface ports
    set HORZ [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 HORZ ]

    set VERT [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 VERT ]

    set Vp_Vn [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 Vp_Vn ]

    set i2c_aic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 i2c_aic ]

    set CAM [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 CAM ]

    set IIC_0_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_0_0 ]

    set PL_LEDRGB1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 PL_LEDRGB1 ]

    set PL_LEDRGB2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 PL_LEDRGB2 ]

    set PL_LEDRGB0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 PL_LEDRGB0 ]

    set PL_LEDRGB3 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 PL_LEDRGB3 ]

    set PL_USER_LED [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 PL_USER_LED ]

    set SEL_JOYSTICK [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 SEL_JOYSTICK ]

    set PL_USER_PB [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 PL_USER_PB ]

    set PL_USER_SW [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 PL_USER_SW ]


    # Create ports
    set AIC_nRST [ create_bd_port -dir O -from 0 -to 0 AIC_nRST ]
    set AIC_sdata_o [ create_bd_port -dir O AIC_sdata_o ]
    set AIC_sdata_i [ create_bd_port -dir I AIC_sdata_i ]
    set AIC_lrclk_o [ create_bd_port -dir O AIC_lrclk_o ]
    set AIC_sclk_o [ create_bd_port -dir O AIC_sclk_o ]
    set AIC_mclk_o [ create_bd_port -dir O AIC_mclk_o ]
    set rpi_enb [ create_bd_port -dir O -from 0 -to 0 rpi_enb ]

    # Create instance: ps8_0_axi_periph, and set properties
    set ps8_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 ps8_0_axi_periph ]
    set_property -dict [list \
			    CONFIG.NUM_MI {20} \
			    CONFIG.NUM_SI {1} \
			   ] $ps8_0_axi_periph


    # Create instance: rst_ps8_0_99M, and set properties
    set rst_ps8_0_99M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_99M ]

    # Create instance: system_management_wiz_0, and set properties
    set system_management_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_management_wiz:1.3 system_management_wiz_0 ]
    set_property -dict [list \
			    CONFIG.ANALOG_BANK_SELECTION {44} \
			    CONFIG.BIPOLAR_VAUXP8_VAUXN8 {false} \
			    CONFIG.BIPOLAR_VAUXP9_VAUXN9 {false} \
			    CONFIG.BIPOLAR_VP_VN {false} \
			    CONFIG.CHANNEL_ENABLE_VAUXP8_VAUXN8 {true} \
			    CONFIG.CHANNEL_ENABLE_VAUXP9_VAUXN9 {true} \
			    CONFIG.CHANNEL_ENABLE_VP_VN {true} \
			    CONFIG.ENABLE_EXTERNAL_MUX {false} \
			    CONFIG.EXTERNAL_MUXADDR_ENABLE {false} \
			    CONFIG.INTERFACE_SELECTION {Enable_AXI} \
			    CONFIG.VAUXN0_LOC {AB9} \
			    CONFIG.VAUXN10_LOC {Y13} \
			    CONFIG.VAUXN11_LOC {W13} \
			    CONFIG.VAUXN12_LOC {AF13} \
			    CONFIG.VAUXN13_LOC {AH13} \
			    CONFIG.VAUXN14_LOC {AH14} \
			    CONFIG.VAUXN15_LOC {AE14} \
			    CONFIG.VAUXN1_LOC {AA8} \
			    CONFIG.VAUXN2_LOC {Y10} \
			    CONFIG.VAUXN3_LOC {AA10} \
			    CONFIG.VAUXN4_LOC {AC11} \
			    CONFIG.VAUXN5_LOC {AD10} \
			    CONFIG.VAUXN6_LOC {AD12} \
			    CONFIG.VAUXN7_LOC {AF12} \
			    CONFIG.VAUXN8_LOC {AA12} \
			    CONFIG.VAUXN9_LOC {W11} \
			    CONFIG.VAUXP0_LOC {AB10} \
			    CONFIG.VAUXP10_LOC {Y14} \
			    CONFIG.VAUXP11_LOC {W14} \
			    CONFIG.VAUXP12_LOC {AE13} \
			    CONFIG.VAUXP13_LOC {AG13} \
			    CONFIG.VAUXP14_LOC {AG14} \
			    CONFIG.VAUXP15_LOC {AE15} \
			    CONFIG.VAUXP1_LOC {Y9} \
			    CONFIG.VAUXP2_LOC {W10} \
			    CONFIG.VAUXP3_LOC {AA11} \
			    CONFIG.VAUXP4_LOC {AB11} \
			    CONFIG.VAUXP5_LOC {AD11} \
			    CONFIG.VAUXP6_LOC {AC12} \
			    CONFIG.VAUXP7_LOC {AE12} \
			    CONFIG.VAUXP8_LOC {Y12} \
			    CONFIG.VAUXP9_LOC {W12} \
			   ] $system_management_wiz_0


    # Create instance: xlconcat_0, and set properties
    set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
    set_property CONFIG.NUM_PORTS {8} $xlconcat_0

    # Create instance: zynq_ultra_ps_e_0, and set properties
    source run_create_zynq_ultra_ps.tcl
    puts "Building for $ddr4_config GB AUP-ZU3 DDR4 Configuration"    
    create_zynq_ultra_ps $ddr4_config

    # Create instance: audio
    create_hier_cell_audio [current_bd_instance .] audio

    # Create instance: mipi
    source run_create_mipi.tcl
    create_hier_cell_mipi [current_bd_instance .] mipi

    # Create instance: pl_user_led, and set properties
    set pl_user_led [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 pl_user_led ]
    set_property -dict [list \
			    CONFIG.C_ALL_OUTPUTS {1} \
			    CONFIG.C_GPIO_WIDTH {8} \
			   ] $pl_user_led


    # Create instance: pl_rgb0_led, and set properties
    set pl_rgb0_led [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 pl_rgb0_led ]
    set_property -dict [list \
			    CONFIG.C_ALL_OUTPUTS {1} \
			    CONFIG.C_GPIO_WIDTH {3} \
			   ] $pl_rgb0_led


    # Create instance: pl_rgb1_led, and set properties
    set pl_rgb1_led [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 pl_rgb1_led ]
    set_property -dict [list \
			    CONFIG.C_ALL_OUTPUTS {1} \
			    CONFIG.C_GPIO_WIDTH {3} \
			   ] $pl_rgb1_led


    # Create instance: pl_rgb2_led, and set properties
    set pl_rgb2_led [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 pl_rgb2_led ]
    set_property -dict [list \
			    CONFIG.C_ALL_OUTPUTS {1} \
			    CONFIG.C_GPIO_WIDTH {3} \
			   ] $pl_rgb2_led


    # Create instance: pl_rgb3_led, and set properties
    set pl_rgb3_led [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 pl_rgb3_led ]
    set_property -dict [list \
			    CONFIG.C_ALL_OUTPUTS {1} \
			    CONFIG.C_GPIO_WIDTH {3} \
			   ] $pl_rgb3_led

    # Create instance: SEL_JOYSTICK, and set properties
    set SEL_JOYSTICK [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 SEL_JOYSTICK ]
    set_property -dict [list \
			    CONFIG.C_ALL_OUTPUTS {1} \
			    CONFIG.C_GPIO_WIDTH {1} \
			   ] [get_bd_cells SEL_JOYSTICK]

    # Create instance: pl_user_pb, and set properties
    set pl_user_pb [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 pl_user_pb ]
    set_property -dict [list \
			    CONFIG.C_ALL_INPUTS {1} \
			    CONFIG.C_GPIO_WIDTH {4} \
			    CONFIG.C_INTERRUPT_PRESENT {1} \
		       ] $pl_user_pb


    # Create instance: pl_user_sw, and set properties
    set pl_user_sw [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 pl_user_sw ]
    set_property -dict [list \
			    CONFIG.C_ALL_INPUTS {1} \
			    CONFIG.C_GPIO_WIDTH {8} \
			    CONFIG.C_INTERRUPT_PRESENT {1} \
		       ] $pl_user_sw
    
    # Create shutdown manager
    
    create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_axi_shutdown_manager:1.0 dfx_axi_shutdown_man_0
    set_property name shutdown_HP0_FPD [get_bd_cells dfx_axi_shutdown_man_0]
    set_property -dict [list CONFIG.DP_AXI_DATA_WIDTH.VALUE_SRC USER] [get_bd_cells shutdown_HP0_FPD]
    set_property -dict [list \
			    CONFIG.CTRL_INTERFACE_TYPE {1} \
			    CONFIG.DP_AXI_DATA_WIDTH {128} \
			   ] [get_bd_cells shutdown_HP0_FPD]


    # Create interface connections
    connect_bd_intf_net -intf_net SEL_JOYSTICK_GPIO [get_bd_intf_ports SEL_JOYSTICK] [get_bd_intf_pins SEL_JOYSTICK/GPIO]
    connect_bd_intf_net -intf_net Vp_Vn_0_1 [get_bd_intf_ports Vp_Vn] [get_bd_intf_pins system_management_wiz_0/Vp_Vn]
    connect_bd_intf_net -intf_net audio_i2c_aic [get_bd_intf_ports i2c_aic] [get_bd_intf_pins audio/i2c_aic]
    connect_bd_intf_net -intf_net diff_analog_io_rtl_0_1 [get_bd_intf_ports HORZ] [get_bd_intf_pins system_management_wiz_0/Vaux8]
    connect_bd_intf_net -intf_net diff_analog_io_rtl_1_1 [get_bd_intf_ports VERT] [get_bd_intf_pins system_management_wiz_0/Vaux9]
    connect_bd_intf_net -intf_net i2s_rx_s_axi_ctrl_i_1 [get_bd_intf_pins audio/i2s_rx_s_axi_ctrl_i] [get_bd_intf_pins ps8_0_axi_periph/M06_AXI]
    connect_bd_intf_net -intf_net i2s_tx_s_axi_ctrl_i_1 [get_bd_intf_pins audio/i2s_tx_s_axi_ctrl_i] [get_bd_intf_pins ps8_0_axi_periph/M07_AXI]
    connect_bd_intf_net -intf_net pl_rgb0_led_GPIO [get_bd_intf_ports PL_LEDRGB0] [get_bd_intf_pins pl_rgb0_led/GPIO]
    connect_bd_intf_net -intf_net pl_rgb1_led_GPIO [get_bd_intf_ports PL_LEDRGB1] [get_bd_intf_pins pl_rgb1_led/GPIO]
    connect_bd_intf_net -intf_net pl_rgb2_led_GPIO [get_bd_intf_ports PL_LEDRGB2] [get_bd_intf_pins pl_rgb2_led/GPIO]
    connect_bd_intf_net -intf_net pl_rgb3_led_GPIO [get_bd_intf_ports PL_LEDRGB3] [get_bd_intf_pins pl_rgb3_led/GPIO]
    connect_bd_intf_net -intf_net pl_user_led_GPIO [get_bd_intf_ports PL_USER_LED] [get_bd_intf_pins pl_user_led/GPIO]
    connect_bd_intf_net -intf_net pl_user_pb_GPIO [get_bd_intf_ports PL_USER_PB] [get_bd_intf_pins pl_user_pb/GPIO]
    connect_bd_intf_net -intf_net pl_user_sw_GPIO [get_bd_intf_ports PL_USER_SW] [get_bd_intf_pins pl_user_sw/GPIO]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M00_AXI [get_bd_intf_pins ps8_0_axi_periph/M00_AXI] [get_bd_intf_pins pl_rgb0_led/S_AXI]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M01_AXI [get_bd_intf_pins ps8_0_axi_periph/M01_AXI] [get_bd_intf_pins pl_rgb1_led/S_AXI]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M02_AXI [get_bd_intf_pins ps8_0_axi_periph/M02_AXI] [get_bd_intf_pins pl_rgb2_led/S_AXI]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M03_AXI [get_bd_intf_pins ps8_0_axi_periph/M03_AXI] [get_bd_intf_pins pl_rgb3_led/S_AXI]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M04_AXI [get_bd_intf_pins ps8_0_axi_periph/M04_AXI] [get_bd_intf_pins pl_user_led/S_AXI]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M08_AXI [get_bd_intf_pins ps8_0_axi_periph/M08_AXI] [get_bd_intf_pins audio/axi_i2c_ctrl_i]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M09_AXI [get_bd_intf_pins ps8_0_axi_periph/M09_AXI] [get_bd_intf_pins SEL_JOYSTICK/S_AXI]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M10_AXI [get_bd_intf_pins ps8_0_axi_periph/M10_AXI] [get_bd_intf_pins audio/axi_gpio_ctrl_i]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M11_AXI [get_bd_intf_pins system_management_wiz_0/S_AXI_LITE] [get_bd_intf_pins ps8_0_axi_periph/M11_AXI]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M12_AXI [get_bd_intf_pins ps8_0_axi_periph/M12_AXI] [get_bd_intf_pins pl_user_pb/S_AXI]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M13_AXI [get_bd_intf_pins ps8_0_axi_periph/M13_AXI] [get_bd_intf_pins pl_user_sw/S_AXI]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M14_AXI [get_bd_intf_pins ps8_0_axi_periph/M14_AXI] [get_bd_intf_pins shutdown_HP0_FPD/S_AXI_CTRL] 
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M15_AXI [get_bd_intf_pins ps8_0_axi_periph/M15_AXI] [get_bd_intf_pins mipi/S_AXI_LITE]    
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M16_AXI [get_bd_intf_pins ps8_0_axi_periph/M16_AXI] [get_bd_intf_pins mipi/csirxss_s_axi]
    connect_bd_intf_net -intf_net ps8_0_axi_periph_M17_AXI [get_bd_intf_pins ps8_0_axi_periph/M17_AXI] [get_bd_intf_pins mipi/S_AXI]
    #    connect_bd_intf_net -intf_net ps8_0_axi_periph_M18_AXI [get_bd_intf_pins ps8_0_axi_periph/M18_AXI] [get_bd_intf_pins shutdown_LPD/S_AXI_CTRL]
    #    connect_bd_intf_net -intf_net ps8_0_axi_periph_M19_AXI [get_bd_intf_pins ps8_0_axi_periph/M19_AXI] [get_bd_intf_pins axi_intc_0/s_axi]

    connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_LPD [get_bd_intf_pins ps8_0_axi_periph/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_LPD]    
    connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_FPD [get_bd_intf_pins mipi/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_FPD]
    connect_bd_intf_net -intf_net shutdown_hp0_fdp [get_bd_intf_pins mipi/M00_AXI] [get_bd_intf_pins shutdown_HP0_FPD/S_AXI]
    connect_bd_intf_net -intf_net mipi_IIC_0_0 [get_bd_intf_ports IIC_0_0] [get_bd_intf_pins mipi/IIC_0_0]
    connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP0_FPD] [get_bd_intf_pins shutdown_HP0_FPD/M_AXI]
    connect_bd_intf_net [get_bd_intf_ports CAM] [get_bd_intf_pins mipi/mipi_phy_if_0]
    
    # Create port connections
    connect_bd_net -net audio_AIC_mclk_o  [get_bd_pins audio/AIC_mclk_o] \
	[get_bd_ports AIC_mclk_o]
    connect_bd_net -net audio_AIC_nRST_tri_o  [get_bd_pins audio/AIC_nRST_tri_o] \
	[get_bd_ports AIC_nRST]
    connect_bd_net -net system_management_wiz_0_ip2intc_irpt  [get_bd_pins system_management_wiz_0/ip2intc_irpt] \
	[get_bd_pins xlconcat_0/In0]
    connect_bd_net -net audio_iic2intc_irpt  [get_bd_pins audio/iic2intc_irpt] \
	[get_bd_pins xlconcat_0/In1]
    connect_bd_net -net audio_i2s_rx_irq_o  [get_bd_pins audio/i2s_rx_irq_o] \
	[get_bd_pins xlconcat_0/In2]
    connect_bd_net -net audio_i2s_tx_irq_o  [get_bd_pins audio/i2s_tx_irq_o] \
	[get_bd_pins xlconcat_0/In3]
    connect_bd_net -net mipi_csirxss_csi_irq_o [get_bd_pins mipi/csirxss_csi_irq] \
	[get_bd_pins xlconcat_0/In4]
    connect_bd_net -net mipi_s2mm_introut [get_bd_pins mipi/s2mm_introut] \
	[get_bd_pins xlconcat_0/In5]
    connect_bd_net -net pl_user_pb_ip2intc_irpt [get_bd_pins pl_user_pb/ip2intc_irpt] \
	[get_bd_pins xlconcat_0/In6]    
    connect_bd_net -net pl_user_sw_ip2intc_irpt [get_bd_pins pl_user_sw/ip2intc_irpt] \
	[get_bd_pins xlconcat_0/In7]
    connect_bd_net -net audio_lrclk_out_0  [get_bd_pins audio/lrclk_o] \
	[get_bd_ports AIC_lrclk_o]
    connect_bd_net -net audio_sclk_out_0  [get_bd_pins audio/sclk_o] \
	[get_bd_ports AIC_sclk_o]
    connect_bd_net -net audio_sdata_0_out_0  [get_bd_pins audio/i2s_tx_sdata_o] \
	[get_bd_ports AIC_sdata_o]
    connect_bd_net -net i2s_rx_sdata_i_0_1  [get_bd_ports AIC_sdata_i] \
	[get_bd_pins audio/i2s_rx_sdata_i]
    connect_bd_net -net xlconcat_0_dout  [get_bd_pins xlconcat_0/dout] \
	[get_bd_pins zynq_ultra_ps_e_0/pl_ps_irq0]
    connect_bd_net -net pl_ps_irq1 [get_bd_pins mipi/iic2intc_irpt] \
	[get_bd_pins zynq_ultra_ps_e_0/pl_ps_irq1]
    connect_bd_net [get_bd_ports rpi_enb] \
	[get_bd_pins mipi/cam_gpio_tri_o]
    connect_bd_net -net zynq_ultra_ps_e_0_pl_clk1  [get_bd_pins zynq_ultra_ps_e_0/pl_clk1] \
	[get_bd_pins mipi/video_aclk] \
	[get_bd_pins ps8_0_axi_periph/M14_ACLK] \
	[get_bd_pins zynq_ultra_ps_e_0/maxihpm0_fpd_aclk] \
	[get_bd_pins zynq_ultra_ps_e_0/saxihp0_fpd_aclk] \
	[get_bd_pins shutdown_HP0_FPD/clk] \
	
    connect_bd_net -net zynq_ultra_ps_e_0_pl_clk0  [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] \
	[get_bd_pins mipi/lite_aclk] \
	[get_bd_pins ps8_0_axi_periph/ACLK] \
	[get_bd_pins ps8_0_axi_periph/M00_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M01_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M02_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M03_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M04_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M05_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M06_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M07_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M08_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M09_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M10_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M11_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M12_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M13_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M15_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M16_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M17_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M18_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M19_ACLK] \
	[get_bd_pins ps8_0_axi_periph/S00_ACLK] \
	[get_bd_pins rst_ps8_0_99M/slowest_sync_clk] \
	[get_bd_pins system_management_wiz_0/s_axi_aclk] \
	[get_bd_pins zynq_ultra_ps_e_0/maxihpm0_lpd_aclk] \
	[get_bd_pins audio/axi_ctrl_clk_i] \
	[get_bd_pins ps8_0_axi_periph/M10_ACLK] \
	[get_bd_pins ps8_0_axi_periph/M11_ACLK] \
	[get_bd_pins pl_rgb0_led/s_axi_aclk] \
	[get_bd_pins pl_rgb1_led/s_axi_aclk] \
	[get_bd_pins pl_rgb2_led/s_axi_aclk] \
	[get_bd_pins pl_rgb3_led/s_axi_aclk] \
	[get_bd_pins pl_user_led/s_axi_aclk] \
	[get_bd_pins SEL_JOYSTICK/s_axi_aclk] \
	[get_bd_pins pl_user_pb/s_axi_aclk] \
	[get_bd_pins ps8_0_axi_periph/M12_ACLK] \
	[get_bd_pins pl_user_sw/s_axi_aclk] \
	[get_bd_pins ps8_0_axi_periph/M13_ACLK]
    connect_bd_net -net zynq_ultra_ps_e_0_pl_resetn0  [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0] \
	[get_bd_pins mipi/aux_reset_in] \
	[get_bd_pins rst_ps8_0_99M/ext_reset_in]
    connect_bd_net [get_bd_pins mipi/peripheral_aresetn] \
	[get_bd_pins shutdown_HP0_FPD/resetn] \
	[get_bd_pins ps8_0_axi_periph/M14_ARESETN]
    connect_bd_net [get_bd_pins rst_ps8_0_99M/peripheral_aresetn] \
	[get_bd_pins mipi/lite_aresetn] \
	[get_bd_pins ps8_0_axi_periph/ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M00_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M01_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M02_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M03_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M04_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M05_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M06_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M07_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M08_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M09_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M10_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M11_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M12_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M13_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M15_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M16_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M17_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M18_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/M19_ARESETN] \
	[get_bd_pins ps8_0_axi_periph/S00_ARESETN] \
	[get_bd_pins system_management_wiz_0/s_axi_aresetn] \
	[get_bd_pins audio/axi_ctrl_nrst_i] \
	[get_bd_pins pl_user_sw/s_axi_aresetn] \
	[get_bd_pins pl_rgb0_led/s_axi_aresetn] \
	[get_bd_pins pl_rgb1_led/s_axi_aresetn] \
	[get_bd_pins pl_rgb2_led/s_axi_aresetn] \
	[get_bd_pins pl_rgb3_led/s_axi_aresetn] \
	[get_bd_pins pl_user_led/s_axi_aresetn] \
	[get_bd_pins SEL_JOYSTICK/s_axi_aresetn] \
	[get_bd_pins pl_user_pb/s_axi_aresetn]

    # Create address segments
    assign_bd_address -offset 0x80010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pl_rgb1_led/S_AXI/Reg] -force
    assign_bd_address -offset 0x80020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pl_rgb2_led/S_AXI/Reg] -force
    assign_bd_address -offset 0x80030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pl_rgb3_led/S_AXI/Reg] -force
    assign_bd_address -offset 0x80040000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pl_user_led/S_AXI/Reg] -force
    assign_bd_address -offset 0x80050000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs audio/i2s_receiver_0/s_axi_ctrl/Reg] -force    
    assign_bd_address -offset 0x80070000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs system_management_wiz_0/S_AXI_LITE/Reg] -force
    assign_bd_address -offset 0x80080000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs audio/i2s_transmitter_0/s_axi_ctrl/Reg] -force
    assign_bd_address -offset 0x80090000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs audio/axi_gpio_0/S_AXI/Reg] -force
    assign_bd_address -offset 0x800A0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs audio/axi_iic_aic/S_AXI/Reg] -force
    assign_bd_address -offset 0x800B0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs SEL_JOYSTICK/S_AXI/Reg] -force
    assign_bd_address -offset 0x800C0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pl_user_pb/S_AXI/Reg] -force
    assign_bd_address -offset 0x800D0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pl_user_sw/S_AXI/Reg] -force
    assign_bd_address -offset 0x800E0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pl_rgb0_led/S_AXI/Reg] -force
    assign_bd_address -offset 0x80140000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi/axi_iic_0/S_AXI/Reg] -force
    assign_bd_address -offset 0x80150000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi/axi_vdma/S_AXI_LITE/Reg] -force
    assign_bd_address -offset 0x80160000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi/mipi_csi2_rx_subsyst/csirxss_s_axi/Reg] -force    
    assign_bd_address -offset 0x80170000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs shutdown_HP0_FPD/S_AXI_CTRL/Reg] -force    
    assign_bd_address -offset 0xA0000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi/demosaic/s_axi_CTRL/Reg] -force
    assign_bd_address -offset 0xA0010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi/gamma_lut/s_axi_CTRL/Reg] -force
    assign_bd_address -offset 0xA0020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi/gpio_ip_reset/S_AXI/Reg] -force
    assign_bd_address -offset 0xA0030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi/pixel_pack/s_axi_control/Reg] -force
    assign_bd_address -offset 0xA0040000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi/v_proc_sys/s_axi_ctrl/Reg] -force
    assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi/axi_vdma/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] -force
    assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces mipi/axi_vdma/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] -force
    
    # Exclude Address Segments
    exclude_bd_addr_seg [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP6/LPD_LPS_OCM] -target_address_space [get_bd_addr_spaces address_remap_0/M_AXI_out]
    exclude_bd_addr_seg [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP6/LPD_DDR_HIGH] -target_address_space [get_bd_addr_spaces address_remap_0/M_AXI_out]

    source ./run_create_iop_subsystems_zu3.tcl
    
    # Add System Managment
    #create_bd_cell -type ip -vlnv xilinx.com:ip:system_management_wiz:1.3 system_management_wiz_1
    #apply_bd_automation -rule xilinx.com:bd_rule:sys_mgmt_wiz -config {USE_Vp_Vn "Vp_Vn" }  [get_bd_cells system_management_wiz_1]
    #apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Clk_slave {Auto} Clk_xbar {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Master {/zynq_ultra_ps_e_0/M_AXI_HPM0_LPD} Slave {/system_management_wiz_1/S_AXI_LITE} ddr_seg {Auto} intc_ip {/ps8_0_axi_periph} master_apm {0}}  [get_bd_intf_pins system_management_wiz_1/S_AXI_LITE]
    #apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Clk_slave {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Clk_xbar {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Master {/zynq_ultra_ps_e_0/M_AXI_HPM0_LPD} Slave {/shutdown_HP0_FPD/S_AXI_CTRL} ddr_seg {Auto} intc_ip {/ps8_0_axi_periph} master_apm {0}}  [get_bd_intf_pins shutdown_HP0_FPD/S_AXI_CTRL]
    
    
    # Restore current instance
    current_bd_instance $oldCurInst

    save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""

