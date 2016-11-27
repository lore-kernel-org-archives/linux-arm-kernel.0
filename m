From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 27 Nov 2016 21:57:58 +0100
Subject: [PATCH 1/2] Documentation: net: dsa: marvell: Add 88E6176
Message-ID: <1480280279-9552-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/net/dsa/marvell.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell.txt b/Documentation/devicetree/bindings/net/dsa/marvell.txt
index b3dd6b40e0de..000bc3b16edd 100644
--- a/Documentation/devicetree/bindings/net/dsa/marvell.txt
+++ b/Documentation/devicetree/bindings/net/dsa/marvell.txt
@@ -15,6 +15,7 @@ Additional required and optional properties can be found in dsa.txt.
 
 Required properties:
 - compatible	       : Should be one of "marvell,mv88e6085" or
+			 "marvell,mv88e6176" or
 			 "marvell,mv88e6190"
 - reg                  : Address on the MII bus for the switch.
 
-- 
2.6.6
