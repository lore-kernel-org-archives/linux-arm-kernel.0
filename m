From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 7 Apr 2017 14:43:02 +0200
Subject: [PATCH v2 5/7] Documentation: dt: Add new compatible to STM32 pinctrl
 driver bindings
In-Reply-To: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
References: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1491568984-20169-6-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new compatible for stm32f469 MCU.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index e4cda3d..d907a74 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -9,6 +9,7 @@ Pin controller node:
 Required properies:
  - compatible: value should be one of the following:
    "st,stm32f429-pinctrl"
+   "st,stm32f469-pinctrl"
    "st,stm32f746-pinctrl"
    "st,stm32h743-pinctrl"
  - #address-cells: The value of this property must be 1
-- 
1.9.1
