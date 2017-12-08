From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 8 Dec 2017 14:56:34 +0100
Subject: [PATCH 1/1] dt-bindings: arm: document supported STM32 SoC family
Message-ID: <1512741394-27341-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This adds a list of supported STM32 SoC bindings.

Signed-off-by: Gwenael Treuveur <gwenael.treuveur@st.com>
Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/devicetree/bindings/arm/stm32.txt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32.txt

diff --git a/Documentation/devicetree/bindings/arm/stm32.txt b/Documentation/devicetree/bindings/arm/stm32.txt
new file mode 100644
index 0000000..05762b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/stm32.txt
@@ -0,0 +1,9 @@
+STMicroelectronics STM32 Platforms Device Tree Bindings
+
+Each device tree must specify which STM32 SoC it uses,
+using one of the following compatible strings:
+
+  st,stm32f429
+  st,stm32f469
+  st,stm32f746
+  st,stm32h743
-- 
2.7.4
