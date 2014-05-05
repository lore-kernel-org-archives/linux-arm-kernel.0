From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon,  5 May 2014 17:53:42 +0200
Subject: [PATCH 8/9] ARM: STi: DT: STiH415: Remove unused CLK_S_GMAC0_PHY &
 CLK_S_ETH1_PHY fixed clocks
In-Reply-To: <1399305223-18703-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1399305223-18703-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1399305223-18703-9-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_S_GMAC0_PHY &  CLK_S_ETH1_PH clocks are no longer used.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih415-clock.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/stih415-clock.dtsi b/arch/arm/boot/dts/stih415-clock.dtsi
index 5bdba06..24a7508 100644
--- a/arch/arm/boot/dts/stih415-clock.dtsi
+++ b/arch/arm/boot/dts/stih415-clock.dtsi
@@ -32,20 +32,6 @@
 			clock-frequency = <500000000>;
 		};
 
-		CLKS_GMAC0_PHY: clockgenA1 at 7 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <25000000>;
-			clock-output-names = "CLKS_GMAC0_PHY";
-		};
-
-		CLKS_ETH1_PHY: clockgenA0 at 7 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <25000000>;
-			clock-output-names = "CLKS_ETH1_PHY";
-		};
-
 		/*
 		 * ClockGenAs on SASG1
 		 */
-- 
1.9.1
