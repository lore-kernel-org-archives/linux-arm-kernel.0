From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Fri, 8 Aug 2014 18:17:12 -0500
Subject: [PATCH 0/4] irqchip: gic-v2m: Rework GICv2m Initialization
Message-ID: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set reworks the GICv2m initialization based on Marc Zyngier
review comments.

* Rebase to git://git.infradead.org/users/jcooper/linux.git irqchip/gic-v2m

Suravee Suthikulpanit (1):
  irqchip/gic-v2m: Restructure the initalization code for v2m

 Documentation/devicetree/bindings/arm/gic.txt |  37 +++++++--
 drivers/irqchip/irq-gic-v2m.c                 | 115 +++++++++-----------------
 drivers/irqchip/irq-gic.c                     |  30 +++----
 drivers/irqchip/irq-gic.h                     |  10 +--
 4 files changed, 91 insertions(+), 101 deletions(-)

-- 
1.9.0
