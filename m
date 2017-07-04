From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 4 Jul 2017 12:59:21 -0300
Subject: [PATCH] ARM: dts: imx6qdl-icore-rqs: Remove unneeded 'fsl,
 mode' property
Message-ID: <1499183961-10237-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx6qdl-icore-rqs boards use sgtl5000 codec and the machine
file (imx-sgtl5000) already sets SSI in slave mode and codec in
master mode, so there is no need for having this property.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 5fab5be..7ca291e 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -184,7 +184,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
-- 
2.7.4
