From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 21 May 2015 16:37:30 -0700
Subject: [PATCH 3/3] MAINTAINERS: Add entry for xilinx mailbox driver.
In-Reply-To: <1432251450-26352-1-git-send-email-moritz.fischer@ettus.com>
References: <1432251450-26352-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1432251450-26352-4-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8e0afb..f1f0d10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10986,6 +10986,13 @@ M:	John Linn <John.Linn@xilinx.com>
 S:	Maintained
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
+XILINX MAILBOX DRIVER
+M:	Moritz Fischer <moritz.fischer@ettus.com>
+L:	linux-kernel at vger.kernel.org
+S:	Maintained
+F:	drivers/mailbox/mailbox-xilinx.c
+F:	Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial at vger.kernel.org
-- 
2.4.1
