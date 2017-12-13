From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Dec 2017 16:33:32 +0100
Subject: [PATCH 8/8] ARM: dts: sun8i: a33 Enable our display frontend
In-Reply-To: <cover.63722fe4aeb908cf3c6f73874bdf69b193fe43c9.1513178989.git-series.maxime.ripard@free-electrons.com>
References: <cover.63722fe4aeb908cf3c6f73874bdf69b193fe43c9.1513178989.git-series.maxime.ripard@free-electrons.com>
Message-ID: <9f92f61048845b9a8496476e00ba6369cb42aae5.1513178989.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display frontend can be used to do hardware scaling, colorspaces
conversion or to implement the buffer format output by the Cedar VPU.

Since we're starting to have some support for it in the DRM driver, let's
enable its DT node.

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
