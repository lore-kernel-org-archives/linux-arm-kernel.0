From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Tue, 31 Jan 2017 14:14:20 +0100
Subject: [PATCH 3/8] Documentation: dt-bindings: Add STM32 pinctrl driver DT
 bindings
In-Reply-To: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
References: <1485868465-30446-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1485868465-30446-4-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add compatible sting for stm32h743 MCU.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index b24583a..ac8dcb7 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -10,6 +10,7 @@ Required properies:
  - compatible: value should be one of the following:
    (a) "st,stm32f429-pinctrl"
    (b) "st,stm32f746-pinctrl"
+   (c) "st,stm32h743-pinctrl"
  - #address-cells: The value of this property must be 1
  - #size-cells	: The value of this property must be 1
  - ranges	: defines mapping between pin controller node (parent) to
-- 
1.9.1
