From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 11 Dec 2017 09:54:31 +0100
Subject: [PATCH 1/5] dt-bindings: pinctrl: Add st,
 stm32f769-pinctrl compatible to stm32-pinctrl
Message-ID: <1512982475-32661-2-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new compatible for stm32f769 MCU.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index 58c2a4c..fd7a4c7 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -11,6 +11,7 @@ Required properies:
    "st,stm32f429-pinctrl"
    "st,stm32f469-pinctrl"
    "st,stm32f746-pinctrl"
+   "st,stm32f769-pinctrl"
    "st,stm32h743-pinctrl"
  - #address-cells: The value of this property must be 1
  - #size-cells	: The value of this property must be 1
-- 
2.7.4
