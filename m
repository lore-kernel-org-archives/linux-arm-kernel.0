From: dlan@gentoo.org (Yixun Lan)
Date: Sat, 14 Oct 2017 07:13:12 +0800
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: Add Meson AXG binding
In-Reply-To: <20171013231313.22850-1-dlan@gentoo.org>
References: <20171013231313.22850-1-dlan@gentoo.org>
Message-ID: <20171013231313.22850-2-dlan@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce new bindings for the Meson AXG SoC which now have
different memory layout.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 4e4bc0bae597..89ee830bd55c 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -41,6 +41,10 @@ Boards with the Amlogic Meson GXM S912 SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,s912", "amlogic,meson-gxm";
 
+Boards with the Amlogic Meson AXG A113D SoC shall have the following properties:
+  Required root node property:
+    compatible: "amlogic,a113d", "amlogic,meson-axg";
+
 Board compatible values (alphabetically, grouped by SoC):
 
   - "geniatech,atv1200" (Meson6)
@@ -74,6 +78,8 @@ Board compatible values (alphabetically, grouped by SoC):
   - "kingnovel,r-box-pro" (Meson gxm S912)
   - "nexbox,a1" (Meson gxm s912)
 
+  - "amlogic,s400" (Meson axg a113d)
+
 Amlogic Meson Firmware registers Interface
 ------------------------------------------
 
-- 
2.14.1
