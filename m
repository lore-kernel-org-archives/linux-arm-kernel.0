From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 25 Jun 2014 18:15:42 +0530
Subject: [PATCH v5 6/6] ARM: EXYNOS: Remove "linux/bug.h" from pmu.c
In-Reply-To: <1403700342-9678-1-git-send-email-pankaj.dubey@samsung.com>
References: <1403700342-9678-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1403700342-9678-7-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes unnecessary header file inclusion from pmu.c.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/pmu.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index fb0deda..dcfcb44 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -11,7 +11,6 @@
 
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/bug.h>
 
 #include "common.h"
 #include "regs-pmu.h"
-- 
1.7.9.5
