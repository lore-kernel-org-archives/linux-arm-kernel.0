From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 01 Aug 2013 04:02:42 +0900
Subject: [PATCH 10/13] ARM: shmobile: Use default ->init_time() on Marzen DT
 ref
In-Reply-To: <20130731190110.31796.96552.sendpatchset@w520>
References: <20130731190110.31796.96552.sendpatchset@w520>
Message-ID: <20130731190242.31796.98376.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Leave ->init_time() set to NULL to use the default ARM behaviour.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-marzen-reference.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-marzen-reference.c
+++ work/arch/arm/mach-shmobile/board-marzen-reference.c	2013-08-01 03:13:42.000000000 +0900
@@ -42,6 +42,5 @@ DT_MACHINE_START(MARZEN, "marzen")
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= marzen_init,
-	.init_time	= shmobile_timer_init,
 	.dt_compat	= marzen_boards_compat_dt,
 MACHINE_END
