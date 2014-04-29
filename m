From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 29 Apr 2014 16:43:24 +0900
Subject: [PATCH 2/4] ARM: shmobile: marzen: Remove early_printk from command
 line
In-Reply-To: <1398757406-30920-1-git-send-email-horms+renesas@verge.net.au>
References: <1398757406-30920-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1398757406-30920-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As far as I understand things this does not have any affect.
So remove it.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 2c727cd..769ae84 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -19,7 +19,7 @@
 	compatible = "renesas,marzen", "renesas,r8a7779";
 
 	chosen {
-		bootargs = "console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on";
+		bootargs = "console=ttySC2,115200 ignore_loglevel root=/dev/nfs ip=on";
 	};
 
 	memory {
-- 
1.8.5.2
