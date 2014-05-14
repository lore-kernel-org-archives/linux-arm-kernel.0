From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 14 May 2014 15:24:11 +0200
Subject: [PATCH v2 03/10] ARM: STi: DT: STiH416: Remove unused CLK_S_GMAC0_PHY
 & CLK_S_ETH1_PHY fixed clocks
In-Reply-To: <1400073858-28912-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1400073858-28912-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1400073858-28912-4-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_S_GMAC0_PHY &  CLK_S_ETH1_PH clocks are no longer used.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih416-clock.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/stih416-clock.dtsi b/arch/arm/boot/dts/stih416-clock.dtsi
index 4bb6633..d7a3b88 100644
--- a/arch/arm/boot/dts/stih416-clock.dtsi
+++ b/arch/arm/boot/dts/stih416-clock.dtsi
@@ -34,20 +34,6 @@
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
