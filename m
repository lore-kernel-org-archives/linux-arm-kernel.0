From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 04 Sep 2012 10:50:06 +0200
Subject: [PATCH v2 2/5] ARM: Exynos4: dts: Specify address and size cells for
 i2c controllers
In-Reply-To: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
Message-ID: <1346748609-11115-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 9b71b61..718e3d2 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -122,6 +122,8 @@
 	};
 
 	i2c at 13860000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13860000 0x100>;
 		interrupts = <0 58 0>;
@@ -129,6 +131,8 @@
 	};
 
 	i2c at 13870000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13870000 0x100>;
 		interrupts = <0 59 0>;
@@ -136,6 +140,8 @@
 	};
 
 	i2c at 13880000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13880000 0x100>;
 		interrupts = <0 60 0>;
@@ -143,6 +149,8 @@
 	};
 
 	i2c at 13890000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13890000 0x100>;
 		interrupts = <0 61 0>;
@@ -150,6 +158,8 @@
 	};
 
 	i2c at 138A0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138A0000 0x100>;
 		interrupts = <0 62 0>;
@@ -157,6 +167,8 @@
 	};
 
 	i2c at 138B0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138B0000 0x100>;
 		interrupts = <0 63 0>;
@@ -164,6 +176,8 @@
 	};
 
 	i2c at 138C0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138C0000 0x100>;
 		interrupts = <0 64 0>;
@@ -171,6 +185,8 @@
 	};
 
 	i2c at 138D0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138D0000 0x100>;
 		interrupts = <0 65 0>;
-- 
1.7.12
