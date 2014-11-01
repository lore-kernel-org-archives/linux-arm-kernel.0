From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sat,  1 Nov 2014 15:24:36 +0100
Subject: [PATCH] ARM: BCM5310X: activate early printk for Netgear R6250
Message-ID: <1414851876-30575-1-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This activates early printk on the Netgear R6250 by default.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index 58d999d..bbb814e 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -16,7 +16,7 @@
 	model = "Netgear R6250 V1 (BCM4708)";
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
+		bootargs = "console=ttyS0,115200 earlyprintk";
 	};
 
 	memory {
-- 
1.9.1
