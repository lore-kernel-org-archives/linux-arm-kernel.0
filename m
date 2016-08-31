From: jorik@kippendief.biz (jorik at kippendief.biz)
Date: Wed, 31 Aug 2016 15:54:00 +0200
Subject: [PATCH 1/7] dts: sun8i-h3: add pinmux definitions for uart2/uart3
In-Reply-To: <1472651646-15579-1-git-send-email-jorik@kippendief.biz>
References: <1472651646-15579-1-git-send-email-jorik@kippendief.biz>
Message-ID: <1472651646-15579-2-git-send-email-jorik@kippendief.biz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jorik Jonker <jorik@kippendief.biz>

This adds pinmux definitions for uarts 2 and 3 on H3 boards

Signed-off-by: Jorik Jonker <jorik@kippendief.biz>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index fdf9fdb..7740748 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -373,6 +373,20 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			uart2_pins_a: uart2 at 0 {
+				allwinner,pins = "PA0", "PA1";
+				allwinner,function = "uart2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			uart3_pins_a: uart3 at 0 {
+				allwinner,pins = "PA13", "PA14";
+				allwinner,function = "uart3";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.7.4
