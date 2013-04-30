From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 30 Apr 2013 16:57:58 -0700
Subject: [PATCH 1/7] tty: xuartps: Sort #includes alphabetically
In-Reply-To: <1367366284-28304-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1367366284-28304-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1367366284-28304-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.cz>
CC: linux-serial at vger.kernel.org
---
 drivers/tty/serial/xilinx_uartps.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4e5c778..773732b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -11,17 +11,17 @@
  *
  */
 
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
-#include <linux/console.h>
-#include <linux/clk.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/module.h>
 
 #define XUARTPS_TTY_NAME	"ttyPS"
 #define XUARTPS_NAME		"xuartps"
-- 
1.8.2.2
