From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed,  3 Oct 2018 11:09:10 +0200
Subject: [PATCH 2/4] dt-bindings: iommu: mediatek: Add binding for MT7623
In-Reply-To: <20181003090912.30501-1-matthias.bgg@gmail.com>
References: <20181003090912.30501-1-matthias.bgg@gmail.com>
Message-ID: <20181003090912.30501-3-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds binding documentation for MT7623 SoC.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
index df5db732138d..6922db598def 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -41,6 +41,8 @@ Required properties:
 - compatible : must be one of the following string:
 	"mediatek,mt2701-m4u" for mt2701 which uses generation one m4u HW.
 	"mediatek,mt2712-m4u" for mt2712 which uses generation two m4u HW.
+	"mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
+						     generation one m4u HW.
 	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
 - reg : m4u register base and size.
 - interrupts : the interrupt of m4u.
@@ -51,7 +53,7 @@ Required properties:
 	according to the local arbiter index, like larb0, larb1, larb2...
 - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
 	Specifies the mtk_m4u_id as defined in
-	dt-binding/memory/mt2701-larb-port.h for mt2701,
+	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
 	dt-binding/memory/mt2712-larb-port.h for mt2712, and
 	dt-binding/memory/mt8173-larb-port.h for mt8173.
 
-- 
2.19.0
