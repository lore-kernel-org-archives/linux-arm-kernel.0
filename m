From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 21 Aug 2014 19:23:23 +0300
Subject: [PATCH v2 3/3] ARM: dts: keystone-k2hk: add dsp gpio controllers nodes
In-Reply-To: <1408638203-8246-1-git-send-email-grygorii.strashko@ti.com>
References: <53ECE9B1.4060303@ti.com>
 <1408638203-8246-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1408638203-8246-4-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Keystone 2 DSP GPIO nodes.
DSP GPIO banks 0-7 correspond to DSP0-DSP7

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2hk.dtsi |   48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/k2hk.dtsi b/arch/arm/boot/dts/k2hk.dtsi
index 321ba2f..84a8887 100644
--- a/arch/arm/boot/dts/k2hk.dtsi
+++ b/arch/arm/boot/dts/k2hk.dtsi
@@ -50,5 +50,53 @@
 			#interrupt-cells = <1>;
 			ti,syscon-dev = <&devctrl 0x2a0>;
 		};
+
+		dspgpio0: keystone_dsp_gpio at 02620240 {
+			compatible = "ti,keystone-dsp-gpio0";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		dspgpio1: keystone_dsp_gpio at 02620244 {
+			compatible = "ti,keystone-dsp-gpio1";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		dspgpio2: keystone_dsp_gpio at 02620248 {
+			compatible = "ti,keystone-dsp-gpio2";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		dspgpio3: keystone_dsp_gpio at 0262024c {
+			compatible = "ti,keystone-dsp-gpio3";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		dspgpio4: keystone_dsp_gpio at 02620250 {
+			compatible = "ti,keystone-dsp-gpio4";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		dspgpio5: keystone_dsp_gpio at 02620254 {
+			compatible = "ti,keystone-dsp-gpio5";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		dspgpio6: keystone_dsp_gpio at 02620258 {
+			compatible = "ti,keystone-dsp-gpio6";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		dspgpio7: keystone_dsp_gpio at 0262025C {
+			compatible = "ti,keystone-dsp-gpio7";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
 	};
 };
-- 
1.7.9.5
