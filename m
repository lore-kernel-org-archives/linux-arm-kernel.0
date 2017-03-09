From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu,  9 Mar 2017 10:51:17 -0800
Subject: [PATCH 0/3] ARM: brcmstb: Kconfig change and updates
Message-ID: <20170309185120.1713-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series contains updates to arch/arm/mach-bcm/Kconfig to enable
a couple of missing options required by the BRCMSTB SoCs.

The last patch updates the earlyprintk debug stub with a new chip: 7260.

Al Cooper (1):
  ARM: brcmstb: Enable ZONE_DMA for non 64-bit capable peripherals

Danesh Petigara (1):
  ARM: brcmstb: Enable ARCH_HAS_HOLES_MEMORYMODEL

Florian Fainelli (1):
  ARM: brcmstb: Add entry for 7260

 arch/arm/include/debug/brcmstb.S | 18 ++++++++++--------
 arch/arm/mach-bcm/Kconfig        |  2 ++
 2 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.9.3
