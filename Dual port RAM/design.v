// DUAL PORT RAM - RTL
module dp_ram_rtl#(parameter int addr_width = 8,  // parameters
                   parameter int data_width = 32)
  (input clk_in,                     // clock
   input rst_n_in,							    // Active low reset 
   input [data_width-1:0] data_in,	// data to be written in dp_ram
   input [addr_width-1:0] rd_addr,	// read address location
   input [addr_width-1:0] wr_addr,	// write address location
   input rd_en,								      // read enable
   input wr_en,								      // write enable
   output reg [data_width-1:0] data_out);	// data read from dp_ram
  
  // declaration of memory
  reg [7:0]dp_ram[2**addr_width -1:0];
  int i;	// iteration variable
  
  always@(posedge clk_in or negedge rst_n_in)
    begin
      if(!rst_n_in)		// if reset is deasserted, whole data in dp_ram is cleared to '0'
        begin
          for(i=0; i<=2**addr_width-1;i++)
            dp_ram[i]<=0;
          data_out <= 'd0;
        end
      else
        begin
          if(rd_en)		// if read enable is asserted, data has to read into data_out from rd_addr location
            data_out <= dp_ram[rd_addr];
          else
            data_out <= data_out;
          
          if(wr_en)		// if write enable is asserted, data_in is written into wr_addr location
            dp_ram[wr_addr] <= data_in;
          else
            dp_ram[wr_addr] <= dp_ram[i];
        end
    end
endmodule
