`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/26 17:43:14
// Design Name: 
// Module Name: Arbiter
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
`include "user_defines.sv"

module Arbiter(
    input [7:0]           gmii_rxd,
    input                 eth_rxck,
    input                 gmii_rxctl,
    input                 rst_rx,
    input                 rst125,
    //input                 clk125,
    
    input                 rst_btn,
    input [7:0]           SW,
    
    output [8:0]          rarp_o,
    output [8:0]          ping_o,
    output [8:0]          UDP_o
    //output reg [7:0]      LED
    );
    
parameter  Idle    = 4'h1;
parameter  WaitSFD = 4'h2;
parameter  RxData  = 4'h3;
parameter  RxEnd   = 4'h4;
    
    reg       pre;
    reg [7:0] RXBUF[64:0];
    
    /* ステートマシン */
    (*dont_touch="true"*)reg [3:0] st;
    reg [3:0] nx;
    
    //<-- test by oikawa
    reg [3:0] rxend_cnt;
    always_ff @(posedge eth_rxck)begin
       if(st==Idle) rxend_cnt <= 4'h0;
       else if(st==RxEnd) rxend_cnt <= (&rxend_cnt)? rxend_cnt : (rxend_cnt + 4'h1);
    end
    //--> test by oikawa
    
    /* 受信 */
    /* 受信データ数 */
    (*dont_touch="true"*) reg [10:0] rx_cnt;
    always_ff @(posedge eth_rxck)begin
        if(st==RxData)    rx_cnt <= (&rx_cnt)? rx_cnt : (rx_cnt + 11'd1);
        else if(st==Idle) rx_cnt <= 0;
    end
      
    always_ff @(posedge eth_rxck)begin
        if(rst_rx)  st <= Idle;
        else        st <= nx;
    end
    always_comb begin
        nx = st; //-- default.
        case(st)
            Idle:    if (gmii_rxctl)  nx = WaitSFD;
            WaitSFD: if (pre)         nx = RxData;
            RxData:  if (!gmii_rxctl) nx = RxEnd;
            RxEnd:   if (rxend_cnt==4'hF)  nx = Idle;
        endcase
    end
    
    /*---MAC/IP addressをDIPスイッチを使って任意に決める(add 2018.12.5)---*/
    (*dont_touch="true"*) wire [47:0] my_MACadd = `my_MAC | {44'b0, SW[3:0]}; 
    (*dont_touch="true"*) wire [31:0] my_IPadd  = `my_IP  | {28'b0, SW[3:0]};
    
    /* DstMAC */
    (*dont_touch="true"*)reg [47:0] DstMAC;
    (*dont_touch="true"*)reg [31:0] DstIP;
    wire [47:0] rx_dstMAC    = {RXBUF[0],RXBUF[1],RXBUF[2],RXBUF[3],RXBUF[4],RXBUF[5]};
    wire [47:0] rx_srcMAC    = {RXBUF[6],RXBUF[7],RXBUF[8],RXBUF[9],RXBUF[10],RXBUF[11]};
    wire [15:0] rx_FTYPE     = {RXBUF[12],RXBUF[13]};
    wire [31:0] rx_srcIP     = {RXBUF[28],RXBUF[29],RXBUF[30],RXBUF[31]};
    wire [31:0] rx_arp_dstIP = {RXBUF[38],RXBUF[39],RXBUF[40],RXBUF[41]};
    wire [31:0] rx_ip4_dstIP = {RXBUF[30],RXBUF[31],RXBUF[32],RXBUF[33]};

    wire is_arp = (rx_FTYPE==`FTYPE_ARP); //-- moikawa add.
    wire dstmac_is_bcast = (rx_dstMAC == `bcast_MAC); //-- dest MAC address is broadcast.
    wire dstmac_is_me    = (rx_dstMAC == my_MACadd);  //-- dest MAC address is me.
    
    always_ff @(posedge eth_rxck) begin
        if(st==RxEnd && is_arp) begin
            if(dstmac_is_bcast || dstmac_is_me) begin   // add 2018.12.5
                DstMAC <= rx_srcMAC;
                DstIP <= rx_srcIP;
            end
        end
        else if(st==Idle) begin
            DstMAC <= 48'b0;
            DstIP <= 32'b0;
        end
    end
    
    /* rxdとrxctlの遅延 */
    (*dont_touch="true"*)reg [7:0] q_rxd [3:0];
    reg [3:0] q_rxctl;
    always @(posedge eth_rxck)begin
       if (rst_rx) begin
          q_rxctl <= 4'b0; 
       end else begin
          q_rxd <= {q_rxd[2:0],gmii_rxd};
          q_rxctl <= {q_rxctl[2:0], gmii_rxctl};
       end
    end    
    

    
    /* 受信データロード */
    always_ff @(posedge eth_rxck)begin
        if(st==RxData) RXBUF[rx_cnt] <= q_rxd[0];
    end
    
    /* SFD検出 */
    always_comb begin
        if(st==WaitSFD && q_rxd[0]==`SFD) pre = 1'b1;
        else pre = 1'b0;
    end
    
    /* CRC_DELAY */
    reg [1:0] delay_CRC;    // CRCのために4バイト遅らせる
    reg       CRC_flg;
    reg       reset;
    always_ff @(posedge eth_rxck or negedge gmii_rxctl)begin
        if(st==RxData)begin
            if(delay_CRC==2'b10)begin
                CRC_flg<=1;
                reset<=1;
            end
            else delay_CRC <= delay_CRC + 1;
            if(!gmii_rxctl) CRC_flg <= 0;
        end
        else if(st==Idle)begin
            reset<=0;
            delay_CRC<=0;
            CRC_flg <= 0;
        end
    end
    //==========================================
    // CRC generator
    //==========================================
    reg [31:0] CRC;
    CRC_ge crc_ge(
                .d     (q_rxd[3]),
                .CLK   (eth_rxck),
                .reset (reset),
                .CRC   (CRC),
                .flg   (CRC_flg)
    );   
    
    (*dont_touch="true"*)reg [31:0] r_crc;
    always_ff @(posedge eth_rxck) begin
        if(st==RxData)begin
            r_crc <= ~{CRC[24],CRC[25],CRC[26],CRC[27],CRC[28],CRC[29],CRC[30],CRC[31],
                      CRC[16],CRC[17],CRC[18],CRC[19],CRC[20],CRC[21],CRC[22],CRC[23],
                      CRC[8],CRC[9],CRC[10],CRC[11],CRC[12],CRC[13],CRC[14],CRC[15],
                      CRC[0],CRC[1],CRC[2],CRC[3],CRC[4],CRC[5],CRC[6],CRC[7]};
        end
        else if(st==Idle) r_crc <= 0;
    end
 
    (*dont_touch="true"*)reg [31:0] FCS;
    always_ff @(posedge eth_rxck) begin
        if (st==RxData && !gmii_rxctl)begin
            FCS <= {q_rxd[3],q_rxd[2],q_rxd[1],q_rxd[0]}; 
        end
        else if(st==Idle)begin
            FCS <= 0;
        end
    end
    
    (*dont_touch="true"*) reg crc_ok; 
    wire FCS_correct = (st==RxEnd && FCS==r_crc);
    always_ff @(posedge eth_rxck)begin
        if(st==RxEnd && rxend_cnt==4'h0 && FCS_correct) crc_ok <= `HI;
        else if(st==Idle) crc_ok <= `LO;
    end
     
    /*---パケットの種類振り分け---*/
    (*dont_touch="true"*)reg [2:0] arp_st;       // ARP Packet
    (*dont_touch="true"*)reg ping_st;      // ICMP Echo Packet(ping)
    (*dont_touch="true"*)reg [2:0] UDP_st;       // UDP Packet
    (*dont_touch="true"*)reg [2:0] els_packet;   // else Packet
    always_ff @(posedge eth_rxck)begin
        if(crc_ok)begin
            if((dstmac_is_bcast ||dstmac_is_me) && is_arp && rx_arp_dstIP==my_IPadd) arp_st <= 3'b111;  // add 2018.12.5
            else if(dstmac_is_me && RXBUF[23]==8'h01 && rx_ip4_dstIP==my_IPadd) ping_st <= `HI; // add 2018.12.11
            else if(dstmac_is_me && RXBUF[23]==8'h11 && rx_ip4_dstIP==my_IPadd) UDP_st  <= 3'h7; // add 2018.12.5
            else els_packet <= 3'h7;
        end
        else begin
            arp_st  <= {arp_st[1:0], `LO};
            ping_st <= `LO;
            UDP_st  <= {UDP_st[1:0], `LO};
            els_packet <= {els_packet[1:0], `LO};
        end
    end
    
    ARP arp(
        /*---INPUT---*/
        .eth_rxck     (eth_rxck),
        .rst_rx       (rst_rx),
        .start_i      (arp_st[2]),
        .myMAC_i      (my_MACadd),  //<---  add 2018.12.5
        .myIP_i       (my_IPadd),    //--->
        .DstMAC_i     (DstMAC),
        .DstIP_i      (DstIP),
        /*---OUTPUT---*/
        .rarp_o       (rarp_o)
    );
    
    ping ping(
        .eth_rxck     (eth_rxck),
        .rst_rx       (rst_rx),
        .rxd_i        ({q_rxctl[0], q_rxd[0]}),
        .arp_st(arp_st[2]),
        .ping_st      (ping_st),
        .my_MAC_i     (my_MACadd),
        .my_IP_i      (my_IPadd),
        //.DstMAC(DstMAC),
        //.DstIP(DstIP),
        .ping_o       (ping_o)
    );
    /*
    UDP_reply UDP_reply(
        .clk125(clk125),
        .rst_rx(rst_rx),
        .RXBUF(RXBUF),
        .rx_cnt(rx_cnt),
        .UDP_st(UDP_st[2]),
        .UDP_tx(UDP_tx),
        .UDP_d(UDP_o)
    );
    */
    
    wire [7:0] imdata;
    wire [9:0] addr;
    wire [8:0] addr_cnt;
    wire    recvend;
    wire    trans_err;
    //wire [7:0] image_buffer [9999:0];
    wire [47:0] DstMAC_UDP;
    wire [31:0] DstIP_UDP;
    wire [15:0] SrcPort;
    wire [15:0] DstPort;
    
    recv_image recv_image(
        /*---Input---*/
        .eth_rxck(eth_rxck),
        .clk125(eth_rxck),
        .rst_rx(rst_rx),
        .pre(pre),
        .rxd(q_rxd[0]),
        //.RXBUF(RXBUF),
        .rx_cnt(rx_cnt),
        .arp_st(arp_st[0]),
        .ping_st(ping_st),
        .UDP_st(UDP_st[2]),
        .els_packet(els_packet[0]),
        .addrb(addr),
        .addr_cnt(addr_cnt),
        .rst_btn(rst_btn),
        .trans_err(trans_err),
        .SW(SW),        // add 2018.12.5
        /*---Output---*/
        .imdata(imdata),
        .recvend(recvend),
        //.image_buffer(image_buffer),
        .DstMAC(DstMAC_UDP),
        .DstIP(DstIP_UDP),
        .SrcPort(SrcPort),
        .DstPort(DstPort)
    );
    
    trans_image trans_image(
        /*---Input---*/
        .eth_rxck(eth_rxck),
        .clk125(eth_rxck),
        .rst_rx(rst_rx),
        .rst_btn(rst_btn),
        .imdata(imdata),
        .recvend(recvend),
        //.image_buffer(image_buffer),
        .my_MACadd(my_MACadd),
        .my_IPadd(my_IPadd),
        .DstMAC(DstMAC_UDP),
        .DstIP(DstIP_UDP),
        .SrcPort(SrcPort),
        .DstPort(DstPort),
        .SW(SW),        // add 2018.12.5
        /*---Output---*/
        .image_cnt(addr),
        .addr_cnt(addr_cnt),
        //.tx_en_clk125(UDP_tx_en),
        //.UDP_tx(UDP_tx),
        .UDP_d(UDP_o),
        .trans_err(trans_err)
    );

//    Image_UDP Image_UDP(
//        /*---Input---*/
//        .eth_rxck(eth_rxck),
//        .clk125(clk125),
//        .rst_rx(rst_rx),
//        .pre(pre),
//        .rxd(q_rxd[0]),
//        //.RXBUF(RXBUF),
//        .rx_cnt(rx_cnt),
//        .arp_st(arp_st),
//        .ping_st(ping_st),
//        .UDP_st(UDP_st),
//        /*---Output---*/
//        .UDP_tx(UDP_tx),
//        .UDP_d(UDP_d)
//    ); 
         
endmodule
