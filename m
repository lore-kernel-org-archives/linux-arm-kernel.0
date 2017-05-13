From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat, 13 May 2017 16:33:20 +0200
Subject: [PATCH v2 01/18] dt-bindings: arm: amlogic: Reorder boards
In-Reply-To: <20170513143337.14278-1-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
Message-ID: <20170513143337.14278-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enforce groupment by SoCs, and order alphabetically within the group
(with some exceptions). This should facilitate adding new boards.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Rebased (new boards added)
 * Pointed out alphabetical order in the binding, too (Rob)
 
 Documentation/devicetree/bindings/arm/amlogic.txt | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index bfd5b558477d..cad5b5a48d92 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -29,26 +29,32 @@ Boards with the Amlogic Meson GXM S912 SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,s912", "amlogic,meson-gxm";
 
-Board compatible values:
+Board compatible values (alphabetically, grouped by SoC):
+
   - "geniatech,atv1200" (Meson6)
+
   - "minix,neo-x8" (Meson8)
-  - "tronfy,mxq" (Meson8b)
+
   - "hardkernel,odroid-c1" (Meson8b)
+  - "tronfy,mxq" (Meson8b)
+
+  - "amlogic,p200" (Meson gxbb)
+  - "amlogic,p201" (Meson gxbb)
+  - "hardkernel,odroid-c2" (Meson gxbb)
+  - "nexbox,a95x" (Meson gxbb or Meson gxl s905x)
   - "tronsmart,vega-s95-pro", "tronsmart,vega-s95" (Meson gxbb)
   - "tronsmart,vega-s95-meta", "tronsmart,vega-s95" (Meson gxbb)
   - "tronsmart,vega-s95-telos", "tronsmart,vega-s95" (Meson gxbb)
-  - "hardkernel,odroid-c2" (Meson gxbb)
-  - "amlogic,p200" (Meson gxbb)
-  - "amlogic,p201" (Meson gxbb)
   - "wetek,hub" (Meson gxbb)
   - "wetek,play2" (Meson gxbb)
+
   - "amlogic,p212" (Meson gxl s905x)
+  - "hwacom,amazetv" (Meson gxl s905x)
   - "khadas,vim" (Meson gxl s905x)
 
   - "amlogic,p230" (Meson gxl s905d)
   - "amlogic,p231" (Meson gxl s905d)
-  - "hwacom,amazetv" (Meson gxl s905x)
+
   - "amlogic,q200" (Meson gxm s912)
   - "amlogic,q201" (Meson gxm s912)
-  - "nexbox,a95x" (Meson gxbb or Meson gxl s905x)
   - "nexbox,a1" (Meson gxm s912)
-- 
2.12.0
