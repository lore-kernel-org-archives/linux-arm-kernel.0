From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Dec 2013 17:47:18 +0100
Subject: [PATCH 2/6] net: cpsw: header, Add missing include
In-Reply-To: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387385242-1161-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"MII_BUS_ID_SIZE" is defined in linux/phy.h which is not included in the
cpsw.h file.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/net/ethernet/ti/cpsw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
index 574f49d..1b71067 100644
--- a/drivers/net/ethernet/ti/cpsw.h
+++ b/drivers/net/ethernet/ti/cpsw.h
@@ -15,6 +15,7 @@
 #define __CPSW_H__
 
 #include <linux/if_ether.h>
+#include <linux/phy.h>
 
 struct cpsw_slave_data {
 	char		phy_id[MII_BUS_ID_SIZE];
-- 
1.8.5.1
