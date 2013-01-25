From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:23:53 +0900
Subject: [PATCH 17/80] sh-pfc: Sort headers alphabetically
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-18-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pfc/core.c    |   12 ++++++------
 drivers/sh/pfc/gpio.c    |    6 +++---
 drivers/sh/pfc/pinctrl.c |   12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/sh/pfc/core.c b/drivers/sh/pfc/core.c
index 8ec57bd..ccf4b7a 100644
--- a/drivers/sh/pfc/core.c
+++ b/drivers/sh/pfc/core.c
@@ -12,17 +12,17 @@
 #define DRV_NAME "sh-pfc"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/sh_pfc.h>
-#include <linux/module.h>
+#include <linux/bitops.h>
 #include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/io.h>
-#include <linux/bitops.h>
-#include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
+#include <linux/sh_pfc.h>
+#include <linux/slab.h>
 
 #include "core.h"
 
diff --git a/drivers/sh/pfc/gpio.c b/drivers/sh/pfc/gpio.c
index c11c1bb..a0454f3 100644
--- a/drivers/sh/pfc/gpio.c
+++ b/drivers/sh/pfc/gpio.c
@@ -12,13 +12,13 @@
 #define pr_fmt(fmt) KBUILD_MODNAME " gpio: " fmt
 
 #include <linux/device.h>
-#include <linux/init.h>
 #include <linux/gpio.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
+#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/sh_pfc.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include "core.h"
 
diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index 47dbd02..221bde0 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -12,17 +12,17 @@
 #define pr_fmt(fmt) KBUILD_MODNAME " pinctrl: " fmt
 
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/sh_pfc.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf.h>
-#include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/sh_pfc.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include "core.h"
 
-- 
1.7.10.4
