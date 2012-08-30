From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 30 Aug 2012 09:31:40 +0200
Subject: [PATCH 3/6] ARM: Exynos4: dts: Specify address and size cells for i2c
 controllers
In-Reply-To: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
References: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
Message-ID: <1346311903-15920-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 5e99503..5935588 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -116,48 +116,64 @@
 	};
 
 	i2c at 13860000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13860000 0x100>;
 		interrupts = <0 58 0>;
 	};
 
 	i2c at 13870000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13870000 0x100>;
 		interrupts = <0 59 0>;
 	};
 
 	i2c at 13880000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13880000 0x100>;
 		interrupts = <0 60 0>;
 	};
 
 	i2c at 13890000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13890000 0x100>;
 		interrupts = <0 61 0>;
 	};
 
 	i2c at 138A0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138A0000 0x100>;
 		interrupts = <0 62 0>;
 	};
 
 	i2c at 138B0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138B0000 0x100>;
 		interrupts = <0 63 0>;
 	};
 
 	i2c at 138C0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138C0000 0x100>;
 		interrupts = <0 64 0>;
 	};
 
 	i2c at 138D0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138D0000 0x100>;
 		interrupts = <0 65 0>;
-- 
1.7.12
