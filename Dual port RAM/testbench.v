// DUAL PORT RAM - DIRECT TEST BENCH
module dp_ram_tb;
  
  //Parameters
  parameter addr_width = 8;
  parameter data_width = 32;
  
  // Declaring RTL's input ports as "reg" and RTL's output ports as "wire"
  reg clk_in_tb;
  reg rst_n_in_tb;
  reg [data_width-1:0] data_in_tb;
  reg [addr_width-1:0] rd_addr_tb;
  reg [addr_width-1:0] wr_addr_tb;
  reg rd_en_tb;
  reg wr_en_tb;
  wire [data_width-1:0] data_out_tb;
  
  // Instantiate RTL in test bench
  dp_ram_rtl DUT(.clk_in(clk_in_tb),
             .rst_n_in(rst_n_in_tb),
             .data_in(data_in_tb),
             .wr_addr(wr_addr_tb),
             .rd_addr(rd_addr_tb),
             .rd_en(rd_en_tb),
             .wr_en(wr_en_tb),
             .data_out(data_out_tb));
  
  // clock generation
  always #5 clk_in_tb = ~clk_in_tb;
  
  // Test cases
  initial
    begin
      // Initialising input ports of DUT
      clk_in_tb 	= 'b0;
      rst_n_in_tb 	= 'b1;
      data_in_tb	= 'd0;
      rd_addr_tb	= 'd0;
      wr_addr_tb	= 'd0;
      rd_en_tb		= 'b0;
      wr_en_tb		= 'b0;
      #2;
      rst_n_in_tb	= 'b0;
      #2;
      rst_n_in_tb	= 'b1;
      // Write operation
      #10;
      wr_addr_tb	= 'd47;
      wr_en_tb		= 'b1;
      data_in_tb	= 'd225;
      // Read operation
      #10;
      wr_en_tb		= 'b0;
      rd_en_tb		= 'b1;
      rd_addr_tb	= 'd47;
      wr_addr_tb	= 'd0;
    end
  
  initial
    begin
      $monitor($time," clk = %b, rst = %b, data_in = %0d, rd_addr = %0d, wr_addr = %0d, rd_en = %b, wr_en = %b, data_out = %0d", clk_in_tb, rst_n_in_tb, data_in_tb, rd_addr_tb, wr_addr_tb, rd_en_tb, wr_en_tb, data_out_tb);
      #50 $finish;
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule
