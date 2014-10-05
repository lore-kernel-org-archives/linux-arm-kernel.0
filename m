From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun,  5 Oct 2014 23:59:18 +0200
Subject: [PATCH v2 6/7] ARM: meson: document meson8 compatible properties
In-Reply-To: <1412546359-15062-1-git-send-email-b.galvani@gmail.com>
References: <1412546359-15062-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1412546359-15062-7-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree bindings documentation for Amlogic Meson8 SoCs.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 7eece72..8fe8150 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -2,7 +2,9 @@ Amlogic MesonX device tree bindings
 -------------------------------------------
 
 Boards with the Amlogic Meson6 SoC shall have the following properties:
+  Required root node property:
+    compatible: "amlogic,meson6"
 
-Required root node property:
-
-compatible = "amlogic,meson6";
+Boards with the Amlogic Meson8 SoC shall have the following properties:
+  Required root node property:
+    compatible: "amlogic,meson8";
-- 
1.9.1
