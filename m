From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 10 Apr 2015 23:36:00 +0200
Subject: [PATCH 5/9] ARM: tegra: fix hda2codec_2x clock name in Tegra124
 device tree
In-Reply-To: <cover.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <4d791b76e1b363b2446a2b6a6bfb84869d9f94e8.1428700856.git.marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index fefec80..095d326 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -620,11 +620,11 @@
 		clocks = <&tegra_car TEGRA124_CLK_HDA>,
 		         <&tegra_car TEGRA124_CLK_HDA2HDMI>,
 			 <&tegra_car TEGRA124_CLK_HDA2CODEC_2X>;
-		clock-names = "hda", "hda2hdmi", "hdacodec_2x";
+		clock-names = "hda", "hda2hdmi", "hda2codec_2x";
 		resets = <&tegra_car 125>, /* hda */
 			 <&tegra_car 128>, /* hda2hdmi */
 			 <&tegra_car 111>; /* hda2codec_2x */
-		reset-names = "hda", "hda2hdmi", "hdacodec_2x";
+		reset-names = "hda", "hda2hdmi", "hda2codec_2x";
 		status = "disabled";
 	};
 
-- 
1.9.3
