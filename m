From: olof@lixom.net (Olof Johansson)
Date: Mon,  1 Aug 2016 14:39:25 -0700
Subject: [GIT PULL 4/7] ARM: SoC defconfig updates for v4.8
In-Reply-To: <1470087568-4222-1-git-send-email-olof@lixom.net>
References: <1470087568-4222-1-git-send-email-olof@lixom.net>
Message-ID: <1470087568-4222-5-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defconfig additions, removals, etc. Most of these are small changes adding
the options for newly upstreamed drivers, or drivers needed for new board
support.

- Removed Broadcom bcm_defconfig, targets are all covered in multi_v7_defconfig
- New defconfig: multi_v4t_defconfig


Conflicts:

None

----------------------------------------------------------------

The following changes since commit 993595177ce9565aa9f6f7a914a2e7b5a1c86262:

  Merge branch 'next/arm64' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to 772a7f22978bccb88b8ba2685a9f37648da615fc:

  Merge tag 'omap-for-v4.8/defconfig-v2-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/defconfig

----------------------------------------------------------------

Alexander Shiyan (1):
      ARM: config: Add a multi_v4t_defconfig

Alexandre Belloni (2):
      ARM: multi_v5_defconfig: enable Atmel platforms
      ARM: multi_v7_defconfig: add ACT8945A

Andrzej Hajda (1):
      ARM: multi_v7_defconfig: Enable Exynos DRM Mixer driver

Arnd Bergmann (4):
      Merge tag 'at91-ab-4.8-defconfig2' of git://git.kernel.org/.../abelloni/linux into next/defconfig
      Merge tag 'sunxi-defconfig-for-4.8' of https://git.kernel.org/.../mripard/linux into next/defconfig
      Merge tag 'sti-defconfig-for-v4.8' of git://git.kernel.org/.../pchotard/sti into next/defconfig
      Merge tag 'omap-for-v4.8/defconfig-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig

Bartlomiej Zolnierkiewicz (1):
      ARM: exynos_defconfig: Disable big.LITTLE switcher

Diego Dorta (1):
      ARM: imx_v6_v7_defconfig: Select ADS7846 support

Dinh Nguyen (1):
      ARM: socfpga: enable PL330 DMA in socfpga_defconfig

Florian Fainelli (7):
      ARM: multi_v7_defconfig: Enable BCM63xx
      ARM: multi_v7_defconfig: Enable BRCMSTB networking
      ARM: multi_v7_defconfig: Enable Broadcom AHCI
      ARM: multi_v7_defconfig: Enable BCM7038 Watchdog
      ARM: multi_v7_defconfig: Enable Broadcom STB PWM
      ARM: multi_v7_defconfig: Enable Broadcom Kona watchdog
      ARM: Remove bcm_defconfig

Franklin S Cooper Jr (1):
      ARM: keystone: Enable PINCTRL_SINGLE Config

Gary Bisson (1):
      ARM: imx_v6_v7_defconfig: enable USB FFS gadget

Javier Martinez Canillas (6):
      ARM: exynos_defconfig: Enable Samsung media platform drivers as modules
      ARM: multi_v7_defconfig: Enable Samsung media platform drivers as modules
      ARM: exynos_defconfig: Enable MFC driver as module
      ARM: multi_v7_defconfig: Enable Exynos MFC driver as module
      ARM: exynos_defconfig: Enable vivid driver as a module
      ARM: multi_v7_defconfig: Enable vivid driver as a module

Joachim Eastwood (1):
      ARM: configs: lpc18xx: enable adc and dac iio drivers

Krzysztof Kozlowski (5):
      ARM: multi_v7_defconfig: Switch max77693 to module
      ARM: multi_v7_defconfig: Enable Trats2 audio codec, touchscreen and sensors
      ARM: multi_v7_defconfig: Enable drivers for Exynos4210 Universal C210 board
      ARM: multi_v7_defconfig: Enable s5p-secss driver
      ARM: exynos_defconfig: Save defconfig on current linux-next

Ley Foon Tan (1):
      ARM: socfpga: add PCIe to socfpga_defconfig

Linus Walleij (1):
      ARM: defconfig: enable the MSM8660 pin controller

Lokesh Vutla (1):
      ARM: keystone: Enable PINCTRL config

Marek Vasut (1):
      ARM: socfpga: Update socfpga_defconfig

Masahiro Yamada (1):
      ARM: keystone: remove redundant depends on ARM_PATCH_PHYS_VIRT

Maxime Ripard (2):
      ARM: multi_v7: Enable sun4i DRM driver
      ARM: sunxi: Enable sun4i DRM driver

Neil Armstrong (1):
      ARM: configs: qualcomm: Add MDM9615 missing defconfigs

Olof Johansson (9):
      Merge tag 'samsung-defconfig-4.8' of git://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'at91-ab-4.8-defconfig' of git://git.kernel.org/.../abelloni/linux into next/defconfig
      Merge tag 'arm-soc/for-4.8/defconfig' of http://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'keystone_config_for_4.8' of git://git.kernel.org/.../ssantosh/linux-keystone into next/defconfig
      Merge tag 'socfpga_defconfig_updates_for_v4.8' of git://git.kernel.org/.../dinguyen/linux into next/defconfig
      Merge tag 'qcom-defconfig-for-4.8' of git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'imx-defconfig-4.8' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'samsung-defconfig-4.8-2' of git://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'renesas-defconfig-for-v4.8' of git://git.kernel.org/.../horms/renesas into next/defconfig

Patrice Chotard (2):
      ARM: multi_v7_defconfig: enable STMicroelectronics BDISP 2D blitter driver
      ARM: multi_v7_defconfig: enable STMicroelectronics DRM Support

Peter Chen (1):
      ARM: imx_v6_v7_defconfig: build in usbnet to support NFS for non-ethernet board

Simon Horman (2):
      ARM: shmobile: defconfig: Enable r8a7792 SoC
      ARM: multi_v7_defconfig: defconfig: Enable r8a7792 SoC

Tony Lindgren (1):
      ARM: omap2plus_defconfig: Fix USB selection to keep Ethernet working

Wenyou Yang (1):
      ARM: at91/defconfig: Add ACT8945A driver


 arch/arm/configs/bcm_defconfig       | 141 ------------------------------
 arch/arm/configs/exynos_defconfig    |  29 +++---
 arch/arm/configs/imx_v6_v7_defconfig |   4 +-
 arch/arm/configs/keystone_defconfig  |   1 +
 arch/arm/configs/lpc18xx_defconfig   |   2 +
 arch/arm/configs/multi_v4t_defconfig | 106 ++++++++++++++++++++++
 arch/arm/configs/multi_v5_defconfig  |  54 +++++++++++-
 arch/arm/configs/multi_v7_defconfig  |  52 +++++++++--
 arch/arm/configs/omap2plus_defconfig |   5 +-
 arch/arm/configs/qcom_defconfig      |   8 ++
 arch/arm/configs/sama5_defconfig     |   3 +
 arch/arm/configs/shmobile_defconfig  |   1 +
 arch/arm/configs/socfpga_defconfig   |  16 +++-
 arch/arm/configs/sunxi_defconfig     |   2 +
 arch/arm/mach-keystone/Kconfig       |   2 +-
 15 files changed, 263 insertions(+), 163 deletions(-)
 delete mode 100644 arch/arm/configs/bcm_defconfig
 create mode 100644 arch/arm/configs/multi_v4t_defconfig
