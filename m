From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  8 Jun 2016 10:21:21 +0100
Subject: [PATCH v3 06/20] ARM: dts: STiH416: Define PWM Capture clock
In-Reply-To: <20160608092135.21184-1-lee.jones@linaro.org>
References: <20160608092135.21184-1-lee.jones@linaro.org>
Message-ID: <20160608092135.21184-7-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 28d84c71..c93e78d2 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -483,8 +483,8 @@
 					&pinctrl_pwm0_chan2_default
 					&pinctrl_pwm0_chan3_default>;
 
-			clock-names	= "pwm";
-			clocks		= <&clk_sysin>;
+			clock-names	= "pwm", "capture";
+			clocks		= <&clk_sysin>, <&clk_s_a0_ls CLK_ICN_REG>;
 
 			st,pwm-num-devs = <4>;
 		};
-- 
2.8.3
