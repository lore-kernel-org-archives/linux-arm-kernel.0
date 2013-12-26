From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Dec 2013 15:22:27 +0100
Subject: [PATCH 1/2] ARM: mvebu: remove prototypes of non-existing functions
 from common.h
In-Reply-To: <1388067748-18414-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1388067748-18414-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1388067748-18414-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach-mvebu/common.h file contains prototypes of functions that
have been removed, so this commit removes the corresponding
prototypes.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/common.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index e366010..4c84689 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -21,12 +21,7 @@
 
 void mvebu_restart(enum reboot_mode mode, const char *cmd);
 
-void armada_370_xp_init_irq(void);
-void armada_370_xp_handle_irq(struct pt_regs *regs);
-
 void armada_xp_cpu_die(unsigned int cpu);
-int armada_370_xp_coherency_init(void);
-int armada_370_xp_pmsu_init(void);
 void armada_xp_secondary_startup(void);
 extern struct smp_operations armada_xp_smp_ops;
 #endif
-- 
1.8.3.2
