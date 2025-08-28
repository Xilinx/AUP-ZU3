# Copyright (C) 2025 Advanced Micro Devices, Inc.
# SPDX-License-Identifier: BSD-3-Clause

source ./iop_scripts/create_grove_iop.tcl
source ./iop_scripts/create_pmod_iop.tcl
source ./iop_scripts/create_rpi_iop.tcl

# Create instance: iop_grove0
create_hier_cell_iop_grove [current_bd_instance .] iop_grove0

# Create instance: iop_rpi0
create_hier_cell_iop_rpi [current_bd_instance .] iop_rpi0

# Create instances: iop_pmod0, iop_pmod1
create_hier_cell_iop_pmod [current_bd_instance .] iop_pmod0
create_hier_cell_iop_pmod [current_bd_instance .] iop_pmod1

set CONTROL_SIGNAL_WIDTH 10
set INSTANCE 0
set name_list {iop_pmod0 iop_pmod1 iop_rpi0 iop_grove0}
set iop_width_list {8 8 28 4}
set NumberOfIOPs [llength $name_list]

create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_0
set_property CONFIG.C_MB_DBG_PORTS $NumberOfIOPs [get_bd_cells mdm_0]

foreach name $name_list iop_width $iop_width_list {
    #puts "$name $iop_width"
    set cell_name "mb_${name}_reset"
    set GPIO $INSTANCE
    # Create EMIO slice for reset
    create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilslice:1.0 $cell_name
    set_property -dict [list \
      CONFIG.DIN_FROM $GPIO \
      CONFIG.DIN_TO $GPIO \
      CONFIG.DIN_WIDTH $CONTROL_SIGNAL_WIDTH \
    ] [get_bd_cells $cell_name]
    
    # Connect EMIO aux reset
    connect_bd_net [get_bd_pins ${cell_name}/Din] [get_bd_pins zynq_ultra_ps_e_0/emio_gpio_o]
    connect_bd_net [get_bd_pins ${cell_name}/Dout] [get_bd_pins ${name}/aux_reset_in]
    
    # Create EMIO slice for INTR ACK	
    set GPIO [expr {$INSTANCE + 1}]
    set intr_ack_cell "mb_${name}_intr_ack"
    create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilslice:1.0 $intr_ack_cell
    set_property -dict [list \
      CONFIG.DIN_FROM $GPIO \
      CONFIG.DIN_TO $GPIO \
      CONFIG.DIN_WIDTH $CONTROL_SIGNAL_WIDTH \
    ] [get_bd_cells $intr_ack_cell]
    
	# Connect EMIO INTR ACK
    connect_bd_net [get_bd_pins ${intr_ack_cell}/Dout] [get_bd_pins ${name}/intr_ack]
	connect_bd_net [get_bd_pins ${intr_ack_cell}/Din] [get_bd_pins zynq_ultra_ps_e_0/emio_gpio_o]    
	
    # Connect MDM debug reset
	#echo "Connect MDM debug reset $GPIO"
	connect_bd_net [get_bd_pins ${name}/mb_debug_sys_rst] [get_bd_pins mdm_0/Debug_SYS_Rst]
	
	#echo "Connect MDM debug $GPIO"
	# Connect MDM debug
	connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ${name}/DEBUG] [get_bd_intf_pins mdm_0/MBDEBUG_${INSTANCE}]
	
	create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 ${name}_buf
	set_property CONFIG.C_SIZE $iop_width [get_bd_cells ${name}_buf]
	set_property CONFIG.C_BUF_TYPE {IOBUF} [get_bd_cells ${name}_buf]
	connect_bd_net [get_bd_pins ${name}/data_i] [get_bd_pins ${name}_buf/IOBUF_IO_O]
	connect_bd_net [get_bd_pins ${name}/data_o] [get_bd_pins ${name}_buf/IOBUF_IO_I]
	connect_bd_net [get_bd_pins ${name}/tri_o] [get_bd_pins ${name}_buf/IOBUF_IO_T]
	create_bd_port -dir IO ${name} -from [expr {$iop_width - 1}] -to 0 
	connect_bd_net [get_bd_ports ${name}] [get_bd_pins ${name}_buf/IOBUF_IO_IO]
	
	# Connect clocks and resets
	connect_bd_net [get_bd_pins ${name}/clk_100M] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
	connect_bd_net [get_bd_pins rst_ps8_0_99M/peripheral_aresetn] [get_bd_pins ${name}/s_axi_aresetn]
	
	incr INSTANCE		

}

