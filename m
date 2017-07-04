From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  4 Jul 2017 10:56:32 +0100
Subject: [PATCH 0/3] irqchip: Miscellaneous fixes for GIC/GICv3
Message-ID: <1499162195-5126-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains some fixes for GIC/GIC-v3 to behave as expected
by the generic management layer.

Suzuki K Poulose (3):
  irqchip: gic-v3: Report failures in gic_irq_domain_alloc
  irqchip: gic-v2: Report failures in gic_irq_domain_alloc
  irq: gic-v3: Honor forced affinity setting

 drivers/irqchip/irq-gic-v3.c | 14 +++++++++++---
 drivers/irqchip/irq-gic.c    |  7 +++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.7.5
