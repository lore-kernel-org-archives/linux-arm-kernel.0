From: philippe.cornu@st.com (Philippe CORNU)
Date: Fri, 2 Jun 2017 16:37:13 +0200
Subject: [PATCH v3 4/6] dt-bindings: display: stm32: remove
 st-display-subsystem parent node requirement
In-Reply-To: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
References: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
Message-ID: <1496414235-20098-5-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need anymore to have a "st-display-subsystem" parent node
in the device tree for the ltdc.

Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
---
 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
index 8e14769..90a8459 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
@@ -1,7 +1,6 @@
 * STMicroelectronics STM32 lcd-tft display controller
 
 - ltdc: lcd-tft display controller host
-  must be a sub-node of st-display-subsystem
   Required properties:
   - compatible: "st,stm32-ltdc"
   - reg: Physical base address of the IP registers and length of memory mapped region.
-- 
1.9.1
