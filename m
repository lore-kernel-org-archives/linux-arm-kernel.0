From: ruchika.gupta@freescale.com (Ruchika Gupta)
Date: Tue, 14 Jul 2015 09:43:15 +0530
Subject: [PATCH][v2] ARM: ls1021a: dtsi: Add crypto node alias in device tree
Message-ID: <1436847195-12523-1-git-send-email-ruchika.gupta@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

U-boot patches up the device tree crypto node for the era property.

Signed-off-by: Ruchika Gupta <ruchika.gupta@freescale.com>
---
Changes from v1:
Rearranged the crypto node in alphabetic sorted order as suggested by Shawn 

 arch/arm/boot/dts/ls1021a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..42dffae 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -53,6 +53,7 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		crypto = &crypto;
 		serial0 = &lpuart0;
 		serial1 = &lpuart1;
 		serial2 = &lpuart2;
-- 
1.8.1.4
