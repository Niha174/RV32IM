`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2024 03:54:22 PM
// Design Name: 
// Module Name: Reg_Mux_ALU
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


module Reg_Mux_ALU(ip_Data_out2,ip_Imm_Gen,Data_out,sel_ALUSrc,op_PC);
    //<--------------------PORT DECLARAION------------->
    input [31:0] ip_Data_out2;       // Second output port of Register file.
    input [31:0] ip_Imm_Gen;         // Output of immediate generator
    input [1:0] sel_ALUSrc;               // Select input of Mux
    input [31:0] op_PC;
    output reg [31:0] Data_out;     // Output of MUX
    //<------------------------------------------------->
    always @ (*)
        begin
            case(sel_ALUSrc)
                2'b00 : begin
                     Data_out <= ip_Data_out2;
                end     
                2'b01 : begin
                    Data_out <= ip_Imm_Gen;
                end
                2'b10 : begin
                    Data_out <= op_PC;
                end 
                default :
                    Data_out <= 32'b0;  
            endcase   
        end
     
endmodule
