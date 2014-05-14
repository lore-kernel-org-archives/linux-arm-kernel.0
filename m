From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 14 May 2014 15:24:16 +0200
Subject: [PATCH v2 08/10] ARM: STi: DT: STiH415: Remove unused CLK_S_GMAC0_PHY
 & CLK_S_ETH1_PHY fixed clocks
In-Reply-To: <1400073858-28912-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1400073858-28912-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1400073858-28912-9-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_S_GMAC0_PHY &  CLK_S_ETH1_PH clocks are no longer used.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih415-clock.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/stih415-clock.dtsi b/arch/arm/boot/dts/stih415-clock.dtsi
index 8b7a795..8618851 100644
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
