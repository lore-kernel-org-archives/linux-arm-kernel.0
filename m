From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 15 May 2013 02:18:09 +0200
Subject: [PATCH v3 09/20] ARM: shmobile: r8a7790: Add GPIO controller devices
 to device tree
In-Reply-To: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1368577100-3530-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add GPIO controller nodes to the r8a7790 core device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 54 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ee21061..b5fe51da 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -44,6 +44,60 @@
 		};
 	};
 
+	gpio0: gpio at ffc40000 {
+		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
+		reg = <0xffc40000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 4 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	gpio1: gpio at ffc41000 {
+		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
+		reg = <0xffc41000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 5 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	gpio2: gpio at ffc42000 {
+		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
+		reg = <0xffc42000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 6 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	gpio3: gpio at ffc43000 {
+		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
+		reg = <0xffc43000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 7 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	gpio4: gpio at ffc44000 {
+		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
+		reg = <0xffc44000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 8 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	gpio5: gpio at ffc45000 {
+		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
+		reg = <0xffc45000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 9 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 0xf08>,
-- 
1.8.1.5
