From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 28 Oct 2014 12:01:39 +0100
Subject: [PATCHv2 1/6] net: fec: indentation cleanup; no functional change
In-Reply-To: <1414494104-27943-1-git-send-email-LW@KARO-electronics.de>
References: <1414494104-27943-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1414494104-27943-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/net/ethernet/freescale/fec_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e364d1f..decea57 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -101,7 +101,7 @@ static void fec_enet_itr_coal_init(struct net_device *ndev);
  * frames not being transmitted until there is a 0-to-1 transition on
  * ENET_TDAR[TDAR].
  */
-#define FEC_QUIRK_ERR006358            (1 << 7)
+#define FEC_QUIRK_ERR006358		(1 << 7)
 /* ENET IP hw AVB
  *
  * i.MX6SX ENET IP add Audio Video Bridging (AVB) feature support.
-- 
1.7.10.4
