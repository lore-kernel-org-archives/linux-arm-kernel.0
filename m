From: const@MakeLinux.com (Constantine Shulyupin)
Date: Tue, 20 Nov 2012 11:25:53 +0200
Subject: [PATCH] fix compilation error in cm_common.c
Message-ID: <1353403553-13525-1-git-send-email-const@MakeLinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Constantine Shulyupin <const@MakeLinux.com>

Added required linux/errno.h

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 arch/arm/mach-omap2/cm_common.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 3246cef..3fafc27 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/errno.h>
 
 #include "cm2xxx.h"
 #include "cm3xxx.h"
-- 
1.7.9.5
