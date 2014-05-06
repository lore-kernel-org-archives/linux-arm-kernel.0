From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 06 May 2014 17:51:20 +0900
Subject: [PATCH v2 4/6] ARM:  EXYNOS: remove unused header inclusion from
 hotplug.c
In-Reply-To: <1399366282-4191-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399366282-4191-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399366282-4191-5-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removed "plat/cpu.h" inclusion from hotplug.c as it
is not required.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/hotplug.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 0243ef3..5e19601 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -19,8 +19,6 @@
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
 
-#include <plat/cpu.h>
-
 #include "common.h"
 #include "regs-pmu.h"
 
-- 
1.7.10.4
