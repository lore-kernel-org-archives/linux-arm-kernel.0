From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 25 Apr 2014 21:32:38 +0900
Subject: [PATCH v2 02/10] ARM: EXYNOS: Cleanup "mach-exynos/common.h" file
In-Reply-To: <1398429166-5539-1-git-send-email-pankaj.dubey@samsung.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1398429166-5539-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1398429166-5539-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused and unwanted declarations from "mach-exynos/common.h"

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/common.h |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 9ef3f83..31c5964 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -15,14 +15,8 @@
 #include <linux/reboot.h>
 #include <linux/of.h>
 
-void mct_init(void __iomem *base, int irq_g0, int irq_l0, int irq_l1);
-
-struct map_desc;
-void exynos_init_io(void);
-void exynos_restart(enum reboot_mode mode, const char *cmd);
 void exynos_cpuidle_init(void);
 void exynos_cpufreq_init(void);
-void exynos_init_late(void);
 
 void exynos_firmware_init(void);
 
-- 
1.7.10.4
