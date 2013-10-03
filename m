From: mats.liljegren@enea.com (Mats Liljegren)
Date: Thu, 3 Oct 2013 15:35:46 +0200
Subject: [PATCH] tci6638: dts: Add timer64 definitions
In-Reply-To: <1380807346-19395-1-git-send-email-mats.liljegren@enea.com>
References: <1380807346-19395-1-git-send-email-mats.liljegren@enea.com>
Message-ID: <1380807346-19395-2-git-send-email-mats.liljegren@enea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mats Liljegren <mats.liljegren@enea.com>
---
 arch/arm/boot/dts/k2hk-evm.dts |  160 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index 16cf335..40c1dc1 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -1344,6 +1344,166 @@
 			interrupts	= <0 280 0xf01>;
 		};
 
+		timer0 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x2200000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 80 0xf01
+					   0 81 0xf01>;
+		};
+
+		timer1 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x2210000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 82 0xf01
+					   0 83 0xf01>;
+		};
+
+		timer2 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x2220000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 84 0xf01
+					   0 85 0xf01>;
+		};
+
+		timer3 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x2230000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 86 0xf01
+					   0 87 0xf01>;
+		};
+
+		timer4 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x2240000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 88 0xf01
+					   0 89 0xf01>;
+		};
+
+		timer5 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x2250000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 90 0xf01
+					   0 91 0xf01>;
+		};
+
+		timer6 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x2260000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 92 0xf01
+					   0 93 0xf01>;
+		};
+
+		timer7 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x2270000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 94 0xf01
+					   0 95 0xf01>;
+		};
+
+		timer8 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x2280000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 96 0xf01
+					   0 97 0xf01>;
+		};
+
+		timer9 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x2290000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 98 0xf01
+					   0 99 0xf01>;
+		};
+
+		timer10 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x22a0000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 100 0xf01
+					   0 101 0xf01>;
+		};
+
+		timer11 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x22b0000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 102 0xf01
+					   0 103 0xf01>;
+		};
+
+		timer12 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x22c0000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 104 0xf01
+					   0 105 0xf01>;
+		};
+
+		timer13 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x22d0000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 106 0xf01
+					   0 107 0xf01>;
+		};
+
+		timer14 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x22e0000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 108 0xf01
+					   0 109 0xf01>;
+		};
+
+		timer15 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x22f0000 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 110 0xf01
+					   0 111 0xf01>;
+		};
+
+		timer16 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x22f0080 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 112 0xf01
+					   0 113 0xf01>;
+		};
+
+		timer17 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x22f0100 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 114 0xf01
+					   0 115 0xf01>;
+		};
+
+		timer18 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x22f0180 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 116 0xf01
+					   0 117 0xf01>;
+		};
+
+		timer19 {
+			compatible	= "arm,arm-timer64";
+			reg		= <0x22f0200 0x80>;
+			clocks		= <&clkmodrst0>;
+			interrupts	= <0 118 0xf01
+					   0 119 0xf01>;
+		};
+
 		aemif at 30000000 {
 			compatible = "ti,davinci-aemif";
 			#address-cells = <2>;
-- 
1.7.10.4
