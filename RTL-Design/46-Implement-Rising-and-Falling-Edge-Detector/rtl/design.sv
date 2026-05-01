// ============================================================
// ID: misc1 — Rising/Falling Edge Detector (single-cycle pulses)
// ============================================================
// Standard approach: register previous sample and compare:
// rise when (sig_in==1 && sig_prev==0), fall when (sig_in==0 && sig_prev==1).
//
// TODO: If sig_in is asynchronous, add a 2-FF synchronizer before edge detect to reduce metastability risk.

module edge_detector #(
  parameter bit RESET_PREV = 1'b0
) (
  input  logic clk,
  input  logic rst_n,
  input  logic sig_in,
  output logic rise_pulse,
  output logic fall_pulse
);

  logic sig_d1;
  logic sig_d2;
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      sig_d1 <= RESET_PREV;
      sig_d2 <= RESET_PREV;
    end else begin
      sig_d1 <= sig_in;
      sig_d2 <= sig_d1;
    end
  end
  
  assign rise_pulse =  sig_d1 & ~sig_d2;
  assign fall_pulse = ~sig_d1 &  sig_d2;
endmodule


