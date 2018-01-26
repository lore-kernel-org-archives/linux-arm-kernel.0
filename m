From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 26 Jan 2018 17:23:39 +0100
Subject: [PATCH] ARM: dts: stm32: Fix HSE clock frequency for stm32h743i-disco
 board
Message-ID: <1516983819-6567-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

The HSE oscillator frequency was wrongly set to 125MHz instead of 25MHz.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32h743i-disco.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32h743i-disco.dts b/arch/arm/boot/dts/stm32h743i-disco.dts
index 79e841d94079..45e088c55741 100644
--- a/arch/arm/boot/dts/stm32h743i-disco.dts
+++ b/arch/arm/boot/dts/stm32h743i-disco.dts
@@ -63,7 +63,7 @@
 };
 
 &clk_hse {
-	clock-frequency = <125000000>;
+	clock-frequency = <25000000>;
 };
 
 &usart2 {
-- 
1.9.1
