From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Thu, 19 Jul 2018 15:10:42 +0200
Subject: [U-BOOT internal] ARM: dts: stm32: Add clk-lse node's label on
 stm32f429
Message-ID: <1532005842-3264-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Add missing clk_lse label for node clk-lse.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index ede77e0f1c41..64278e81bc08 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -58,7 +58,7 @@
 			clock-frequency = <0>;
 		};
 
-		clk-lse {
+		clk_lse: clk-lse {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
-- 
1.9.1
