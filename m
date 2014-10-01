From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed,  1 Oct 2014 12:05:30 +0200
Subject: [PATCH 1/2] ARM: i.MX53: add IPU CSI port nodes
Message-ID: <1412157931-32752-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lucas Stach <l.stach@pengutronix.de>

Add the IPU CSI port nodes to the dtsi.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 5a6ee68e654b..76948d79f707 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -134,6 +134,14 @@
 			         <&clks IMX5_CLK_IPU_DI1_GATE>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 2>;
+			
+			ipu_csi0: port at 0 {
+				reg = <0>;
+			};
+
+			ipu_csi1: port at 1 {
+				reg = <1>;
+			};
 
 			ipu_di0: port at 2 {
 				#address-cells = <1>;
-- 
2.1.0
