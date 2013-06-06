From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 6 Jun 2013 10:24:17 +0200
Subject: [PATCH v3 4/7] pcmcia: at91_cf: clean up header includes
In-Reply-To: <cover.1370506678.git.nicolas.ferre@atmel.com>
References: <cover.1370506678.git.nicolas.ferre@atmel.com>
Message-ID: <049152805bb97b6721b494bda83d4eeaebc66371.1370506678.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joachim Eastwood <manabian@gmail.com>

Use includes from linux/ instead of asm/ and remove a
unnecessary mach/ include.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/pcmcia/at91_cf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index 43bc342..bce8a64 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -18,13 +18,11 @@
 #include <linux/slab.h>
 #include <linux/gpio.h>
 #include <linux/platform_data/atmel.h>
+#include <linux/io.h>
+#include <linux/sizes.h>
 
 #include <pcmcia/ss.h>
 
-#include <mach/hardware.h>
-#include <asm/io.h>
-#include <asm/sizes.h>
-
 #include <mach/at91rm9200_mc.h>
 #include <mach/at91_ramc.h>
 
-- 
1.8.2.2
