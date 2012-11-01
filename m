From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 1 Nov 2012 10:49:26 -0500
Subject: [PATCH 2/3] ARM: dts: Add OMAP5 timer nodes
In-Reply-To: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
References: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1351784967-32520-3-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 11 timer nodes for OMAP5 devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   89 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 930dbfe..c8954f1 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -379,5 +379,94 @@
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp3";
 		};
+
+		timer1: timer at 4ae18000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4ae18000 0x80>;
+			interrupts = <0 37 0x4>;
+			ti,hwmods = "timer1";
+			ti,timer-alwon;
+		};
+
+		timer2: timer at 48032000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48032000 0x80>;
+			interrupts = <0 38 0x4>;
+			ti,hwmods = "timer2";
+		};
+
+		timer3: timer at 48034000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48034000 0x80>;
+			interrupts = <0 39 0x4>;
+			ti,hwmods = "timer3";
+		};
+
+		timer4: timer at 48036000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48036000 0x80>;
+			interrupts = <0 40 0x4>;
+			ti,hwmods = "timer4";
+		};
+
+		timer5: timer at 40138000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x40138000 0x80>,
+			      <0x49038000 0x80>;
+			interrupts = <0 41 0x4>;
+			ti,hwmods = "timer5";
+			ti,timer-dsp;
+		};
+
+		timer6: timer at 4013a000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4013a000 0x80>,
+			      <0x4903a000 0x80>;
+			interrupts = <0 42 0x4>;
+			ti,hwmods = "timer6";
+			ti,timer-dsp;
+			ti,timer-pwm;
+		};
+
+		timer7: timer at 4013c000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4013c000 0x80>,
+			      <0x4903c000 0x80>;
+			interrupts = <0 43 0x4>;
+			ti,hwmods = "timer7";
+			ti,timer-dsp;
+		};
+
+		timer8: timer at 4013e000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4013e000 0x80>,
+			      <0x4903e000 0x80>;
+			interrupts = <0 44 0x4>;
+			ti,hwmods = "timer8";
+			ti,timer-dsp;
+			ti,timer-pwm;
+		};
+
+		timer9: timer at 4803e000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4803e000 0x80>;
+			interrupts = <0 45 0x4>;
+			ti,hwmods = "timer9";
+		};
+
+		timer10: timer at 48086000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48086000 0x80>;
+			interrupts = <0 46 0x4>;
+			ti,hwmods = "timer10";
+		};
+
+		timer11: timer at 48088000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48088000 0x80>;
+			interrupts = <0 47 0x4>;
+			ti,hwmods = "timer11";
+			ti,timer-pwm;
+		};
 	};
 };
-- 
1.7.9.5
