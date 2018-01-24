From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 24 Jan 2018 11:39:40 +0100
Subject: [linux-sunxi][PATCH 2/5] arm64: allwinner: a64: Add SPDIF TX pin to
 the A64
In-Reply-To: <20180124103943.2062-1-codekipper@gmail.com>
References: <20180124103943.2062-1-codekipper@gmail.com>
Message-ID: <20180124103943.2062-3-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF TX pin to the A64 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index c82979038b0b..db1694ec3ee4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -336,6 +336,11 @@
 				drive-strength = <40>;
 			};
 
+			spdif_tx_pins_a: spdif at 0 {
+				pins = "PH8";
+				function = "spdif";
+			};
+
 			spi0_pins: spi0 {
 				pins = "PC0", "PC1", "PC2", "PC3";
 				function = "spi0";
-- 
2.16.0
