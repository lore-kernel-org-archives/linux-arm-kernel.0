From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri, 16 Mar 2018 11:33:42 +0100
Subject: [PATCH net-next 01/10] net: mvpp2: align the ethtool ops definition
In-Reply-To: <20180316103351.16616-1-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
Message-ID: <20180316103351.16616-2-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cosmetic patch to align the ethtool functions to ops definitions. This
patch does not change in any way the driver's behaviour.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 9bd35f2291d6..430114ad93fc 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -7885,18 +7885,18 @@ static const struct net_device_ops mvpp2_netdev_ops = {
 };
 
 static const struct ethtool_ops mvpp2_eth_tool_ops = {
-	.nway_reset	= phy_ethtool_nway_reset,
-	.get_link	= ethtool_op_get_link,
-	.set_coalesce	= mvpp2_ethtool_set_coalesce,
-	.get_coalesce	= mvpp2_ethtool_get_coalesce,
-	.get_drvinfo	= mvpp2_ethtool_get_drvinfo,
-	.get_ringparam	= mvpp2_ethtool_get_ringparam,
-	.set_ringparam	= mvpp2_ethtool_set_ringparam,
-	.get_strings	= mvpp2_ethtool_get_strings,
-	.get_ethtool_stats = mvpp2_ethtool_get_stats,
-	.get_sset_count	= mvpp2_ethtool_get_sset_count,
-	.get_link_ksettings = phy_ethtool_get_link_ksettings,
-	.set_link_ksettings = phy_ethtool_set_link_ksettings,
+	.nway_reset		= phy_ethtool_nway_reset,
+	.get_link		= ethtool_op_get_link,
+	.set_coalesce		= mvpp2_ethtool_set_coalesce,
+	.get_coalesce		= mvpp2_ethtool_get_coalesce,
+	.get_drvinfo		= mvpp2_ethtool_get_drvinfo,
+	.get_ringparam		= mvpp2_ethtool_get_ringparam,
+	.set_ringparam		= mvpp2_ethtool_set_ringparam,
+	.get_strings		= mvpp2_ethtool_get_strings,
+	.get_ethtool_stats	= mvpp2_ethtool_get_stats,
+	.get_sset_count		= mvpp2_ethtool_get_sset_count,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 };
 
 /* Used for PPv2.1, or PPv2.2 with the old Device Tree binding that
-- 
2.14.3
