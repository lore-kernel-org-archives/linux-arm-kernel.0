From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue,  1 Apr 2014 18:38:13 +0200
Subject: [PATCH] ARM: AM335X: EVM: fix pinmux documentation in devicetree
Message-ID: <1396370358-778-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wrong documentation in pinmux description can be especially confusing.
Keep it proper.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/arm/boot/dts/am335x-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 7e6c64ed966d..fb5dc92692cf 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -295,8 +295,8 @@
 
 	am335x_evm_audio_pins: am335x_evm_audio_pins {
 		pinctrl-single,pins = <
-			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rx_dv.mcasp1_aclkx */
-			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_txd3.mcasp1_fsx */
+			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
 			0x108 (PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
 			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
 		>;
-- 
1.9.0
