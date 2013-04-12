From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 12 Apr 2013 16:29:06 +0200
Subject: [PATCH v4 1/5] ARM: dts: mvebu: fix cpus section indentation
In-Reply-To: <1365776950-30094-1-git-send-email-gregory.clement@free-electrons.com>
References: <1365776950-30094-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1365776950-30094-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Align the cpu node indentation with the rest of the file

[gc]: added a commit description
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |   32 +++++++++---------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |   32 +++++++++---------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |   54 +++++++++++++++---------------
 3 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index c2c7845..e072a53 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -25,22 +25,22 @@
 	};
 
 	cpus {
-	    #address-cells = <1>;
-	    #size-cells = <0>;
-
-	    cpu at 0 {
-		device_type = "cpu";
-		compatible = "marvell,sheeva-v7";
-		reg = <0>;
-		clocks = <&cpuclk 0>;
-	    };
-
-	    cpu at 1 {
-		device_type = "cpu";
-		compatible = "marvell,sheeva-v7";
-		reg = <1>;
-		clocks = <&cpuclk 1>;
-	    };
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "marvell,sheeva-v7";
+			reg = <0>;
+			clocks = <&cpuclk 0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "marvell,sheeva-v7";
+			reg = <1>;
+			clocks = <&cpuclk 1>;
+		};
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 885bf22..6dae1bc 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -26,22 +26,22 @@
 	};
 
 	cpus {
-	    #address-cells = <1>;
-	    #size-cells = <0>;
-
-	    cpu at 0 {
-		device_type = "cpu";
-		compatible = "marvell,sheeva-v7";
-		reg = <0>;
-		clocks = <&cpuclk 0>;
-	    };
-
-	    cpu at 1 {
-		device_type = "cpu";
-		compatible = "marvell,sheeva-v7";
-		reg = <1>;
-		clocks = <&cpuclk 1>;
-	    };
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "marvell,sheeva-v7";
+			reg = <0>;
+			clocks = <&cpuclk 0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "marvell,sheeva-v7";
+			reg = <1>;
+			clocks = <&cpuclk 1>;
+		};
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 23a5ac4..b9da5b8 100644
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
@@ -300,4 +300,4 @@
 			};
 		};
 	};
- };
+};
-- 
1.7.9.5
