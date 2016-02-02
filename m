From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 2 Feb 2016 14:43:12 +0200
Subject: [PATCH 0/5] ARM: davinci: Add dma_slave_map to board files
Message-ID: <1454416997-14230-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following series adds the dma_slave map to the edma driver. The
dma_slave_map is needed later when we convert drivers to use the new dmaengine
API for requesting slave channels.

Regards,
Peter
---
Peter Ujfalusi (5):
  ARM: davinci: devices-da8xx: Add dma_slave_map to edma
  ARM: davinci: dm355: Add dma_slave_map to edma
  ARM: davinci: dm365: Add dma_slave_map to edma
  ARM: davinci: dm644x: Add dma_slave_map to edma
  ARM: davinci: dm646x: Add dma_slave_map to edma

 arch/arm/mach-davinci/devices-da8xx.c | 46 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/dm355.c         | 20 +++++++++++++++
 arch/arm/mach-davinci/dm365.c         | 22 +++++++++++++++++
 arch/arm/mach-davinci/dm644x.c        | 12 +++++++++
 arch/arm/mach-davinci/dm646x.c        | 11 +++++++++
 5 files changed, 111 insertions(+)

-- 
2.7.0
