module apb_ram (
    input  wire        pclk,
    input  wire        presetn,
    input  wire [31:0] paddr,
    input  wire [31:0] pwdata,
    input  wire        psel,
    input  wire        penable,
    input  wire        pwrite,
    output reg  [31:0] prdata,
    output reg         pready,
    output reg         pslverr
);

    // 32 x 32-bit memory
    reg [31:0] mem [0:31];

    // state machine
    typedef enum logic [1:0] {IDLE=2'b00, SETUP=2'b01, ACCESS=2'b10} state_t;
    state_t state, nstate;

    // word address (ignore lower 2 bits since word aligned)
    wire [4:0] word_addr = paddr[6:2];

    // FSM: sequential
    always @(posedge pclk or negedge presetn) begin
        if (!presetn) begin
            state   <= IDLE;
            pready  <= 1'b0;
            prdata  <= 32'b0;
            pslverr <= 1'b0;
        end else begin
            state <= nstate;
        end
    end

    // FSM: combinational
    always @(*) begin
        // defaults
        nstate  = state;
        pready  = 1'b0;
        pslverr = 1'b0;

        case (state)
            IDLE: begin
                if (psel && !penable) 
                    nstate = SETUP;
            end

            SETUP: begin
                if (psel && !penable) begin
                    // address check
                    if (word_addr < 32)
                        nstate = ACCESS;
                    else begin
                        nstate  = IDLE;
                        pslverr = 1'b1;
                    end
                end
            end

            ACCESS: begin
                if (psel && penable) begin
                    if (word_addr < 32) begin
                        if (pwrite) begin
                            mem[word_addr] = pwdata;  // write
                        end else begin
                            prdata = mem[word_addr];  // read
                        end
                        pready  = 1'b1;
                        nstate  = IDLE;
                    end else begin
                        pslverr = 1'b1;
                        pready  = 1'b1;
                        nstate  = IDLE;
                    end
                end
            end
        endcase
    end

endmodule

interface apb;
    logic pclk;
    logic presetn;
    logic [31:0] paddr;
    logic [31:0] pwdata;
    logic psel;
    logic penable;
    logic pwrite;
    logic [31:0]prdata;
    logic pready;
endinterface