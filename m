From: mporter@linaro.org (Matt Porter)
Date: Mon,  3 Feb 2014 08:40:32 -0500
Subject: [PATCH v2 6/6] ARM: dts: AM33XX: Add ecap interrupt properties
In-Reply-To: <1391434832-23807-1-git-send-email-mporter@linaro.org>
References: <1391434832-23807-1-git-send-email-mporter@linaro.org>
Message-ID: <1391434832-23807-7-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing interrupt properties to the ecap0, ecap1, and ecap2
nodes.

Signed-off-by: Matt Porter <mporter@linaro.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 6d95d3d..b4139ba 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -582,6 +582,8 @@
 				compatible = "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48300100 0x80>;
+				interrupts = <31>;
+				interrupt-names = "ecap0";
 				ti,hwmods = "ecap0";
 				status = "disabled";
 			};
@@ -610,6 +612,8 @@
 				compatible = "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48302100 0x80>;
+				interrupts = <47>;
+				interrupt-names = "ecap1";
 				ti,hwmods = "ecap1";
 				status = "disabled";
 			};
@@ -638,6 +642,8 @@
 				compatible = "ti,am33xx-ecap";
 				#pwm-cells = <3>;
 				reg = <0x48304100 0x80>;
+				interrupts = <61>;
+				interrupt-names = "ecap2";
 				ti,hwmods = "ecap2";
 				status = "disabled";
 			};
-- 
1.8.4
