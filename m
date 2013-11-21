From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 21 Nov 2013 20:43:13 -0200
Subject: [PATCH] ARM: dts: imx6sabre: Pass reg property in lvds
Message-ID: <1385073793-8543-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The 'reg' property is missing in the lvds nodes, so add them for correctness.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts  | 1 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index ec9e4c1..ab81576 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -169,6 +169,7 @@
 	status = "okay";
 
 	lvds-channel at 0 {
+		reg = <0>;
 		fsl,data-mapping = "spwg";
 		fsl,data-width = <18>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 4239ef9..115bf44 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -236,6 +236,7 @@
 	status = "okay";
 
 	lvds-channel at 1 {
+		reg = <1>;
 		fsl,data-mapping = "spwg";
 		fsl,data-width = <18>;
 		status = "okay";
-- 
1.8.1.2
