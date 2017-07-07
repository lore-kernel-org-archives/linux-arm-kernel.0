From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri,  7 Jul 2017 14:03:16 -0500
Subject: [PATCHv1 1/4] ARM: dts: socfpga: update documentation for clock
 bindings
Message-ID: <1499454199-31901-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the bindings document for the Arria10 and Stratix10 clock bindings.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 Documentation/devicetree/bindings/clock/altr_socfpga.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/altr_socfpga.txt b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
index f72e80e..1c32658 100644
--- a/Documentation/devicetree/bindings/clock/altr_socfpga.txt
+++ b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
@@ -12,6 +12,20 @@ Required properties:
 	"altr,socfpga-gate-clk" - Clocks that directly feed peripherals and
 		can get gated.
 
+	For Arria10:
+	"altr,socfpga-a10-pll-clock" - for a PLL clock
+	"altr,socfpga-a10-perip-clock" - The peripheral clock divided from the
+		PLL clock.
+	"altr,socfpga-a10-gate-clk" - Clocks that directly feed peripherals and
+		can get gated.
+
+	For Stratix10:
+	"altr,socfpga-s10-pll-clock" - for a PLL clock
+	"altr,socfpga-s10-perip-clock" - The peripheral clock divided from the
+		PLL clock.
+	"altr,socfpga-s10-gate-clk" - Clocks that directly feed peripherals and
+		can get gated.
+
 - reg : shall be the control register offset from CLOCK_MANAGER's base for the clock.
 - clocks : shall be the input parent clock phandle for the clock. This is
 	either an oscillator or a pll output.
-- 
2.7.4
