From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 16 Oct 2017 06:01:49 +0200
Subject: [PATCH 4/5] dt-bindings: arm: realtek: Document RTD1296 and Synology
 DS418
In-Reply-To: <20171016040150.23400-1-afaerber@suse.de>
References: <20171016040150.23400-1-afaerber@suse.de>
Message-ID: <20171016040150.23400-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define compatible strings for Realtek RTD1296 SoC and Synology
DiskStation DS418 NAS.

Cc: info at synology.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/realtek.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
index 500e771614c4..d977aa0a0f46 100644
--- a/Documentation/devicetree/bindings/arm/realtek.txt
+++ b/Documentation/devicetree/bindings/arm/realtek.txt
@@ -36,3 +36,20 @@ Root node property compatible must contain, depending on board:
 Example:
 
     compatible = "zidoo,x9s", "realtek,rtd1295";
+
+
+RTD1296 SoC
+===========
+
+Required root node properties:
+
+ - compatible :  must contain "realtek,rtd1296"
+
+
+Root node property compatible must contain, depending on board:
+
+ - Synology DiskStation DS418: "synology,ds418"
+
+Example:
+
+    compatible = "synology,ds418", "realtek,rtd1296";
-- 
2.13.6
