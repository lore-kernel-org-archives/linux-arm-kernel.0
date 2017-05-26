From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 26 May 2017 13:13:18 +0200
Subject: [PATCH] serial: uartps: Fix kernel doc warnings
Message-ID: <d4e9f4ba39e5cee042402f5b012a953fcca99837.1495797196.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch fixes the kernel doc warnings in the driver.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index d82133d0f79a..81d1d553a5db 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -186,6 +186,7 @@
  * @pclk:		APB clock
  * @baud:		Current baud rate
  * @clk_rate_change_nb:	Notifier block for clock changes
+ * @quirks:		Flags for RXBS support.
  */
 struct cdns_uart {
 	struct uart_port	*port;
-- 
1.9.1
