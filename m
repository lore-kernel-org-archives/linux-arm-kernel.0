From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 16 Oct 2017 05:01:52 +0200
Subject: [PATCH 2/3] dt-bindings: arm: realtek: Document MeLE V9
In-Reply-To: <20171016030153.11078-1-afaerber@suse.de>
References: <20171016030153.11078-1-afaerber@suse.de>
Message-ID: <20171016030153.11078-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a compatible string for MeLE V9 Media Player.

Cc: meleservice at mele.cn
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/realtek.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
index 297c15eb81e2..95839e19ae92 100644
--- a/Documentation/devicetree/bindings/arm/realtek.txt
+++ b/Documentation/devicetree/bindings/arm/realtek.txt
@@ -12,6 +12,7 @@ Required root node properties:
 
 Root node property compatible must contain, depending on board:
 
+ - MeLE V9: "mele,v9"
  - ProBox2 AVA: "probox2,ava"
  - Zidoo X9S: "zidoo,x9s"
 
-- 
2.13.6
