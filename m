From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 May 2016 00:24:54 +0200
Subject: [GIT PULL 6/7] ARM: SoC defconfig updates for v4.7
In-Reply-To: <8749147.ztcb6kVhye@wuerfel>
References: <8749147.ztcb6kVhye@wuerfel>
Message-ID: <2717085.7it4MHH99U@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to 0ef659a30055e5ec914b51f5294789ea2a92b08c:

  ARM: aspeed: adapt defconfigs for new CONFIG_PRINTK_TIME (2016-05-11 14:11:13 +0200)

----------------------------------------------------------------
ARM: SoC defconfig updates for v4.7

As usual, a bunch of commits, mostly adding drivers and other options to
defconfigs.

We are adding three new defconfig files for the newly added 32-bit
machines (aspeed and mps2), the rest is mainly housekeeping.

The changes outside of arch/arm/config/ are for a Kconfig symbol
that got renamed.

----------------------------------------------------------------
Arnd Bergmann (14):
      Merge tag 'samsung-defconfig-4.7' of git://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'mvebu-defconfig-4.7-1' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'arm-soc/for-4.7/defconfig' of http://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'keystone_config_for_4.7' of git://git.kernel.org/.../ssantosh/linux-keystone into next/defconfig
      Merge tag 'renesas-pci-defconfig-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'lpc32xx-defconfig-4.7' of git://github.com/vzapolskiy/linux-lpc32xx into next/defconfig
      Merge tag 'omap-for-v4.7/defconfig-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig
      Merge tag 'davinci-for-v4.7/defconfig' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'tegra-for-4.7-defconfig' of git://git.kernel.org/.../tegra/linux into next/defconfig
      Merge tag 'imx-defconfig-4.7' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'ux500-defconfig-armsoc2' of git://git.kernel.org/.../linusw/linux-stericsson into next/defconfig
      Merge tag 'aspeed-for-4.7-defconfig' of https://github.com/shenki/linux into next/defconfig
      Merge tag 'at91-defconfig2' of git://git.kernel.org/.../nferre/linux-at91 into next/defconfig
      ARM: aspeed: adapt defconfigs for new CONFIG_PRINTK_TIME

Boris Brezillon (1):
      ARM: multi_v7_defconfig: add HLCDC drivers as modules

Eric Anholt (7):
      ARM: multi_v7_defconfig: Add more BCM2835 support
      ARM: multi_v7_defconfig: Switch BCM2835 to sdhci-iproc.c for MMC
      ARM: multi_v7_defconfig: Build in DWC2 USB support
      ARM: bcm2835: Switch BCM2835 to sdhci-iproc.c for MMC
      ARM: bcm2835: Enable CONFIG_PM.
      ARM: bcm2835: Enable the VC4 graphics driver in the defconfig
      ARM: bcm2835: Enable NFS root support.

Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2016-04-20' into defconfig/next

Gary Bisson (3):
      ARM: imx_v6_v7_defconfig: add FT5x06 and TSC2004 touch support
      ARM: imx_v6_v7_defconfig: add CONFIG_I2C_MUX_GPIO
      ARM: imx_v6_v7_defconfig: add CONFIG_RTC_DRV_M41T80

Heiko Stuebner (2):
      ARM: multi_v7_defconfig: Enable Rockchip displayport phy
      ARM: multi_v7_defconfig: Enable new Rockchip display-controller drivers

Jan Luebbe (2):
      ARM: multi_v5_defconfig: Enable support for MX21/MX27
      ARM: multi_v5_defconfig: Enable recommended options for systemd

Javier Martinez Canillas (3):
      ARM: exynos_defconfig: Enable CPUFreq governors as modules
      ARM: multi_v7_defconfig: Enable CPUFreq governors as modules
      ARM: omap2plus_defconfig: Fix warning due invalid RXKAD symbol value

Joel Stanley (2):
      arm/configs/multi_v5: Add Aspeed ast2400
      arm/configs: Add Aspeed defconfig

Keerthy (1):
      ARM: configs: keystone: Add CPU Hotplug related options

Kevin Hilman (1):
      ARM: davinci_all_defconfig: enable SPI and NOR as modules

Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Enable Trats2 audio codec, touchscreen and sensors

Lee Jones (5):
      ARM: multi_v7_defconfig: Enable ST's PWM driver
      ARM: multi_v7_defconfig: Enable ST's Power Reset driver
      ARM: multi_v7_defconfig: Enable support for PWM Regulators
      ARM: multi_v7_defconfig: Enable ST's HW Random Number Generator
      ARM: multi_v7_defconfig: Remove unused Kconfig option MACH_UX500_DT

Linus Walleij (2):
      ARM: u8500_defconfig: remove staging from defconfig
      ARM: u8500_defconfig: update sensor config

Lokesh Vutla (1):
      ARM: omap2plus_defconfig: Enable GPIO_TPIC2810

