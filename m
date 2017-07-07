From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 7 Jul 2017 09:26:26 +0200
Subject: [PATCH 3/8] dt-bindings: interrupt-controllers: add compatible string
 for stm32h7
In-Reply-To: <1499412391-25480-1-git-send-email-ludovic.Barre@st.com>
References: <1499412391-25480-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1499412391-25480-4-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
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
