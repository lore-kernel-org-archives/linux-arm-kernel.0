From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Fri,  6 Jul 2018 20:32:47 +0200
Subject: [PATCH v3 6/9] dt-bindings: samsung: Document bindings for SGH-T959P
 board
In-Reply-To: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <1530901970-14972-7-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Bakker <xc-racer2@live.ca>

Document the binding for Samsung Galaxy S Fascinate 4G (SGH-T959P).

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
--
Changes from v2:
  - Added Acked-by

Changes from v1:
  - Added missing commit msg.
--
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 3fa287a86300..37e96e48c48c 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -3,6 +3,7 @@
 Required root node properties:
     - compatible = should be one or more of the following.
 	- "samsung,aries"	- for S5PV210-based Samsung Aries board.
+	- "samsung,fascinate4g"	- for S5PV210-based Samsung Galaxy S Fascinate 4G (SGH-T959P) board.
 	- "samsung,galaxys"	- for S5PV210-based Samsung Galaxy S (i9000)  board.
 	- "samsung,artik5"	- for Exynos3250-based Samsung ARTIK5 module.
 	- "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
-- 
2.7.4
