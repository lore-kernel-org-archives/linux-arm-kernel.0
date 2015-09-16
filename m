From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 16 Sep 2015 10:28:29 +0200
Subject: [PATCH 4/6] pinctrl: sunxi: Remove unneeded semicolon
In-Reply-To: <1442392111-8448-1-git-send-email-javier@osg.samsung.com>
References: <1442392111-8448-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1442392111-8448-5-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not needed an is just creating a null statement, so remove it.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index fb4669c0ce0e..d3428709b0a6 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1031,7 +1031,7 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 		irq_set_chip_and_handler(irqno, &sunxi_pinctrl_edge_irq_chip,
 					 handle_edge_irq);
 		irq_set_chip_data(irqno, pctl);
-	};
+	}
 
 	for (i = 0; i < pctl->desc->irq_banks; i++) {
 		/* Mask and clear all IRQs before registering a handler */
-- 
2.4.3
