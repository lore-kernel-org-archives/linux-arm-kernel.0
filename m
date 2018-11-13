From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 13 Nov 2018 15:48:03 +0100
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: stm32: Document hwlock
 properties
In-Reply-To: <20181113144805.1054-1-benjamin.gaignard@st.com>
References: <20181113144805.1054-1-benjamin.gaignard@st.com>
Message-ID: <20181113144805.1054-2-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hwlocks as optional property

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
index 6a36bf66d932..cd01b2292ec6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
@@ -14,6 +14,10 @@ Required properties:
   (only needed for exti controller with multiple exti under
   same parent interrupt: st,stm32-exti and st,stm32h7-exti)
 
+Optional properties:
+
+- hwlocks: reference to a phandle of a hardware spinlock provider node.
+
 Example:
 
 exti: interrupt-controller at 40013c00 {
-- 
2.15.0
