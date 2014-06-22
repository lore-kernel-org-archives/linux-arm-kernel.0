From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 22 Jun 2014 21:49:55 +0200
Subject: [PATCH] ARM: dts: exynos5410: Fill in CPU clock-frequency
Message-ID: <1403466596-3347-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's 1.6 GHz for the Cortex-A15.

Avoids warnings like "/cpus/cpu at 0 missing clock-frequency property".

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/exynos5410.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 3839c26..9d0b8cc 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -28,24 +28,28 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
+			clock-frequency = <1600000000>;
 		};
 
 		CPU1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x1>;
+			clock-frequency = <1600000000>;
 		};
 
 		CPU2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x2>;
+			clock-frequency = <1600000000>;
 		};
 
 		CPU3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x3>;
+			clock-frequency = <1600000000>;
 		};
 	};
 
-- 
1.9.3
