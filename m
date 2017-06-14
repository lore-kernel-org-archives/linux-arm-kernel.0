From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 14 Jun 2017 17:13:15 +0200
Subject: [PATCH v2 2/3] dt-bindings: iio: update STM32 timers clock names
In-Reply-To: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
References: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1497453196-31470-3-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock name has been updated during driver/DT binding review:
https://lkml.org/lkml/2016/12/13/718
Update DT binding doc to reflect this.

Fixes: bf2d8581b1b3 (iio: Add bindings for STM32 timer trigger driver)
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
index 55a653d..6abc755 100644
--- a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
@@ -14,7 +14,7 @@ Example:
 		compatible = "st,stm32-timers";
 		reg = <0x40010000 0x400>;
 		clocks = <&rcc 0 160>;
-		clock-names = "clk_int";
+		clock-names = "int";
 
 		timer at 0 {
 			compatible = "st,stm32-timer-trigger";
-- 
1.9.1
