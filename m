From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 20 Jun 2012 17:00:30 +0800
Subject: [RFC PATCH 1/2] irq_domain: correct a minor wrong comment for linear
 revmap
Message-ID: <1340182831-10477-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

The revmap type should be linear for irq_domain_add_linear function.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 kernel/irq/irqdomain.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3e4ea85..cb83554 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -219,7 +219,7 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
 
 /**
- * irq_domain_add_linear() - Allocate and register a legacy revmap irq_domain.
+ * irq_domain_add_linear() - Allocate and register a linear revmap irq_domain.
  * @of_node: pointer to interrupt controller's device tree node.
  * @size: Number of interrupts in the domain.
  * @ops: map/unmap domain callbacks
-- 
1.7.0.4
