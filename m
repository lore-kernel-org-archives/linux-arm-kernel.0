From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Jun 2015 14:59:03 +0100
Subject: [PATCH v2 4/9] ARM: STi: STiH407: Provide CPU with a means to look-up
 Major number
In-Reply-To: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1435154348-28840-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used for CPU Frequency Scaling.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index f48767e..838f1c3 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -32,6 +32,7 @@
 			clock-names = "cpu";
 			clock-latency = <100000>;
 			cpu0-supply = <&pwm_regulator>;
+			st,syscfg = <&syscfg_core 0x8e0>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
-- 
1.9.1
