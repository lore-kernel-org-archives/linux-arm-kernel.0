From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu,  2 Apr 2015 18:41:45 +0300
Subject: [PATCH 1/3] mfd: ucb1x00: add irq field to the platform data
Message-ID: <1427989307-1805-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow boards to specify the irq that is used by UCB1x00 chip, add irq
field to the platform data structure.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 include/linux/mfd/ucb1x00.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
index e1345ff..9a2dacb 100644
--- a/include/linux/mfd/ucb1x00.h
+++ b/include/linux/mfd/ucb1x00.h
@@ -118,6 +118,7 @@ struct ucb1x00_plat_data {
 	unsigned		irq_base;
 	int			gpio_base;
 	unsigned		can_wakeup;
+	int			irq;
 };
 
 struct ucb1x00 {
-- 
2.1.4
