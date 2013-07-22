From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 Jul 2013 16:36:13 +0900
Subject: [PATCH 01/11] ARM: shmobile: r8a73a4: add I2C controller DT nodes
In-Reply-To: <cover.1374478037.git.horms+renesas@verge.net.au>
References: <cover.1374478037.git.horms+renesas@verge.net.au>
Message-ID: <f98c1069bf1748ffa18cbebbc3a9f88dfc19a631.1374478037.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add Device Tree nodes for the 9 I2C controllers on r8a73a4, compatible with
the i2c-sh_mobile.c driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 4ff2019..4e1ddf0 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -85,4 +85,85 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 69 4>;
 	};
+
+	i2c0: i2c at e6500000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6500000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 174 0x4>;
+	};
+
+	i2c1: i2c at e6510000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6510000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 175 0x4>;
+	};
+
+	i2c2: i2c at e6520000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6520000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 176 0x4>;
+	};
+
+	i2c3: i2c at e6530000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6530000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 177 0x4>;
+	};
+
+	i2c4: i2c at e6540000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6540000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 178 0x4>;
+	};
+
+	i2c5: i2c at e60b0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe60b0000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 179 0x4>;
+	};
+
+	i2c6: i2c at e6550000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6550000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 184 0x4>;
+	};
+
+	i2c7: i2c at e6560000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6560000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 185 0x4>;
+	};
+
+	i2c8: i2c at e6570000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6570000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 173 0x4>;
+	};
 };
-- 
1.8.2.1
