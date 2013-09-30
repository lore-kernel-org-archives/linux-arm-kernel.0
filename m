From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 30 Sep 2013 09:05:05 +0200
Subject: [PATCH] ARM: amba: Extend number of IRQS
Message-ID: <0a5b86b1a90ff48133a1f0d43e342bec9da8fa57.1380524685.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xilinx Zynq pl330 dma driver has 9 irqs which all have to
be used by the driver to get it work properly.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Not sure if there are others IP with more than 9 irqs.
---
 include/linux/amba/bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 43ec7e2..b327a1b 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -21,7 +21,7 @@
 #include <linux/resource.h>
 #include <linux/regulator/consumer.h>

-#define AMBA_NR_IRQS	2
+#define AMBA_NR_IRQS	9
 #define AMBA_CID	0xb105f00d

 struct clk;
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130930/22a79ecd/attachment.sig>
