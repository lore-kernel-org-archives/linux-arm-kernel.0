From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 13 Sep 2014 16:07:19 -0400
Subject: [PATCH v3 3/3] MAINTAINER: net: Add TI NETCP Ethernet driver entry
In-Reply-To: <1410638839-14792-1-git-send-email-santosh.shilimkar@ti.com>
References: <1410638839-14792-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1410638839-14792-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeep Nair <sandeep_n@ti.com>

Signed-off-by: Sandeep Nair <sandeep_n@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 134483f..7b1c41d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9038,6 +9038,12 @@ F:	drivers/power/lp8788-charger.c
 F:	drivers/regulator/lp8788-*.c
 F:	include/linux/mfd/lp8788*.h
 
+TI NETCP ETHERNET DRIVER
+M:	Sandeep Nair <sandeep_n@ti.com>
+L:	netdev at vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/ti/netcp*
+
 TI TWL4030 SERIES SOC CODEC DRIVER
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
-- 
1.7.9.5
