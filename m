From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon,  5 May 2014 17:53:36 +0200
Subject: [PATCH 2/9] ARM: STi: DT: STiH416: Remove unused CLK_S_ICN_REG_0
 fixed clock
In-Reply-To: <1399305223-18703-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1399305223-18703-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1399305223-18703-3-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_S_ICN_REG_0 clock is no longer used.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih416-clock.dtsi | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/boot/dts/stih416-clock.dtsi b/arch/arm/boot/dts/stih416-clock.dtsi
index 66693e4..47bbfd4 100644
--- a/arch/arm/boot/dts/stih416-clock.dtsi
+++ b/arch/arm/boot/dts/stih416-clock.dtsi
@@ -34,17 +34,6 @@
 			clock-frequency = <600000000>;
 		};
 
-		/*
-		 * Bootloader initialized system infrastructure clock for
-		 * serial devices.
-		 */
-		CLK_S_ICN_REG_0: clockgenA0 at 4 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <100000000>;
-			clock-output-names = "CLK_S_ICN_REG_0";
-		};
-
 		CLK_S_GMAC0_PHY: clockgenA1 at 7 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
-- 
1.9.1
