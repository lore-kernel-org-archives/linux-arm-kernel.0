From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 18 May 2016 10:41:26 +0200
Subject: [PATCH 05/11] ARM: DT: STiH410: Add compatibility string on clkgend0
 for audio clocks
In-Reply-To: <1463560892-7209-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1463560892-7209-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1463560892-7209-6-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is used in the clock driver to apply a clock propagation
flag on the audio clocks of STiH410

Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih410-clock.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index d1f2aca..c265e54 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -226,7 +226,7 @@
 
 			clk_s_d0_flexgen: clk-s-d0-flexgen {
 				#clock-cells = <1>;
-				compatible = "st,flexgen";
+				compatible = "st,stih407-clkgend0", "st,flexgen";
 
 				clocks = <&clk_s_d0_quadfs 0>,
 					 <&clk_s_d0_quadfs 1>,
-- 
1.9.1
