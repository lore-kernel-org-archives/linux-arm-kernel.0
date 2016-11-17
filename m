From: p.wassi@gmx.at (p.wassi at gmx.at)
Date: Thu, 17 Nov 2016 21:29:47 +0100
Subject: [PATCH] kirkwood: fix spelling mistake
Message-ID: <trinity-6911950b-e19a-4b44-aeed-adaccbc33164-1479414587776@3capp-gmx-bs50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Wassi <p.wassi@gmx.at>

Fix a spelling mistake in arch/arm/boot/dts/kirkwood-topkick.dts

Signed-off-by: Paul Wassi <p.wassi@gmx.at>
---
The manufacturer's name is Univer*s*al Scientific Industrial...
Compare with footer of page here:
http://www.usish.com/english/products_topkick1281p2.php

 arch/arm/boot/dts/kirkwood-topkick.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -rupN a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -4,7 +4,7 @@
 #include "kirkwood-6282.dtsi"
 
 / {
-	model = "Univeral Scientific Industrial Co. Topkick-1281P2";
+	model = "Universal Scientific Industrial Co. Topkick-1281P2";
 	compatible = "usi,topkick-1281P2", "usi,topkick", "marvell,kirkwood-88f6282", "marvell,kirkwood";
 
 	memory {
