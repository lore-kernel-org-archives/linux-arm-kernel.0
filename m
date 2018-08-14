From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Tue, 14 Aug 2018 18:38:39 +0800
Subject: [PATCH v3 1/2] dt-bindings: arm: amlogic: Add Meson G12A binding
In-Reply-To: <1534243121-33589-1-git-send-email-jianxin.pan@amlogic.com>
References: <1534243121-33589-1-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <1534243121-33589-2-git-send-email-jianxin.pan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce new bindings for the Meson G12A SoC

Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index b5c2b5c..cf4bbc7 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -57,6 +57,10 @@ Boards with the Amlogic Meson AXG A113D SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,a113d", "amlogic,meson-axg";
 
+Boards with the Amlogic Meson G12A S905D2 SoC shall have the following properties:
+  Required root node property:
+    compatible: "amlogic,g12a";
+
 Board compatible values (alphabetically, grouped by SoC):
 
   - "geniatech,atv1200" (Meson6)
@@ -101,6 +105,8 @@ Board compatible values (alphabetically, grouped by SoC):
 
   - "amlogic,s400" (Meson axg a113d)
 
+  - "amlogic,u200" (Meson g12a s905d2)
+
 Amlogic Meson Firmware registers Interface
 ------------------------------------------
 
-- 
1.9.1
