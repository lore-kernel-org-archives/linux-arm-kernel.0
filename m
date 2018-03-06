From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 6 Mar 2018 17:09:30 +0800
Subject: [PATCH v4 5/6] dt-bindings: clock: mediatek: add audsys support for
 MT2701
In-Reply-To: <cover.1520327262.git.ryder.lee@mediatek.com>
References: <cover.1520327262.git.ryder.lee@mediatek.com>
Message-ID: <9ff8a4ae99e50bc5f9f1ae6c7a454cb80451fd5b.1520327262.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a compatible string for MT2701.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index 97b304e..34a69ba 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -6,6 +6,7 @@ The MediaTek AUDSYS controller provides various clocks to the system.
 Required Properties:
 
 - compatible: Should be one of:
+	- "mediatek,mt2701-audsys", "syscon"
 	- "mediatek,mt7622-audsys", "syscon"
 - #clock-cells: Must be 1
 
-- 
1.9.1
