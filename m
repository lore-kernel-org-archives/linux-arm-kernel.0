From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 4 Jul 2016 15:47:32 +0200
Subject: [PATCH 4/4] ARM: dts: stm32f429: add missing #reset-cells of rcc
In-Reply-To: <1467640052-6770-1-git-send-email-gabriel.fernandez@st.com>
References: <1467640052-6770-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1467640052-6770-4-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch adds #reset-cells property to rcc node.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 35df462..fe89236 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -326,6 +326,7 @@
 		};
 
 		rcc: rcc at 40023810 {
+			#reset-cells = <1>;
 			#clock-cells = <2>;
 			compatible = "st,stm32f42xx-rcc", "st,stm32-rcc";
 			reg = <0x40023800 0x400>;
-- 
1.9.1
