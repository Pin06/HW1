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
    input  wire [7:0] i_sw,       // 開關輸入
    input  wire [7:0] i_led_in,   // 來自 PS  的 LED 資料
    output wire [7:0] o_led_out   //  LED輸出
    );
    
    // Switch 控制 LED 顯示
    // 每顆 LED 依照對應的 switch 狀態決定是否顯示 i_led_in
    //assign o_led_out = i_sw;
    assign o_led_out = i_led_in & i_sw;



endmodule
