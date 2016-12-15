From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2016 00:03:13 +0100
Subject: [GIT PULL 3/7] ARM: SoC defconfig updates for v4.10
In-Reply-To: <2664636.Hf0nvRznEK@wuerfel>
References: <2664636.Hf0nvRznEK@wuerfel>
Message-ID: <3605479.MNqTqkDJEG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69:

  Linux 4.9-rc2 (2016-10-23 17:10:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to 9f793ef32fc6bf8ae8ca49e3adcdca7143553b58:

  Merge tag 'davinci-for-v4.10/defconfig-4' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci into next/defconfig (2016-12-07 12:35:06 -0800)

----------------------------------------------------------------
ARM: SoC defconfig updates for v4.10

Defconfig additions, removals, etc. Most of these are small changes adding
the options for newly upstreamed drivers, or drivers needed for new board
support.

Bartlomiej Zolnierkiewicz has done a series of patches reducing the use
of CONFIG_IDE from 19 to 3 in favor of CONFIG_ATA.

Overall more patches than usual, but nothing big.

----------------------------------------------------------------
Adam Ford (1):
      ARM: omap2plus_defconfig: Enable TOUCHSCREEN_TSC2004

Alan Tull (1):
      ARM: socfpga: updates for socfpga_defconfig

Alexandre Bailon (1):
      ARM: davinci_all_defconfig: Enable da8xx usb otg

Alexandre TORGUE (1):
      ARM: configs: Add new config fragment to change RAM start point

Arnd Bergmann (4):
      Merge branch 'v4.9-rc2-arm-configs-pata' of https://github.com/bzolnier/linux into next/defconfig
      Merge tag 'davinci-for-v4.10/defconfig-3' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'arm-soc/for-4.10/defconfig' of http://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'sti-defconfig-for-4.10-round3' of git://git.kernel.org/.../pchotard/sti into next/defconfig

Axel Haslam (1):
      ARM: davinci_all_defconfig: Enable OHCI as module

Bartlomiej Zolnierkiewicz (16):
      arm: assabet_defconfig: disable IDE subsystem
      arm: badge4_defconfig: disable IDE subsystem
      arm: cerfcube_defconfig: disable IDE subsystem
      arm: lart_defconfig: disable IDE subsystem
      arm: mainstone_defconfig: disable IDE subsystem
      arm: shannon_defconfig: disable IDE subsystem
      arm: collie_defconfig: convert to use libata PATA drivers
      arm: omap1_defconfig: convert to use libata PATA drivers
      arm: am200epdkit_defconfig: convert to use libata PATA drivers
      arm: corgi_defconfig: convert to use libata PATA drivers
      arm: h3600_defconfig: convert to use libata PATA drivers
      arm: ixp4xx_defconfig: convert to use libata PATA drivers
      arm: jornada720_defconfig: convert to use libata PATA drivers
      arm: netwinder_defconfig: convert to use libata PATA drivers
      arm: s3c2410_defconfig: convert to use libata PATA drivers
      arm: spitz_defconfig: convert to use libata PATA drivers

Bartosz Golaszewski (2):
      ARM: davinci_all_defconfig: enable LCDC DRM driver
      ARM: davinci_all_defconfig: enable the mstpri and ddrctl drivers

David Lechner (3):
      ARM: davinci_all_defconfig: enable gpio poweroff driver
      ARM: davinci_all_defconfig: build MMC into kernel
      ARM: davinci_all_defconfig: enable LED default-on trigger

Dinh Nguyen (2):
      ARM: socfpga_defconfig: Enable HIGHMEM
      ARM: socfpga_defconfig: enable FS configs to support Angstrom filesystem

Florian Fainelli (2):
      ARM: multi_v7_defconfig: Enable BCM47xx/BCM5301x drivers
      Merge tag 'bcm2835-defconfig-next-2016-11-18' into defconfig/next

Javier Martinez Canillas (2):
      ARM: exynos_defconfig: Enable exynos-gsc driver as module
      ARM: multi_v7_defconfig: Enable exynos-gsc driver as module

Linus Walleij (3):
      ARM: defconfig: update U8500 defconfig
      ARM: defconfig: turn on the DT cpufreq for Integrator
      ARM: defconfig: drop GPIO_SYSFS on multiplatforms

Lokesh Vutla (2):
      ARM: omap2plus_defconfig: Enable REGULATOR_GPIO
      ARM: omap2plus_defconfig: Enable LP873X support

Marcel Ziswiler (1):
      ARM: tegra: Enable SGTL5000 audio

Marek Vasut (2):
      ARM: imx_v6_v7_defconfig: Increase CMA size
      ARM: imx_v6_v7_defconfig: Select the es8328 codec driver

Martin Sperl (1):
      ARM: bcm2835: add thermal driver to default config

Maxime Coquelin (1):
      ARM: config: Enable GPIO Key driver in stm32_defconfig

Maxime Ripard (2):
      ARM: sunxi: Enable VGA bridge
      ARM: multi_v7: enable VGA bridge

Neil Armstrong (1):
      ARM: qcom_defconfig: Fix MDM9515 LCC and GCC config

Niklas S?derlund (1):
      ARM: shmobile: defconfig: Enable CONFIG_CGROUPS

Olof Johansson (12):
      Merge tag 'sti-defconfig-for-4.10' of git://git.kernel.org/.../pchotard/sti into next/defconfig
      Merge tag 'renesas-defconfig-for-v4.10' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'davinci-for-v4.10/defconfig' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'samsung-defconfig-4.10' of git://git.kernel.org/.../krzk/linux into next/defconfig
      Merge branch 'sti-defconfig-for-4.10-round2' of git://git.kernel.org/.../pchotard/sti into next/defconfig
      Merge tag 'socfpga_defconfig_updates_for_v4.10' of git://git.kernel.org/.../dinguyen/linux into next/defconfig
      Merge tag 'qcom-defconfig-for-4.10' of git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'imx-defconfig-4.10' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'sunxi-defconfig-for-4.10' of https://git.kernel.org/.../mripard/linux into next/defconfig
      Merge tag 'omap-for-v4.10/defconfig-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig
      Merge tag 'tegra-for-4.10-arm-defconfig' of git://git.kernel.org/.../tegra/linux into next/defconfig
      Merge tag 'davinci-for-v4.10/defconfig-4' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig

Patrice Chotard (2):
      ARM: multi_v7_defconfig: Remove ST_THERMAL_SYSCFG Kconfig symbol
      ARM: multi_v7_defconfig: enable STMicroelectronics HVA driver

Peter Griffin (2):
      ARM: multi_v7_defconfig: Remove miphy365 phy Kconfig symbol.
      ARM: multi_v7_defconfig: Remove stih41x phy Kconfig symbol.

Sekhar Nori (1):
      ARM: davinci_all_defconfig: add missing options for systemd

Steffen Trumtrar (1):
      ARM: socfpga: defconfig: enable qspi

Thierry Reding (2):
      ARM: tegra: Update default configuration for v4.9-rc1
      ARM: tegra: Enable GMI driver in default configuration

Tony Lindgren (1):
      ARM: omap2plus_defconfig: Run make savedefconfig to save some space

 arch/arm/configs/am200epdkit_defconfig  |  5 +++--
 arch/arm/configs/assabet_defconfig      |  1 -
 arch/arm/configs/badge4_defconfig       |  2 --
 arch/arm/configs/bcm2835_defconfig      |  2 ++
 arch/arm/configs/cerfcube_defconfig     |  1 -
 arch/arm/configs/collie_defconfig       |  5 +++--
 arch/arm/configs/corgi_defconfig        |  7 +++----
 arch/arm/configs/davinci_all_defconfig  | 20 ++++++++++++++++----
 arch/arm/configs/dram_0xc0000000.config |  1 +
 arch/arm/configs/exynos_defconfig       |  1 +
 arch/arm/configs/h3600_defconfig        |  5 +++--
 arch/arm/configs/imx_v6_v7_defconfig    |  2 ++
 arch/arm/configs/integrator_defconfig   |  1 +
 arch/arm/configs/ixp4xx_defconfig       |  9 +++++----
 arch/arm/configs/jornada720_defconfig   |  5 +++--
 arch/arm/configs/lart_defconfig         |  2 --
 arch/arm/configs/mainstone_defconfig    |  1 -
 arch/arm/configs/multi_v5_defconfig     |  1 -
 arch/arm/configs/multi_v7_defconfig     | 20 ++++++++++++++++----
 arch/arm/configs/netwinder_defconfig    |  7 ++++---
 arch/arm/configs/omap1_defconfig        |  4 ++--
 arch/arm/configs/omap2plus_defconfig    | 12 ++++++------
 arch/arm/configs/qcom_defconfig         |  4 ++--
 arch/arm/configs/s3c2410_defconfig      | 10 +++-------
 arch/arm/configs/shannon_defconfig      |  1 -
 arch/arm/configs/shmobile_defconfig     |  1 +
 arch/arm/configs/socfpga_defconfig      | 15 +++++++++++++++
 arch/arm/configs/spitz_defconfig        |  8 +++-----
 arch/arm/configs/stm32_defconfig        |  3 +--
 arch/arm/configs/sunxi_defconfig        |  1 +
 arch/arm/configs/tegra_defconfig        | 27 +++++++++++++--------------
 arch/arm/configs/u8500_defconfig        |  7 +++----
 32 files changed, 113 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm/configs/dram_0xc0000000.config
