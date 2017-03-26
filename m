From: plaes@plaes.org (Priit Laes)
Date: Sun, 26 Mar 2017 20:20:19 +0300
Subject: [PATCH v2 4/6] dt-bindings: List devicetree binding for the CCU of
 Allwinner A20
In-Reply-To: <cover.a58841efb571d44013658505f3fa140536a89d1c.1490545262.git-series.plaes@plaes.org>
References: <cover.a58841efb571d44013658505f3fa140536a89d1c.1490545262.git-series.plaes@plaes.org>
Message-ID: <8e57db5486511208e3962b7ea8955d2881a14dd3.1490545262.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A20 is now driven by sunxi-ng CCU driver.

Add devicetree binding for it.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 68512aa..de90988 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -4,6 +4,7 @@ Allwinner Clock Control Unit Binding
 Required properties :
 - compatible: must contain one of the following compatibles:
 		- "allwinner,sun6i-a31-ccu"
+		- "allwinner,sun7i-a20-ccu"
 		- "allwinner,sun8i-a23-ccu"
 		- "allwinner,sun8i-a33-ccu"
 		- "allwinner,sun8i-h3-ccu"
-- 
git-series 0.9.1
