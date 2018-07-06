From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Fri,  6 Jul 2018 20:32:46 +0200
Subject: [PATCH v3 5/9] dt-bindings: samsung: Document bindings for Samsung
 aries boards
In-Reply-To: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <1530901970-14972-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the binding for Samsung Galaxy S (i9000) phone
and whole Samsung Aries devices family (based on S5PV210).

Also because this is first not Exynos-based devices, document this information
at beginning of file.

Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
--
Changes from v2:
  - Squashed with patch which was documenting existence
    of non Exynos-based boards
  - Added reviewed-by

Changes from v1:
  - Added missing commit msg.
--
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 14510b215480..3fa287a86300 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -1,7 +1,9 @@
-* Samsung's Exynos SoC based boards
+* Samsung's Exynos and S5P SoC based boards
 
 Required root node properties:
     - compatible = should be one or more of the following.
+	- "samsung,aries"	- for S5PV210-based Samsung Aries board.
+	- "samsung,galaxys"	- for S5PV210-based Samsung Galaxy S (i9000)  board.
 	- "samsung,artik5"	- for Exynos3250-based Samsung ARTIK5 module.
 	- "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
 	- "samsung,monk"	- for Exynos3250-based Samsung Simband board.
-- 
2.7.4
