From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 24 Dec 2015 17:29:41 +0530
Subject: [GIT PULL] DaVinci device-tree updates for v4.5
Message-ID: <567BDE2D.3020909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This pull request is based on an immutable branch from Vinod Koul for 
some dmaengine fixes which are now merged into v4.4-rc6.

I know this is late. The final version of patches was sent last week. I 
have tested the patches and feel confident it does not break anything.

Thanks,
Sekhar

The following changes since commit ae0add740cd06169cd124f9aaa6eceb11e5b3060:

  dmaengine: edma: DT: Change reserved slot array from 16bit to 32bit type (2015-12-10 08:32:42 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.5/dts

for you to fetch changes up to f0ad43539af41bc2f8baff9ce3237d368d55654e:

  ARM: DTS: da850: Enable DMA for SPI1 (2015-12-24 16:32:14 +0530)

----------------------------------------------------------------
EDMA device-tree updates including move to
new EDMA bindings and EDMA support for MMC/SD
and SPI.

----------------------------------------------------------------
Peter Ujfalusi (6):
      ARM: DTS: da850: fix edma0 reg space
      ARM: DTS: da850: Use the new DT bindings for the eDMA3
      ARM: DTS: da850: Enable eDMA1
      ARM: DTS: da850: Enable DMA use for MMC0
      ARM: DTS: da850: Add node for mmc1
      ARM: DTS: da850: Enable DMA for SPI1

 arch/arm/boot/dts/da850-enbw-cmc.dts |  8 +++++
 arch/arm/boot/dts/da850-evm.dts      |  8 +++++
 arch/arm/boot/dts/da850.dtsi         | 58 ++++++++++++++++++++++++++++++++----
 3 files changed, 68 insertions(+), 6 deletions(-)
