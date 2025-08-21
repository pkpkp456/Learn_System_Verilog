class transaction;
    rand bit [31:0] paddr;
    rand bit [31:0] pwdata;
    rand bit op;
    bit psel;
    bit[31:0] prdata;
    bit penable;
    bit pready;
    bit slverr;
    constraint rd_wr {
        op dist {1:/50,0:/50};
    }
    function transaction copy();
        copy = new();
        copy.paddr=this.paddr;
        copy.pwdata=this.pwdata;
        copy.op=this.op;
        copy.psel=this.psel;
        copy.penable=this.penable;
        copy.prdata=this.prdata;
        copy.pready=this.pready;
        copy.slverr=this.slverr;
        return copy;
    endfunction
    function new();
        this.paddr   = 32'h0;
        this.pwdata  = 32'h0;
        this.op      = 0;
        this.psel    = 0;
        this.penable = 0;
        this.prdata  = 32'h0;
        this.pready  = 0;
        this.slverr  = 0;
    endfunction
    function void display(string str,string str2);
        $display("[%s]|[%s]|paddr: %h, pwdata: %h, op: %b, psel: %b, penable: %b, prdata: %h, pready: %b, slverr: %b",str,str2,
                 paddr, pwdata, op, psel, penable, prdata, pready, slverr);
    endfunction
endclass
class generator;
    transaction tr;
    mailbox #(transaction) mbgd;
    event drvdone;
    event scodone;
    event done;
    int count=0;
    function new(mailbox #(transaction) mbgd);
        this.mbgd=mbgd;
    endfunction
    task run();
        tr=new();
        repeat(count) begin
            assert(tr.randomize()) else $fatal("Transaction randomization failed");
            mbgd.put(tr.copy());
            tr.display("GEN", "DONE");
            @drvdone;
            @scodone;
        end
        ->done;
    endtask
endclass
class driver;
    mailbox #(transaction) mbgd;
    transaction tr;
    event drvdone;
    virtual apb apb_if;   // APB interface handle

    // Constructor
    function new(mailbox #(transaction) mbgd, virtual apb apb_if);
        this.mbgd   = mbgd;
        this.apb_if = apb_if;
    endfunction

    // -----------------------
    // Write operation
    // -----------------------
    task write();
        // Setup phase
        apb_if.psel    <= 1;
        apb_if.penable <= 0;
        apb_if.pwrite  <= 1;
        apb_if.paddr   <= tr.paddr;
        apb_if.pwdata  <= tr.pwdata;
        @(posedge apb_if.pclk);

        // Access phase
        apb_if.penable <= 1;
        @(posedge apb_if.pclk);

        // Wait until ready
        wait(apb_if.pready);
        tr.slverr = apb_if.pslverr;

        tr.display("DRV", "WRITE");

        // De-assert
        apb_if.psel    <= 0;
        apb_if.penable <= 0;
        apb_if.pwrite  <= 0;
    endtask

    // -----------------------
    // Read operation
    // -----------------------
    task read();
        // Setup phase
        apb_if.psel    <= 1;
        apb_if.penable <= 0;
        apb_if.pwrite  <= 0;
        apb_if.paddr   <= tr.paddr;
        @(posedge apb_if.pclk);

        // Access phase
        apb_if.penable <= 1;
        @(posedge apb_if.pclk);

        // Wait until ready
        wait(apb_if.pready);
        tr.prdata = apb_if.prdata; // ✅ sample slave data
        tr.slverr = apb_if.pslverr;

        tr.display("DRV", "READ");

        // De-assert
        apb_if.psel    <= 0;
        apb_if.penable <= 0;
    endtask

    // -----------------------
    // Reset task
    // -----------------------
    task reset();
        apb_if.psel    <= 0;
        apb_if.penable <= 0;
        apb_if.pwrite  <= 0;
        apb_if.paddr   <= '0;
        apb_if.pwdata  <= '0;
        tr.display("DRV", "RESET");
    endtask

    // -----------------------
    // Run forever
    // -----------------------
    task run();
        forever begin
            mbgd.get(tr);
            if (!apb_if.presetn) begin
                reset();
            end else begin
                if (tr.op == 1)
                    write();
                else
                    read();
            end
            ->drvdone;
        end
    endtask
endclass
