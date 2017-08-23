From: plaes@plaes.org (Priit Laes)
Date: Wed, 23 Aug 2017 20:23:30 +0300
Subject: [PATCH v7 2/5] dt-bindings: List devicetree binding for the CCU of
 Allwinner A20
In-Reply-To: <cover.2a284ee63f45063ec7c0720b1098860e0b516c6d.1503507503.git-series.plaes@plaes.org>
References: <cover.2a284ee63f45063ec7c0720b1098860e0b516c6d.1503507503.git-series.plaes@plaes.org>
Message-ID: <9723e9c9341f5d7d23a01a3d6d37b7acdb8aa3cf.1503507503.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A20 is now driven by sunxi-ng CCU driver.

Add devicetree binding for it.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index a082260..2712891 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -6,6 +6,7 @@ Required properties :
 		- "allwinner,sun5i-a10s-ccu"
 		- "allwinner,sun5i-a13-ccu"
 		- "allwinner,sun6i-a31-ccu"
+		- "allwinner,sun7i-a20-ccu"
 		- "allwinner,sun8i-a23-ccu"
 		- "allwinner,sun8i-a33-ccu"
 		- "allwinner,sun8i-a83t-ccu"
-- 
git-series 0.9.1
