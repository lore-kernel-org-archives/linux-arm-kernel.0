From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Tue, 20 May 2014 15:22:48 +0200
Subject: [PATCH v3 04/11] ARM: STi: DT: STiH416: Remove unused CLK_S_GMAC0_PHY
 & CLK_S_ETH1_PHY fixed clocks
In-Reply-To: <1400592175-13176-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1400592175-13176-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1400592175-13176-5-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_S_GMAC0_PHY &  CLK_S_ETH1_PH clocks are no longer used.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih416-clock.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/stih416-clock.dtsi b/arch/arm/boot/dts/stih416-clock.dtsi
index 600aeef..072c587 100644
--- a/arch/arm/boot/dts/stih416-clock.dtsi
+++ b/arch/arm/boot/dts/stih416-clock.dtsi
@@ -33,20 +33,6 @@
 			clock-frequency = <600000000>;
 		};
 
-		CLK_S_GMAC0_PHY: clockgenA1 at 7 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <25000000>;
-			clock-output-names = "CLK_S_GMAC0_PHY";
-		};
-
-		CLK_S_ETH1_PHY: clockgenA0 at 7 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <25000000>;
-			clock-output-names = "CLK_S_ETH1_PHY";
-		};
-
 		/*
 		 * ClockGenAs on SASG2
 		 */
-- 
1.9.1
