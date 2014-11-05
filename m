From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  5 Nov 2014 10:12:51 -0200
Subject: [PATCH] ARM: dts: imx6q-tbs2910: Remove unneeded 'fsl,mode' property
Message-ID: <1415189571-24035-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx6q-tbs2910 board uses sgtl5000 codec and the machine file (imx-sgtl5000)
already sets SSI in slave mode and codec in master mode, so there is no need
for having this property.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-tbs2910.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index d2a5743..f7427bf 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -215,7 +215,6 @@
 };
 
 &ssi1 {
-	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
-- 
1.9.1
