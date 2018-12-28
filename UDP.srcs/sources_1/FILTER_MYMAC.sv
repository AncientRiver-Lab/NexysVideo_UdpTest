
`define DELAY_DEPTH

module FILTER_MYMAC 
  (
   input 	clk,
   input 	rst,
   input [7:0] 	eth_rxd_i,
   input 	eth_ctl_i,
   output [7:0] eth_rxd_o,
   output 	eth_ctl_o
 );

   genvar g;
   reg [8:0] delay_stream [`DELAY_DEPTH-1:0];

   always @(posedge clk) begin
      if(rst) delay_stream[0] <= 9'b0;
      else    delay_stream[0] <= {eth_ctl_i, eth_rxd_i};
   end
   
   generate for(g=1; g<`DELAY_DEPTH; g=g+1) begin
   always @(posedge clk) begin
      delay_stream[g] <= delay_stream[g-1];
   end
   end endgenerate
   
   
endmodule // FILTER_MYMAC

   
