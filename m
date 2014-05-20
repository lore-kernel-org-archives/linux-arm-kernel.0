From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 20 May 2014 19:08:49 +0530
Subject: [PATCH 2/2] ARM: dts: add pmu syscon handle to exynos5420 hdmi
In-Reply-To: <1400593129-21170-1-git-send-email-rahul.sharma@samsung.com>
References: <1400593129-21170-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1400593129-21170-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PMU syscon handle to HDMI dt node for controlling
PHY Enable/Disable bit.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8e7e35c..20dc308 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -687,6 +687,7 @@
 		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
 			"sclk_hdmiphy", "mout_hdmi";
 		phy = <&hdmiphy>;
+		samsung,syscon-phandle = <&pmu_system_controller>;
 		status = "disabled";
 	};
 
-- 
1.7.9.5
