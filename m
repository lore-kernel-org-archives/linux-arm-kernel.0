From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  7 May 2015 14:38:42 +0100
Subject: [PATCH 10/12] ARM: STi: DT: STih407: Switch LPC mode from RTC to
 Clocksource
In-Reply-To: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1431005924-21777-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This aligns with the internal configuration.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 2b2315d..bf1c7f5 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -354,7 +354,7 @@
 			reg = <0x8788000 0x1000>;
 			interrupts = <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clk_s_d3_flexgen CLK_LPC_1>;
-			st,lpc-mode = <ST_LPC_MODE_RTC>;
+			st,lpc-mode = <ST_LPC_MODE_CLKSRC>;
 		};
 	};
 };
-- 
1.9.1
