From: leilk.liu@mediatek.com (Leilk Liu)
Date: Tue, 20 Nov 2018 16:41:08 +0800
Subject: [PATCH 2/2] spi: mediatek: add spi support for mt7629 IC
In-Reply-To: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
References: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1542703268-17285-3-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch add support for mt7629 IC.

Change-Id: Icb8ced408ebd1340fb0340592b91f24740d07e1e
Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 9ee1fe9..0cce6f0 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -150,6 +150,9 @@ struct mtk_spi {
 	{ .compatible = "mediatek,mt7622-spi",
 		.data = (void *)&mt7622_compat,
 	},
+	{ .compatible = "mediatek,mt7629-spi",
+		.data = (void *)&mt7622_compat,
+	},
 	{ .compatible = "mediatek,mt8135-spi",
 		.data = (void *)&mtk_common_compat,
 	},
-- 
1.7.9.5
