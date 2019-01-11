`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/31 19:16:30
// Design Name: 
// Module Name: ARP_reply
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

module TOP(
    input [3:0]  ETH_RXD, // 受信フレームデータ
    input 	     ETH_RXCK, // 受信クロック
    input 	     ETH_RXCTL, // 受信フレーム検知で'1'
    
    input 	     BTN_C, // 任意のタイミングでのリセット   
            
    output [3:0] ETH_TXD, //-- Ether RGMII Tx data.
    output       ETH_TXCK,
    output   	 ETH_TXCTL,
    inout        ETH_RST_B, //-- Ether PHY reset(active low)
    input 	     eth_int_b,
    input 	     eth_pme_b,
    output           eth_mdc,
    inout 	     eth_mdio,

    input 	     SYSCLK, // その他用クロック
    input 	     CPU_RSTN, //
    input 	     reset_i,
    
    input [7:0]  SW,
    output [7:0] LED,
    output [7:0] PMOD_A,
    output [7:0] PMOD_B,
    output [7:0] PMOD_C,

    output [1:0] SET_VADJ,
    output       VADJ_EN
    );
    
    wire [7:0]       gmii_txd;
    wire             gmii_txctl;
     
    (*dont_touch="true"*) wire [7:0] gmii_rxd;
    (*dont_touch="true"*) wire  gmii_rxctl;
    
    wire eth_rxck;
    wire eth_clkgen_locked;
    wire rst_rx;
    ETH_CLKGEN eth_clkgen (
          .eth_rxck     (ETH_RXCK),
          .rxck_90deg   (eth_rxck),
          .rxck_180deg  (eth_rxck_90),
          .locked       (eth_clkgen_locked),
          .resetn       (CPU_RSTN)
    );
    //**------------------------------------------------------------
    //** RGMII to GMII translator. (add by moikawa)
    //**
   wire  gmii_rxctl_hi, gmii_rxctl_lo;
   
    RGMII2GMII rgmii2gmii (
          .rxd_i      ( ETH_RXD       ), //<-- INPUT[3:0]
          .rxck_i     ( eth_rxck      ), //<-- INPUT, Rx clock 125 MHz.
          .rxctl_i    ( ETH_RXCTL     ), //--
          .rxd_o      ( gmii_rxd      ), //--[7:0]
          .rxctl_hi_o ( gmii_rxctl_hi ),
          .rxctl_lo_o ( gmii_rxctl_lo ),
          .rxctl_o    ( gmii_rxctl    )
    ) ;
    //**------------------------------------------------------------
    //** GMII to RGMII translator. (add by moikawa)
    //**
    wire rst125;
    wire sys_clkgen_locked;
    GMII2RGMII gmii2rgmii (
          .txck_o   ( ETH_TXCK   ),
          .txd_o    ( ETH_TXD    ), //--> OUTPUT
          .txctl_o  ( ETH_TXCTL  ), //--> OUTPUT
          .txck_i   ( eth_rxck   ), //- Tx clock 125MHz.
          .txck_90_i( eth_rxck_90),
          .txd_i    ( gmii_txd   ), //-- [7:0]
          .txctl_i  ( gmii_txctl )  //--
    );
    //**------------------------------------------------------------
    //** Reset generator. (add by moikawa)
    //**
    RSTGEN rstgen125 (
         .reset_o  ( rst_rx ),
         .reset_i  ( 1'b0   ),
         .locked_i ( eth_clkgen_locked ),
         .clk      ( eth_rxck )
    );
    RSTGEN rstgen_rx (
         .reset_o  ( rst_sys ),
         .reset_i  ( 1'b0   ),
         .locked_i ( sys_clkgen_locked ),
         .clk      ( eth_rxck )
    );
    
    wire rst_btn = BTN_C;
    //wire arp_tx_en;
    //wire ping_tx_en;
    //wire UDP_tx_en;
    //wire arp_tx;
    //wire ping_tx;
    wire UDP_btn_tx;        // ボタン入力によるUDP送信
    //wire UDP_tx;            // UDPの送受信
    wire [8:0] rarp_o;   
    wire [8:0] ping_o;  
    wire [8:0] UDP_btn_d;   // ボタン入力によるUDP送信
    wire [8:0] UDP_o;       // UDPの送受信
    
    Arbiter R_Arbiter (
        /*---INPUT---*/
        .gmii_rxd     (gmii_rxd),   //<-- "rgmii2gmii"
        .gmii_rxctl   (gmii_rxctl), //<-- "rgmii2gmii"
        .eth_rxck     (eth_rxck),   //<-- "eth_clkgen"
        .rst_rx       (rst_rx),
        .rst125       (rst125),
        //.clk125       (clk125),
        .rst_btn      (rst_btn),
        .SW(SW),
        /*---OUTPUT---*/
        .rarp_o       (rarp_o),
        .ping_o       (ping_o),
        .UDP_o        (UDP_o)
    );
    wire [7:0] tx_led;
    T_Arbiter T_Arbiter(
        .rarp_i       (rarp_o),
        .ping_i       (ping_o),
        .UDP_btn_d(UDP_btn_d),
        .UDP_i        (UDP_o),
        .UDP_btn_tx(UDP_btn_tx),
        .eth_rxck(eth_rxck),
        //.clk125(clk125),
        //.clk125_90(clk125_90),
        .rst       (rst_rx),
        .txd_o        (gmii_txd),
        .gmii_txctl_o (gmii_txctl),
        //.LED(LED)
        .LED          (tx_led)
    );
    
//    always_comb begin
//        if(SW[0]) LED = LED_rx;
//        else if(SW[1]) LED = LED_tx;
//    end
    
    
//    reg [17:0]  clk125_cnt;
//    reg         BTN;
    /*
    always_ff @(posedge clk125)begin
        if(BTN_C)begin
            clk125_cnt <= clk125_cnt + 1;
            if(clk125_cnt==18'd262143)begin
                BTN <= 1;
            end
            else BTN <= 0;
        end
        else BTN <= 0;
    end
    */
//    always_comb begin
//        BTN = BTN_C;
//    end
    
//    UDP UDP(
//        .clk125(clk125),
//        .rst_rx(rst125),
//        .BTN_C(BTN),
//        .UDP_d(UDP_btn_d),
//        .UDP_tx(UDP_btn_tx)
//    );
/*    
   wire        eth_mdio_oe; //-- output enable.
   wire        eth_mdio_o;  //-- output serial data.
   
   ETH_PHY_CTRL (
      .SYSCLK_i   (SYSCLK),
      .rstn_req_i (1'b1),
      .eth_int_b  (eth_int_b),		 
      .eth_pme_b  (eth_pme_b),		 
      .eth_rst_b  (eth_rst_b),           //-- EtherPHY resetn output at least 10ms.
      .eth_mdc    (eth_mdc),		 
      .eth_mdio_i (eth_mdio),		 
      .eth_mdio_oe(eth_mdio_oe),		 
      .eth_mdio_o (eth_mdio_o)
   );
   assign eth_mdio = (eth_mdio_oe)? eth_mdio_o : 1'bz;
*/
   assign ETH_RST_B = 1'bz;
   assign eth_mdio  = 1'bz;
   assign eth_mdc   = 1'b1;
   
   assign LED[3:0] = tx_led[3:0];
   assign LED[8] = sys_clkgen_locked;
   assign LED[7] = eth_clkgen_locked;

   assign PMOD_A[0] = CPU_RSTN;
   assign PMOD_A[1] = sys_clkgen_locked;
   assign PMOD_A[2] = eth_clkgen_locked;
   assign PMOD_A[3] = ETH_RST_B;
   assign PMOD_A[4] = eth_mdc;
   assign PMOD_A[5] = 1'b0; //eth_mdio_o;
   assign PMOD_A[6] = 1'b0; //eth_mdio_oe;

   assign SET_VADJ = 2'b11;  //-- 3.3V
   assign VADJ_EN  = 1'b1;   //-- On
   
endmodule // TOP

/*
module ETH_PHY_CTRL (
  input      SYSCLK_i,      //-- 100MHz
  input      rstn_req_i,   
  input      eth_int_b,
  input      eth_pme_b,
  output reg eth_rst_b,   //-- assert 10ms at least.
  output reg eth_mdc,     //-- about 1 MHz.
  output reg eth_mdio_oe,
  output reg eth_mdio_o,
  input      eth_mdio_i
  );
   
   reg [2:0] rstn_sync;
   reg [23:0] rst_period; //-- down counter.

   reg [6:0]  r_mdc_cyc;
   
   always @(posedge SYSCLK_i) begin
      rstn_sync <= {rstn_sync[1:0], rstn_req_i};
   end

   always @(posedge SYSCLK_i) begin
      if(rstn_sync[2]==1'b0) rst_period <= 24'hFF_FFFF;
      else if(rst_period > 24'h0) rst_period <= rst_period - 24'h1;
   end
   
   wire s_eth_rst_b = (rst_period == 24'h0);
   always @(posedge SYSCLK_i) begin
      eth_rst_b <= s_eth_rst_b;
   end

   always @(posedge SYSCLK_i) begin
      if(rstn_sync[2]==1'b0) r_mdc_cyc <= 7'd0;
      else                   r_mdc_cyc <= r_mdc_cyc + 7'd1;
   end
   wire s_mdc_rise = (r_mdc_cyc==7'd63);
   wire s_mdc_fall = (r_mdc_cyc==7'd127);

   always @(posedge SYSCLK_i) begin
      if(s_mdc_rise)      eth_mdc <= 1'b1;
      else if(s_mdc_fall) eth_mdc <= 1'b0;
   end

   always @(posedge SYSCLK_i) begin
      eth_mdio_o  <= 1'b1;
      eth_mdio_oe <= 1'b0;
   end
   
   
endmodule // ETH_PHY_INF
*/
