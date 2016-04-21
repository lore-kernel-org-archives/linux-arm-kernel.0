From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Apr 2016 16:07:43 +0100
Subject: [[PATCH v2] 4/8] ARM: dts: STi: STiH407: Provide CPU with a means to
 look-up Major number
In-Reply-To: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
References: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1461251267-14897-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used for CPU Frequency Scaling.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index d0e639cd..eb2601f 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -36,6 +36,7 @@
 			clock-names = "cpu";
 			clock-latency = <100000>;
 			cpu0-supply = <&pwm_regulator>;
+			st,syscfg = <&syscfg_core 0x8e0>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
-- 
2.8.0
