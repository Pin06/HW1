# SoC HW1

## 功能
此專案實現了LED呼吸燈計數器，具體功能如下：
- 八個LED燈進行計數功能。
- LED隨時間利用PWM改變亮度，實現呼吸燈效果。

## Block Design

![image](https://github.com/user-attachments/assets/9cf6ff5d-9ea7-479d-a979-a0515e245516)


## 示範影片


https://github.com/user-attachments/assets/d4db3e2a-9b87-417f-a908-2edebbfdf181





## 運行原理
1. **LED 呼吸燈**：通過C程式(PS端)產生一個呼吸燈訊號源，並透過AXI將此訊號存進slv_reg0暫存器。
2. **AXI4_Lite**：包一個AXI4Lite規格的IP，存取slv_reg0上的LED訊號，並對其進行邏輯運算。
3. **計數器**：在IP中，寫一個0~31的計數器，並與LED訊號做AND運算後於開發板上的LED顯示輸出。

## 開發環境與工具
- **硬體平台**：FPGA (E-Elements EGO-XZ7) 
- **開發工具**：Vivado / SDK 
- **程式語言**：Verilog
