From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  2 Jun 2016 15:50:10 +0800
Subject: [PATCH 2/3] ARM: dts: sun8i-h3: Add uart1 pinmux setting
In-Reply-To: <1464853811-15233-1-git-send-email-wens@csie.org>
References: <1464853811-15233-1-git-send-email-wens@csie.org>
Message-ID: <1464853811-15233-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add uart1 pins for 4 pin (RX/TX/RTS/CTS) mode.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 52558046dbaf..3c37f7e2b079 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -540,6 +540,13 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			uart1_pins_a: uart1 at 0 {
+				allwinner,pins = "PG6", "PG7", "PG8", "PG9";
+				allwinner,function = "uart1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		ahb_rst: reset at 01c202c0 {
-- 
2.8.1
