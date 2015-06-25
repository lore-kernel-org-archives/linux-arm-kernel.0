From: vitalya@ti.com (Vitaly Andrianov)
Date: Thu, 25 Jun 2015 10:31:48 -0400
Subject: [PATCH v2 1/3] ARM: keystone: clean and sort keystone.c headers
In-Reply-To: <1435242710-31346-1-git-send-email-vitalya@ti.com>
References: <1435242710-31346-1-git-send-email-vitalya@ti.com>
Message-ID: <1435242710-31346-2-git-send-email-vitalya@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch remove unused and sort remaining headers.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/mach-keystone/keystone.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 0662087..4534c7d 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -10,18 +10,15 @@
  * version 2, as published by the Free Software Foundation.
  */
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/init.h>
-#include <linux/of_platform.h>
-#include <linux/of_address.h>
 #include <linux/memblock.h>
+#include <linux/of_platform.h>
 
-#include <asm/setup.h>
-#include <asm/mach/map.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/smp_plat.h>
 #include <asm/memory.h>
+#include <asm/setup.h>
+#include <asm/smp_plat.h>
 
 #include "memory.h"
 
-- 
1.9.1
