From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 10 Apr 2015 01:14:16 +0930
Subject: [PATCH v2 2/5] ARM: dts: OdroidXU3: Enable TMU at Exynos5422 base.
In-Reply-To: <1428594259-3915-1-git-send-email-linux.amoon@gmail.com>
References: <1428594259-3915-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1428594259-3915-3-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables TMU IP block on the Exynos5422 OdroidXU3
device.

Tested on OdroidXU3 board.

Changes since v1 : None

Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 04d982b..6e7ee53 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -287,6 +287,31 @@
 		#cooling-cells = <2>;
 		cooling-levels = <0 130 170 230>;
 	};
+
+	tmu at 10060000 {
+		vtmu-supply = <&ldo10_reg>;
+		status = "okay";
+	};
+
+	tmu at 10064000 {
+		vtmu-supply = <&ldo10_reg>;
+		status = "okay";
+	};
+
+	tmu at 10068000 {
+		vtmu-supply = <&ldo10_reg>;
+		status = "okay";
+	};
+
+	tmu at 1006c000 {
+		vtmu-supply = <&ldo10_reg>;
+		status = "okay";
+	};
+
+	tmu at 100a0000 {
+		vtmu-supply = <&ldo10_reg>;
+		status = "okay";
+	};
 };
 
 &hdmi {
-- 
1.9.1
