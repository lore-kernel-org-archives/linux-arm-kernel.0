From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 21 Mar 2016 21:00:59 +0100
Subject: [linux-sunxi][PATCH v3 1/8] ARM: dts :sunxi: Add SPDIF TX pin to the
 A10
In-Reply-To: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
References: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
Message-ID: <1458590466-12572-2-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF TX pin to the A10 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 2c8f5e6..62fcef9 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -1006,6 +1006,13 @@
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
 		};
 
 		timer at 01c20c00 {
-- 
2.7.4
