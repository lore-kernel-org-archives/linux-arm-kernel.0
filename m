From: threeway@gmail.com (Steev Klimaszewski)
Date: Sun, 19 Jul 2015 15:15:13 -0500
Subject: [PATCH] ARM: tegra: Fix nyan-big panel binding
Message-ID: <1437336913-12886-1-git-send-email-steev@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nyan-big Chromebook uses a 1920x1080 panel, not a 1366x768 panel so correct
the binding.

Signed-off-by: Steev Klimaszewski <steev@gentoo.org>
---
 arch/arm/boot/dts/tegra124-nyan-big.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/tegra124-nyan-big.dts
index 2d21253..30d4495 100644
--- a/arch/arm/boot/dts/tegra124-nyan-big.dts
+++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
@@ -9,7 +9,7 @@
 	compatible = "google,nyan-big", "nvidia,tegra124";
 
 	panel: panel {
-		compatible = "auo,b133xtn01";
+		compatible = "auo,b133htn01";
 
 		backlight = <&backlight>;
 		ddc-i2c-bus = <&dpaux>;
-- 
2.4.6
