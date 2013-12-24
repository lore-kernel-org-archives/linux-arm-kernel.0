From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:14:18 +0900
Subject: [PATCH 01/11] serial: sh-sci: Sort headers alphabetically
In-Reply-To: <cover.1387887969.git.horms+renesas@verge.net.au>
References: <cover.1387887969.git.horms+renesas@verge.net.au>
Message-ID: <8fb9631c517b862267590e7af93615a6ef03394d.1387887969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

This helps locating duplicates.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1a3fc7a..e98a217 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -23,35 +23,35 @@
 
 #undef DEBUG
 
-#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/ctype.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/sh_dma.h>
-#include <linux/timer.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/tty.h>
-#include <linux/tty_flip.h>
-#include <linux/serial.h>
-#include <linux/major.h>
-#include <linux/string.h>
-#include <linux/sysrq.h>
 #include <linux/ioport.h>
+#include <linux/major.h>
+#include <linux/module.h>
 #include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/console.h>
-#include <linux/platform_device.h>
-#include <linux/serial_sci.h>
 #include <linux/notifier.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/cpufreq.h>
-#include <linux/clk.h>
-#include <linux/ctype.h>
-#include <linux/err.h>
-#include <linux/dmaengine.h>
-#include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
+#include <linux/serial.h>
+#include <linux/serial_sci.h>
+#include <linux/sh_dma.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
+#include <linux/string.h>
+#include <linux/sysrq.h>
+#include <linux/timer.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 
 #ifdef CONFIG_SUPERH
 #include <asm/sh_bios.h>
-- 
1.8.4
