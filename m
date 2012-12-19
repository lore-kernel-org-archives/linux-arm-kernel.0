From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Dec 2012 21:18:13 +0100
Subject: [PATCH 4/6] ARM: sunxi: Add uart1 pinctrl groups
In-Reply-To: <1355948295-19680-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1355948295-19680-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1355948295-19680-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index e29c52b..7a9535b 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -23,5 +23,19 @@
 		reg = <0x01c20800 0x400>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		uart1_pins_a: uart1 at 0 {
+			allwinner,pins = "PE10", "PE11";
+			allwinner,function = "uart1";
+			allwinner,drive = <0>;
+			allwinner,pull = <0>;
+		};
+
+		uart1_pins_b: uart1 at 1 {
+			allwinner,pins = "PG3", "PG4";
+			allwinner,function = "uart1";
+			allwinner,drive = <0>;
+			allwinner,pull = <0>;
+		};
 	};
 };
-- 
1.7.9.5
