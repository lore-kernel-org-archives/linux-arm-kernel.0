From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 27 Jun 2013 11:47:57 +0200
Subject: [PATCH 2/3] ARM: shmobile: r8a73a4: add I2C controller DT nodes
In-Reply-To: <1372326479-15028-1-git-send-email-g.liakhovetski@gmx.de>
References: <1372326479-15028-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1372326479-15028-3-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Device Tree nodes for the 9 I2C controllers on r8a73a4, compatible with
the i2c-sh_mobile.c driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a73a4.dtsi |   81 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

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
1.7.2.5
