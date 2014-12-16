From: vigneshr@ti.com (Vignesh R)
Date: Tue, 16 Dec 2014 14:52:49 +0530
Subject: [PATCH 0/2] PCIe related fixes for DRA7xx
Message-ID: <1418721771-31184-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix inconsistent enumeration of PCIe gen2 cards on DRA7xx
boards. Tested this patch series, after applying some out of the
tree patches for resetting PCIe.

Vignesh R (2):
  phy: phy-ti-pipe3: fix inconsistent enumeration of PCIe gen2 cards
  ARM: dts: DRA7X: drop id property in pcie_phy

 arch/arm/boot/dts/dra7.dtsi          |  2 --
 drivers/phy/phy-omap-control.c       |  7 +++----
 drivers/phy/phy-ti-pipe3.c           | 10 ++++++----
 include/linux/phy/omap_control_phy.h |  6 +++---
 4 files changed, 12 insertions(+), 13 deletions(-)

-- 
1.9.1
