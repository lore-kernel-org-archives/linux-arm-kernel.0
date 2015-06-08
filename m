From: carlo@caione.org (Carlo Caione)
Date: Mon,  8 Jun 2015 10:52:23 +0200
Subject: [PATCH 2/4] of: documentation: add bindings documentation for Meson8b
In-Reply-To: <1433753545-7980-1-git-send-email-carlo@caione.org>
References: <1433753545-7980-1-git-send-email-carlo@caione.org>
Message-ID: <1433753545-7980-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 973884a..b1a6444 100644
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
   - "geniatech,atv1200"
   - "minix,neo-x8"
+  - "tronfy,mxq"
+  - "hardkernel,odroid-c1"
-- 
1.9.1
