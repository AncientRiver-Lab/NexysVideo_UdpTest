`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/25 15:50:07
// Design Name: 
// Module Name: ping
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

module ping(
    /*---I/O---*/
    input           eth_rxck,
    //input           clk125;
    input           rst_rx,
    input [8:0]     rxd_i,
    input           arp_st,
    input           ping_st,
    input [47:0]    my_MAC_i,
    input [31:0]    my_IP_i,

    output reg [8:0] ping_o
    );
    
    /*---parameter---*/
    parameter   Idle    =   4'h0;
    parameter   Stby    =   4'hD;
    parameter   Presv   =   4'h1;
    parameter   Hcsum   =   4'h2;
    parameter   Hc_End  =   4'h3;
    parameter   Icsum   =   4'h4;
    parameter   Ic_End  =   4'h5;
    parameter   Ready   =   4'h6;
    parameter   Tx_Hc   =   4'h7;
    parameter   Tx_HEnd =   4'h8;
    parameter   Tx_Ic   =   4'h9;
    parameter   Tx_IEnd =   4'hA;
    parameter   Tx_En   =   4'hB;
    parameter   Tx_End  =   4'hC; 
    
    parameter   TTL     =   16'd255;
    //parameter   ip_head =   4'd14;
    //parameter   icmp    =   6'd34;
    parameter   V_I_T   =   16'h45_00;  // Version/IHL, TOS
    parameter   Protocol=   8'h01;
    //parameter   ByteLen =   16'd102;
    
    /*---wire/register---*/
    (*dont_touch="true"*)reg [7:0] RXBUF [255:0];
    (*dont_touch="true"*)reg [7:0] TXBUF [255:0];

    reg [47:0] tx_dstMAC;
    reg [31:0] tx_dstIP;
    reg [15:0] ToLen;   // Total Length
    reg [15:0] Ident;
    reg [15:0] SeqNum;
    reg [7:0] ICMP_Msg [255:0];
    
    wire [47:0] rx_dstMAC    = {RXBUF[0],RXBUF[1],RXBUF[2],RXBUF[3],RXBUF[4],RXBUF[5]};
    wire [47:0] rx_srcMAC    = {RXBUF[6],RXBUF[7],RXBUF[8],RXBUF[9],RXBUF[10],RXBUF[11]};
    wire [15:0] rx_FTYPE     = {RXBUF[12],RXBUF[13]};
    wire [15:0] rx_ToLen     = {RXBUF[16],RXBUF[17]};
    
    /*---ステートマシン---*/
    (*dont_touch="true"*)reg [3:0]   st;
    reg [3:0]   nx;
    reg [7:0]  rx_cnt;     // データ数
    reg         tx_end;
    reg [2:0]   end_cnt;
    (*dont_touch="true"*)reg [7:0]   csum_cnt;
    (*dont_touch="true"*)reg         csum_ok;
    reg [2:0]   err_cnt;
   
    always_ff @(posedge eth_rxck) begin
        if (rst_rx) st <= Idle;
        else        st <= nx;
    end
    
    wire hcsum_end = (csum_cnt==8'd34);
    wire hcend_end = (err_cnt==3'd7);
    wire icsum_end = (csum_cnt==rx_cnt-8'd3);
    wire icend_end = (err_cnt==3'd7);
    wire txhc_end  = (csum_cnt==8'd34);
    wire txic_end  = (csum_cnt==rx_cnt-8'd3);
    
    always_comb begin
        nx = st;
        case(st)
            Idle : if(rxd_i[8]) nx = Stby;
            Stby : begin                                //-- Wait for SFD byte.
                if(rxd_i[8]) begin
                    if(rxd_i[7:0]==`SFD) nx = Presv;
                    else if(rxd_i[7:0]==`PREAMB) nx = Stby;
                    else nx=Idle;
                end 
                else nx = Idle;
            end 
            Presv : begin                      //-- save rx frame.
                if(arp_st)  nx = Idle;
                else if(ping_st) nx = Hcsum;
                else if(rx_cnt>=8'd255) nx = Idle;
            end
            Hcsum : if(hcsum_end) nx = Hc_End;
            Hc_End : if(hcend_end) begin
                        if(csum_ok) nx = Icsum;           //-- chksum correct.
                        else        nx = Idle; //-- chksum error.
                     end 
            Icsum : if(icsum_end) nx = Ic_End;  // add 2018.11.20
            Ic_End : if(icend_end) begin
                        if(csum_ok) nx = Ready;
                        else        nx = Idle;
                     end
            Ready : nx = Tx_Hc;
            Tx_Hc : if(txhc_end) nx = Tx_HEnd;
            Tx_HEnd :  if(err_cnt==3'd7) nx = Tx_Ic;      // err_cnt==2'b01は引き伸ばすために行っているTXBUFの為でもあったが
            Tx_Ic :    if(txic_end) nx = Tx_IEnd; // add 2018.11.20
            Tx_IEnd : if(err_cnt==3'd7) nx = Tx_En;      // err_cnt==2'b01は引き伸ばすために行っている上と同じ
            Tx_En :   if(tx_end) nx = Tx_End;
            Tx_End :  if(end_cnt==3'd7) nx = Idle;
        endcase
    end
    
    /*---データ数/RXBUF保持---*/
    always_ff @(posedge eth_rxck)begin
        if (st==Presv) RXBUF[rx_cnt]  <= rxd_i[7:0];
    end 
    
    always_ff @(posedge eth_rxck)begin
        if(st==Hcsum)begin
            tx_dstMAC <= rx_srcMAC;
            tx_dstIP  <= {RXBUF[26],RXBUF[27],RXBUF[28],RXBUF[29]};
            ToLen   <= rx_ToLen;;
            Ident   <= {RXBUF[38],RXBUF[39]};
            SeqNum  <= {RXBUF[40],RXBUF[41]};
        end
        else if(st==Idle)begin
            tx_dstMAC <= 48'b0;
            tx_dstIP  <= 32'b0;
            ToLen   <= 16'b0;
            Ident   <= 16'b0;
            SeqNum  <= 16'b0;
        end
    end
    
    integer msg_cnt;
    always_ff @(posedge eth_rxck)begin
        if(st==Hcsum)begin
            for(msg_cnt=0; msg_cnt<(256-46); msg_cnt=msg_cnt+1) ICMP_Msg[msg_cnt] <= RXBUF[msg_cnt+42];
        end
        else if(st==Idle) begin
            for(msg_cnt=0; msg_cnt<256; msg_cnt=msg_cnt+1) ICMP_Msg[msg_cnt] <= 8'b0;
        end
    end
    
    always_ff @(posedge eth_rxck)begin
        if(st==Presv) begin
          if(rxd_i[8]) rx_cnt <= (&rx_cnt)? rx_cnt : (rx_cnt + 8'd1);
        end
        else if(st==Idle) rx_cnt <= 0;
    end
    
    /*---リセット信号---*/
    reg chksum_rst;
    always_ff @(posedge eth_rxck)begin
        if(st==Idle) chksum_rst <= 1;
        else         chksum_rst <= 0;
    end
    
    /*---チェックサム用データ---*/
    reg [7:0]       chksum_data;
    reg             chksum_en;
    (*dont_touch="true"*)reg [15:0]      chksum_o;
    
    always_ff @(posedge eth_rxck)begin         
        if(st==Idle)        csum_cnt <= 0;
        else if(st==Hcsum)  csum_cnt <= (&csum_cnt)? csum_cnt : (csum_cnt + 1);
        else if(st==Icsum)  csum_cnt <= (&csum_cnt)? csum_cnt : (csum_cnt + 1);
        else if(st==Tx_Hc)  csum_cnt <= (&csum_cnt)? csum_cnt : (csum_cnt + 1);
        else if(st==Tx_Ic)  csum_cnt <= (&csum_cnt)? csum_cnt : (csum_cnt + 1);
        else                csum_cnt <= 0; 
    end
    
    /*---チェックサム用データ---*/
    always_ff @(posedge eth_rxck)begin    // 最初の14bitはMACヘッダ
        if(st==Hcsum)       chksum_data <= RXBUF[csum_cnt];
        else if(st==Icsum)  chksum_data <= RXBUF[csum_cnt];  //-- icmp = 34
        else if(st==Tx_Hc)  chksum_data <= TXBUF[csum_cnt];
        else if(st==Tx_Ic)  chksum_data <= TXBUF[csum_cnt];
        else                chksum_data <= 0;
    end
    
    /*---チェックサム計算開始用---*/
    always_ff @(posedge eth_rxck)begin
        if(st==Hcsum)       chksum_en <= (csum_cnt > 8'd13 && csum_cnt < 8'd34);
        else if(st==Icsum)  chksum_en <= (csum_cnt > 8'd33 && csum_cnt < rx_cnt-8'd4);
        else if(st==Tx_Hc)  chksum_en <= (csum_cnt > 8'd13 && csum_cnt < 8'd34);
        else if(st==Tx_Ic)  chksum_en <= (csum_cnt > 8'd33 && csum_cnt < rx_cnt-8'd4);
        else if(st==Idle)   chksum_en <= 0;
        else                chksum_en <= 0;
    end
    
    /*---Checksum OK---*/
    always_ff @(posedge eth_rxck)begin
        if(st==Hc_End)begin
            if(chksum_o==16'h0000) csum_ok <= `HI;
        end
        else if(st==Ic_End) begin
            if(chksum_o==16'h0000) csum_ok <= `HI;
        end
        else                    csum_ok <= 0;
    end
    
    /*---Tx_Data Ready---*/
    reg [9:0] tx_cnt;
    /*---Ready Extend---*/
    /*
    always_ff @(posedge eth_rxck)begin
        if(st==Ready)begin
            ready_cnt <= ready_cnt + 1;
        end
        else begin
            ready_cnt <= 0;
        end
    end

    reg ready_rxck;                
    always_ff @(posedge eth_rxck)begin
        if(ready_cnt>=1&&ready_cnt<=3)begin
            ready_rxck <= 1;
        end
        else begin
            ready_rxck <= 0;
        end
    end
    */
    
    /*---tx_Hcend Extend---*/
    /*
    reg tx_hend_rxck;      
    reg tx_iend_rxck;  
    always_ff @(posedge eth_rxck)begin
        if(st==Tx_HEnd) begin
            if(err_cnt>=1&&err_cnt<=3)   tx_hend_rxck <= 1;
            else                         tx_hend_rxck <= 0;
        end 
        else if(st==Tx_IEnd)begin
            if(err_cnt>=1&&err_cnt<=3)   tx_iend_rxck <= 1;
            else                         tx_iend_rxck <= 0;
        end
        else begin
            tx_hend_rxck <= 0;
            tx_iend_rxck <= 0;
        end
    end
    */
    
    reg [15:0] csum_extend;
    always_ff @(posedge eth_rxck)begin 
       if(st==Tx_HEnd) begin
           if(err_cnt==3'd1) csum_extend <= chksum_o;
       end
       else if(st==Tx_IEnd)begin
           if(err_cnt==3'b0) csum_extend <= chksum_o;
       end
       else csum_extend <= 16'h5555;  // dummy value.
    end
    
    /*---送信用データ---*/
    integer i;
    always_ff @(posedge eth_rxck)begin
        if(st==Ready)begin
            {TXBUF[0],TXBUF[1],TXBUF[2],TXBUF[3],TXBUF[4],TXBUF[5]} <= tx_dstMAC;
            {TXBUF[6],TXBUF[7],TXBUF[8],TXBUF[9],TXBUF[10],TXBUF[11]} <= my_MAC_i;     // add 2018.12.5
            {TXBUF[12],TXBUF[13]} <= `FTYPE_IPV4;
            {TXBUF[14],TXBUF[15]} <= V_I_T;         // Version/IHL, TOS
            {TXBUF[16],TXBUF[17]} <= ToLen;         // Total Length         
            {TXBUF[18],TXBUF[19]} <= 16'hAB_CD;     // Identification
            {TXBUF[20],TXBUF[21]} <= 16'h40_00;     // Flags[15:13] ,Flagment Offset[12:0]
            TXBUF[22] <= TTL;                       // Time To Live
            //TXBUF[23] <= RXBUF[23];                 // Protocol ICMP=1
            TXBUF[23] <= Protocol;                 // Protocol ICMP=1
            {TXBUF[24],TXBUF[25]} <= 16'h00_00;     // Header Checksum
            {TXBUF[26],TXBUF[27],TXBUF[28],TXBUF[29]} <= my_IP_i;                      // add 2018.12.5
            {TXBUF[30],TXBUF[31],TXBUF[32],TXBUF[33]} <= tx_dstIP;
            {TXBUF[34],TXBUF[35]} <= `PING_REPLY;   // Echo Reply = {Type=8'h00,Code=8'h00}
            {TXBUF[36],TXBUF[37]} <= 16'h00_00;     // ICMP Checksum      
            //TXBUF[39:38] <= RXBUF[39:38];         // Identifier
            {TXBUF[38],TXBUF[39]} <= Ident;
            //TXBUF[41:40] <= RXBUF[41:40];         // Sequence number
            {TXBUF[40],TXBUF[41]} <= SeqNum;
            /*--Random Data--*/
            for(i=0;i<(rx_cnt-6'd46);i=i+1)begin
                //TXBUF[6'd42+i] <= RXBUF[6'd42+i];
                //TXBUF[6'd42+i] <= ICMP_Msg[i];
                TXBUF[6'd42+i] <= i;
            end
            {TXBUF[rx_cnt-4],TXBUF[rx_cnt-3],TXBUF[rx_cnt-2],TXBUF[rx_cnt-1]} <= 32'h01_02_03_04;   // dummy
        end
        else if(st==Tx_HEnd) {TXBUF[24],TXBUF[25]} <= csum_extend;
        else if(st==Tx_IEnd) {TXBUF[36],TXBUF[37]} <= csum_extend;
        /*
        else if(st==Idle)begin   //-- Leave as is.
            for(i=0;i<9'd256;i=i+1) TXBUF[i] <= 0;
        end
        */
    end
    
    
    /*---Header Checksum Error---*/
    always_ff @(posedge eth_rxck)begin
        if(st==Hc_End)          err_cnt <= err_cnt + 3'b1;
        else if(st==Ic_End)     err_cnt <= err_cnt + 3'b1;
        else if(st==Tx_HEnd)    err_cnt <= err_cnt + 3'b1;
        else if(st==Tx_IEnd)    err_cnt <= err_cnt + 3'b1;
        else                    err_cnt <= 0;
    end
    
    always_ff @(posedge eth_rxck)begin
        if(st==Tx_End)  end_cnt <= end_cnt + 1'b1;
        else            end_cnt <= 1'b0;
    end
    
    checksum checksum(
        .clk_i   (eth_rxck),
        .d       (chksum_data),
        .data_en (chksum_en),
        .csum_o  (chksum_o),
        .rst     (chksum_rst)
    );

    //reg [7:0] clk_cnt;
    always_ff @(posedge eth_rxck)begin
        if(st==Tx_En)begin
            tx_cnt <= tx_cnt + 1;
            if(tx_cnt==rx_cnt) tx_end <= 1; 
        end
        else begin
            tx_cnt <= 0;
            tx_end <= 0;
        end
    end
    
    reg [2:0] fcs_cnt;
    always_ff @(posedge eth_rxck)begin
        if(st==Tx_En && fcs_cnt!=3'b100) fcs_cnt <= fcs_cnt + 1;
        else                             fcs_cnt <= 0;
    end 
    always_ff @(posedge eth_rxck)begin
        if(st==Tx_En && tx_cnt<(rx_cnt-8'd4)) ping_o <= {`HI,TXBUF[tx_cnt]};
        else if(st==Tx_En && fcs_cnt!=3'd4)  ping_o <= {`LO,TXBUF[tx_cnt]};
        else             ping_o <= 0;
    end  
endmodule // PING
