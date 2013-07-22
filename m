From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 22 Jul 2013 14:14:34 +0200
Subject: [PATCH v3 07/31] fs_enet: silence a build warning (unused variable)
In-Reply-To: <1374495298-22019-1-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
Message-ID: <1374495298-22019-8-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 8de53a1..c04eb3a 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -583,7 +583,6 @@ static struct sk_buff *tx_skb_align_workaround(struct net_device *dev,
 					       struct sk_buff *skb)
 {
 	struct sk_buff *new_skb;
-	struct fs_enet_private *fep = netdev_priv(dev);
 
 	/* Alloc new skb */
 	new_skb = netdev_alloc_skb(dev, skb->len + 4);
-- 
1.7.10.4
