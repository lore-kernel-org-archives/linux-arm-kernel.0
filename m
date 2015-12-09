From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  9 Dec 2015 15:58:13 +0000
Subject: [PATCH v6 06/10] ARM: STi: STiH407: Link CPU with its voltage supply
In-Reply-To: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
References: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449676697-25432-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Used for Voltage Scaling using CPUFreq.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index af9233b..d0e639cd 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -35,6 +35,7 @@
 			clocks = <&clk_m_a9>;
 			clock-names = "cpu";
 			clock-latency = <100000>;
+			cpu0-supply = <&pwm_regulator>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
-- 
1.9.1
