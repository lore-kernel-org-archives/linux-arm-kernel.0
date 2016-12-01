From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 1 Dec 2016 16:27:49 +0100
Subject: [PATCH v3 9/9] ARM: dts: stm32f4: Include auxiliary stm32f4 clock
 definition
In-Reply-To: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
References: <1480606069-5178-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1480606069-5178-10-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch include auxiliary clock definition (clocks which are not derived
from system clock.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 7c7dfbd..223dc12 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -48,6 +48,7 @@
 #include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
+#include <dt-bindings/clock/stm32f4-clock.h>
 
 / {
 	clocks {
-- 
1.9.1
