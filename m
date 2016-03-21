From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 21 Mar 2016 17:10:39 +0100
Subject: [linux-sunxi][PATCH v2 2/5] ARM: dts :sunxi: Add SPDIF pins to A10
 and A20
In-Reply-To: <1458576642-4078-1-git-send-email-codekipper@gmail.com>
References: <1458576642-4078-1-git-send-email-codekipper@gmail.com>
Message-ID: <1458576642-4078-3-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF pins to the A10 and A20 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 21 +++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 2c8f5e6..0483640 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -1006,6 +1006,27 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			spdif_tx_pins_a: spdif at 0 {
+				allwinner,pins = "PB13";
+				allwinner,function = "spdif";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+			};
+
+			spdif_rx_pins_a: spdif at 1 {
+				allwinner,pins = "PB12";
+				allwinner,function = "spdif";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spdif_mclk_pins_a: spdif at 2 {
+				allwinner,pins = "PB3";
+				allwinner,function = "spdif";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		timer at 01c20c00 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 0940a78..7264d5e 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1193,6 +1193,27 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			spdif_tx_pins_a: spdif at 0 {
+				allwinner,pins = "PB13";
+				allwinner,function = "spdif";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+			};
+
+			spdif_rx_pins_a: spdif at 1 {
+				allwinner,pins = "PB12";
+				allwinner,function = "spdif";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spdif_mclk_pins_a: spdif at 2 {
+				allwinner,pins = "PB3";
+				allwinner,function = "spdif";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
2.7.4
