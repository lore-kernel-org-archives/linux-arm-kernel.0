From: stu.hsieh@mediatek.com (stu.hsieh at mediatek.com)
Date: Fri, 25 May 2018 10:34:18 +0800
Subject: [PATCH v3 1/8] drm/mediatek: update dt-bindings for mt2712
In-Reply-To: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
References: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1527215665-11937-2-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stu Hsieh <stu.hsieh@mediatek.com>

Update device tree binding documentation for the display subsystem for
Mediatek MT2712 SoCs.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 383183a89164..8469de510001 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -40,7 +40,7 @@ Required properties (all function blocks):
 	"mediatek,<chip>-dpi"        - DPI controller, see mediatek,dpi.txt
 	"mediatek,<chip>-disp-mutex" - display mutex
 	"mediatek,<chip>-disp-od"    - overdrive
-  the supported chips are mt2701 and mt8173.
+  the supported chips are mt2701, mt2712 and mt8173.
 - reg: Physical base address and length of the function block register space
 - interrupts: The interrupt signal from the function block (required, except for
   merge and split function blocks).
-- 
2.12.5
