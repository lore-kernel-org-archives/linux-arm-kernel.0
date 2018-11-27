From: patrick.havelange@essensium.com (Patrick Havelange)
Date: Tue, 27 Nov 2018 15:09:44 +0100
Subject: [PATCH 1/1] ARM: dts: ls1021a: add nodes for PWMs
Message-ID: <20181127140944.31018-1-patrick.havelange@essensium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LS1021A has 8 possible PWMs, so adding them (disabled by default)

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 96 ++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index bdd6e66a79ad..d3014da9a66b 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -525,6 +525,102 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm at 29d0000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm1: pwm at 29e0000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x29e0000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm2: pwm at 29f0000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x29f0000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm3: pwm at 2a00000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a00000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm4: pwm at 2a10000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a10000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm5: pwm at 2a20000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a20000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm6: pwm at 2a30000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a30000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm7: pwm at 2a40000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a40000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
 		wdog0: watchdog at 2ad0000 {
 			compatible = "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
-- 
2.17.1
