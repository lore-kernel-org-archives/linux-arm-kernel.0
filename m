From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:09:26 +0100
Subject: [PATCH v3 13/13] ARM: dts: sun8i: a33 Enable our display frontend
In-Reply-To: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
References: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
Message-ID: <53b519deaf2e507b121b64abcb4ba0da075bd6a7.1515492513.git-series.maxime.ripard@free-electrons.com>
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
