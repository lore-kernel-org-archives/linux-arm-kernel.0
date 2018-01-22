From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 10:25:27 +0100
Subject: [PATCH v4 13/13] ARM: dts: sun8i: a33 Enable our display frontend
In-Reply-To: <cover.671c2fcad4ca649d65bd2b9982a8361befa8bfd1.1516613040.git-series.maxime.ripard@free-electrons.com>
References: <cover.671c2fcad4ca649d65bd2b9982a8361befa8bfd1.1516613040.git-series.maxime.ripard@free-electrons.com>
Message-ID: <ee3bcabdaa48a50d65394848c8aff1423609033e.1516613040.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display frontend can be used to do hardware scaling, colorspaces
conversion or to implement the buffer format output by the Cedar VPU.

Since we're starting to have some support for it in the DRM driver, let's
enable its DT node.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 50eb84fa246a..a21f2ed07a52 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -289,7 +289,6 @@
 			clock-names = "ahb", "mod",
 				      "ram";
 			resets = <&ccu RST_BUS_DE_FE>;
-			status = "disabled";
 
 			ports {
 				#address-cells = <1>;
-- 
git-series 0.9.1
