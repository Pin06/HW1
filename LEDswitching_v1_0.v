
`timescale 1 ns / 1 ps

	module LEDswitching_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 4
	)
	(
		// Users to add ports here
        output wire [7:0] LED_out,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
	
	//User added start
    reg [7:0] count; 	      // 4位二進制計數器
    reg [31:0] divider;     // 分頻器寄存器
    reg slow_clk;           // 慢時鐘信號
	wire [31:0] slv_reg0_out;
	//User added end
	
// Instantiation of Axi Bus Interface S00_AXI
	LEDswitching_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) LEDswitching_v1_0_S00_AXI_inst (
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready),
		//User added start
		.slv_reg0_out(slv_reg0_out)
		//User added end
	);

	// Add user logic here
	
	// 分頻器：將時鐘信號分頻以產生慢時鐘信號
    always @(posedge s00_axi_aclk) begin
        if (s00_axi_aresetn == 0) begin
            divider <= 32'b0;
            slow_clk <= 1'b0;
        end 
        else begin
            if (divider == 32'd3_300_000) begin // 時鐘頻率為3.3MHz
                divider <= 32'b0;
                slow_clk <= ~slow_clk; // 3,300,000個時鐘週期翻轉一次慢時鐘信號
            end 
            else begin
                divider <= divider + 1;
            end
        end
    end
    
    // 計數器：使用慢時鐘信號進行計數
    always @(posedge slow_clk) begin
        if (s00_axi_aresetn == 0) begin
            count <= 8'b00000000; // 重置計數器
        end 
        else begin
            if (count == 8'b11111111) begin
                count <= 8'b00000000; // 當計數器達到9時重置為0
            end 
            else begin
                count <= count + 1; // 計數器加1
            end
        end
    end
    
    assign LED_out = slv_reg0_out[7:0] & count;
	// User logic ends

endmodule