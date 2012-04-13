From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Apr 2012 15:05:04 +0100
Subject: [PATCH 2/7] ARM: ux500: Shorten Snowball's DT compatible gpio entry
In-Reply-To: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334325909-5779-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is believed that the gpio compatible match entry is too long
and cumbersome in its current form. This patch takes steps to
decrease its length by using ST-Mircroelectrics' abbreviation ST.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index f482845..421e15f 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -164,7 +164,7 @@
 		};
 
 		i2c at 80004000 {
-			compatible = "stericsson,db8500-i2c", "stmicroelectronics,nomadik-i2c";
+			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c";
 			reg = <0x80004000 0x1000>;
 			interrupts = <0 21 0x4>;
 			#address-cells = <1>;
@@ -172,7 +172,7 @@
 		};
 
 		i2c at 80122000 {
-			compatible = "stericsson,db8500-i2c", "stmicroelectronics,nomadik-i2c";
+			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c";
 			reg = <0x80122000 0x1000>;
 			interrupts = <0 22 0x4>;
 			#address-cells = <1>;
@@ -180,7 +180,7 @@
 		};
 
 		i2c at 80128000 {
-			compatible = "stericsson,db8500-i2c", "stmicroelectronics,nomadik-i2c";
+			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c";
 			reg = <0x80128000 0x1000>;
 			interrupts = <0 55 0x4>;
 			#address-cells = <1>;
@@ -188,7 +188,7 @@
 		};
 
 		i2c at 80110000 {
-			compatible = "stericsson,db8500-i2c", "stmicroelectronics,nomadik-i2c";
+			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c";
 			reg = <0x80110000 0x1000>;
 			interrupts = <0 12 0x4>;
 			#address-cells = <1>;
@@ -196,7 +196,7 @@
 		};
 
 		i2c at 8012a000 {
-			compatible = "stericsson,db8500-i2c", "stmicroelectronics,nomadik-i2c";
+			compatible = "stericsson,db8500-i2c", "st,nomadik-i2c";
 			reg = <0x8012a000 0x1000>;
 			interrupts = <0 51 0x4>;
 			#address-cells = <1>;
-- 
1.7.9.1
