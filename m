From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 16 Mar 2016 17:59:39 +0800
Subject: [PATCH 0/2] PCI: mvebu: trivial cleanup
Message-ID: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

trivial clean ups to pci-mvebu.c

Jisheng Zhang (2):
  PCI: mvebu: constify mvebu_pcie_pm_ops structure
  PCI: mvebu: use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for mvebu_pcie_pm_ops

 drivers/pci/host/pci-mvebu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.7.0
