From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Apr 2016 10:50:10 +1000
Subject: [GIT PULL] Renesas ARM Based SoC PCI Defconfig Updates for v4.7
Message-ID: <cover.1461631445.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC PCI defconfig updates for v4.7.


This pull request includes a single patch with changes that I would
ordinarily be inclined to split into different branches. However,
are most easily done atomicly and as they are rather small I have
kept them in one patch in its own branch. My hope is that you can find
an appropriate home for it.

The patch updates renames PCI_RCAR_GEN2_PCIE Kconfig symbol
as PCIE_RCAR. It includes PCI Makefile and Kconfig changes and
accordingly the patch has an ack from Bjorn Helgaas. It also updates
arm and arm64 defconfigs.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pci-defconfig-for-v4.7

for you to fetch changes up to 350a73b4f896e620216d8e9429bbac16d89da8b0:

  PCI: rcar-pcie: Remove Gen2 designation from Kconfig (2016-04-22 10:14:34 +1000)

----------------------------------------------------------------
Renesas ARM Based SoC Pci Defconfig Updates for v4.7

* Remove Gen2 designation from Kconfig for R-Car PCIE driver

----------------------------------------------------------------
Simon Horman (1):
      PCI: rcar-pcie: Remove Gen2 designation from Kconfig

 arch/arm/configs/multi_v7_defconfig | 2 +-
 arch/arm/configs/shmobile_defconfig | 2 +-
 arch/arm64/configs/defconfig        | 2 +-
 drivers/pci/host/Kconfig            | 4 ++--
 drivers/pci/host/Makefile           | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)
