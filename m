From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:55 +0100
Subject: [PATCH 58/62] ARM: exynos: add missing include of linux/module.h
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-59-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the restructuring of the module.h and init.h headers,
we now need to include this explicitly here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-exynos/cpuidle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index f57cb91..93d2dec 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -14,6 +14,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/io.h>
 #include <linux/export.h>
+#include <linux/module.h>
 #include <linux/time.h>
 #include <linux/platform_device.h>
 
-- 
1.8.3.2
