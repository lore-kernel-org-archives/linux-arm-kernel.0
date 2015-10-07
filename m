From: carlo@caione.org (Carlo Caione)
Date: Wed,  7 Oct 2015 22:31:03 +0200
Subject: [PATCH v2 2/4] of: documentation: add bindings documentation for
 Meson8b
In-Reply-To: <1444249865-6897-1-git-send-email-carlo@caione.org>
References: <1444249865-6897-1-git-send-email-carlo@caione.org>
Message-ID: <1444249865-6897-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 973884a..1dfee20 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -9,6 +9,12 @@ Boards with the Amlogic Meson8 SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,meson8";
 
+Boards with the Amlogic Meson8b SoC shall have the following properties:
+  Required root node property:
+    compatible: "amlogic,meson8b";
+
 Board compatible values:
-  - "geniatech,atv1200"
-  - "minix,neo-x8"
+  - "geniatech,atv1200" (Meson6)
+  - "minix,neo-x8" (Meson8)
+  - "tronfy,mxq" (Meson8b)
+  - "hardkernel,odroid-c1" (Meson8b)
-- 
1.9.1
