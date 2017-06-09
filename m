From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Fri, 9 Jun 2017 09:37:54 +0200
Subject: [PATCH 2/2] dt-bindings: iio: update STM32 timers clock names
In-Reply-To: <1496993874-9870-1-git-send-email-fabrice.gasnier@st.com>
References: <1496993874-9870-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1496993874-9870-3-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock name has been updated during driver/DT binding review:
https://lkml.org/lkml/2016/12/13/718
Update DT binding doc to reflect this.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
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