# Modifying the concat block created in the base.tcl based on Number of IOPs
set xlconcat_ports [get_property CONFIG.NUM_PORTS [get_bd_cells xlconcat_0]]
set new_xlconcat_ports [expr {$xlconcat_ports + $NumberOfIOPs}]
set_property CONFIG.NUM_PORTS $new_xlconcat_ports [get_bd_cells xlconcat_0]
#set_property CONFIG.NUM_PORTS {12} [get_bd_cells xlconcat_0]
delete_bd_objs [get_bd_nets xlconcat_0_dout]

connect_bd_net [get_bd_pins iop_pmod0/intr_req] [get_bd_pins xlconcat_0/In8] 
connect_bd_net [get_bd_pins iop_pmod1/intr_req] [get_bd_pins xlconcat_0/In9]
connect_bd_net [get_bd_pins iop_rpi0/intr_req] [get_bd_pins xlconcat_0/In10]
connect_bd_net [get_bd_pins iop_grove0/intr_req] [get_bd_pins xlconcat_0/In11]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 axi_intc_0
connect_bd_net [get_bd_pins xlconcat_0/dout] [get_bd_pins axi_intc_0/intr]
set_property CONFIG.C_IRQ_CONNECTION {1} [get_bd_cells axi_intc_0]
connect_bd_net [get_bd_pins axi_intc_0/irq] [get_bd_pins zynq_ultra_ps_e_0/pl_ps_irq0]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Clk_slave {Auto} Clk_xbar {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Master {/zynq_ultra_ps_e_0/M_AXI_HPM0_LPD} Slave {/axi_intc_0/s_axi} ddr_seg {Auto} intc_ip {/ps8_0_axi_periph} master_apm {0}}  [get_bd_intf_pins axi_intc_0/s_axi]

# Create AXI connections

# Enable LPD on PSU__USE__S_AXI_GP6
set_property CONFIG.PSU__USE__S_AXI_GP6 {1} [get_bd_cells zynq_ultra_ps_e_0]

# Add AXI interconnect
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 iop_axi_interconnect_lpd
set_property -dict [list \
  CONFIG.NUM_MI {1} \
  CONFIG.NUM_SI $NumberOfIOPs \
] [get_bd_cells iop_axi_interconnect_lpd]

connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/saxi_lpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins iop_axi_interconnect_lpd/M00_ACLK]
connect_bd_net [get_bd_pins rst_ps8_0_99M/interconnect_aresetn] [get_bd_pins iop_axi_interconnect_lpd/M00_ARESETN]

# Add address remap
create_bd_cell -type ip -vlnv user.org:user:address_remap:1.0 address_remap_0
set_property -dict [list \
  CONFIG.C_M_AXI_out_ADDR_WIDTH {31} \
  CONFIG.C_S_AXI_in_ADDR_WIDTH {31} \
  CONFIG.C_M_AXI_out_DATA_WIDTH {128} \
  CONFIG.C_S_AXI_in_DATA_WIDTH {128} \
] [get_bd_cells address_remap_0]

connect_bd_intf_net -boundary_type upper [get_bd_intf_pins iop_axi_interconnect_lpd/M00_AXI] [get_bd_intf_pins address_remap_0/S_AXI_in]

