From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 26 Jan 2013 15:36:55 +0100
Subject: [PATCH 5/5] ARM: sunxi: Add the pin groups for UART0 and UART1 on
 sun4i
In-Reply-To: <1359211016-24097-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1359211016-24097-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1359211016-24097-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 73e0dd5..f99f60d 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -23,6 +23,27 @@
 			reg = <0x01c20800 0x400>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			uart0_pins_a: uart0 at 0 {
+				allwinner,pins = "PB22", "PB23";
+				allwinner,function = "uart0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			uart0_pins_b: uart0 at 1 {
+				allwinner,pins = "PF2", "PF4";
+				allwinner,function = "uart0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			uart1_pins_a: uart1 at 0 {
+				allwinner,pins = "PA10", "PA11";
+				allwinner,function = "uart1";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 	};
 };
-- 
1.7.10.4
