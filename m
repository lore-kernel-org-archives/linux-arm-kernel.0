From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 22 May 2014 14:45:05 -0300
Subject: [PATCH] ARM: dts: imx51-babbage: Add PMIC RTC support
Message-ID: <1400780705-19305-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx51-babbage.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 6bc3243..ee51a10 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -203,6 +203,7 @@
 		reg = <0>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		fsl,mc13xxx-uses-rtc;
 
 		regulators {
 			sw1_reg: sw1 {
-- 
1.8.3.2
