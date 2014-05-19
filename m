From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Mon, 19 May 2014 10:45:39 +0530
Subject: [PATCH V2 1/2] ARM: dts: Add pwmX_out pinctrl nodes to Exynos5250
In-Reply-To: <1400476540-14828-1-git-send-email-ajaykumar.rs@samsung.com>
References: <1400476540-14828-1-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <1400476540-14828-2-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the PWM nodes to 5250 pinctrl dtsi file.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
index 9a49e68..886cfca 100644
--- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
@@ -351,6 +351,34 @@
 			samsung,pin-drv = <0>;
 		};
 
+		pwm0_out: pwm0-out {
+			samsung,pins = "gpb2-0";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		pwm1_out: pwm1-out {
+			samsung,pins = "gpb2-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		pwm2_out: pwm2-out {
+			samsung,pins = "gpb2-2";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		pwm3_out: pwm3-out {
+			samsung,pins = "gpb2-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
 		i2c7_bus: i2c7-bus {
 			samsung,pins = "gpb2-2", "gpb2-3";
 			samsung,pin-function = <3>;
-- 
1.7.9.5
