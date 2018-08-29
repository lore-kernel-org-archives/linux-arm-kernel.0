From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Wed, 29 Aug 2018 10:15:09 +0200
Subject: [PATCH] MAINTAINERS: replace free-electrons.com by bootlin.com for
 Thomas Petazzoni
Message-ID: <20180829081509.20437-1-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Free Electrons is now called Bootlin, and my e-mail address was
changed as well, so this commit updates the entries in the MAINTAINERS
file accordingly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1820f2e4d5f4..b716ad6b1900 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8777,7 +8777,7 @@ S:	Maintained
 F:	drivers/net/phy/marvell10g.c
 
 MARVELL MVNETA ETHERNET DRIVER
-M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 L:	netdev at vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/marvell/mvneta.*
@@ -11026,7 +11026,7 @@ S:	Maintained
 F:	drivers/firmware/pcdp.*
 
 PCI DRIVER FOR AARDVARK (Marvell Armada 3700)
-M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 L:	linux-pci at vger.kernel.org
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -11058,7 +11058,7 @@ F:	Documentation/devicetree/bindings/pci/versatile.txt
 F:	drivers/pci/controller/pci-versatile.c
 
 PCI DRIVER FOR ARMADA 8K
-M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 L:	linux-pci at vger.kernel.org
 L:	linux-arm-kernel at lists.infradead.org
 S:	Maintained
@@ -11120,7 +11120,7 @@ F:	include/linux/switchtec.h
 F:	drivers/ntb/hw/mscc/
 
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
-M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 M:	Jason Cooper <jason@lakedaemon.net>
 L:	linux-pci at vger.kernel.org
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
2.14.4