connect_bd_net [get_bd_pins address_remap_0/s_axi_in_aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
connect_bd_net [get_bd_pins address_remap_0/m_axi_out_aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
connect_bd_net [get_bd_pins address_remap_0/s_axi_in_aresetn] [get_bd_pins iop_pmod1/peripheral_aresetn]
connect_bd_net [get_bd_pins address_remap_0/m_axi_out_aresetn] [get_bd_pins iop_pmod1/peripheral_aresetn]

# Add AXI slice
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_0
connect_bd_net [get_bd_pins axi_register_slice_0/aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
connect_bd_net [get_bd_pins axi_register_slice_0/aresetn] [get_bd_pins rst_ps8_0_99M/interconnect_aresetn]
connect_bd_intf_net [get_bd_intf_pins address_remap_0/M_AXI_out] [get_bd_intf_pins axi_register_slice_0/S_AXI]

# Add DFX shutdown manager
create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_axi_shutdown_manager:1.0 shutdown_LPD
set_property CONFIG.DP_AXI_DATA_WIDTH {128} [get_bd_cells shutdown_LPD]
set_property CONFIG.CTRL_INTERFACE_TYPE {1} [get_bd_cells shutdown_LPD]
connect_bd_intf_net [get_bd_intf_pins axi_register_slice_0/M_AXI] [get_bd_intf_pins shutdown_LPD/S_AXI]	
connect_bd_intf_net [get_bd_intf_pins shutdown_LPD/M_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_LPD]
connect_bd_net [get_bd_pins shutdown_LPD/clk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
connect_bd_net [get_bd_pins shutdown_LPD/resetn] [get_bd_pins rst_ps8_0_99M/interconnect_aresetn]
## AGS: No longer present
#set_property offset 0x80140000 [get_bd_addr_segs {zynq_ultra_ps_e_0/Data/SEG_shutdown_HP0_FPD_Reg}]

# Connect master clock to AXI interconnect and reset
connect_bd_net [get_bd_pins iop_axi_interconnect_lpd/ACLK] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
connect_bd_net [get_bd_pins rst_ps8_0_99M/interconnect_aresetn] [get_bd_pins iop_axi_interconnect_lpd/ARESETN]

set INSTANCE 0
foreach name $name_list {
    set SLAVE "S0${INSTANCE}_AXI" 
	set SLAVE_RESET "S0${INSTANCE}_ARESETN"
	set SLAVE_CLK "S0${INSTANCE}_ACLK"
	connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ${name}/M_AXI] [get_bd_intf_pins iop_axi_interconnect_lpd/$SLAVE]
	connect_bd_net [get_bd_pins ${name}/peripheral_aresetn] [get_bd_pins iop_axi_interconnect_lpd/$SLAVE_RESET] -boundary_type upper
	connect_bd_net [get_bd_pins iop_axi_interconnect_lpd/$SLAVE_CLK] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
	incr INSTANCE
}

# Increase Interconnect by 4 Master ports for the iops
set ports [get_property CONFIG.NUM_MI [get_bd_cells ps8_0_axi_periph]]
set INSTANCE $ports 
set new_ports [expr {$ports + $NumberOfIOPs}]
set_property CONFIG.NUM_MI $new_ports [get_bd_cells ps8_0_axi_periph]


foreach name $name_list {
    set MASTER_AXI "M${INSTANCE}_AXI"
	set MASTER_CLK "M${INSTANCE}_ACLK"
	set MASTER_RESET "M${INSTANCE}_ARESETN"
	connect_bd_intf_net -boundary_type upper [get_bd_intf_pins ${name}/S_AXI] [get_bd_intf_pins ps8_0_axi_periph/$MASTER_AXI]
	connect_bd_net [get_bd_pins ps8_0_axi_periph/$MASTER_CLK] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
	connect_bd_net [get_bd_pins ps8_0_axi_periph/$MASTER_RESET] [get_bd_pins rst_ps8_0_99M/peripheral_aresetn]
	incr INSTANCE
}

apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Clk_slave {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Clk_xbar {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Master {/zynq_ultra_ps_e_0/M_AXI_HPM0_LPD} Slave {/shutdown_LPD/S_AXI_CTRL} ddr_seg {Auto} intc_ip {/ps8_0_axi_periph} master_apm {0}}  [get_bd_intf_pins shutdown_LPD/S_AXI_CTRL]


assign_bd_address -target_address_space /address_remap_0/M_AXI_out [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP6/LPD_DDR_LOW] -force
assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces address_remap_0/M_AXI_out] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP6/LPD_DDR_LOW] -force

assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space /iop_grove0/mb/Data [get_bd_addr_segs address_remap_0/S_AXI_in/memory] -force
assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space /iop_pmod0/mb/Data [get_bd_addr_segs address_remap_0/S_AXI_in/memory] -force
assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space /iop_pmod1/mb/Data [get_bd_addr_segs address_remap_0/S_AXI_in/memory] -force
assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space /iop_rpi0/mb/Data [get_bd_addr_segs address_remap_0/S_AXI_in/memory] -force

assign_bd_address -offset 0x80100000 -range 0x00010000 -target_address_space /zynq_ultra_ps_e_0/Data [get_bd_addr_segs iop_grove0/mb_bram_ctrl/S_AXI/Mem0] -force
assign_bd_address -offset 0x80110000 -range 0x00010000 -target_address_space /zynq_ultra_ps_e_0/Data [get_bd_addr_segs iop_pmod0/mb_bram_ctrl/S_AXI/Mem0] -force
assign_bd_address -offset 0x80120000 -range 0x00010000 -target_address_space /zynq_ultra_ps_e_0/Data [get_bd_addr_segs iop_pmod1/mb_bram_ctrl/S_AXI/Mem0] -force
assign_bd_address -offset 0x80130000 -range 0x00010000 -target_address_space /zynq_ultra_ps_e_0/Data [get_bd_addr_segs iop_rpi0/mb_bram_ctrl/S_AXI/Mem0] -force


save_bd_design
