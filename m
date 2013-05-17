From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Fri, 17 May 2013 07:13:41 +0200
Subject: [PATCH] ARM: dts: apf28dev: Add touchscreen support for APF28dev
Message-ID: <1368767622-12968-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx28-apf28dev.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 3d905d1..b602494 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -103,6 +103,7 @@
 
 		apbx at 80040000 {
 			lradc at 80050000 {
+				fsl,lradc-touchscreen-wires = <4>;
 				status = "okay";
 			};
 
-- 
1.8.1.5
