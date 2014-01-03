From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri,  3 Jan 2014 16:48:47 +0100
Subject: [PATCH 3/4] ARM: shmobile: Remove duplicate
 shmobile_invalidate_start() declaration
In-Reply-To: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
References: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1388764128-27686-3-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/mach-shmobile/include/mach/common.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index e31980590eb4..cb8e32deb2a3 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -25,7 +25,6 @@ extern int shmobile_smp_apmu_boot_secondary(unsigned int cpu,
 					    struct task_struct *idle);
 extern void shmobile_smp_apmu_cpu_die(unsigned int cpu);
 extern int shmobile_smp_apmu_cpu_kill(unsigned int cpu);
-extern void shmobile_invalidate_start(void);
 struct clk;
 extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
-- 
1.7.9.5
