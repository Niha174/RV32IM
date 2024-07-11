`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2024 05:14:47 PM
// Design Name: 
// Module Name: Pc_mux
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


module Pc_mux(
input [7:0]pc,
input [31:0]mux_out,
input br_en, 
output reg [7:0]pc_out
    );

always @ (*)begin 
    if(br_en)begin 
        pc_out <= mux_out; 
    end
    else begin 
        pc_out <= pc; 
    end
end    

    
endmodule
