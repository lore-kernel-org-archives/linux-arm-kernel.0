From: joelagnel@ti.com (Joel A Fernandes)
Date: Tue, 25 Jun 2013 20:06:44 -0500
Subject: [PATCH 0/2] EDMA config and comments
Message-ID: <1372208804-6319-1-git-send-email-joelagnel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joel A Fernandes <agnel.joel@gmail.com>

Minor patches remaining after EDMA series has been merged:

First patch adds the TI_EDMA option which people can forget to add and
can result in failure without any informative errors of why DMA is not
working.

Second patch adds comments to the EDMA code for the calculations in the
A-sync case. From my experience, this code is not-so-obvious. Hopefully
this makes the life of readers of the code a little better.

Joel A Fernandes (2):
  ARM: configs: Enable TI_EDMA in omap2plus_defconfig
  DMA: EDMA: Add comments for A-sync case calculations

 arch/arm/configs/omap2plus_defconfig |    1 +
 drivers/dma/edma.c                   |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

-- 
1.7.9.5
