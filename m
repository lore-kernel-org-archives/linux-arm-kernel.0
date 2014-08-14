From: zonque@gmail.com (Daniel Mack)
Date: Thu, 14 Aug 2014 11:46:12 +0200
Subject: [PATCH 1/2] ARM: pxa: dts: fix mmc controller compatible string
Message-ID: <1408009573-24523-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vendor prefix was renamed from "mrvl" to "marvell". Follow this
change in the dts file.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index febd391..f188f8c 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -128,7 +128,7 @@
 		};
 
 		mmc0: mmc at 41100000 {
-			compatible = "mrvl,pxa-mmc";
+			compatible = "marvell,pxa-mmc";
 			reg = <0x41100000 0x1000>;
 			interrupts = <23>;
 			dmas = <&dma 21
-- 
2.0.4
