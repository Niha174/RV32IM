`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2024 07:53:37 PM
// Design Name: 
// Module Name: TOP_TB
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


module TOP_TB();
    reg clk;
    reg reset;
//    reg [31:0] Instruction;
    wire [31:0] op_WriteBack;
    //<-----------------DUT----------------------->
    Top_Module DUT(
    .clk(clk),               
    .reset(reset),             
//    .Instruction(Instruction),
    .op_WriteBack(op_WriteBack)
    );
    //<-------------Clock Generation---------------->
    always #5 clk=~clk;
    initial 
        begin
            clk=0;
            reset=1;
         #100
            reset=0;   
                                      
        #600 $finish();            
            
        end
endmodule

