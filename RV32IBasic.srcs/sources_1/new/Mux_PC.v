`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/11/2024 08:55:09 PM
// Design Name: 
// Module Name: Mux_PC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux_PC(ip_Add_PC,ip_Add_J,sel_PCSrc,op_Mux_pc);
    //<-----------------------PORT DECLARATION--------------------------->
    input [31:0] ip_Add_PC;
    input [31:0] ip_Add_J;
    input sel_PCSrc;
    output reg [31:0] op_Mux_pc;
    //<----------------------------------------------------------------->
    always @ (*)
    begin
        case(sel_PCSrc)
            1'b0 : begin
                op_Mux_pc <= ip_Add_PC;
            end
            1'b1 : begin
                op_Mux_pc <= ip_Add_J;
            end
            default : op_Mux_pc <= 32'b0;
        endcase
    end
endmodule
