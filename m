From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Sep 2014 19:19:31 +0200
Subject: [PATCH v6 3/7] net: cpsw: header, Add missing include
In-Reply-To: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
References: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1410110375-3570-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"MII_BUS_ID_SIZE" is defined in linux/phy.h which is not included in the
cpsw.h file.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
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
2.1.0
