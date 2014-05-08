From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 May 2014 11:39:22 -0400
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.16
Message-ID: <20140508153922.GE12708@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

guys,

We have a nice round of defconfig changes this time.  Pretty simple,
based on v3.15-rc1, and been in -next for a while.

Please pull.

thx,

Jason.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.16

for you to fetch changes up to 208f4e0d9bce775fbc7ab08c830d135d3da5777c:

  ARM: multi_v5_defconfig: Enable sound modules needed for t5325 (2014-05-05 01:22:11 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.16

 - enable the following:
    - nfsroot
    - fhandle
    - sdhci_pxav3
    - ahci_mvebu
    - spi_nor
    - sound for t5325

----------------------------------------------------------------
Andrew Lunn (2):
      ARM: mvebu_v5_defconfig: Enable sound modules needed for t5325
      ARM: multi_v5_defconfig: Enable sound modules needed for t5325

Brian Norris (1):
      ARM: mvebu: defconfig: add MTD_SPI_NOR (new dependency for M25P80)

Ezequiel Garcia (2):
      ARM: mvebu: Enable nfsroot in the defconfig
      ARM: mvebu: enable fhandle in the defconfigs

Thomas Petazzoni (2):
      ARM: configs: add CONFIG_MMC_SDHCI_PXAV3 to the mvebu_v7_defconfig
      ARM: configs: add ahci_mvebu to mvebu_v7_defconfig

 arch/arm/configs/dove_defconfig     | 2 +-
 arch/arm/configs/kirkwood_defconfig | 1 +
 arch/arm/configs/multi_v5_defconfig | 3 ++-
 arch/arm/configs/mvebu_v5_defconfig | 5 ++++-
 arch/arm/configs/mvebu_v7_defconfig | 9 +++++++++
 5 files changed, 17 insertions(+), 3 deletions(-)
