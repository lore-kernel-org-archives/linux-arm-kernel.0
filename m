From: plaes@plaes.org (Priit Laes)
Date: Fri, 14 Jul 2017 17:49:26 +0300
Subject: [PATCH v6 4/6] dt-bindings: List devicetree binding for the CCU of
 Allwinner A10
In-Reply-To: <cover.ba2aaaa405a7ec685034e34926b8855fd6c9ab86.1500043741.git-series.plaes@plaes.org>
References: <cover.ba2aaaa405a7ec685034e34926b8855fd6c9ab86.1500043741.git-series.plaes@plaes.org>
Message-ID: <4f4fe9818784e72de423a34c6e40344153c46eb9.1500043741.git-series.plaes@plaes.org>
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
index 81d0fa4..429168d 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -3,6 +3,7 @@ Allwinner Clock Control Unit Binding
 
 Required properties :
 - compatible: must contain one of the following compatibles:
+		- "allwinner,sun4i-a10-ccu"
 		- "allwinner,sun6i-a31-ccu"
 		- "allwinner,sun7i-a20-ccu"
 		- "allwinner,sun8i-a23-ccu"
-- 
git-series 0.9.1
