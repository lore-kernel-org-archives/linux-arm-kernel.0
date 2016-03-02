From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed,  2 Mar 2016 03:34:58 +0100
Subject: [PATCH v2 3/6] Documentation: devicetree: amlogic: Document Meson
 GXBaby
In-Reply-To: <1456886101-22967-1-git-send-email-afaerber@suse.de>
References: <1456886101-22967-1-git-send-email-afaerber@suse.de>
Message-ID: <1456886101-22967-4-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "amlogic,meson-gxbb" compatible string.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2: unchanged
 
 Documentation/devicetree/bindings/arm/amlogic.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 1dfee20eee74..776f08ca215f 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -13,6 +13,10 @@ Boards with the Amlogic Meson8b SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,meson8b";
 
+Boards with the Amlogic Meson GXBaby SoC shall have the following properties:
+  Required root node property:
+    compatible: "amlogic,meson-gxbb";
+
 Board compatible values:
   - "geniatech,atv1200" (Meson6)
   - "minix,neo-x8" (Meson8)
-- 
2.6.2
