From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Sat, 30 Aug 2014 12:15:41 +0800
Subject: [PATCH v3 5/6] ARM: dts: hix5hd2: add gpio node
In-Reply-To: <1409372142-5960-1-git-send-email-zhangfei.gao@linaro.org>
References: <1409372142-5960-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1409372142-5960-6-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 arch/arm/boot/dts/hisi-x5hd2.dtsi |  234 +++++++++++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index 18f52f0..152f3ad 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -131,6 +131,240 @@
 				clock-names = "apb_pclk";
 				status = "disabled";
 			};
+
+			gpio0: gpio at b20000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb20000 0x1000>;
+				interrupts = <0 108 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio1: gpio at b21000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb21000 0x1000>;
+				interrupts = <0 109 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio2: gpio at b22000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb22000 0x1000>;
+				interrupts = <0 110 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio3: gpio at b23000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb23000 0x1000>;
+				interrupts = <0 111 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio4: gpio at b24000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb24000 0x1000>;
+				interrupts = <0 112 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio5: gpio at 004000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0x004000 0x1000>;
+				interrupts = <0 113 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio6: gpio at b26000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb26000 0x1000>;
+				interrupts = <0 114 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio7: gpio at b27000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb27000 0x1000>;
+				interrupts = <0 115 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio8: gpio at b28000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb28000 0x1000>;
+				interrupts = <0 116 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio9: gpio at b29000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb29000 0x1000>;
+				interrupts = <0 117 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio10: gpio at b2a000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb2a000 0x1000>;
+				interrupts = <0 118 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio11: gpio at b2b000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb2b000 0x1000>;
+				interrupts = <0 119 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio12: gpio at b2c000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb2c000 0x1000>;
+				interrupts = <0 120 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio13: gpio at b2d000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb2d000 0x1000>;
+				interrupts = <0 121 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio14: gpio at b2e000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb2e000 0x1000>;
+				interrupts = <0 122 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio15: gpio at b2f000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb2f000 0x1000>;
+				interrupts = <0 123 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio16: gpio at b30000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb30000 0x1000>;
+				interrupts = <0 124 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			gpio17: gpio at b31000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0xb31000 0x1000>;
+				interrupts = <0 125 0x4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&clock HIX5HD2_FIXED_100M>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
 		};
 
 		local_timer at 00a00600 {
-- 
1.7.9.5
