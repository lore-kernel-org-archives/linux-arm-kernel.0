From: plaes@plaes.org (Priit Laes)
Date: Sun, 25 Jun 2017 23:45:45 +0300
Subject: [PATCH v4 4/6] dt-bindings: List devicetree binding for the CCU of
 Allwinner A10
In-Reply-To: <cover.24b2b13ec5a68552e186ba1637f1328363c3886e.1498422562.git-series.plaes@plaes.org>
References: <cover.24b2b13ec5a68552e186ba1637f1328363c3886e.1498422562.git-series.plaes@plaes.org>
Message-ID: <cc55dca83509fe2d2f7f97686de7a9d58653b45b.1498422562.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A10 is now driven by sunxi-ng CCU driver.

Add devicetree binding for it.

Acked-by: Rob Herring <robh@kernel.org>
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
