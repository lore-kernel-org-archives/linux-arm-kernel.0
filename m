From: christophe.roullier@st.com (Christophe Roullier)
Date: Mon, 21 May 2018 10:07:26 +0200
Subject: [PATCH V3 8/8] dt-bindings: stm32: add compatible for syscon
In-Reply-To: <1526890046-10565-1-git-send-email-christophe.roullier@st.com>
References: <1526890046-10565-1-git-send-email-christophe.roullier@st.com>
Message-ID: <1526890046-10565-9-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch describes syscon DT bindings.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 Documentation/devicetree/bindings/arm/stm32.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32.txt b/Documentation/devicetree/bindings/arm/stm32.txt
index 6808ed9..e46ebad 100644
--- a/Documentation/devicetree/bindings/arm/stm32.txt
+++ b/Documentation/devicetree/bindings/arm/stm32.txt
@@ -8,3 +8,8 @@ using one of the following compatible strings:
   st,stm32f746
   st,stm32h743
   st,stm32mp157
+
+Required nodes:
+- syscon: the soc bus node must have a system controller node pointing to the
+  global control registers, with the compatible string
+  "st,stm32mp157-syscfg", "syscon";
-- 
1.9.1
