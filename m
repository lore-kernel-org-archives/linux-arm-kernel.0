From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 18 Dec 2017 16:17:44 +0100
Subject: [PATCH V2 1/9] devicetree: bindings: Document supported STM32 SoC
 family
In-Reply-To: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1513610272-7824-2-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This adds a list of supported STM32 SoC bindings.

Signed-off-by: Gwenael Treuveur <gwenael.treuveur@st.com>
Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
