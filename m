From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Aug 2016 10:34:57 +0100
Subject: [PATCH v4 06/17] ARM: dts: STiH416: Define the number of PWM Capture
 channels
In-Reply-To: <20160816093508.28307-1-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
Message-ID: <20160816093508.28307-7-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index bf15a32..422f9bd 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -487,6 +487,7 @@
 			clocks		= <&clk_sysin>, <&clk_s_a0_ls CLK_ICN_REG>;
 
 			st,pwm-num-chan = <4>;
+			st,capture-num-chan = <2>;
 		};
 
 		/* SBC PWM Module */
-- 
2.9.0
