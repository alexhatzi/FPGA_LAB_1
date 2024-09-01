

module top (
      input clk
    , input but1
    , input but2
    , output logic [7:0] cathode
    , output logic [3:0] anode 
    , output logic debugBUT_LED
    , output logic debugDISP_LED
) ;


    typedef enum logic [1:0] {FIRST_DIGIT, SECOND_DIGIT} state_t ;
    state_t STATE ; 
     
  logic but_clk                 ; 
  logic display_clk             ; 
  logic digit_clk               ;
  logic [3:0] btn_cnt [1:0]     ;    
  logic [7:0] cathode_trk [1:0] ;


clk_divider #(.CLK_COUNT(12500000))  // 4 Hz (100 MHz / (4*2) )
    u_button_clock
    (    .clk       (clk    )
    ,    .sample_clk(but_clk)
    ) ; 


clk_divider #(.CLK_COUNT(200000)) //  250 Hz (100 MHz / (250*2))
    u_display_clk
    (    .clk       (    clk    )
    ,    .sample_clk(display_clk)
    ) ; 
    
    


buttoncount u_buttoncount
    (
        .sample_clk  ( but_clk  )
    ,   .but1        ( but1     )
    ,   .but2        ( but2     )
    ,   .but1counter (btn_cnt[0])
    ,   .but2counter (btn_cnt[1])
    ) ; 




    seg_decoder u_segdecoder_1
    ( .clk      ( clk           ) 
    , .butcnt   ( btn_cnt[0]    )
    , .cathode  ( cathode_trk[0])
    );

    seg_decoder u_segdecoder_2
    ( .clk      ( clk           ) 
    , .butcnt   ( btn_cnt[1]    )
    , .cathode  ( cathode_trk[1])
    );


always@(posedge display_clk) begin

    case (STATE) 
    FIRST_DIGIT : begin
        cathode [7:0] = cathode_trk[0]  ;
        anode   [1:0] = 2'b01         ; 
        STATE         =   SECOND_DIGIT  ;
    end
    SECOND_DIGIT : begin
        anode   [1:0] = 2'b10         ; 
        cathode [7:0] = cathode_trk[1]  ;
        STATE         =   FIRST_DIGIT   ;
    end
    default : STATE = FIRST_DIGIT ; 
   endcase

end

    assign anode [3:2] = '1 ; 


    always@(posedge but_clk)
    debugBUT_LED = ~debugDISP_LED ; 
    
    always@(posedge display_clk)
    debugDISP_LED = ~debugDISP_LED ; 





endmodule 