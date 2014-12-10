From: Ying.Liu@freescale.com (Liu Ying)
Date: Wed, 10 Dec 2014 16:37:19 +0800
Subject: [PATCH RFC 06/15] ARM: dts: imx6q: Add MIPI DSI remote end points for
 IPU2 DI0/1 end points
In-Reply-To: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
References: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <1418200648-32656-7-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds MIPI DSI remote end points for IPU2 DI0/1 end points.

Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e6a6d90..82507e7 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -185,6 +185,7 @@
 				};
 
 				ipu2_di0_mipi: endpoint at 2 {
+					remote-endpoint = <&mipi_mux_2>;
 				};
 
 				ipu2_di0_lvds0: endpoint at 3 {
@@ -206,6 +207,7 @@
 				};
 
 				ipu2_di1_mipi: endpoint at 2 {
+					remote-endpoint = <&mipi_mux_3>;
 				};
 
 				ipu2_di1_lvds0: endpoint at 3 {
-- 
2.1.0
