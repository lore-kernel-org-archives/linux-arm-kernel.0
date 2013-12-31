From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 31 Dec 2013 17:44:53 +0100
Subject: [RFC PATCH 3/3] i2c: mv64xxx: Document the newly introduced Armada XP
 A0 compatible
In-Reply-To: <1388508293-9141-1-git-send-email-gregory.clement@free-electrons.com>
References: <1388508293-9141-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1388508293-9141-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index 82e8f6f17179..9410ed72ec45 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -5,7 +5,7 @@ Required properties :
 
  - reg             : Offset and length of the register set for the device
  - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i-i2c"
-                     or "marvell,mv78230-i2c"
+                     or "marvell,mv78230-i2c" or "marvell,mv78230-a0-i2c"
  - interrupts      : The interrupt number
 
 Optional properties :
-- 
1.8.1.2
