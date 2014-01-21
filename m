From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 21 Jan 2014 11:33:11 +0100
Subject: [PATCH 2/2] tty: uartps: Get rid of Xilinx PS name
In-Reply-To: <7d0c02bf2d7eb816eb505d04c3800112805e2b62.1390300383.git.michal.simek@xilinx.com>
References: <7d0c02bf2d7eb816eb505d04c3800112805e2b62.1390300383.git.michal.simek@xilinx.com>
Message-ID: <82f1a903f281c73683c5e69cac0206759561cccd.1390300383.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use zynq name instead.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index b2f929e..528f16a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1,5 +1,5 @@
 /*
- * Xilinx PS UART driver
+ * Xilinx Zynq UART driver
  *
  * 2011 - 2013 (C) Xilinx Inc.
  *
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140121/45360577/attachment.sig>
