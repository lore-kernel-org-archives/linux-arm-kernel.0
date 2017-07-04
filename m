From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue,  4 Jul 2017 17:34:22 +0800
Subject: [PATCH] ARM: dts: lpc18xx: remove num-slots from lpc18xx
Message-ID: <1499160862-87345-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dwmmc driver deprecated num-slots and plan to get rid
of it finally. Just move a step to cleanup it from DT.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm/boot/dts/lpc18xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 7cae9c5..10b8249 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -115,7 +115,6 @@
 			compatible = "snps,dw-mshc";
 			reg = <0x40004000 0x1000>;
 			interrupts = <6>;
-			num-slots = <1>;
 			clocks = <&ccu2 CLK_SDIO>, <&ccu1 CLK_CPU_SDIO>;
 			clock-names = "ciu", "biu";
 			resets = <&rgu 20>;
-- 
1.9.1
