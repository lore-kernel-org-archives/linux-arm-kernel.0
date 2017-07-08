From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 08 Jul 2017 20:16:29 +0100
Subject: [PATCH 1/6] MAINTAINERS: add Macchiatobin maintainers entry
In-Reply-To: <20170708191317.GM4902@n2100.armlinux.org.uk>
References: <20170708191317.GM4902@n2100.armlinux.org.uk>
Message-ID: <E1dTvDR-0007Ea-Fx@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a maintainers entry for the Macchiatobin board.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 91b149bc3206..0d236fe12597 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7976,6 +7976,12 @@ L:	libertas-dev at lists.infradead.org
 S:	Orphan
 F:	drivers/net/wireless/marvell/libertas/
 
+MARVELL MACCHIATOBIN SUPPORT
+M:	Russell King <rmk@armlinux.org.uk>
+L:	linux-arm-kernel at lists.infradead.org
+S:	Maintained
+F:	arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+
 MARVELL MV643XX ETHERNET DRIVER
 M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
 L:	netdev at vger.kernel.org
-- 
2.7.4
