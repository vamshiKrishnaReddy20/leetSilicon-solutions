// ============================================================
// ID: rtl2 — 1-Cycle High Pulse Detector (0->1->0)
// ============================================================
// Goal: detect exactly-one-cycle high pulse using 2-cycle history. 

module one_cycle_pulse (
    input  logic clk,
    input  logic rst_n,
    input  logic sig_in,
    output logic onecycle_pulse
);

  logic d1, d2;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      d1 <= 1'b0;
      d2 <= 1'b0;
      onecycle_pulse <= 1'b0;
    end else begin
        d1 <= sig_in;
        d2 <= d1;
        onecycle_pulse <= (sig_in == 1'b0) && (d1 == 1'b1) && (d2 == 1'b0);
    end
  end

endmodule
