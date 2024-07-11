`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/11/2024 08:37:22 PM
// Design Name: 
// Module Name: Add_PC
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


module Add_PC(ip_clk,ip_rst,ip_add,op_add,pc_temp);
//<--------------PORT DECLARATION------------------------------->
    input [31:0] ip_add;  
    input ip_clk;                     // Output from PC 
    input ip_rst;                     // Output from PC 
//    input [3:0] ip_4bit;                      // 4-bit input of ADDER
    output reg [31:0] op_add;                // Output of ADDER
    output reg [31:0] pc_temp;                // point to current instruction
    //<-----------------------ADD----------------------------->
//    reg [7:0] pc_temp; //
    always @(posedge ip_clk) begin
    if (ip_rst)begin 
        op_add<= 'd0; 
    end
    else 
            op_add <= ip_add + 32'd4;
    end
    
    always @ (posedge ip_clk)begin 
        pc_temp <= op_add;
    end
    
//assign op_add = ip_rst ? 32'd0 : ip_add + 4'h4;
endmodule
