From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:57 +0100
Subject: [PATCH 56/77] ARM: dts: sun8i: a23/a33: Remove leading zeros from
 unit-addresses
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <ca6ee0daebdef6017b14ea568f5426785eadab25.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of our device trees have had leading zeros for padding as part of
the nodes unit-addresses.

Remove all these useless zeros that generate warnings

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index d74cd95afe6d..0036309e2c50 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -262,7 +262,7 @@
 			};
 		};
 
-		video-codec at 01c0e000 {
+		video-codec at 1c0e000 {
 			compatible = "allwinner,sun8i-a33-video-engine";
 			reg = <0x01c0e000 0x1000>;
 			clocks = <&ccu CLK_BUS_VE>, <&ccu CLK_VE>,
-- 
git-series 0.9.1
