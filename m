From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Mon, 12 Mar 2018 15:03:41 +0800
Subject: [PATCH v2 4/5] arm64: dts: add clock device nodes of MT2712
In-Reply-To: <20180312070342.4335-1-weiyi.lu@mediatek.com>
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
Message-ID: <20180312070342.4335-6-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add new clocks according to ECO design change

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index fdf66f4fe7c3..d7688bc9db1b 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -199,6 +199,34 @@
 		clock-output-names = "clkaud_ext_i_2";
 	};
 
+	clki2si0_mck_i: oscillator at 6 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <30000000>;
+		clock-output-names = "clki2si0_mck_i";
+	};
+
+	clki2si1_mck_i: oscillator at 7 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <30000000>;
+		clock-output-names = "clki2si1_mck_i";
+	};
+
+	clki2si2_mck_i: oscillator at 8 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <30000000>;
+		clock-output-names = "clki2si2_mck_i";
+	};
+
+	clktdmin_mclk_i: oscillator at 9 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <30000000>;
+		clock-output-names = "clktdmin_mclk_i";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-- 
2.12.5
