// ============================================================
// ID: arith1 — Parameterizable Adder/Subtractor (two's complement)
// ============================================================
// Subtraction via two's complement: A - B = A + (~B) + 1.
// Signed overflow rule (add): when adding same-sign operands yields opposite-sign result.
//
// TODO: Document flag meanings for subtraction:
// - carry_out from adder is often interpreted as "no borrow" for unsigned subtract,
//   and borrow = ~carry_out (if using A + ~B + 1 form).
//
// TODO: Decide whether overflow flag applies to:
// - signed interpretation only (typical), or
// - also provide separate unsigned overflow/underflow flags.

module adder_sub #(
  parameter int unsigned WIDTH = 32
) (
  input  logic [WIDTH-1:0] a,
  input  logic [WIDTH-1:0] b,
  input  logic             sub,
  output logic [WIDTH-1:0] result,
  output logic             carry_out,
  output logic             overflow
);

  logic [WIDTH-1:0] b_eff;
  logic             carry_in;
  logic             a_sign, b_eff_sign, res_sign;

  assign b_eff    = sub ? ~b : b;
  assign carry_in = sub ? 1'b1 : 1'b0;

  assign {carry_out, result} = a + b_eff + carry_in;

  // Signed Overflow Logic
  assign a_sign     = a[WIDTH-1];
  assign b_eff_sign = b_eff[WIDTH-1];
  assign res_sign   = result[WIDTH-1];

  always_comb begin
    overflow = (a_sign == b_eff_sign) && (a_sign != res_sign);
  end

endmodule


