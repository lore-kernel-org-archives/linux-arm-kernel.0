From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Sat, 1 Oct 2016 15:42:33 +0530
Subject: [PATCH v2 4/6] arm: dts: imx7: Update #pwm-cells for PWM polarity
 control
In-Reply-To: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
References: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
Message-ID: <20161001101235.24598-5-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update #pwm-cells to 3 in order to support PWM signal polarity control.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 0d7d5ac..8d1d471 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -601,7 +601,7 @@
 				clocks = <&clks IMX7D_PWM1_ROOT_CLK>,
 					 <&clks IMX7D_PWM1_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -612,7 +612,7 @@
 				clocks = <&clks IMX7D_PWM2_ROOT_CLK>,
 					 <&clks IMX7D_PWM2_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -623,7 +623,7 @@
 				clocks = <&clks IMX7D_PWM3_ROOT_CLK>,
 					 <&clks IMX7D_PWM3_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -634,7 +634,7 @@
 				clocks = <&clks IMX7D_PWM4_ROOT_CLK>,
 					 <&clks IMX7D_PWM4_ROOT_CLK>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
-- 
2.9.2
