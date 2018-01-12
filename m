From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Fri, 12 Jan 2018 16:22:52 +0200
Subject: [PATCH v2 05/16] ARM: dts: clps711x: update pwm-cells
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1515766983-15151-6-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update pwm-cells to 2 to allow initialization of channel number an period.

Cc: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/ep7209.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ep7209.dtsi b/arch/arm/boot/dts/ep7209.dtsi
index aaf1261d2ee4..fdfe6ab31569 100644
--- a/arch/arm/boot/dts/ep7209.dtsi
+++ b/arch/arm/boot/dts/ep7209.dtsi
@@ -133,7 +133,7 @@
 			compatible = "cirrus,ep7209-pwm";
 			reg = <0x80000400 0x4>;
 			clocks = <&clks CLPS711X_CLK_PWM>;
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 		};
 
 		uart1: uart at 80000480 {
-- 
2.7.4
