From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 13 Nov 2018 10:51:40 +0100
Subject: [PATCH 1/3] dt-bindings: pinctrl: stm32: Document hwlocks properties
In-Reply-To: <20181113095142.32015-1-benjamin.gaignard@st.com>
References: <20181113095142.32015-1-benjamin.gaignard@st.com>
Message-ID: <20181113095142.32015-2-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hwlocks as optional property

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index ef4f2ff4a1aa..48df30a36b01 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -56,6 +56,7 @@ Optional properties:
    More details in Documentation/devicetree/bindings/gpio/gpio.txt.
  - st,bank-ioport: should correspond to the EXTI IOport selection (EXTI line
    used to select GPIOs as interrupts).
+ - hwlocks: reference to a phandle of a hardware spinlock provider node.
 
 Example 1:
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
-- 
2.15.0
