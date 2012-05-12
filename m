From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 May 2012 18:37:57 -0600
Subject: [PATCH 5/9] ARM: dt: tegra: consistenly use lower-case for hex
 constants
In-Reply-To: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
References: <1336783081-16978-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1336783081-16978-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-paz00.dts |    2 +-
 arch/arm/boot/dts/tegra20.dtsi    |    8 ++++----
 arch/arm/boot/dts/tegra30.dtsi    |    8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
index 03b2e65..d469322 100644
--- a/arch/arm/boot/dts/tegra-paz00.dts
+++ b/arch/arm/boot/dts/tegra-paz00.dts
@@ -249,7 +249,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "nvidia,nvec";
-		reg = <0x7000C500 0x100>;
+		reg = <0x7000c500 0x100>;
 		interrupts = <0 92 0x04>;
 		clock-frequency = <80000>;
 		request-gpios = <&gpio 170 0>; /* gpio PV2 */
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 7f718bd..5f9110a 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -48,7 +48,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
-		reg = <0x7000C000 0x100>;
+		reg = <0x7000c000 0x100>;
 		interrupts = <0 38 0x04>;
 	};
 
@@ -56,7 +56,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
-		reg = <0x7000C400 0x100>;
+		reg = <0x7000c400 0x100>;
 		interrupts = <0 84 0x04>;
 	};
 
@@ -64,7 +64,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c";
-		reg = <0x7000C500 0x100>;
+		reg = <0x7000c500 0x100>;
 		interrupts = <0 92 0x04>;
 	};
 
@@ -72,7 +72,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "nvidia,tegra20-i2c-dvc";
-		reg = <0x7000D000 0x200>;
+		reg = <0x7000d000 0x200>;
 		interrupts = <0 53 0x04>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index b52378a..ea829f5 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -66,7 +66,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible =  "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
-		reg = <0x7000C000 0x100>;
+		reg = <0x7000c000 0x100>;
 		interrupts = <0 38 0x04>;
 	};
 
@@ -74,7 +74,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
-		reg = <0x7000C400 0x100>;
+		reg = <0x7000c400 0x100>;
 		interrupts = <0 84 0x04>;
 	};
 
@@ -82,7 +82,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
-		reg = <0x7000C500 0x100>;
+		reg = <0x7000c500 0x100>;
 		interrupts = <0 92 0x04>;
 	};
 
@@ -98,7 +98,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
-		reg = <0x7000D000 0x100>;
+		reg = <0x7000d000 0x100>;
 		interrupts = <0 53 0x04>;
 	};
 
-- 
1.7.0.4
