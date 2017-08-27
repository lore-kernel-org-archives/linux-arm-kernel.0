From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Aug 2017 14:54:24 +0200
Subject: [PATCH 2/3] dt-bindings: arm: realtek: Add ProBox2 AVA
In-Reply-To: <20170827125425.3400-1-afaerber@suse.de>
References: <20170827125425.3400-1-afaerber@suse.de>
Message-ID: <20170827125425.3400-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document a compatible string for the PROBOX2 AVA TV Box.

Cc: support at probox2.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/realtek.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
index 13d755787b4f..297c15eb81e2 100644
--- a/Documentation/devicetree/bindings/arm/realtek.txt
+++ b/Documentation/devicetree/bindings/arm/realtek.txt
@@ -12,6 +12,7 @@ Required root node properties:
 
 Root node property compatible must contain, depending on board:
 
+ - ProBox2 AVA: "probox2,ava"
  - Zidoo X9S: "zidoo,x9s"
 
 
-- 
2.12.3
