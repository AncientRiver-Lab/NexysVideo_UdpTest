`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/04 19:59:37
// Design Name: 
// Module Name: T_Arbiter
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

module T_Arbiter(
    input [8:0] rarp_i,
    input [8:0] ping_i,
    input [8:0] UDP_btn_d,
    input [8:0] UDP_i,
    //input ping_tx,
    input UDP_btn_tx,
    input UDP_tx,
    input eth_rxck,
    input rst,
    
    output reg [7:0] txd_o,
    output reg gmii_txctl_o,
   
    output reg [7:0] txend_count_o
    );
    
parameter Idle     =  4'h0;   // 待機状態
parameter Stby     =  4'h1;
parameter TxPre    =  4'h2;   // プリアンブル送信
parameter TxData   =  4'h4;   // データ送信
parameter TxEnd    =  4'h8;   // 送信終了
    
    /* ステートマシン */
   
    reg [3:0] st, nx;
    reg [2:0] fcs_cnt;
    wire      tx_end = (st==TxData && fcs_cnt==3'd4);
    reg [3:0] pre_cnt;
    wire      pre_end = (pre_cnt==4'd8);
    always_ff @(posedge eth_rxck) begin
        if (rst) st <= Idle;
        else     st <= nx;
    end
    
    wire valid;
    wire [11:0]  q_dout;
    reg [1:0] stby_cyc;
    reg [10:0] txdata_cyc;
    
    wire rarp_first, rarp_last;
    wire ping_first, ping_last;
    
     //wire tx_any = (rarp_first || ping_first || UDP_i[8]);
     wire tx_any = (rarp_first || ping_first);
    
    always_comb begin
        nx = st;
        case(st)
            Idle :   if(tx_any)  nx = Stby;
            Stby :   if(q_dout[11] && valid) nx = TxPre;  
            TxPre :  if(pre_end) nx = TxData;
            TxData : if(tx_end)  nx = TxEnd;
            TxEnd :              nx = Idle;
        endcase
    end
    
    always_ff @(posedge eth_rxck) begin //-- count up during "Stby" state only, else clear.
       if (rst) stby_cyc <= 2'd0;
       else if(st==Stby) stby_cyc <= stby_cyc + 2'd1;
       else stby_cyc <= 2'd0;
    end
    always_ff @(posedge eth_rxck) begin //-- count up during "TxData" state only, else clear.
       if (rst) txdata_cyc <= 11'd0;
       else if(st==TxData) txdata_cyc <= (&txdata_cyc)? txdata_cyc : (txdata_cyc + 11'd1);
       else txdata_cyc <= 11'd0;
    end
    
    reg [8:0] rarp_d;
    reg [8:0] ping_d;
    always_ff @(posedge eth_rxck) begin
       rarp_d <= rarp_i;
       ping_d <= ping_i;
    end
    assign rarp_first = ({rarp_d[8],rarp_i[8]}==2'b01); //-- rise edge
    assign rarp_last  = ({rarp_d[8],rarp_i[8]}==2'b10); //-- fall edge
    
    assign ping_first = ({ping_d[8],ping_i[8]}==2'b01); //-- rise edge
    assign ping_last  = ({ping_d[8],ping_i[8]}==2'b10); //-- fall edge
    
    /*-----Queue-----*/
    reg  [11:0]  q_din;
    reg         wr_en;
    reg         rd_req;
    wire        rd_en; //*
    wire        full;
    wire        overflow;
    wire        empty;
   // wire        valid;
    wire        underflow;
    wire [10:0] rd_data_count;
    wire [10:0] wr_data_count;
   
    wire        wr_rst_busy;
    wire        rd_rst_busy;
    
    /*--書き込み--*/  
    always_comb begin
        if(rarp_d[8] | rarp_first)begin
            wr_en      = rarp_d[8] | rarp_first;
            q_din[11]  = rarp_first;
            q_din[10]  = rarp_last;
            q_din[9]   = `LO; // no use.
            q_din[8:0] = rarp_d[8:0];
        end
        else if(ping_d[8] | ping_first) begin
            wr_en      = ping_d[8] | ping_first;
            q_din[11]  = ping_first; 
            q_din[10]  = ping_last;
            q_din[9]   = `LO; // no use.
            q_din[8:0] = ping_d[8:0];
        end
        else if(UDP_btn_tx)begin
            wr_en <= UDP_btn_tx;
            q_din <= UDP_btn_d;
        end
        else if(UDP_tx)begin
            wr_en <= UDP_tx;
            q_din <= UDP_i;
        end
        else wr_en <= 1'b0;
    end 
    
    queue TX_queue(
        //-- write side
        
        //-- read side
        .rst(rst),
        .wr_clk(eth_rxck),      // 書き込み用クロック (write clock)
        .rd_clk(eth_rxck),        // 読み出し用クロック (read clock)
        .din            (q_din),   // 書き込むデータ [8:0]din = {1'data_frame,8'data}
        .wr_en(wr_en),          // 書き込み開始
        .rd_en(rd_en),          // 読み出し開始
        .dout(q_dout),          // 読み出しデータ
        .full(full),
        .overflow(overflow),    // キューがオーバーフロー
        .empty(empty),          // キュー内が空
        .valid(valid),          // 書き込みflg
        .underflow(underflow),  // キューがアンダーフロー
        .rd_data_count(rd_data_count), // データの数
        .wr_data_count(wr_data_count),
        .wr_rst_busy(wr_rst_busy),
        .rd_rst_busy(rd_rst_busy)
    );

    
    /*--CRC用データ--*/
    /*---CRC計算---*/
//    always_ff @(posedge clk125)begin
//        crc_d   <= q_dout[7:0];
//        crc_en  <= q_dout[8];
//    end
    
    
    /*----- 送信 -----*/
    reg [7:0] d;       // CRC用
    reg flg;
    reg txen;

    /*--プリアンブル--*/
    always_ff @(posedge eth_rxck)begin
        if(st==TxPre)     pre_cnt <= pre_cnt + 1;
        else if(st==Idle) pre_cnt <= 0;        
    end
    /*--読み出し管理(rd_en)--*/

    always_ff @(posedge eth_rxck)begin //-- TODO: maybe too complex
       case(st)
         Stby: rd_req <= (stby_cyc==2'd1 && !empty);
         TxPre: begin
             if(pre_end) rd_req<=1;
         end
         TxData: begin
             //if(rd_data_count<11'd3) rd_en<=0;
             if (empty) rd_req <= `LO;  //-- means last byte in stream.
         end
         default: rd_req <= `LO;
       endcase
    end
    wire last_byte = (q_dout[10]==`HI && valid); // is last byte in a frame.
    assign rd_en = rd_req && (!last_byte);
    
    /*---delay q_dout[8]---*/
    reg [11:0] q_dout_d;
    always_ff @(posedge eth_rxck)begin
        q_dout_d <= q_dout;
    end
    
    /*--送信--*/
    //(*dont_touch="true"*)reg [31:0] CRC32;
    (*dont_touch="true"*)reg [31:0] r_crc;
    always_ff @(posedge eth_rxck)begin
       case (st)
         Idle:  txd_o <= `PREAMB;
         TxPre: txd_o <= `PREAMB;
         TxData: begin
                if(txdata_cyc==11'd0) txd_o <=`SFD;
                else if(valid)        txd_o <= q_dout[7:0];
                else if(!valid) begin
                   txd_o <= (fcs_cnt==3'd0) ? r_crc[31:24] : 
                            (fcs_cnt==3'd1) ? r_crc[25:16] :
                            (fcs_cnt==3'd2) ? r_crc[15:8] : r_crc[7:0];
     /*--debug--*/
//                txd_o <= (fcs_cnt==3'b000) ? 8'h01 : (
//                                   (fcs_cnt==3'b001) ? 8'h02 : (
//                                       (fcs_cnt==3'b010) ? 8'h03 : 8'h04
//                                   )
//                              );
                end
         end
       endcase
    end
    
    /*--txen管理--*/
    
    always_ff @(posedge eth_rxck)begin
        case(st) 
           Idle: fcs_cnt <= 3'd7;
           TxData: begin
              if(last_byte) fcs_cnt <= 3'd0; //-- use final byte flag. 
              else if (fcs_cnt < 3'd7) fcs_cnt <= fcs_cnt + 3'd1;
           end
           default: /*hold*/ ;
        endcase
    end

    always_ff @(posedge eth_rxck)begin
        if(st==Idle) gmii_txctl_o <= 0;
        else if(st==TxPre) gmii_txctl_o <= `HI;
        else if(st==TxData && fcs_cnt==3'd4) gmii_txctl_o <= `LO;
    end
    
    /*--CRC計算--*/
//    wire [31:0] crc0_reg;
//    wire [7:0]  crc0;
//    wire crc0_init = !txen;
//    reg crc0_valid;
    
//    crc_32 Tx_crc_32(
//        .crc_reg(crc0_reg),
//        .crc(crc0),
//        .d(q_dout[7:0]),
//        .calc(q_dout[8]),
//        .init(crc0_init),
//        .d_valid(crc0_valid),
//        .clk(eth_rxck),
//        .reset(1'b0)
//    );
    
    reg reset;
    always_ff @(posedge eth_rxck)begin
        if(st==Idle)    reset <= 1'b0;
        else            reset <= 1'b1;
    end
    
    /*--CRC計算2--*/
    wire crc_flg = (st==TxData && valid==`HI);
    
    (*dont_touch="true"*)reg [31:0] CRC;
    CRC_ge T_crc_ge(
        .flg  (crc_flg), 
        .d    (q_dout[7:0]),  //<-- fifo out
        .CLK  (eth_rxck),
        .reset(reset), 
        .CRC  (CRC)
    );
    
    
    //always_ff @(posedge eth_rxck) begin
    always_comb begin
        //if(q_dout[8])begin
        //if(st==TxData)begin
            r_crc = ~{CRC[24],CRC[25],CRC[26],CRC[27],CRC[28],CRC[29],CRC[30],CRC[31],
                      CRC[16],CRC[17],CRC[18],CRC[19],CRC[20],CRC[21],CRC[22],CRC[23],
                      CRC[8],CRC[9],CRC[10],CRC[11],CRC[12],CRC[13],CRC[14],CRC[15],
                      CRC[0],CRC[1],CRC[2],CRC[3],CRC[4],CRC[5],CRC[6],CRC[7]};
        //end
        //else if(st==Idle) r_crc <= 32'b0;
    end
    
    
    
//    reg [1:0] delay_crc_en;
//    always_ff @(posedge eth_rxck)begin
//        delay_crc_en <= {delay_crc_en[0],crc_en};
//    end
    
//    always_ff @(posedge eth_rxck)begin
//        if(st==Idle) CRC32 <= 0;
//        else if(delay_crc_en[1]) CRC32 <= r_crc;
//        else if(!delay_crc_en[1]) CRC32 <= CRC32;
//        else CRC32 <= 0;
//    end
    
    always_ff @(posedge eth_rxck)begin
        if(rst) txend_count_o <= 8'd0;
        else if(st==TxEnd) txend_count_o <= txend_count_o + 8'd1;
    end
    
endmodule
