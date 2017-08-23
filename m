From: plaes@plaes.org (Priit Laes)
Date: Wed, 23 Aug 2017 20:23:31 +0300
Subject: [PATCH v7 3/5] dt-bindings: List devicetree binding for the CCU of
 Allwinner A10
In-Reply-To: <cover.2a284ee63f45063ec7c0720b1098860e0b516c6d.1503507503.git-series.plaes@plaes.org>
References: <cover.2a284ee63f45063ec7c0720b1098860e0b516c6d.1503507503.git-series.plaes@plaes.org>
Message-ID: <8164ec90ec4949801522a1b6b3fe57efe9feb60e.1503507503.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A10 is now driven by sunxi-ng CCU driver.

Add devicetree binding for it.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 2712891..7eda08e 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -3,6 +3,7 @@ Allwinner Clock Control Unit Binding
 
 Required properties :
 - compatible: must contain one of the following compatibles:
+		- "allwinner,sun4i-a10-ccu"
 		- "allwinner,sun5i-a10s-ccu"
 		- "allwinner,sun5i-a13-ccu"
 		- "allwinner,sun6i-a31-ccu"
-- 
git-series 0.9.1
