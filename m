From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 29 Sep 2014 16:36:03 +0800
Subject: [PATCH] MAINTAINERS: add atmel nand driver maintainer entry
Message-ID: <1411979763-1449-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an entry in MAINTAINERS file for ATMEL nand driver.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3705430..1bdf3bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1698,6 +1698,12 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
 F:	drivers/net/ethernet/cadence/
 
+ATMEL NAND DRIVER
+M:	Josh Wu <josh.wu@atmel.com>
+L:	linux-mtd at lists.infradead.org
+S:	Supported
+F:	drivers/mtd/nand/atmel_nand*
+
 ATMEL SPI DRIVER
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
-- 
1.9.1
