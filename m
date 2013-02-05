From: tobetter@gmail.com (Dongjin Kim)
Date: Tue,  5 Feb 2013 09:47:57 +0900
Subject: [PATCH] ARM: dts: Adding RTC device node
Message-ID: <1360025290-16278-1-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables RTC device node defined in arch/arm/boot/dts/exynos4.dtsi.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/exynos4412-odroidx.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 54fe32f..85c958a 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -83,6 +83,10 @@
 		regulator-boot-on;
 	};
 
+	rtc at 10070000 {
+		status = "okay";
+	};
+
 	sdhci at 12530000 {
 		bus-width = <4>;
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-- 
1.7.10.4
