From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Mon, 02 Aug 2010 09:25:11 +0900
Subject: [PATCH 2/3] ARM: Samsung: Don't use the mach/gpio.h directly
Message-ID: <20100802002511.GA32261@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the linux/gpio.h. also fix the build error since new C preprocessor directives.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/gpiolib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/gpiolib.c b/arch/arm/plat-samsung/gpiolib.c
index 8a8ba8b..c354089 100644
--- a/arch/arm/plat-samsung/gpiolib.c
+++ b/arch/arm/plat-samsung/gpiolib.c
@@ -18,7 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/irq.h>
 #include <linux/io.h>
-#include <mach/gpio.h>
+#include <linux/gpio.h>
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
-- 
1.5.3.3
