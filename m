From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 28 May 2018 20:53:10 +0200
Subject: [PATCH] dt-bindings: arm: Remove obsolete insignal-boards.txt
Message-ID: <20180528185310.21971-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatibles mentioned in insignal-boards.txt are already documented
under devicetree/bindings/arm/samsung/samsung-boards.txt.  Also the
contents of insignal-boards.txt is not accurate, e.g. does not mention
Arndale boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/insignal-boards.txt | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/insignal-boards.txt

diff --git a/Documentation/devicetree/bindings/arm/insignal-boards.txt b/Documentation/devicetree/bindings/arm/insignal-boards.txt
deleted file mode 100644
index 524c3dc5d808..000000000000
--- a/Documentation/devicetree/bindings/arm/insignal-boards.txt
+++ /dev/null
@@ -1,8 +0,0 @@
-* Insignal's Exynos4210 based Origen evaluation board
-
-Origen low-cost evaluation board is based on Samsung's Exynos4210 SoC.
-
-Required root node properties:
-    - compatible = should be one or more of the following.
-        (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
-        (b) "samsung,exynos4210"  - for boards based on Exynos4210 SoC.
-- 
2.14.1
