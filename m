From: serveralex@gmail.com (=?UTF-8?q?Alexander=20M=C3=BCller?=)
Date: Tue, 10 May 2016 22:08:35 +0200
Subject: [PATCH 1/6] pinctrl: meson: Fix eth_tx_en bit index
In-Reply-To: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
References: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
Message-ID: <1462910920-5462-2-git-send-email-serveralex@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix pinctrl eth_tx_en bit index according to Hardkernel ODROID-C1 datasheet.

Signed-off-by: Alexander M?ller <serveralex@gmail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index a100bcf..874f2ed 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -564,7 +564,7 @@ static struct meson_pmx_group meson8b_cbus_groups[] = {
 	GROUP(eth_rx_clk,	6,	3),
 	GROUP(eth_txd0_1,	6,	4),
 	GROUP(eth_txd1_1,	6,	5),
-	GROUP(eth_tx_en,	6,	0),
+	GROUP(eth_tx_en,	6,	6),
 	GROUP(eth_ref_clk,	6,	8),
 	GROUP(eth_mdc,		6,	9),
 	GROUP(eth_mdio_en,	6,	10),
-- 
2.5.0
