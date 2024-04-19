`timescale 1ns / 1ps
 
///////////fields of IR
`define oper_type IR[31:27]
`define rdst      IR[26:22]
`define rsrc1     IR[21:17]
`define imm_mode  IR[16]
`define rsrc2     IR[15:11]
`define isrc      IR[15:0]
 
 
////////////////arithmetic operation
`define movsgpr        5'b00000
`define mov            5'b00001
`define add            5'b00010
`define sub            5'b00011
`define mul            5'b00100



module tb;
 
 
integer i = 0;

top dut(clk, sys_rst, din, dout);
 
///////////////updating value of all GPR to 2
initial begin
for( i = 0; i < 32; i = i + 1)
begin
dut.GPR[i] = 2;
end
end
 
 
 
initial begin
//////// immediate add op
$display("-----------------------------------------------------------------");
dut.IR = 0;
dut.`imm_mode = 1;
dut.`oper_type = 2;
dut.`rsrc1 = 2;///gpr[2] = 2
dut.`rdst  = 0;///gpr[0]
dut.`isrc = 4;
#10;
$display("OP:ADI Rsrc1:%0d  Rsrc2:%0d Rdst:%0d",dut.GPR[2], dut.`isrc, dut.GPR[0]);
$display("-----------------------------------------------------------------");
////////////register add op
dut.IR = 0;
dut.`imm_mode = 0;
dut.`oper_type = 2;
dut.`rsrc1 = 4;
dut.`rsrc2 = 5;
dut.`rdst  = 0;
#10;
$display("OP:ADD Rsrc1:%0d  Rsrc2:%0d Rdst:%0d",dut.GPR[4], dut.GPR[5], dut.GPR[0] );
$display("-----------------------------------------------------------------");
 
//////////////////////immediate mov op
dut.IR = 0;
dut.`imm_mode = 1;
dut.`oper_type = 1;
dut.`rdst = 4;///gpr[4]
dut.`isrc = 55;
#10;
$display("OP:MOVI Rdst:%0d  imm_data:%0d",dut.GPR[4],dut.`isrc  );
$display("-----------------------------------------------------------------");
 
//////////////////register mov
dut.IR = 0;
dut.`imm_mode = 0;
dut.`oper_type = 1;
dut.`rdst = 4;
dut.`rsrc1 = 7;//gpr[7]
#10;
$display("OP:MOV Rdst:%0d  Rsrc1:%0d",dut.GPR[4],dut.GPR[7] );
$display("-----------------------------------------------------------------");

//////// immediate mul op
$display("-----------------------------------------------------------------");
dut.IR = 0;
dut.`imm_mode = 1;
dut.`oper_type = 4;
dut.`rsrc1 = 2;///gpr[2] = 2
dut.`rdst  = 0;///gpr[0]
dut.`isrc = 4;
#10;
$display("OP:MUI Rsrc1:%0d  Rsrc2:%0d RdstLSB:%0d RdstMSB:%0d",dut.GPR[2], dut.`isrc, dut.GPR[0],dut.SGPR);
$display("-----------------------------------------------------------------");
////////////register mul op
dut.IR = 0;
dut.`imm_mode = 0;
dut.`oper_type = 4;
dut.`rsrc1 = 0;///gpr[0] = 8
dut.`rsrc2 = 1;///gpr[1] = 2
dut.`rdst  = 2;///gpr[2]
#10;
//////////////////mov sgpr
dut.IR = 0;
dut.`imm_mode = 0;
dut.`oper_type = 0;
dut.`rdst = 3;///gpr[3]
#10;

$display("OP:MUL Rsrc1:%0d  Rsrc2:%0d RdstLSB:%0d RdstMSB:%0d",dut.GPR[0], dut.GPR[1], dut.GPR[2], dut.GPR[3] );
$display("-----------------------------------------------------------------");
 
 
end
 
endmodule