From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu,  7 Nov 2013 00:04:03 +0400
Subject: [PATCH 2/3] ARM: shmobile: Remove non-existent LOCAL_TIMERS
Message-ID: <1383768243-11466-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-shmobile/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a4a4b75..2de4fb8 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -4,7 +4,7 @@ config ARCH_SHMOBILE_MULTI
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if LOCAL_TIMERS
+	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
 	select ARM_GIC
 	select MIGHT_HAVE_CACHE_L2X0
-- 
1.8.1.5
