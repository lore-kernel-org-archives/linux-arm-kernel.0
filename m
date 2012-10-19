From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 19 Oct 2012 11:45:59 +0900
Subject: [PATCH 7/7] ARM: dts: Add pin controller node for Samsung EXYNOS5440
 SoC
In-Reply-To: <1350614759-1852-1-git-send-email-kgene.kim@samsung.com>
References: <1350614759-1852-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1350614759-1852-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.abraham@linaro.org>

Add a pin controller node for Samsung Exynos5440 (EXYNOS5440) SoC.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/boot/dts/exynos5440.dtsi |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 380a89a..a7cda84 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -90,6 +90,23 @@
 		reg = <0xE0000 0x1000>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		#gpio-cells = <2>;
+
+		fan: fan {
+			samsung,exynos5440-pin-function = <1>;
+		};
+
+		hdd_led0: hdd_led0 {
+			samsung,exynos5440-pin-function = <2>;
+		};
+
+		hdd_led1: hdd_led1 {
+			samsung,exynos5440-pin-function = <3>;
+		};
+
+		uart1: uart1 {
+			samsung,exynos5440-pin-function = <4>;
+		};
 	};
 
 	i2c at F0000 {
-- 
1.7.4.4
