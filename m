From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 28 Mar 2017 13:19:28 +0200
Subject: [PATCH v2 01/11] ARM: at91: pm: Cleanup headers
In-Reply-To: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
References: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170328111938.21297-2-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unnecessary header inclusions and reorder the remaining ones.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index a277981f414d..9e2b5c1e503e 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -10,28 +10,17 @@
  * (at your option) any later version.
  */
 
-#include <linux/gpio.h>
-#include <linux/suspend.h>
-#include <linux/sched.h>
-#include <linux/proc_fs.h>
 #include <linux/genalloc.h>
-#include <linux/interrupt.h>
-#include <linux/sysfs.h>
-#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-#include <linux/platform_data/atmel.h>
-#include <linux/io.h>
+#include <linux/suspend.h>
+
 #include <linux/clk/at91_pmc.h>
 
-#include <asm/irq.h>
-#include <linux/atomic.h>
-#include <asm/mach/time.h>
-#include <asm/mach/irq.h>
-#include <asm/fncpy.h>
 #include <asm/cacheflush.h>
+#include <asm/fncpy.h>
 #include <asm/system_misc.h>
 
 #include "generic.h"
-- 
2.11.0
