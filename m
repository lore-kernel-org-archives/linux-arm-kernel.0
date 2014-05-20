From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 20 May 2014 19:08:48 +0530
Subject: [PATCH 1/2] ARM: dts: add pmu syscon handle to exynos5250 hdmi
In-Reply-To: <1400593129-21170-1-git-send-email-rahul.sharma@samsung.com>
References: <1400593129-21170-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1400593129-21170-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PMU syscon handle to HDMI dt node for controlling
PHY Enable/Disable bit.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 68a3e6f..52e5db5 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -704,6 +704,7 @@
 			 <&clock CLK_MOUT_HDMI>;
 		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
 				"sclk_hdmiphy", "mout_hdmi";
+		samsung,syscon-phandle = <&pmu_system_controller>;
 	};
 
 	mixer {
-- 
1.7.9.5
