From: seanpaul@chromium.org (Sean Paul)
Date: Mon,  7 Jan 2013 16:00:00 -0500
Subject: [PATCH] ARM: dts: exynos5250: Set HDMI version to v1.4
Message-ID: <1357592400-18117-1-git-send-email-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the HDMI version to v1.4 for all exynos5250 targets. This property
was previously being inferred by the existence of the hdmi node.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 arch/arm/boot/dts/exynos5250.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 2e3b6ef..9fb6845 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -576,6 +576,7 @@
 		compatible = "samsung,exynos5-hdmi";
 		reg = <0x14530000 0x100000>;
 		interrupts = <0 95 0>;
+		samsung,supports-hdmi-1.4;
 	};
 
 	mixer {
-- 
1.7.7.3
