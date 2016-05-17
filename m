From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 00:21:59 +0200
Subject: [GIT PULL 3/7] ARM: SoC 64-bit changes for v4.7
In-Reply-To: <8749147.ztcb6kVhye@wuerfel>
References: <8749147.ztcb6kVhye@wuerfel>
Message-ID: <2939699.o6fZg7I3Ka@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-arm64

for you to fetch changes up to da4a95d23beea1c3d1d131480f681b0b276e207e:

  Merge tag 'mvebu-defconfig64-4.7-1' of git://git.infradead.org/linux-mvebu into next/arm64 (2016-05-10 17:46:15 +0200)

----------------------------------------------------------------
ARM: SoC 64-bit changes for v4.7

One new platform gets added this time: The Cortex-A53 based LG Electronics
LG1K platform used in digital TVs.

The other changes are mostly smaller updates to the defconfig files, to
enable additional platform specific drivers, as they get merged through
the subsystem trees.

----------------------------------------------------------------
Akira Tsukamoto (1):
      arm64: defconfig: enable several common USB network adapters

Alim Akhtar (1):
      arm64: defconfig: Enable PL330 DMA controller

Andre Przywara (1):
      arm64: defconfig: Add Juno SATA controller

Arnd Bergmann (6):
      Merge tag 'samsung-defconfig64-4.7' of git://git.kernel.org/.../krzk/linux into next/arm64
      Merge tag 'hi6220-config-for-4.7v3' of git://github.com/hisilicon/linux-hisi into next/arm64
      Merge tag 'renesas-arm64-defconfig-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/arm64
      Merge tag 'imx-defconfig64-4.7' of git://git.kernel.org/.../shawnguo/linux into next/arm64
      Merge tag 'mvebu-arm64-4.7-1' of git://git.infradead.org/linux-mvebu into next/arm64
      Merge tag 'mvebu-defconfig64-4.7-1' of git://git.infradead.org/linux-mvebu into next/arm64

Chanho Min (3):
      arm64: add Kconfig entry for LG1K SoC family
      arm64: defconfig: enable ARCH_LG1K
      MAINTAINERS: add Chanho Min as ARM/LG1K maintainer

Guodong Xu (3):
      arm64: defconfig: Enable the PMIC and regulator for Hi6220 and 96boards HiKey
      arm64: defconfig: add CONFIG_SPI_SPIDEV as module
      arm64: defconfig: enable configs for WLAN and TI WL1835 as modules

Kevin Hilman (1):
      arm64: defconfig: enable basic boot for Amlogic meson

Leo Yan (1):
      arm64: Kconfig: select sp804 timer for ARCH_HISI

Olof Johansson (1):
      Merge tag 'gxbb-arm64' of https://github.com/carlocaione/linux-meson into next/arm64

Stuart Yoder (3):
      arm64: defconfig: cleanup the defconfig
      arm64: defconfig: enable 48-bit virtual addresses
      arm64: defconfig: enable freescale/nxp config options

Thomas Petazzoni (3):
      arm64: marvell: enable AP806 and CP110 syscon driver
      MAINTAINERS: update entry for Marvell ARM platform maintainers
      arm64: configs: add options useful for Armada 7K/8K support

Yoshihiro Shimoda (1):
      arm64: defconfig: Add Renesas R-Car USB 3.0 driver support

 MAINTAINERS                  |  8 +++++++-
 arch/arm64/Kconfig.platforms | 10 ++++++++--
 arch/arm64/configs/defconfig | 45 +++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 55 insertions(+), 8 deletions(-)
