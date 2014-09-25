From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 25 Sep 2014 13:48:37 -0400
Subject: [PATCH v5 3/3] MAINTAINER: net: Add TI NETCP Ethernet driver entry
In-Reply-To: <1411667317-1163-1-git-send-email-santosh.shilimkar@ti.com>
References: <1411667317-1163-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1411667317-1163-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeep Nair <sandeep_n@ti.com>

Signed-off-by: Sandeep Nair <sandeep_n@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aefa948..4821dcf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9117,6 +9117,13 @@ F:	drivers/power/lp8788-charger.c
 F:	drivers/regulator/lp8788-*.c
 F:	include/linux/mfd/lp8788*.h
 
+TI NETCP ETHERNET DRIVER
+M:	Sandeep Nair <sandeep_n@ti.com>
+M:	Santosh Shilimkar <santosh.shilimkar@ti.com>
+L:	netdev at vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/ti/netcp*
+
 TI TWL4030 SERIES SOC CODEC DRIVER
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
-- 
1.7.9.5
