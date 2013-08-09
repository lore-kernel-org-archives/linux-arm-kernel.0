From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:49:16 +0900
Subject: [PATCH 08/14] ARM: shmobile: Remove sh73a0 ->nr_irqs
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
References: <20130809094748.6530.16511.sendpatchset@w520>
Message-ID: <20130809094916.6530.67468.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove .nr_irqs for sh73a0 DT cases.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kzm9g-reference.c |    1 -
 arch/arm/mach-shmobile/setup-sh73a0.c          |    1 -
 2 files changed, 2 deletions(-)

--- 0009/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ work/arch/arm/mach-shmobile/board-kzm9g-reference.c	2013-08-08 16:09:22.000000000 +0900
@@ -57,7 +57,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-refere
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_init_delay,
-	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_machine	= kzm_init,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
--- 0009/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2013-08-08 16:09:35.000000000 +0900
@@ -957,7 +957,6 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH7
 	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_init_delay,
-	.nr_irqs	= NR_IRQS_LEGACY,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
