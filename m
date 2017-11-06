From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 6 Nov 2017 18:03:33 +0100
Subject: [PATCH v3 3/9] dt-bindings: interrupt-controllers: add compatible
 string for stm32h7
In-Reply-To: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
References: <1509987819-29599-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1509987819-29599-4-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch updates stm32-exti documentation with stm32h7-exti
compatible string.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
index 6e7703d..edf03f0 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
@@ -2,7 +2,9 @@ STM32 External Interrupt Controller
 
 Required properties:
 
-- compatible: Should be "st,stm32-exti"
+- compatible: Should be:
+    "st,stm32-exti"
+    "st,stm32h7-exti"
 - reg: Specifies base physical address and size of the registers
 - interrupt-controller: Indentifies the node as an interrupt controller
 - #interrupt-cells: Specifies the number of cells to encode an interrupt
-- 
2.7.4
