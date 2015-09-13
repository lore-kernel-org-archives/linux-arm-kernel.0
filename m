From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 13 Sep 2015 12:14:30 +0100
Subject: [PATCH 0/3] GIC fixes for 4.3-rc2
Message-ID: <1442142873-20213-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, Jason,

This small collection of patches address a number of issues all over
the GIC spectrum, ranging from boot issues, ITS corruption and compile
warnings.

It would be good if these fixes could make it into 4.3-rc2.

Thanks,

	M.

Marc Zyngier (2):
  irqchip/GIC: Add workaround for aliased GIC400
  irqchip/gic-v3-its: Add missing cache flushes

Pavel Fedin (1):
  irqchip/GICv2m: Fix GICv2m build warning on 32 bits

 drivers/irqchip/irq-gic-v2m.c    |  4 ++--
 drivers/irqchip/irq-gic-v3-its.c |  6 +++++-
 drivers/irqchip/irq-gic.c        | 44 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 46 insertions(+), 8 deletions(-)

-- 
2.1.4
