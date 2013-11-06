From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu,  7 Nov 2013 00:02:36 +0400
Subject: [PATCH 1/3] ARM: bcm: Remove non-existent GENERIC_TIME
Message-ID: <1383768156-11414-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-bcm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 9fe6d88..7e29ce7 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -19,7 +19,6 @@ config ARCH_BCM_MOBILE
 	select CPU_V7
 	select CLKSRC_OF
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_TIME
 	select GPIO_BCM_KONA
 	select SPARSE_IRQ
 	select TICK_ONESHOT
-- 
1.8.1.5
