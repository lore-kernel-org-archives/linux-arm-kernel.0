From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  8 Mar 2016 09:03:58 +0100
Subject: [PATCHv2 2/8] ARM: dts: imx6-tx6: cleanup; no functional change
In-Reply-To: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
References: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1457424244-14549-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an empty line between properties and subnode in the clocks node.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index 5d348d9..912f284 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -67,6 +67,7 @@
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <0>;
+
 		mclk: clock at 0 {
 			compatible = "fixed-clock";
 			reg = <0>;
-- 
2.1.4
