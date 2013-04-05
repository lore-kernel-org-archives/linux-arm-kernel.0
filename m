From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 5 Apr 2013 14:58:52 +0800
Subject: [PATCH -next] ARM: tegra: pm: remove duplicated include from pm.c
Message-ID: <CAPgLHd-FCVa-k1dBCgPrQOdDpmovvWwy+UjFmu8pj5ZCRad5EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-tegra/pm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 6ce6beb..d647e9e 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -39,7 +39,6 @@
 #include "fuse.h"
 #include "pmc.h"
 #include "sleep.h"
-#include "pmc.h"
 
 #ifdef CONFIG_PM_SLEEP
 static DEFINE_SPINLOCK(tegra_lp2_lock);
