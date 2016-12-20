From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 20 Dec 2016 11:40:36 +0100
Subject: [linux-sunxi][PATCH 1/3] ARM: dts: sun6i: Add SPDIF TX pin to the A31
In-Reply-To: <20161220104038.22532-1-codekipper@gmail.com>
References: <20161220104038.22532-1-codekipper@gmail.com>
Message-ID: <20161220104038.22532-2-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF TX pin to the A31 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 20a0331ddfb5..7370ba6c9993 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -586,6 +586,11 @@
 				bias-pull-up;
 			};
 
+			spdif_pins_a: spdif at 0 {
+				pins = "PH28";
+				function = "spdif";
+			};
+
 			uart0_pins_a: uart0 at 0 {
 				pins = "PH20", "PH21";
 				function = "uart0";
-- 
2.11.0
