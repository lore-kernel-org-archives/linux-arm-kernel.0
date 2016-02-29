From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  1 Mar 2016 00:44:19 +0100
Subject: [PATCH 2/8] Documentation: devicetree: amlogic: Document Meson GXBaby
In-Reply-To: <1456789465-2962-1-git-send-email-afaerber@suse.de>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
Message-ID: <1456789465-2962-3-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use "amlogic,meson-gxbb" compatible string.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
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
