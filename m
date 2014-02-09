From: richard@nod.at (Richard Weinberger)
Date: Sun,  9 Feb 2014 19:48:04 +0100
Subject: [PATCH 26/28] Remove LOCAL_TIMERS
In-Reply-To: <1391971686-9517-1-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
Message-ID: <1391971686-9517-27-git-send-email-richard@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The symbol is an orphan, get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm/mach-shmobile/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 3386406..c055388 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -8,7 +8,6 @@ config ARCH_SHMOBILE_MULTI
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if LOCAL_TIMERS
 	select HAVE_SMP
 	select ARM_GIC
 	select MIGHT_HAVE_CACHE_L2X0
-- 
1.8.4.2
