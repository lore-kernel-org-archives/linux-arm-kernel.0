From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 01 Aug 2013 04:01:55 +0900
Subject: [PATCH 05/13] ARM: shmobile: Use default ->init_time() on Bockw
In-Reply-To: <20130731190110.31796.96552.sendpatchset@w520>
References: <20130731190110.31796.96552.sendpatchset@w520>
Message-ID: <20130731190155.31796.59580.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Leave ->init_time() set to NULL to use the default ARM behaviour.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-bockw.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-bockw.c
+++ work/arch/arm/mach-shmobile/board-bockw.c	2013-08-01 03:06:01.000000000 +0900
@@ -279,7 +279,6 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
-	.init_time	= shmobile_timer_init,
 	.dt_compat	= bockw_boards_compat_dt,
 	.init_late      = r8a7778_init_late,
 MACHINE_END
