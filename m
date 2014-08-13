From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 13 Aug 2014 19:16:22 +0300
Subject: [PATCH 4/4] ARM: dts: keystone-k2hk: add dsp gpio controllers nodes
In-Reply-To: <1407946582-20927-1-git-send-email-grygorii.strashko@ti.com>
References: <1407946582-20927-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1407946582-20927-5-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Keystone 2 DSP GPIO nodes.
DSP GPIO banks 0-7 correspond to DSP0-DSP7

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2hk.dtsi |   56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/k2hk.dtsi b/arch/arm/boot/dts/k2hk.dtsi
index 321ba2f..009e180 100644
--- a/arch/arm/boot/dts/k2hk.dtsi
+++ b/arch/arm/boot/dts/k2hk.dtsi
@@ -50,5 +50,61 @@
 			#interrupt-cells = <1>;
 			ti,syscon-dev = <&devctrl 0x2a0>;
 		};
+
+		dspgpio0: keystone_dsp_gpio at 02620240 {
+			compatible = "ti,keystone-mctrl-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <&devctrl 0x240>;
+		};
+
+		dspgpio1: keystone_dsp_gpio at 2620244 {
+			compatible = "ti,keystone-mctrl-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <&devctrl 0x244>;
+		};
+
+		dspgpio2: keystone_dsp_gpio at 2620248 {
+			compatible = "ti,keystone-mctrl-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <&devctrl 0x248>;
+		};
+
+		dspgpio3: keystone_dsp_gpio at 262024c {
+			compatible = "ti,keystone-mctrl-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <&devctrl 0x24c>;
+		};
+
+		dspgpio4: keystone_dsp_gpio at 2620250 {
+			compatible = "ti,keystone-mctrl-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <&devctrl 0x250>;
+		};
+
+		dspgpio5: keystone_dsp_gpio at 2620254 {
+			compatible = "ti,keystone-mctrl-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <&devctrl 0x254>;
+		};
+
+		dspgpio6: keystone_dsp_gpio at 2620258 {
+			compatible = "ti,keystone-mctrl-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <&devctrl 0x258>;
+		};
+
+		dspgpio7: keystone_dsp_gpio at 262025C {
+			compatible = "ti,keystone-mctrl-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio,syscon-dev = <&devctrl 0x25c>;
+		};
 	};
 };
-- 
1.7.9.5
