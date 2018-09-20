From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 20 Sep 2018 18:17:06 +0200
Subject: [PATCH] ARM: dts: stm32: update HASH1 dma property on stm32mp157c
Message-ID: <1537460226-1435-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused parameter from HASH1 dma property on stm32mp157c SoC.

Fixes: 1e726a40e067 ("ARM: dts: stm32: Add HASH support on stm32mp157c")

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 185541a..04cf534 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -923,7 +923,7 @@
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc HASH1>;
 			resets = <&rcc HASH1_R>;
-			dmas = <&mdma1 31 0x10 0x1000A02 0x0 0x0 0x0>;
+			dmas = <&mdma1 31 0x10 0x1000A02 0x0 0x0>;
 			dma-names = "in";
 			dma-maxburst = <2>;
 			status = "disabled";
-- 
2.7.4
