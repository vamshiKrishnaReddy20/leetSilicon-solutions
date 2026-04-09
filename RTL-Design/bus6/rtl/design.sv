// ============================================================
// Read-only AXI-Lite peripheral.
module axi_read_only_status #(
  parameter VERSION = 32'h0000_0001
) (
  input  logic        ACLK,
  input  logic        ARESETn,
  input  logic [31:0] status_in,
  input  logic        AWVALID,
  output logic        AWREADY,
  input  logic [31:0] AWADDR,
  input  logic        WVALID,
  output logic        WREADY,
  input  logic [31:0] WDATA,
  input  logic [3:0]  WSTRB,
  output logic        BVALID,
  input  logic        BREADY,
  output logic [1:0]  BRESP,
  input  logic        ARVALID,
  output logic        ARREADY,
  input  logic [31:0] ARADDR,
  output logic        RVALID,
  input  logic        RREADY,
  output logic [31:0] RDATA,
  output logic [1:0]  RRESP
);

  
  assign AWREADY = 1'b1; 
  assign WREADY  = 1'b1;
  assign BRESP   = 2'b10; // SLVERR (Slave Error)

  always_ff @(posedge ACLK or negedge ARESETn) begin
      if (!ARESETn) begin
          BVALID <= 1'b0;
      end else begin
          // Signal BVALID when a write is attempted
          if (AWVALID && WVALID && !BVALID) begin
              BVALID <= 1'b1;
          end else if (BREADY && BVALID) begin
              BVALID <= 1'b0;
          end
      end
  end

    // --- Read Logic ---
  assign ARREADY = !RVALID; // Ready for new address if not holding a response
  assign RRESP   = 2'b00;   // OKAY response for reads

  always_ff @(posedge ACLK or negedge ARESETn) begin
      if (!ARESETn) begin
          RVALID <= 1'b0;
          RDATA  <= 32'h0;
      end else begin
          if (ARVALID && ARREADY) begin
              RVALID <= 1'b1;
              // Address Decoding
              case (ARADDR[3:0])
                  4'h0:    RDATA <= VERSION;
                  4'h4:    RDATA <= status_in;
                  default: RDATA <= 32'h0; // Or handle as SLVERR
              endcase
          end else if (RREADY && RVALID) begin
              RVALID <= 1'b0;
          end
      end
  end

endmodule
