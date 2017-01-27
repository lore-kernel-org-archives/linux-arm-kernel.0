From: codekipper@gmail.com (codekipper at gmail.com)
Date: Fri, 27 Jan 2017 16:48:06 +0100
Subject: [linux-sunxi][PATCH 1/3] ARM: dts: sun8i-h3: Add SPDIF TX pin to the
 H3
In-Reply-To: <20170127154808.19229-1-codekipper@gmail.com>
References: <20170127154808.19229-1-codekipper@gmail.com>
Message-ID: <20170127154808.19229-2-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF TX pin to the H3 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 08fd0860bb6b..6e250bd9a8a9 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -375,6 +375,11 @@
 				bias-pull-up;
 			};
 
+			spdif_tx_pins_a: spdif at 0 {
+				pins = "PA17";
+				function = "spdif";
+			};
+
 			spi0_pins: spi0 {
 				pins = "PC0", "PC1", "PC2", "PC3";
 				function = "spi0";
-- 
2.11.0
