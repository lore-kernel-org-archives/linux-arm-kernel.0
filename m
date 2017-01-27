From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 27 Jan 2017 17:15:19 +0100
Subject: [PATCH 6/8] Documentation: dt: Add new compatible to STM32 pinctrl
 driver bindings
In-Reply-To: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
References: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1485533721-9019-7-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new compatible for stm32f469 MCU.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index 25d9809..4f0487d 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -9,7 +9,8 @@ Pin controller node:
 Required properies:
  - compatible: value should be one of the following:
    (a) "st,stm32f429-pinctrl"
-   (b) "st,stm32f746-pinctrl"
+   (b) "st,stm32f469-pinctrl"
+   (c) "st,stm32f746-pinctrl"
  - #address-cells: The value of this property must be 1
  - #size-cells	: The value of this property must be 1
  - ranges	: defines mapping between pin controller node (parent) to
-- 
1.9.1
