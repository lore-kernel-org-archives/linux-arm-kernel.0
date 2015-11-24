From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 24 Nov 2015 14:47:42 +0100
Subject: [PATCH 3/3] ARM: dts: at91: specify DT property "atmel,
 twd-hold-cycles"
In-Reply-To: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
References: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1448372862-11912-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wenyou Yang <wenyou.yang@atmel.com>

Specify the device tree property "atmel,twd-hold-cycles" to 25
to adapt to the PMIC ACT8945A.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index ad6de73..25ffd86 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -129,6 +129,7 @@
 				dmas = <0>, <0>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c0_default>;
+				atmel,twd-hold-cycles = <25>;
 				status = "okay";
 
 				pmic: act8865 at 5b {
-- 
2.5.0
