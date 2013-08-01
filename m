From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  1 Aug 2013 17:26:56 +0900
Subject: [PATCH 14/14] ARM: shmobile: r8a7779: Remove '0x's from R8A7779 DTS
 file
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
Message-ID: <98724b7ec9d34d875fc193660c87d6dd0d17ceb7.1375344714.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 7f146c6..86bd487 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -65,7 +65,7 @@
 		sense-bitfield-width = <2>;
 	};
 
-	i2c0: i2c at 0xffc70000 {
+	i2c0: i2c at ffc70000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -74,7 +74,7 @@
 		interrupts = <0 79 0x4>;
 	};
 
-	i2c1: i2c at 0xffc71000 {
+	i2c1: i2c at ffc71000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -83,7 +83,7 @@
 		interrupts = <0 82 0x4>;
 	};
 
-	i2c2: i2c at 0xffc72000 {
+	i2c2: i2c at ffc72000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -92,7 +92,7 @@
 		interrupts = <0 80 0x4>;
 	};
 
-	i2c3: i2c at 0xffc73000 {
+	i2c3: i2c at ffc73000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
-- 
1.8.3.2
