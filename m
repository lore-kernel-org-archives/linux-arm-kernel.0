From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri,  2 Oct 2015 18:31:15 +0000
Subject: [PATCH] ARM: bcm2835: add label for uart0
Message-ID: <1443810675-25558-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a label for uart0 to allow changing of uart0 pins.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 301c73f..2029394 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -92,7 +92,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		uart at 7e201000 {
+		uart0: uart at 7e201000 {
 			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
 			reg = <0x7e201000 0x1000>;
 			interrupts = <2 25>;
-- 
1.7.9.5
