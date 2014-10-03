From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Fri,  3 Oct 2014 23:35:49 +0800
Subject: [PATCH v4 3/3] ARM: dts: hix5hd2: add i2c node
In-Reply-To: <1412350549-2607-1-git-send-email-zhangfei.gao@linaro.org>
References: <1412350549-2607-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1412350549-2607-4-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 arch/arm/boot/dts/hisi-x5hd2.dtsi |   60 +++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index d3d99fb..17d0637 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -476,5 +476,65 @@
                         interrupts = <0 70 4>;
                         clocks = <&clock HIX5HD2_SATA_CLK>;
 		};
+
+		i2c0: i2c at b10000 {
+			compatible = "hisilicon,hix5hd2-i2c";
+			reg = <0xb10000 0x1000>;
+			interrupts = <0 38 4>;
+			clocks = <&clock HIX5HD2_I2C0_RST>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at b11000 {
+			compatible = "hisilicon,hix5hd2-i2c";
+			reg = <0xb11000 0x1000>;
+			interrupts = <0 39 4>;
+			clocks = <&clock HIX5HD2_I2C1_RST>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at b12000 {
+			compatible = "hisilicon,hix5hd2-i2c";
+			reg = <0xb12000 0x1000>;
+			interrupts = <0 40 4>;
+			clocks = <&clock HIX5HD2_I2C2_RST>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at b13000 {
+			compatible = "hisilicon,hix5hd2-i2c";
+			reg = <0xb13000 0x1000>;
+			interrupts = <0 41 4>;
+			clocks = <&clock HIX5HD2_I2C3_RST>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c at b16000 {
+			compatible = "hisilicon,hix5hd2-i2c";
+			reg = <0xb16000 0x1000>;
+			interrupts = <0 43 4>;
+			clocks = <&clock HIX5HD2_I2C4_RST>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c at b17000 {
+			compatible = "hisilicon,hix5hd2-i2c";
+			reg = <0xb17000 0x1000>;
+			interrupts = <0 44 4>;
+			clocks = <&clock HIX5HD2_I2C5_RST>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5
