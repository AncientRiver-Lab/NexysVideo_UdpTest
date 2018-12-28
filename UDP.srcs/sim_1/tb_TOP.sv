`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2018 02:56:08 PM
// Design Name: 
// Module Name: tb_TOP
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
`timescale 1ns / 1ps

`include "user_defines.sv"

module tb_TOP();
   logic       SYSCLK;
   logic       CPU_RSTN;
   logic [7:0] SW;
   logic [3:0] ETH_RXD,    ETH_TXD;
   logic       ETH_RXCTL,  ETH_TXCTL;
   logic       ETH_RXCK,   ETH_TXCK;

   TOP top(
	   .ETH_RXCK(ETH_RXCK),
	   .ETH_RXCTL(ETH_RXCTL),
	   .ETH_RXD (ETH_RXD),

	   .ETH_TXCK(ETH_TXCK),
	   .ETH_TXCTL(ETH_TXCTL),
	   .ETH_TXD (ETH_TXD),

       .SW(SW),

	   .SYSCLK (SYSCLK),
	   .CPU_RSTN (CPU_RSTN)
	   );
   
   initial begin
      SW = 8'h00;
   
      ETH_RXCTL = `LO;
      ETH_RXD = {4{1'bx}};

      
      fork
	 forever begin       //-- Generate system clock.
	    #5 SYSCLK = `HI;
	    #5 SYSCLK = `LO;
	 end
	 forever begin       //-- Generate etherRx clock.
	    #4 ETH_RXCK = `HI;
	    #4 ETH_RXCK = `LO;
	 end
	 begin               //-- Generate reset.
	    CPU_RSTN = `HI;
	    #29 CPU_RSTN = `LO;
	    #23 CPU_RSTN = `HI;
            #100;
	    @(posedge top.eth_clkgen_locked);
	    #100;
	    recvByte(8'h12);
	    recvByte(8'h34);
	    recvByte(8'h56);
	    recvByte(8'h78);
	    recvByte(8'h9A);
	    recvEnd();
	    #100;
	    repeat(100) @(posedge ETH_RXCK);
	    repeat(2) begin
	          recvARP();
	          repeat(100) @(posedge ETH_RXCK);
	    end
	    repeat(2) begin
              recvPING();
              repeat(300) @(posedge ETH_RXCK);
        end
	 end
      join
   end
	    
   //**
   //** receive 1 Byte via RGMII.
   //**
   task recvEnd();
      begin
         @(posedge ETH_RXCK) #0.5;
         ETH_RXD = {4{1'bx}};
         ETH_RXCTL = 1'b0;
      end
   endtask 
   task recvByte(input [7:0] c);
      begin
	 @(posedge ETH_RXCK) #0.5;
	 ETH_RXD = c[3:0];
	 ETH_RXCTL = 1'b1;
	 @(negedge ETH_RXCK) #0.5;
	 ETH_RXD = c[7:4];
      end
   endtask //
   
   task recvWord(input [15:0] w);
   begin
      recvByte(w[15:8]);  //-- MSB first
      recvByte(w[7:0]);
   end
   endtask
   
   task recvPreamble();
   integer i;
   begin
      for (i=0;i<7;i=i+1) begin
         recvByte(8'h55);
      end
      recvByte(8'hd5);
   end
   endtask
   
   task recvMac(input [47:0] addr);
      begin
	 recvByte(addr[47:40]);
	 recvByte(addr[39:32]);
	 recvByte(addr[31:24]);
	 recvByte(addr[23:16]);
	 recvByte(addr[15:8]);
	 recvByte(addr[7:0]);
      end
   endtask // recvMac
   task recvIp(input [31:0] addr);
      begin
	 recvByte(addr[31:24]);
	 recvByte(addr[23:16]);
	 recvByte(addr[15:8]);
	 recvByte(addr[7:0]);
      end
   endtask // recvIp
   
   task recvARP();
   begin
     recvPreamble();
     recvMac(`bcast_MAC);
     recvMac(48'hCB_A9_87_65_43_21);
     //recvByte(8'h08);
     //recvByte(8'h06);
     recvWord(16'h0806);
     recvByte(8'h00);
     recvByte(8'h01);
     recvByte(8'h08);
     recvByte(8'h00);
     recvByte(8'h06);
     recvByte(8'h04);
     recvByte(8'h00);
     recvByte(8'h01);
     recvMac(48'hCB_A9_87_65_43_21);
     recvIp({8'd172, 8'd31, 8'd210, 8'd16});
     recvMac(48'h00_00_00_00_00_00);
     recvIp({8'd172, 8'd31, 8'd210, 8'd160});  
     //CRC
     recvByte(8'hcb);
     recvByte(8'hcd);
     recvByte(8'h39);
     recvByte(8'h06);
     recvEnd();
   end
   endtask
   
   task recvPING();
   reg [15:0] chksum;
   begin
     recvPreamble();
     recvMac(48'h00_0A_35_02_0F_B0);
     recvMac(48'hCB_A9_87_65_43_21);
     recvWord(16'h0800);  
     
     calcIPCHKSUM( { 16'h4500, 
                     16'd64,
                     16'h0001,
                     16'h0000,
                     16'hFF01,
                     16'h0000,
                     {8'd172, 8'd31, 8'd210, 8'd16},
                     {8'd172, 8'd31, 8'd210, 8'd160}},
                     chksum);
     
     recvWord(16'h4500); //-- IP header section
     recvWord(16'd64);
     recvWord(16'h0001);
     recvWord(16'h0000);
     recvWord(16'hFF01);
     recvWord(chksum); //-- checksum
     recvIp({8'd172, 8'd31, 8'd210, 8'd16}); //--src
     recvIp({8'd172, 8'd31, 8'd210, 8'd160}); //--dest
     
     
     
     recvWord(16'h0800);
     recvWord(16'h672b); //-- chksum
     recvWord(16'h1234);
     recvWord(16'habcd);
     
     repeat(16) recvByte(8'h5a);
     
     //CRC
     recvByte(8'ha7);
     recvByte(8'hae);
     recvByte(8'h18);
     recvByte(8'h4e);
     recvEnd();
   end
   endtask
   
   task calcIPCHKSUM(input [159:0] header, output [15:0] chksum);
   integer i;
   reg [159:0] tmp;
   integer sum;
   begin
      tmp = header;
      sum = 0;
      for (i=0; i<10; i=i+1) begin
         sum = sum + tmp[15:0];
         tmp = (tmp >> 16);
      end
      while (sum > 32'h0000FFFF) begin
         sum = (sum & 32'h0000FFFF) + {16'h0000, sum[31:16]};
      end
      chksum = ~sum;
   end
   endtask 
   
   task rstCPU();
      begin
	 CPU_RSTN = 0;
	 #1000;
	 CPU_RSTN = 1;
      end
   endtask
endmodule // tb_TOP

