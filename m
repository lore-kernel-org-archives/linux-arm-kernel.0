From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  8 Aug 2013 14:51:22 +0200
Subject: [PATCH 3/8] ARM: dts: mxs: add another set of saif0_pins (without
 MCLK)
In-Reply-To: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
References: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1375966287-6784-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28.dtsi |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 546fd7a..7d7f277 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -518,6 +518,18 @@
 					fsl,pull-up = <1>;
 				};
 
+				saif0_pins_b: saif0 at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						0x3150 /* MX28_PAD_SAIF0_LRCLK__SAIF0_LRCLK */
+						0x3160 /* MX28_PAD_SAIF0_BITCLK__SAIF0_BITCLK */
+						0x3170 /* MX28_PAD_SAIF0_SDATA0__SAIF0_SDATA0 */
+					>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
 				saif1_pins_a: saif1 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.2.5
