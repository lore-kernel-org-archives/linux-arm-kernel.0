From: stu.hsieh@mediatek.com (Stu Hsieh)
Date: Wed, 20 Jun 2018 16:19:03 +0800
Subject: [PATCH v7 01/29] drm/mediatek: update dt-bindings for mt2712
In-Reply-To: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
References: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1529482771-2153-2-git-send-email-stu.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update device tree binding documentation for the display subsystem for
Mediatek MT2712 SoCs.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
Acked-by: CK Hu <ck.hu@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
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
