From: olof@lixom.net (Olof Johansson)
Date: Wed, 22 Aug 2018 21:32:56 -0700
Subject: [GIT PULL 3/4] ARM: SoC defconfig updates
In-Reply-To: <20180823043257.18582-1-olof@lixom.net>
References: <20180823043257.18582-1-olof@lixom.net>
Message-ID: <20180823043257.18582-4-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We keep these separate since some files are shared and conflict-prone,
but there isn't really much to write about here.

Some of the churnier pieces is for the Aspeed platforms, which did an
overdue refresh of the defconfig, and enabled USB gadget and some
drivers from there. Most of the rest are minor additions here and there
to turn on drivers that are needed or useful on the various platforms.

----------------------------------------------------------------

The following changes since commit 4344bb3ec602d8b613a2f6c71f84eb631468a432:

  Merge tag 'armsoc-drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to 07d268f541dee9e58ded056fb6782942faa89a91:

  Merge tag 'v4.19-rockchip-defconfig64-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into next/defconfig

----------------------------------------------------------------

Abhishek Sahu (2):
      ARM: qcom_defconfig: Enable QCOM NAND related configs
      arm64: defconfig: Enable CONFIG_MTD_NAND_QCOM for IPQ8074

Adam Ford (1):
      ARM: davinci_all_defconfig: set CONFIG_BACKLIGHT_PWM=m

Amelie Delaunay (1):
      ARM: multi_v7_defconfig: enable STM32 RTC

Baruch Siach (2):
      ARM: mvebu_v7_defconfig: sync defconfig
      ARM: mvebu_v7_defconfig: enable SFP support

Benjamin Herrenschmidt (2):
      arm: configs: Add USB gadget to Aspeed G4 defconfig
      arm: configs: Add USB gadget to Aspeed G5 defconfig

David Lechner (2):
      ARM: davinci_all_defconfig: remove CONFIG_DAVINCI_RESET_CLOCKS
      ARM: davinci_all_defconfig: Enable Bluetooth

Dien Pham (1):
      arm64: defconfig: Enable BD9571MWV regulator

Enric Balletbo i Serra (1):
      arm64: defconfig: Enable more peripherals for Samsung Chromebook Plus.

Florian Fainelli (2):
      Merge tag 'bcm2835-defconfig-next-2018-07-03' into defconfig/next
      Merge tag 'bcm2835-defconfig-64-next-2018-07-03' into defconfig-arm64/next

Geert Uytterhoeven (5):
      ARM: shmobile: defconfig: Drop NET_VENDOR_<FOO>=n
      ARM: shmobile: defconfig: Enable reset controller support
      ARM: shmobile: defconfig: Enable support for RZN1D-DB
      ARM: shmobile: defconfig: Disable /sbin/hotplug fork-bomb
      ARM: multi_v7_defconfig: Enable support for RZN1D-DB

Gregory CLEMENT (1):
      ARM: multi_v7_defconfig: Add Marvell NAND controller support

Hugues Fruchet (1):
      ARM: multi_v7_defconfig: enable STM32 DCMI media support

Joel Stanley (4):
      ARM: config: aspeed: Update defconfig
      ARM: config: multi_v5: Refresh configuration
      ARM: config: multi_v5: Enable ASPEED drivers
      ARM: config: aspeed: Enable new FSI drivers

Kishon Vijay Abraham I (1):
      ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP

Kunihiko Hayashi (1):
      ARM: multi_v7_defconfig: add CONFIG_UNIPHIER_THERMAL and CONFIG_SNI_AVE

Leonard Crestez (1):
      ARM: imx_v6_v7_defconfig: Enable imx6qdl-sabreauto sensors

Murali Karicheri (1):
      ARM: keystone: k2g: enable micrel and dp83867 phys

Olof Johansson (15):
      Merge tag 'keystone_config_for_4.19' of git://git.kernel.org/.../ssantosh/linux-keystone into next/defconfig
      Merge tag 'arm-soc/for-4.19/defconfig' of https://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'arm-soc/for-4.19/defconfig-arm64' of https://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'davinci-for-v4.19/defconfig' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'samsung-defconfig-4.19' of https://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'stm32-defconfig-for-v4.19-1' of git://git.kernel.org/.../atorgue/stm32 into next/defconfig
      Merge tag 'mvebu-defconfig-4.19-1' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'hisi-defconfig-for-4.19' of git://github.com/hisilicon/linux-hisi into next/defconfig
      Merge tag 'imx-defconfig-4.19' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'renesas-arm64-defconfig-for-v4.19' of https://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'qcom-arm64-defconfig-for-4.19' of git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'qcom-defconfig-for-4.19' of git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'renesas-arm-defconfig-for-v4.19' of https://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'aspeed-4.19-defconfig' of git://git.kernel.org/.../joel/aspeed into next/defconfig
      Merge tag 'v4.19-rockchip-defconfig64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/defconfig

Pawe? Chmiel (3):
      ARM: s5pv210_defconfig: Run make savedefconfig
      ARM: s5pv210_defconfig: Enable drivers for Samsung Aries based phones
      ARM: s5pv210_defconfig: Enable options needed to boot typical Linux distro

Pierre-Yves MORDRET (1):
      ARM: multi_v7_defconfig: enable STM32 DMAv2, DMAMUX and MDMA

Ray Jui (1):
      arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG

Robin Gong (1):
      ARM: imx_v6_v7_defconfig: add DMATEST support

Stefan Agner (2):
      ARM: mxs_defconfig: use MXSFB DRM driver
      ARM: imx_v6_v7_defconfig: use MXSFB DRM driver

Stefan Wahren (3):
      ARM: bcm2835_defconfig: Enable RPi voltage sensor
      ARM: multi_v7_defconfig: Enable RPi voltage sensor
      arm64: defconfig: Enable RPi voltage sensor

Zhou Wang (1):
      arm64: defconfig: enable HiSilicon PMU driver


 arch/arm/configs/aspeed_g4_defconfig   | 113 +++++++++++++++++++++++----
 arch/arm/configs/aspeed_g5_defconfig   | 117 +++++++++++++++++++++++-----
 arch/arm/configs/bcm2835_defconfig     |   2 +-
 arch/arm/configs/davinci_all_defconfig |  11 ++-
 arch/arm/configs/imx_v6_v7_defconfig   |   8 +-
 arch/arm/configs/keystone_defconfig    |   5 ++
 arch/arm/configs/multi_v5_defconfig    |  30 ++++---
 arch/arm/configs/multi_v7_defconfig    |  10 +++
 arch/arm/configs/mvebu_v7_defconfig    |  13 +---
 arch/arm/configs/mxs_defconfig         |   5 +-
 arch/arm/configs/qcom_defconfig        |   2 +
 arch/arm/configs/s5pv210_defconfig     |  49 +++++++++++-
 arch/arm/configs/shmobile_defconfig    |  17 +---
 arch/arm64/configs/defconfig           |  23 ++++++
 14 files changed, 324 insertions(+), 81 deletions(-)
