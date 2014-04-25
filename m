From: jhovold@gmail.com (Johan Hovold)
Date: Fri, 25 Apr 2014 15:36:26 +0200
Subject: [PATCH] ARM: dts: am335x-boneblack: remove use of ti,
 vcc-aux-disable-is-sleep
Message-ID: <1398432986-30585-1-git-send-email-jhovold@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove use of property ti,vcc-aux-disable-is-sleep, which does not
exist.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 6b71ad95a5cf..305975d3f531 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -26,7 +26,6 @@
 	pinctrl-0 = <&emmc_pins>;
 	bus-width = <8>;
 	status = "okay";
-	ti,vcc-aux-disable-is-sleep;
 };
 
 &am33xx_pinmux {
-- 
1.8.3.2
