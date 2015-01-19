From: b.galvani@gmail.com (Beniamino Galvani)
Date: Tue, 20 Jan 2015 00:22:58 +0100
Subject: [PATCH 2/3] of: Define board compatible for MINIX NEO-X8
In-Reply-To: <1421709779-25691-1-git-send-email-b.galvani@gmail.com>
References: <1421709779-25691-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1421709779-25691-3-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the board compatible property for MINIX NEO-X8, a
Meson8-based digital media player. While at it, move the other
existing Meson board compatible to amlogic.txt.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt   | 4 ++++
 Documentation/devicetree/bindings/arm/geniatech.txt | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/geniatech.txt

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 8fe8150..973884a 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -8,3 +8,7 @@ Boards with the Amlogic Meson6 SoC shall have the following properties:
 Boards with the Amlogic Meson8 SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,meson8";
+
+Board compatible values:
+  - "geniatech,atv1200"
+  - "minix,neo-x8"
diff --git a/Documentation/devicetree/bindings/arm/geniatech.txt b/Documentation/devicetree/bindings/arm/geniatech.txt
deleted file mode 100644
index 74ccba4..0000000
--- a/Documentation/devicetree/bindings/arm/geniatech.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-Geniatech platforms device tree bindings
--------------------------------------------
-
-Geniatech ATV1200
-    - compatible = "geniatech,atv1200"
-- 
2.1.4
