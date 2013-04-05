From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  5 Apr 2013 22:24:03 +0200
Subject: [PATCH v2 8/9] arm: dts: mvebu: fix cpus section indentation
In-Reply-To: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
References: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1365193444-13441-9-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |   28 ++++++++--------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |   28 ++++++++--------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |   54 +++++++++++++++---------------
 3 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index f0d38fb..392f118 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -25,22 +25,22 @@
 	};
 
 	cpus {
-	    #address-cells = <1>;
-	    #size-cells = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-	    cpu at 0 {
-		device_type = "cpu";
-		compatible = "marvell,sheeva-v7";
-		reg = <0>;
-		clocks = <&cpuclk 0>;
-	    };
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "marvell,sheeva-v7";
+			reg = <0>;
+			clocks = <&cpuclk 0>;
+		};
 
-	    cpu at 1 {
-		device_type = "cpu";
-		compatible = "marvell,sheeva-v7";
-		reg = <1>;
-		clocks = <&cpuclk 1>;
-	    };
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "marvell,sheeva-v7";
+			reg = <1>;
+			clocks = <&cpuclk 1>;
+		};
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 2621bda..8fb7fea 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -26,22 +26,22 @@
 	};
 
 	cpus {
-	    #address-cells = <1>;
-	    #size-cells = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-	    cpu at 0 {
-		device_type = "cpu";
-		compatible = "marvell,sheeva-v7";
-		reg = <0>;
-		clocks = <&cpuclk 0>;
-	    };
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "marvell,sheeva-v7";
+			reg = <0>;
+			clocks = <&cpuclk 0>;
+		};
 
-	    cpu at 1 {
-		device_type = "cpu";
-		compatible = "marvell,sheeva-v7";
-		reg = <1>;
-		clocks = <&cpuclk 1>;
-	    };
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "marvell,sheeva-v7";
+			reg = <1>;
+			clocks = <&cpuclk 1>;
+		};
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index ccb95ff..fa665cb 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -27,36 +27,36 @@
 
 
 	cpus {
-	    #address-cells = <1>;
-	    #size-cells = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-	    cpu at 0 {
-		device_type = "cpu";
-		compatible = "marvell,sheeva-v7";
-		reg = <0>;
-		clocks = <&cpuclk 0>;
-	    };
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "marvell,sheeva-v7";
+			reg = <0>;
+			clocks = <&cpuclk 0>;
+		};
 
-	    cpu at 1 {
-		device_type = "cpu";
-		compatible = "marvell,sheeva-v7";
-		reg = <1>;
-		clocks = <&cpuclk 1>;
-	    };
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "marvell,sheeva-v7";
+			reg = <1>;
+			clocks = <&cpuclk 1>;
+		};
 
-	    cpu at 2 {
-		device_type = "cpu";
-		compatible = "marvell,sheeva-v7";
-		reg = <2>;
-		clocks = <&cpuclk 2>;
-	    };
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "marvell,sheeva-v7";
+			reg = <2>;
+			clocks = <&cpuclk 2>;
+		};
 
-	    cpu at 3 {
-		device_type = "cpu";
-		compatible = "marvell,sheeva-v7";
-		reg = <3>;
-		clocks = <&cpuclk 3>;
-	    };
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "marvell,sheeva-v7";
+			reg = <3>;
+			clocks = <&cpuclk 3>;
+		};
 	};
 
 	soc {
@@ -114,4 +114,4 @@
 			};
 		};
 	};
- };
+};
-- 
1.7.9.5
