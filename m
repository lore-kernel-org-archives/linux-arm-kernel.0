From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 17 Jan 2016 12:15:28 +0000
Subject: [PATCH V3 1/4] ARM: bcm2835: follow dt uart node-naming convention
In-Reply-To: <1453032932-2512-1-git-send-email-kernel@martin.sperl.org>
References: <1453032932-2512-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1453032932-2512-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

This patch fixes the naming of the device tree node: uart at 7e201000
to conform to the standard of: serial at 7e201000

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm2835.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index aef64de..b37a088 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -108,7 +108,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		uart0: uart at 7e201000 {
+		uart0: serial at 7e201000 {
 			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
 			reg = <0x7e201000 0x1000>;
 			interrupts = <2 25>;
-- 
1.7.10.4
