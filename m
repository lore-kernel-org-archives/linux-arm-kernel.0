From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 21 Mar 2013 12:40:14 +0100
Subject: [PATCH v2 4/7] pcmcia: at91_cf: clean up header includes
In-Reply-To: <cover.1363865228.git.nicolas.ferre@atmel.com>
References: <cover.1363865228.git.nicolas.ferre@atmel.com>
Message-ID: <6016c8edd48eeb6f1c20c6f6463f47fc2ee7bb06.1363865228.git.nicolas.ferre@atmel.com>
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
1.8.0
