From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 13 May 2015 16:06:55 +0930
Subject: v5 Exynos5422 odroidxu3 pwm-fan control using thermal sensors
Message-ID: <1431499020-3912-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rebase on  https://github.com/krzk/linux.git v4.2-next/dt-samsung

Changes from previous version.
Updated the the "cpu-crit-0" trip point in arch/arm/boot/dts/exynos5-cpu-thermal.dtsi

Changes From 
				cpu_crit0: cpu-crit-0 {
					temperature = <100000>; /* millicelsius */
					hysteresis = <0>; /* millicelsius */
					type = "critical";
				};
Changes To 
				cpu_crit0: cpu-crit-0 {
					temperature = <120000>; /* millicelsius */
					hysteresis = <0>; /* millicelsius */
					type = "critical";
				};

Changes were made to match exynos5420-trip-points.dtsi

-Anand Moon
