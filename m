From: han.xu@nxp.com (Han Xu)
Date: Thu, 18 Feb 2016 03:55:15 +0000
Subject: [PATCH] MAINTAINERS: add maintainer entry for FREESCALE GPMI NAND
 driver
Message-ID: <1455767715-621-1-git-send-email-han.xu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a maintainer entry for FREESCALE GPMI NAND driver and add myself as a
maintainer.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7bd927e..49baa5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4543,6 +4543,12 @@ L:	linuxppc-dev at lists.ozlabs.org
 S:	Maintained
 F:	drivers/dma/fsldma.*
 
+FREESCALE GPMI NAND DRIVER
+M:	Han Xu <han.xu@nxp.com>
+L:	linux-mtd at lists.infradead.org
+S:	Maintained
+F:	drivers/mtd/nand/gpmi-nand/*
+
 FREESCALE I2C CPM DRIVER
 M:	Jochen Friedrich <jochen@scram.de>
 L:	linuxppc-dev at lists.ozlabs.org
-- 
2.7.1
