From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Jul 2013 09:14:35 +0200
Subject: [PATCH] i2c: mv64xxx: Document the newly introduced allwinner
 compatible
Message-ID: <1374650075-26190-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index a1ee681..6113f92 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -4,7 +4,7 @@
 Required properties :
 
  - reg             : Offset and length of the register set for the device
- - compatible      : Should be "marvell,mv64xxx-i2c"
+ - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i-i2c"
  - interrupts      : The interrupt number
 
 Optional properties :
-- 
1.8.3.2
