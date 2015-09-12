From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sat, 12 Sep 2015 13:17:36 +0200
Subject: [PATCH] ARM: BCM5301X: add NAND flash chip description for Asus
 RT-AC87U
Message-ID: <1442056656-11491-1-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND flash chip description were not imported for the Asus RT-AC87U
dts file when this was done for all the other dts files, because these
patches were send in parallel.

This adds a missing NAND flash chip description to this patch:
commit 9faa5960eef3204cae6637b530f5e23e53b5a9ef
Author: Hauke Mehrtens <hauke@hauke-m.de>
Date: Fri May 29 23:39:47 2015 +0200

ARM: BCM5301X: add NAND flash chip description

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
index aedf3c4..8ade7de 100644
--- a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
+++ b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
@@ -10,6 +10,7 @@
 /dts-v1/;
 
 #include "bcm4708.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
 
 / {
 	compatible = "asus,rt-ac87u", "brcm,bcm4709", "brcm,bcm4708";
-- 
2.1.4
