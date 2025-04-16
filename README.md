# SoC HW1

## 功能
此專案實現了LED燈光控制系統，具體功能如下：
- 八個LED燈同時閃爍。
- 可以透過開關獨立控制每個LED的亮滅。
- 當按住按鈕時，LED的閃爍速度會加快。

## Block Design

![Block Design](https://github.com/user-attachments/assets/44c7e07f-257b-403f-9c85-7fe447064de8)

## 示範影片

[示範影片]

https://github.com/user-attachments/assets/05768bee-c7c6-49e9-bd99-047adc7e7943


## 系統結構
1. **LED 控制**：通過C程式(PS端)與Verilog(PL端)實現LED燈的開關控制。
2. **速度調節**：使用按鈕來調節LED燈的閃爍速度。
3. **開關致能**：RTL接收PS之LED訊號並讓switch控制是否輸出。

## 開發環境與工具
- **硬體平台**：FPGA (E-Elements EGO-XZ7) 
- **開發工具**：Vivado / SDK 
- **程式語言**：Verilog
