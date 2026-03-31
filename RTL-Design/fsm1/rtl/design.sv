// ============================================================
// Overlapping Sequence Detector for 1011
// ============================================================
// Detect pattern "1011" on serial input in (1 bit/cycle).
// Overlapping means the FSM must fall back to the longest suffix that is also a prefix,
// not always to IDLE, after partial or full matches.
//
// TODO: Choose FSM type and document:
// - Mealy: detect can pulse on a transition (state+input).
// - Moore: detect asserted in a dedicated DETECT state (often 1-cycle).
//
// TODO: Clarify pulse vs level for detect.
// TODO: Choose reset type (sync/async) and document it.

module seq_det_1011 #(
   parameter bit MEALY = 1  // TODO: 1=Mealy, 0=Moore
  ) (
    input  logic clk,
    input  logic rst_n,
    input  logic in,
    output logic detect
  );

  always_comb begin
     state_d = state_q;  
    unique case (state_q)
      ST_IDLE  : state_d = (in) ? S1   : ST_IDLE;
      S1       : state_d = (in) ? S1   : S10;
      S10      : state_d = (in) ? S101 : ST_IDLE;
      S101     : state_d = (in) ? S1011: S10;
      S1011    : state_d = (in) ? S1   : S10;
      default  : state_d = ST_IDLE;
    endcase
  end
  
  typedef enum logic [2:0] {
      ST_IDLE,
      S1,
      S10,
      S101,
      S1011
  } state_t;

  state_t state_q, state_d;
    // State register
  always_ff @(posedge clk or negedge rst_n) begin
      if (!rst_n)
        state_q <= ST_IDLE;
      else
        state_q <= state_d;
  end

    // Output logic
  assign detect = (MEALY) ?
                  ((state_q == S101) && in) :  // Mealy pulse
                  (state_q == S1011);          // Moore pulse

  endmodule