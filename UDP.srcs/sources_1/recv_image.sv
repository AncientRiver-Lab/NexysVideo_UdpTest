`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/27 18:47:57
// Design Name: 
// Module Name: recv_image
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

/*---recv_image.sv---*/
// 受信チェックサム計算と画像データの取得,処理を行う
// 画像データは100x100の10,000バイト
// フラグメントなし
// UDPデータとして1,000バイトずつ送られてくる
// UDPデータの順番については考慮しない
// 取得した画像は明度反転して返信

module recv_image(
   /*---I/O Declare---*/
    input           eth_rxck,
    input           clk125,
    input           rst_rx,
    input           pre,
    input [7:0]     rxd,
    //input [7:0]     RXBUF [1045:0];
    input [10:0]    rx_cnt,
    input           arp_st,
    input           ping_st,
    input           UDP_st,
    input           els_packet,
    input [9:0]     addrb,
    input [8:0]     addr_cnt,
    
    input           rst_btn,
    input           trans_err,
    input [7:0]     SW,
        
    output reg [7:0]  imdata,
    output reg        recvend,
    output reg [47:0] DstMAC,
    output reg [31:0] DstIP,
    output reg [15:0] SrcPort,
    output reg [15:0] DstPort
    //output reg [7:0]  image_buffer [9999:0]
    );
    
    /*---parameter---*/
    parameter   Idle        =   8'h00;
    parameter   Presv       =   8'h01;
    parameter   Hcsum       =   8'h02;
    parameter   Hc_End      =   8'h03;
    parameter   Ucsum       =   8'h04;
    parameter   Uc_End      =   8'h05;
    parameter   Select      =   8'h06;
    parameter   Recv_End    =   8'h07;
    parameter   ERROR       =   8'h08;
    
    parameter   eth_head    =   4'd14;
    parameter   udp         =   6'd34;
    parameter   MsgSize     =   16'd1000;
    
    /*---wire/register---*/
    //wire [3:0] packet_cnt_sel = (SW[7:4]==4'd0) ? SW[7:4] : (SW[7:4] - 4'd1) ;     // add 2018.12.5
    wire [8:0] packet_cnt_sel = (SW[7:4]==4'd0) ? 4'd0 :                            // add 2018.12.6
                                 (SW[7:4]==4'd1) ? 4'd1-1'b1 :
                                 (SW[7:4]==4'd2) ? 4'd2-1'b1 :
                                 (SW[7:4]==4'd3) ? 4'd4-1'b1 :
                                 (SW[7:4]==4'd4) ? 4'd8-1'b1 :
                                 (SW[7:4]==4'd5) ? 5'd16-1'b1 :
                                 (SW[7:4]==4'd6) ? 6'd32-1'b1 :
                                 (SW[7:4]==4'd7) ? 7'd64-1'b1 :
                                 (SW[7:4]==4'd8) ? 8'd128-1'b1 :
                                 (SW[7:4]==4'd9) ? 9'd256-1'b1 :
                                 (SW[7:4]==4'd10) ? 4'd10-1'b1 :
                                 8'd160-1'b1;
    
    reg [7:0]   RXBUF   [1045:0];
    reg [7:0]   VBUF    [1019:0];
    reg [10:0]  rx_cnt_i;
    reg         rst;
    reg [10:0]  UDP_cnt;  // 固定長のUDPデータ用カウント
    reg [15:0]  UDP_Checksum;
    reg [4:0]   end_cnt;

    /*---ステートマシン---*/
    (*dont_touch="true"*)reg [7:0]   st;
    reg [7:0]   nx;
    (*dont_touch="true"*)reg [10:0]  csum_cnt;
    (*dont_touch="true"*)reg [10:0]  d_csum_cnt;   
    (*dont_touch="true"*)reg         csum_ok;
    reg [2:0]   err_cnt;
    reg [8:0]   packet_cnt;

    always_ff @(posedge eth_rxck)begin
        if (rst_rx) st <= Idle;
        else        st <= nx;
    end
    
    always_comb begin
        nx = st;
        case (st)
            Idle : begin
                if (pre) nx = Presv;
            end
            Presv : begin
                if (arp_st||ping_st||els_packet)            nx = Idle;
                //else if (UDP_st&&rx_cnt<100)    nx = Idle;        // add 2018.11.19
                //else if (UDP_st&&rx_cnt>100)    nx = Hcsum;       // add 2018.11.19
                else if (UDP_st)                nx = Hcsum;
                else if (rst_btn)               nx = Idle;
            end
            Hcsum : begin
                if(csum_cnt==6'd22) nx = Hc_End;
            end
            Hc_End : begin 
                if(csum_ok) nx = Ucsum;
                else if(err_cnt==3'b010) nx = ERROR; 
            end
            Ucsum : begin
                if(csum_cnt==10'd1022) nx = Uc_End;    // 仮想ヘッダの長さ(仮想ヘッダ(12)+UDPデータ長(1008))
            end
            Uc_End : begin
                if(csum_ok) nx = Select;
                else if(err_cnt==3'b010) nx = ERROR;
            end
            Select : begin
                //if(packet_cnt==4'd9) nx = Recv_End;
                if(packet_cnt==packet_cnt_sel) nx = Recv_End;   // add 2018.12.5
                else                 nx = Idle;
            end
            Recv_End : begin
                if(end_cnt==5'h1F) nx = Idle;
            end
            ERROR : begin
                nx = Idle;
            end
            default : begin
                nx = Idle;
            end
        endcase
    end
    
    /*---データの保持---*/
    integer i;
    
//    always_ff @(posedge eth_rxck)begin
//        if (st==Presv) begin
//            rx_cnt_i    <= rx_cnt;
//            RXBUF_i     <= RXBUF;
//            MsgSize     <= {RXBUF[38],RXBUF[39]} - 4'd8;    // UDPデータグラム-UDヘッダ(8バイト)=1000バイト
//        end
//        else if(st==Idle) begin
//            rx_cnt_i    <= 11'd0;
//            for (i=0;i<1046;i=i+1) RXBUF_i[i] <= 8'h00;
//            MsgSize     <= 16'd0;
//        end
//    end
    
    always_ff @(posedge eth_rxck)begin
        if(st==Presv)begin
            RXBUF[rx_cnt] <= rxd;
        end
        else if(st==Idle)begin
            for (i=0;i<1046;i=i+1) RXBUF[i] <= 8'h00;
        end
    end
    
    always_ff @(posedge eth_rxck)begin
        if (st==Select) begin
            DstMAC  <= {RXBUF[6],RXBUF[7],RXBUF[8],RXBUF[9],RXBUF[10],RXBUF[11]};
            DstIP   <= {RXBUF[26],RXBUF[27],RXBUF[28],RXBUF[29]};
        end
        else if(st==Idle)begin
            DstMAC  <= 48'b0;
            DstIP   <= 32'b0;
        end
    end
    
    always_ff @(posedge eth_rxck)begin
        if(st==Select)begin
            SrcPort <= {RXBUF[34],RXBUF[35]};
            DstPort <= {RXBUF[36],RXBUF[37]};    
            //UDP_Checksum <= {RXBUF[40],RXBUF[41]}; 
        end
        else if(st==Idle)begin
            SrcPort <= 16'b0;
            DstPort <= 16'b0;
            //UDP_Checksum <= 16'b0;
        end
    end
    
//    integer msg_cnt;
//    always_ff @(posedge eth_rxck)begin
//        if (st==Presv) begin
//            for(msg_cnt=0;msg_cnt<10'd1000;msg_cnt=msg_cnt+1) image_buffer[(packet_cnt*10'd1000)+msg_cnt] <= RXBUF[6'd42+msg_cnt];
//        end
//        else if((st==Idle&&packet_cnt==0)||st==ERROR) begin 
//            for(msg_cnt=0;msg_cnt<14'd10000;msg_cnt=msg_cnt+1) image_buffer[msg_cnt] <= 8'b0;
//        end
//    end
    
    /*---RAM用データ---*/
    reg wea;
    reg [17:0] addra;
    always_ff @(posedge eth_rxck)begin
        if(st==Presv) begin
            if(rx_cnt==11'd41) wea <= 1'b1;
            //if(rx_cnt==11'd42) wea <= 1'b1;     // debug
            else if(rx_cnt==11'd1041) wea <= 1'b0;
        end
        else begin
            wea <= 1'b0;
        end
    end
    
    always_ff @(posedge eth_rxck)begin
        if(st==Presv) begin
            if(rx_cnt>11'd41&&rx_cnt<11'd1042) addra <= addra + 1'b1;
        end
        //else if(st==Idle&&packet_cnt==0) begin
        else if(st==Idle) begin             // add 2018.11.19
            //addra <= 11'b0;
            addra <= packet_cnt * 1000;     // add 2018.11.19
        end
    end
    
    /*---パケット数のカウント---*/
    always_ff @(posedge eth_rxck)begin
        if (rst_rx)                         packet_cnt <= 9'd0;
        else if (rst_btn||trans_err)        packet_cnt <= 9'd0;
        else if (st==Select)                packet_cnt <= packet_cnt + 9'b1;
        else if (st==Recv_End||st==ERROR)   packet_cnt <= 0;
    end
    
    /*---リセット信号---*/
    always_ff @(posedge eth_rxck)begin
        if (st==Idle)   rst <= 1;
        else            rst <= 0;
    end  
    
    /*---チェックサム計算失敗用---*/
    always_ff @(posedge eth_rxck)begin
        if(st==Hc_End)          err_cnt <= err_cnt + 3'b1;
        else if(st==Uc_End)     err_cnt <= err_cnt + 3'b1;
        else                    err_cnt <= 0;
    end 
    
    /*---チェックサム用データ---*/
    (*dont_touch="true"*)reg [7:0]       data;
    reg [1:0]             data_en;
    (*dont_touch="true"*)reg [15:0]      csum;
       
    always_ff @(posedge eth_rxck)begin         
        if(st==Idle)                csum_cnt <= 0;
        else if(st==Hcsum)begin
            if(csum_cnt==6'd22)     csum_cnt <= 0;
            else                    csum_cnt <= csum_cnt + 1;
        end
        else if(st==Ucsum)begin
            if(csum_cnt==10'd1022)  csum_cnt <= 0;
            else                    csum_cnt <= csum_cnt + 1;
        end
        else                        csum_cnt <= 0;
    end


//<-- moikawa add (2018.11.02)
    wire [10:0] rxbuf_sel = csum_cnt + eth_head;
    reg [7:0]  data_pipe [17:0]; // part of pipelined selector from TXBUF[].
    wire [4:0]  data_pipe_sel;

    wire [10:0] rxbuf_sel_v = csum_cnt;
    reg [7:0]  data_pipe_v [16:0]; // part of pipelined selector from TXBUF[].
    wire [4:0]  data_pipe_sel_v; 
//--> moikawa add (2018.11.02)

    
    always_ff @(posedge eth_rxck)begin    // 最初の14bitはMACヘッダ
        //if(st==Hcsum)       data <= RXBUF[csum_cnt+eth_head];
        if(st==Hcsum)       data <= data_pipe[ data_pipe_sel ];
        //else if(st==Ucsum)  data <= VBUF[csum_cnt];
        else if(st==Ucsum)  data <= data_pipe_v[ data_pipe_sel_v ];
        else                data <= 0;
    end

//<-- moikawa add (2018.11.02)
    reg [10:0] rxbuf_sel_d;
    integer    k;

    always_ff @(posedge eth_rxck) begin
        rxbuf_sel_d <= rxbuf_sel;
    end
    assign data_pipe_sel = (rxbuf_sel_d[10:6] < 5'd17)? 
                            rxbuf_sel_d[10:6] : 5'd17 ;

    always_ff @(posedge eth_rxck) begin // inserted pipelined stage.
        //for (k=0; k<64; k=k+1) begin
        //  data_pipe[k] <= TXBUF[ (64*k) + txbuf_sel[5:0] ];
        //end
        data_pipe[0]  <=  RXBUF[ rxbuf_sel[5:0]         ];
        data_pipe[1]  <=  RXBUF[ rxbuf_sel[5:0] + 64    ];
        data_pipe[2]  <=  RXBUF[ rxbuf_sel[5:0] + 128   ];
        data_pipe[3]  <=  RXBUF[ rxbuf_sel[5:0] + 192   ];
        data_pipe[4]  <=  RXBUF[ rxbuf_sel[5:0] + 256   ];
        data_pipe[5]  <=  RXBUF[ rxbuf_sel[5:0] + 320   ];
        data_pipe[6]  <=  RXBUF[ rxbuf_sel[5:0] + 384   ];
        data_pipe[7]  <=  RXBUF[ rxbuf_sel[5:0] + 448   ];
        data_pipe[8]  <=  RXBUF[ rxbuf_sel[5:0] + 512   ];
        data_pipe[9]  <=  RXBUF[ rxbuf_sel[5:0] + 576   ];
        data_pipe[10] <=  RXBUF[ rxbuf_sel[5:0] + 640   ];
        data_pipe[11] <=  RXBUF[ rxbuf_sel[5:0] + 704   ];
        data_pipe[12] <=  RXBUF[ rxbuf_sel[5:0] + 768   ];
        data_pipe[13] <=  RXBUF[ rxbuf_sel[5:0] + 832   ];
        data_pipe[14] <=  RXBUF[ rxbuf_sel[5:0] + 896   ];
        data_pipe[15] <=  RXBUF[ rxbuf_sel[5:0] + 960   ];
        if (rxbuf_sel[5:0] < 6'd22) begin
	       data_pipe[16] <=  RXBUF[ rxbuf_sel[5:0] + 1024  ];
        end else begin
	       data_pipe[16] <=  8'h00;
        end
        data_pipe[17] <= 8'h00;  // dummy value.
    end
//--> moikawa add (2018.11.02)

    /*---VBUF用data_pipe---*/
    reg [10:0] rxbuf_sel_v_d;

    always_ff @(posedge eth_rxck) begin
        rxbuf_sel_v_d <= rxbuf_sel_v;
    end
    assign data_pipe_sel_v = (rxbuf_sel_v_d[10:6] < 5'd17)? 
                              rxbuf_sel_v_d[10:6] : 5'd17 ;

    always_ff @(posedge eth_rxck) begin // inserted pipelined stage.
        data_pipe_v[0]  <=  VBUF[ rxbuf_sel_v[5:0]         ];
        data_pipe_v[1]  <=  VBUF[ rxbuf_sel_v[5:0] + 64    ];
        data_pipe_v[2]  <=  VBUF[ rxbuf_sel_v[5:0] + 128   ];
        data_pipe_v[3]  <=  VBUF[ rxbuf_sel_v[5:0] + 192   ];
        data_pipe_v[4]  <=  VBUF[ rxbuf_sel_v[5:0] + 256   ];
        data_pipe_v[5]  <=  VBUF[ rxbuf_sel_v[5:0] + 320   ];
        data_pipe_v[6]  <=  VBUF[ rxbuf_sel_v[5:0] + 384   ];
        data_pipe_v[7]  <=  VBUF[ rxbuf_sel_v[5:0] + 448   ];
        data_pipe_v[8]  <=  VBUF[ rxbuf_sel_v[5:0] + 512   ];
        data_pipe_v[9]  <=  VBUF[ rxbuf_sel_v[5:0] + 576   ];
        data_pipe_v[10] <=  VBUF[ rxbuf_sel_v[5:0] + 640   ];
        data_pipe_v[11] <=  VBUF[ rxbuf_sel_v[5:0] + 704   ];
        data_pipe_v[12] <=  VBUF[ rxbuf_sel_v[5:0] + 768   ];
        data_pipe_v[13] <=  VBUF[ rxbuf_sel_v[5:0] + 832   ];
        data_pipe_v[14] <=  VBUF[ rxbuf_sel_v[5:0] + 896   ];
        if(rxbuf_sel_v[5:0] < 6'd60)begin
            data_pipe_v[15] <=  VBUF[ rxbuf_sel_v[5:0] + 960   ];
        end else begin
	       data_pipe_v[15] <=  8'h00;
        end
        data_pipe_v[16] <= 8'h00;  // dummy value.
    end
    
    /*---チェックサム計算開始用---*/
    always_ff @(posedge eth_rxck)begin
        if(st==Hcsum)begin
            if(csum_cnt!=6'd22) data_en <= {data_en[0],1'b1};
            else                data_en <= 0;
        end
        else if(st==Ucsum)begin
            if(csum_cnt!=(5'd22+MsgSize))
                                data_en <= {data_en[0],1'b1};
            else                data_en <= 0;
        end
        else if(st==Idle)       data_en <= 0;
        else                    data_en <= 0;
    end
        
    /*---Checksum OK---*/
    always_ff @(posedge eth_rxck)begin
        if(st==Hc_End)begin
            if(csum==16'h00_00) csum_ok <= 1;
            else                csum_ok <= 0;
        end
        else if(st==Uc_End)begin
            if(csum==16'h00_00) csum_ok <= 1;
            else                csum_ok <= 0;
        end
        else                    csum_ok <= 0;
    end
    
    /*---仮想ヘッダ準備---*/
    integer v_cnt;
    always_ff @(posedge eth_rxck)begin
        if(st==Hc_End)begin
            {VBUF[0],VBUF[1],VBUF[2],VBUF[3]} <= {RXBUF[26],RXBUF[27],RXBUF[28],RXBUF[29]};
            //{VBUF[4],VBUF[5],VBUF[6],VBUF[7]} <= `my_IP;
            {VBUF[4],VBUF[5],VBUF[6],VBUF[7]} <= {RXBUF[30],RXBUF[31],RXBUF[32],RXBUF[33]};        // add 2018.12.5
            {VBUF[8],VBUF[9]} <= 16'h00_11;
            {VBUF[10],VBUF[11]} <= MsgSize+4'd8;
            {VBUF[12],VBUF[13]} <= {RXBUF[34],RXBUF[35]};
            {VBUF[14],VBUF[15]} <= {RXBUF[36],RXBUF[37]};
            {VBUF[16],VBUF[17]} <= MsgSize+4'd8;
            {VBUF[18],VBUF[19]} <= {RXBUF[40],RXBUF[41]};
            for(v_cnt=0;v_cnt<10'd1000;v_cnt=v_cnt+1)
                VBUF[20+v_cnt]  <= RXBUF[42+v_cnt];
        end
        else if(st==Idle)begin
            for(v_cnt=0;v_cnt<10'd1020;v_cnt=v_cnt+1) VBUF[v_cnt] <= 8'b0;
            v_cnt <= 0;
        end
    end
    
    /*---終了---*/
    always_ff @(posedge eth_rxck)begin
        if (st==Recv_End) end_cnt <= end_cnt + 1;
        else              end_cnt <= 0;
    end
    
    always_ff @(posedge eth_rxck)begin
        if (st==Recv_End) recvend <= 1;
        else              recvend <= 0;
    end
    
    checksum recv_checksum(
        .clk_i(eth_rxck),
        .d(data),
        .data_en(data_en[1]),
        .csum_o(csum),
        .rst(rst)
    );
    /*
    wire [17:0] addr_r = addrb + (addr_cnt * 1000);
    */
    reg [17:0] addr_r;
    always_ff @(posedge eth_rxck)begin
        addr_r <= addrb + (addr_cnt * 1000);
    end
    
    /*---BlockRAM Generator---*/
    image_RAM image_RAM(
        .clka(eth_rxck),
        //.ena(1'b1),     // PortA  enable
        .wea(wea),      // write enable
        .addra(addra),  // write address
        .dina(rxd),     // write data
        .clkb(eth_rxck),
        //.enb(1'b1),     // PortB enable
        .addrb(addr_r),       // read address
        .doutb(imdata)  // read data
    );
    
    
endmodule
