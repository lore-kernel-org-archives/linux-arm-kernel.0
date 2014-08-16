From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 16 Aug 2014 17:18:31 +0200
Subject: [PATCH v3 3/7] net: cpsw: header, Add missing include
In-Reply-To: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1408202315-20006-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"MII_BUS_ID_SIZE" is defined in linux/phy.h which is not included in the
cpsw.h file.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/net/ethernet/ti/cpsw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
index 574f49da693f..1b710674630c 100644
--- a/drivers/net/ethernet/ti/cpsw.h
+++ b/drivers/net/ethernet/ti/cpsw.h
@@ -15,6 +15,7 @@
 #define __CPSW_H__
 
 #include <linux/if_ether.h>
+#include <linux/phy.h>
 
 struct cpsw_slave_data {
 	char		phy_id[MII_BUS_ID_SIZE];
-- 
2.0.1
