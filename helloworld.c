/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <unistd.h>  // for usleep()

#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xparameters.h"

#define LEDswitching_BASEADDR XPAR_LEDSWITCHING_0_S00_AXI_BASEADDR
#define MAX_DUTY 100
#define MIN_DUTY 1
#define STEP     1       // 調整步進大小
#define BREATH_DELAY 5000
#define DELAY    100    // 延遲(us)
#define PWM_PERIOD_us 1000  // PWM週期(us)


int main()
{
	u32 led_on = 0xFF;
	u32 led_off = 0x00;
	int duty = 1;
	int direction = 1;

	while(1)
	{
		for(int t=0;t<=MAX_DUTY;t++){
			if(t<duty){
				Xil_Out32(LEDswitching_BASEADDR, led_on); // 0xFF寫資料到slv_reg0
			}else{
				Xil_Out32(LEDswitching_BASEADDR, led_off); // 0x00寫資料到slv_reg0
			}
			usleep(DELAY);
		}

		duty += direction;
		if(duty >= MAX_DUTY){
			duty = MAX_DUTY;
			direction = -STEP;
		}else if(duty <= MIN_DUTY){
			duty = MIN_DUTY;
			direction = STEP;
		}
		usleep(BREATH_DELAY);
	}
	return 0;
}
