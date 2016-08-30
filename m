From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Aug 2016 14:12:33 +0200
Subject: [PATCH 1/4] ARM: dts: set the 24MHz xtal as parent of the UART clock
Message-ID: <1472559156-32148-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has no practical effect but reflects the actual clock
hierarchy of the system.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorap.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 4b34b54e09a1..c1e3abf5d072 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -39,6 +39,7 @@
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <14745600>;
+		clocks = <&xtal24mhz>;
 	};
 
 	syscon {
-- 
2.7.4
