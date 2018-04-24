From: christophe.roullier@st.com (Christophe Roullier)
Date: Tue, 24 Apr 2018 17:02:00 +0200
Subject: [PATCH  8/8] dt-bindings: stm32: add compatible for syscon
In-Reply-To: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
References: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
Message-ID: <1524582120-4451-9-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch describes syscon DT bindings.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 Documentation/devicetree/bindings/arm/stm32.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32.txt b/Documentation/devicetree/bindings/arm/stm32.txt
index 6808ed9..a871a78 100644
--- a/Documentation/devicetree/bindings/arm/stm32.txt
+++ b/Documentation/devicetree/bindings/arm/stm32.txt
@@ -8,3 +8,10 @@ using one of the following compatible strings:
   st,stm32f746
   st,stm32h743
   st,stm32mp157
+
+Required nodes:
+
+- syscon: some subnode of the STM32 SoC node must be a
+  system controller node pointing to the control registers,
+  with the compatible string set to one of these tuples:
+  "st,stm32-syscfg", "syscon"
-- 
1.9.1
