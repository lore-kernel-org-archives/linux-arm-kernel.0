From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Jan 2013 22:30:37 +0100
Subject: [PATCH 5/7] ARM: sunxi: Add uart1 pinctrl groups
In-Reply-To: <1358544639-14761-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1358544639-14761-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1358544639-14761-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 707bef5..e112189 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -24,6 +24,20 @@
 			reg = <0x01c20800 0x400>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			uart1_pins_a: uart1 at 0 {
+				allwinner,pins = "PE10", "PE11";
+				allwinner,function = "uart1";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			uart1_pins_b: uart1 at 1 {
+				allwinner,pins = "PG3", "PG4";
+				allwinner,function = "uart1";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 	};
 };
-- 
1.7.10.4