Marcel Ziswiler (2):
      ARM: imx_v6_v7_defconfig: add CONFIG_I2C_GPIO
      ARM: imx_v6_v7_defconfig: add CONFIG_MICREL_PHY

Marek Vasut (1):
      ARM: at91: sama5: Update defconfig

Masahiro Yamada (1):
      ARM: multi_v7_defconfig: enable Denali NAND controller

Nicolas Ferre (8):
      ARM: at91/defconfig: add the HDMA controller to sama5_defconfig
      ARM: at91/defconfig: add HLCDC driver to sama5_defconfig
      ARM: at91/defconfig: add PDMIC driver to sama5_defconfig
      ARM: multi_v7_defconfig: add Atmel watchdog timers
      ARM: multi_v7_defconfig: add Atmel ISI (Image Sensor Interface) driver
      ARM: multi_v7_defconfig: add the Atmel Audio microphone interface PDMIC
      ARM: multi_v7_defconfig: add the Atmel sama5d2-compatible ADC driver
      ARM: at91/defconfig: sama5: add CONFIG_FHANDLE

Nishanth Menon (1):
      ARM: omap2plus_defconfig: Enable DP83867 support

Olof Johansson (2):
      Merge tag 'renesas-defconfig-for-v4.7' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'sti-defconfig-for-v4.7-1' of git://git.kernel.org/.../mcoquelin/sti into next/defconfig

Romain Perier (3):
      ARM: mvebu_v7_defconfig: Enabling the new Marvell's cryptographic engine driver
      ARM: multi_v7_defconfig: Enabling the new Marvell's cryptographic engine driver
      ARM: mvebu_v5_defconfig: Switching to the new Marvell's cryptographic engine driver

Sekhar Nori (2):
      ARM: davinci_all_defconfig: enable GPIO_SYSFS
      ARM: davinci_all_defconfig: support systemd

Simon Horman (1):
      PCI: rcar-pcie: Remove Gen2 designation from Kconfig

Thierry Reding (2):
      ARM: tegra: Enable XUSB controller in defconfig
      ARM: multi_v7: Enable Tegra XUSB controller in defconfig

Thomas Petazzoni (1):
      MAINTAINERS: attach arch/arm/configs/mvebu_*_defconfig to relevant maintainers

Tony Lindgren (3):
      ARM: omap2plus_defconfig: Update with make savedefconfig
      ARM: omap2plus_defconfig: Enable twl6030 USB phy as loadable module
      ARM: omap2plus_defconfig: Enable PWM and ir-rx51 as loadable modules

Vladimir Murzin (1):
      ARM: configs: add MPS2 defconfig

Vladimir Zapolskiy (2):
      ARM: LPC32xx: defconfig update
      ARM: LPC32xx: add PL175 memory controller driver to defconfig

Wolfram Sang (2):
      ARM: multi_v7_defconfig: enable I2C demultiplexer and slave eeprom
      ARM: shmobile: defconfig: enable I2C demultiplexer and slave eeprom

Yegor Yefremov (1):
      ARM: omap2plus_defconfig: Enable MDIO Bus/PHY emulation support

 MAINTAINERS                            |   2 +-
 arch/arm/configs/aspeed_g4_defconfig   |  86 ++++++++++++++++++++++++++
 arch/arm/configs/aspeed_g5_defconfig   |  88 ++++++++++++++++++++++++++
 arch/arm/configs/bcm2835_defconfig     |  11 ++--
 arch/arm/configs/davinci_all_defconfig |   7 ++-
 arch/arm/configs/exynos_defconfig      |  11 ++++
 arch/arm/configs/imx_v6_v7_defconfig   |   6 ++
 arch/arm/configs/keystone_defconfig    |   2 +
 arch/arm/configs/lpc32xx_defconfig     |  29 ++++-----
 arch/arm/configs/mps2_defconfig        | 109 +++++++++++++++++++++++++++++++++
 arch/arm/configs/multi_v5_defconfig    |  29 +++++++--
 arch/arm/configs/multi_v7_defconfig    |  37 +++++++++--
 arch/arm/configs/mvebu_v5_defconfig    |   2 +-
 arch/arm/configs/mvebu_v7_defconfig    |   1 +
 arch/arm/configs/omap2plus_defconfig   |  66 +++++++++-----------
 arch/arm/configs/sama5_defconfig       |  13 +++-
 arch/arm/configs/shmobile_defconfig    |   5 +-
 arch/arm/configs/tegra_defconfig       |   2 +
 arch/arm/configs/u8500_defconfig       |   5 +-
 arch/arm64/configs/defconfig           |   2 +-
 drivers/pci/host/Kconfig               |   4 +-
 drivers/pci/host/Makefile              |   2 +-
 22 files changed, 437 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm/configs/aspeed_g4_defconfig
 create mode 100644 arch/arm/configs/aspeed_g5_defconfig
 create mode 100644 arch/arm/configs/mps2_defconfig
