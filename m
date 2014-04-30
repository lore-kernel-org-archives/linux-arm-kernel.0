From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 30 Apr 2014 14:17:28 +0900
Subject: [PATCH v3 03/12] ARM: EXYNOS: Cleanup "mach-exynos/common.h" file
In-Reply-To: <1398835057-3860-1-git-send-email-pankaj.dubey@samsung.com>
References: <1398835057-3860-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1398835057-3860-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused and unwanted declarations from "mach-exynos/common.h"

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/common.h |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 30123a0..8a4aa0b 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -15,15 +15,6 @@
 #include <linux/reboot.h>
 #include <linux/of.h>
 
-void mct_init(void __iomem *base, int irq_g0, int irq_l0, int irq_l1);
-
-struct map_desc;
-void exynos_init_io(void);
-void exynos_restart(enum reboot_mode mode, const char *cmd);
-void exynos_cpuidle_init(void);
-void exynos_cpufreq_init(void);
-void exynos_init_late(void);
-
 void exynos_firmware_init(void);
 
 #ifdef CONFIG_PINCTRL_EXYNOS
-- 
1.7.10.4
