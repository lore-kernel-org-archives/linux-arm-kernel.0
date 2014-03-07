From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  7 Mar 2014 11:13:29 -0800
Subject: [PATCH RFC v2 06/11] tty: xuartps: Change driver name to 'cdns-uart'
In-Reply-To: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1394219614-3197-7-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
I'm not sure about this change. Is this acceptable or already too much?
I think the name is used for some sysfs entries.

	S?ren
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index b4a2a68b5e0e..3be1da41c2a8 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -31,7 +31,7 @@
 #include <linux/module.h>
 
 #define XUARTPS_TTY_NAME	"ttyPS"
-#define XUARTPS_NAME		"xuartps"
+#define XUARTPS_NAME		"cdns-uart"
 #define XUARTPS_MAJOR		0	/* use dynamic node allocation */
 #define XUARTPS_MINOR		0	/* works best with devtmpfs */
 #define XUARTPS_NR_PORTS	2
-- 
1.9.0.1.g4196000
