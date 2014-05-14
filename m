From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 14 May 2014 15:24:15 +0200
Subject: [PATCH v2 07/10] ARM: STi: DT: STiH415: Remove unused CLK_S_ICN_REG_0
 fixed clock
In-Reply-To: <1400073858-28912-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1400073858-28912-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1400073858-28912-8-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_S_ICN_REG_0 clock is no longer used.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih415-clock.dtsi | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/stih415-clock.dtsi b/arch/arm/boot/dts/stih415-clock.dtsi
index 9b8f4c0..8b7a795 100644
--- a/arch/arm/boot/dts/stih415-clock.dtsi
+++ b/arch/arm/boot/dts/stih415-clock.dtsi
@@ -32,16 +32,6 @@
 			clock-frequency = <500000000>;
 		};
 
-		/*
-		 * Bootloader initialized system infrastructure clock for
-		 * serial devices.
-		 */
-		CLKS_ICN_REG_0: CLKS_ICN_REG_0 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <100000000>;
-		};
-
 		CLKS_GMAC0_PHY: clockgenA1 at 7 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
-- 
1.9.1
