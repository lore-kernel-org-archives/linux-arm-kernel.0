From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Jul 2013 11:52:22 +0100
Subject: [PATCH 03/22] ARM: u300: Remove '0x's from U300 DTS file
In-Reply-To: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374490361-25769-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 8a1032c..a9da480 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -307,7 +307,7 @@
 		clocks = <&i2c0_clk>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		ab3100: ab3100 at 0x48 {
+		ab3100: ab3100 at 48 {
 			compatible = "stericsson,ab3100";
 			reg = <0x48>;
 			interrupt-parent = <&vica>;
@@ -385,10 +385,10 @@
 		clocks = <&i2c1_clk>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		fwcam0: fwcam at 0x10 {
+		fwcam0: fwcam at 10 {
 			reg = <0x10>;
 		};
-		fwcam1: fwcam at 0x5d {
+		fwcam1: fwcam at 5d {
 			reg = <0x5d>;
 		};
 	};
-- 
1.8.1.2
