From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Fri, 8 Aug 2014 18:17:14 -0500
Subject: [PATCH 2/4] irqchip: gic-v2m: Remove the matching name gic-400-v2m
In-Reply-To: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <1407539836-9768-3-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch remove the matching name gic-400-v2m.
It will use the "gic-400" instead

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
---
 drivers/irqchip/irq-gic-v2m.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 94ed8d6..57b5a51 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -245,7 +245,4 @@ gicv2m_of_init(struct device_node *node, struct device_node *parent)
 
 	return gicv2m_msi_init(node, &gic->v2m_data);
 }
-
-IRQCHIP_DECLARE(arm_gic_400_v2m, "arm,gic-400-v2m", gicv2m_of_init);
-
 #endif /* CONFIG_OF */
-- 
1.9.0
