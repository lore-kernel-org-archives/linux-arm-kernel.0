From: plaes@plaes.org (Priit Laes)
Date: Mon, 27 Feb 2017 23:09:14 +0200
Subject: [PATCH 4/4] dt-bindings: List devicetree binding for the CCU of
 Allwinner A20
In-Reply-To: <20170227210914.18954-1-plaes@plaes.org>
References: <20170227210914.18954-1-plaes@plaes.org>
Message-ID: <20170227210914.18954-5-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A20 is now driven by sunxi-ng CCU driver.

Add devicetree binding for it.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index bae5668..265262c 100644
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
2.9.3
