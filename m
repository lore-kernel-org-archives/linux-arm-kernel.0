From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon,  3 Mar 2014 17:02:14 +0100
Subject: [PATCH v2 09/11] ARM: dts: s3c64xx: Add nodes for power domains
In-Reply-To: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1393862536-9842-10-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree nodes for power domains available on S3C64xx
SoCs.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/boot/dts/s3c6400.dtsi | 1 +
 arch/arm/boot/dts/s3c6410.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/s3c6400.dtsi b/arch/arm/boot/dts/s3c6400.dtsi
index a7d1c8e..c1abdaf 100644
--- a/arch/arm/boot/dts/s3c6400.dtsi
+++ b/arch/arm/boot/dts/s3c6400.dtsi
@@ -37,5 +37,6 @@
 		compatible = "samsung,s3c6400-clock";
 		reg = <0x7e00f000 0x1000>;
 		#clock-cells = <1>;
+		#power-domain-cells = <1>;
 	};
 };
diff --git a/arch/arm/boot/dts/s3c6410.dtsi b/arch/arm/boot/dts/s3c6410.dtsi
index eb4226b..7e48c86 100644
--- a/arch/arm/boot/dts/s3c6410.dtsi
+++ b/arch/arm/boot/dts/s3c6410.dtsi
@@ -41,6 +41,7 @@
 		compatible = "samsung,s3c6410-clock";
 		reg = <0x7e00f000 0x1000>;
 		#clock-cells = <1>;
+		#power-domain-cells = <1>;
 	};
 
 	i2c1: i2c at 7f00f000 {
-- 
1.9.0
