From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Tue, 5 Jul 2016 15:40:17 +0200
Subject: [PATCH 3/3] Documentation: dt: Add new compatible to STM32 pinctrl
 driver bindings
In-Reply-To: <1467726017-20041-1-git-send-email-alexandre.torgue@st.com>
References: <1467726017-20041-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1467726017-20041-4-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index 7b4800c..587bffb 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -9,6 +9,7 @@ Pin controller node:
 Required properies:
  - compatible: value should be one of the following:
    (a) "st,stm32f429-pinctrl"
+   (b) "st,stm32f746-pinctrl"
  - #address-cells: The value of this property must be 1
  - #size-cells	: The value of this property must be 1
  - ranges	: defines mapping between pin controller node (parent) to
-- 
1.9.1
