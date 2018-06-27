From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Wed, 27 Jun 2018 19:12:19 +0200
Subject: [PATCH v2 05/10] dt-bindings: samsung: Add S5PV210 as possible soc in
 Samsung boards
In-Reply-To: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <1530119544-30023-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are Samsung devices, which are not Exynos-based boards,
like it's in case of S5PV210. Document this information at beginning
of file.

Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 14510b215480..175f669d9bb6 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -1,4 +1,4 @@
-* Samsung's Exynos SoC based boards
+* Samsung's Exynos and S5P SoC based boards
 
 Required root node properties:
     - compatible = should be one or more of the following.
-- 
2.7.4
