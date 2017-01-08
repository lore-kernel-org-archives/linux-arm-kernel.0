From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun,  8 Jan 2017 14:30:58 +0100
Subject: [PATCH 2/4] Documentation: devicetree: arm: mediatek: Add Geek Force
 board
In-Reply-To: <20170108133100.10428-1-afaerber@suse.de>
References: <20170108133100.10428-1-afaerber@suse.de>
Message-ID: <20170108133100.10428-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index c860b24..f533758 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -41,6 +41,9 @@ Supported boards:
 - Evaluation board for MT7623:
     Required root node properties:
       - compatible = "mediatek,mt7623-evb", "mediatek,mt7623";
+- AsiaRF Geek Force board:
+    Required root node properties:
+      - compatible = "asiarf,geekforce", "mediatek,mt7623";
 - MTK mt8127 tablet moose EVB:
     Required root node properties:
       - compatible = "mediatek,mt8127-moose", "mediatek,mt8127";
-- 
2.10.2
