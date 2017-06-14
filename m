From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 14 Jun 2017 17:13:16 +0200
Subject: [PATCH v2 3/3] dt-bindings: pwm: update STM32 timers clock names
In-Reply-To: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
References: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1497453196-31470-4-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock name has been updated during driver/DT binding review:
https://lkml.org/lkml/2016/12/13/718
Update DT binding doc to reflect this.

Fixes: cd9a99c2f8e8 (dt-bindings: pwm: Add STM32 bindings)
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/pwm/pwm-stm32.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
index 6dd0403..3e6d550 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -24,7 +24,7 @@ Example:
 		compatible = "st,stm32-timers";
 		reg = <0x40010000 0x400>;
 		clocks = <&rcc 0 160>;
-		clock-names = "clk_int";
+		clock-names = "int";
 
 		pwm {
 			compatible = "st,stm32-pwm";
-- 
1.9.1
