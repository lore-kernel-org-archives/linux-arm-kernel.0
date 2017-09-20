From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 20 Sep 2017 13:38:18 +0530
Subject: [PATCH 0/4] iirqchip: Handle return value of kasprintf
Message-ID: <1505894901-9403-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kasprintf() can fail here and we must check its return value.

Arvind Yadav (4):
  [PATCH 1/4] irqchip/gic-v3-its: Handle return value of kasprintf
  [PATCH 2/4] irqchip/gic-v3-its-platform-msi: Handle return value of kasprintf
  [PATCH 3/4] irqchip/gic: Handle return value of kasprintf
  [PATCH 4/4] irqchip/lpc32xx: Handle return value of kasprintf

 drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 3 +++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 3 +++
 drivers/irqchip/irq-gic.c                     | 4 ++++
 drivers/irqchip/irq-lpc32xx.c                 | 5 +++++
 4 files changed, 15 insertions(+)

-- 
1.9.1
