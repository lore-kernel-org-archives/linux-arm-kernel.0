From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Apr 2016 16:07:47 +0100
Subject: [[PATCH v2] 8/8] ARM: dts: STi: STih407: Switch LPC mode from RTC to
 Clocksource
In-Reply-To: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
References: <1461251267-14897-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1461251267-14897-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This aligns with the internal configuration.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 33de7361..ad8ba10 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -584,7 +584,7 @@
 			reg = <0x8788000 0x1000>;
 			interrupts = <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>;
 			clocks = <&clk_s_d3_flexgen CLK_LPC_1>;
-			st,lpc-mode = <ST_LPC_MODE_RTC>;
+			st,lpc-mode = <ST_LPC_MODE_CLKSRC>;
 		};
 
 		sata0: sata at 9b20000 {
-- 
2.8.0
