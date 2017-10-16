From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 16 Oct 2017 06:01:47 +0200
Subject: [PATCH 2/5] dt-bindings: arm: realtek: Document RTD1293 and Synology
 DS418j
In-Reply-To: <20171016040150.23400-1-afaerber@suse.de>
References: <20171016040150.23400-1-afaerber@suse.de>
Message-ID: <20171016040150.23400-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define compatible strings for Realtek RTD1293 SoC and Synology
DiskStation DS418j NAS.

Cc: info at synology.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/realtek.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
index 297c15eb81e2..500e771614c4 100644
--- a/Documentation/devicetree/bindings/arm/realtek.txt
+++ b/Documentation/devicetree/bindings/arm/realtek.txt
@@ -2,6 +2,23 @@ Realtek platforms device tree bindings
 --------------------------------------
 
 
+RTD1293 SoC
+===========
+
+Required root node properties:
+
+ - compatible :  must contain "realtek,rtd1293"
+
+
+Root node property compatible must contain, depending on board:
+
+ - Synology DiskStation DS418j: "synology,ds418j"
+
+Example:
+
+    compatible = "synology,ds418j", "realtek,rtd1293";
+
+
 RTD1295 SoC
 ===========
 
-- 
2.13.6
