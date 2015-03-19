From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 18 Mar 2015 17:31:31 -0700
Subject: [PATCH 1/2] ARM: dts: brcmstb: un-hexify clock frequency
Message-ID: <1426725092-16392-1-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This value makes much more sense in decimal.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 arch/arm/boot/dts/bcm7445.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
index 0ca0f4e523d0..b183dc99111a 100644
--- a/arch/arm/boot/dts/bcm7445.dtsi
+++ b/arch/arm/boot/dts/bcm7445.dtsi
@@ -76,7 +76,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clock-frequency = <0x4d3f640>;
+			clock-frequency = <81000000>;
 		};
 
 		sun_top_ctrl: syscon at 404000 {
-- 
1.9.1
