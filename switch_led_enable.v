`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/29 20:03:39
// Design Name: 
// Module Name: switch_led_enable
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


module switch_led_enable(
    input  wire [7:0] i_sw,       // �}����J
    input  wire [7:0] i_led_in,   // �Ӧ� PS  �� LED ���
    output wire [7:0] o_led_out   //  LED��X
    );
    
    // Switch ���� LED ���
    // �C�� LED �̷ӹ����� switch ���A�M�w�O�_��� i_led_in
    //assign o_led_out = i_sw;
    assign o_led_out = i_led_in & i_sw;



endmodule
