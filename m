From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  8 Oct 2017 14:26:28 +0200
Subject: [PATCH] dt-bindings: samsung: Document binding for new Odroid HC1
 board
Message-ID: <20171008122628.30973-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the binding for new Hardkernel Odroid HC1 board.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 3c551894f621..5e95e3e81140 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -57,6 +57,7 @@ Required root node properties:
 	- "hardkernel,odroid-xu3-lite" - for Exynos5422-based Hardkernel
 					 Odroid XU3 Lite board.
 	- "hardkernel,odroid-xu4" - for Exynos5422-based Hardkernel Odroid XU4.
+	- "hardkernel,odroid-hc1" - for Exynos5422-based Hardkernel Odroid HC1.
 
   * Insignal
 	- "insignal,arndale"      - for Exynos5250-based Insignal Arndale board.
-- 
2.11.0
