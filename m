From: christophe.roullier@st.com (Christophe Roullier)
Date: Wed, 2 May 2018 16:18:43 +0200
Subject: [PATCH V2 8/8] dt-bindings: stm32: add compatible for syscon
In-Reply-To: <1525270723-18241-1-git-send-email-christophe.roullier@st.com>
References: <1525270723-18241-1-git-send-email-christophe.roullier@st.com>
Message-ID: <1525270723-18241-9-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch describes syscon DT bindings.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 Documentation/devicetree/bindings/arm/stm32.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32.txt b/Documentation/devicetree/bindings/arm/stm32.txt
index 6808ed9..06e3834 100644
--- a/Documentation/devicetree/bindings/arm/stm32.txt
+++ b/Documentation/devicetree/bindings/arm/stm32.txt
@@ -8,3 +8,7 @@ using one of the following compatible strings:
   st,stm32f746
   st,stm32h743
   st,stm32mp157
+
+Required nodes:
+- syscon: the soc bus node must have a system controller node pointing to the
+  global control registers, with the compatible string "syscon";
-- 
1.9.1
