From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Wed, 13 May 2015 09:20:45 +0200
Subject: [PATCH] ARM: BCM5301X: Fix chip typo in ARCH_BCM_5301X help message
Message-ID: <1431501645-3887-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 8b11f44..7fec7e8 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -47,7 +47,7 @@ config ARCH_BCM_5301X
 	  BCM53014, BCM53015, BCM53016, BCM53017, BCM53018, BCM4707,
 	  BCM4708 and BCM4709.
 
-	  Do not confuse this with the BCM4760 which is a totally
+	  Do not confuse this with the BCM4706 which is a totally
 	  different SoC or with the older BCM47XX and BCM53XX based
 	  network SoC using a MIPS CPU, they are supported by arch/mips/bcm47xx
 
-- 
1.8.4.5
