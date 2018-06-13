From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Wed, 13 Jun 2018 12:05:18 +0530
Subject: [PATCH 3/4] net: emaclite: Remove unused 'has_mdio' flag.
In-Reply-To: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1528871719-1681-4-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused 'has_mdio' flag.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 06eb6c8..ec4608e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -123,7 +123,6 @@
  * @phy_node:		pointer to the PHY device node
  * @mii_bus:		pointer to the MII bus
  * @last_link:		last link status
- * @has_mdio:		indicates whether MDIO is included in the HW
  */
 struct net_local {
 
@@ -144,7 +143,6 @@ struct net_local {
 	struct mii_bus *mii_bus;
 
 	int last_link;
-	bool has_mdio;
 };
 
 
-- 
1.7.1
