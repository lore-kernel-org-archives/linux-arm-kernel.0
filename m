From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 01 Aug 2013 04:02:51 +0900
Subject: [PATCH 11/13] ARM: shmobile: Use default ->init_time() on KZM9G DT ref
In-Reply-To: <20130731190110.31796.96552.sendpatchset@w520>
References: <20130731190110.31796.96552.sendpatchset@w520>
Message-ID: <20130731190251.31796.67349.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Leave ->init_time() set to NULL to use the default ARM behaviour.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kzm9g-reference.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ work/arch/arm/mach-shmobile/board-kzm9g-reference.c	2013-08-01 03:16:17.000000000 +0900
@@ -52,6 +52,5 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-refere
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_machine	= kzm_init,
-	.init_time	= shmobile_timer_init,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
