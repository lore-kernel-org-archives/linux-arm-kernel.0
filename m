From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2017 00:09:21 +0100
Subject: [GIT PULL 4/7] ARM: SoC defconfig updates for v4.11
In-Reply-To: <8729461.VkrRdW7LzJ@wuerfel>
References: <8729461.VkrRdW7LzJ@wuerfel>
Message-ID: <5899738.ksGWrgfKsZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to ddf5cf02b981e32aa5896cfd66fc191b9a58ed2e:

  ARM: multi_v7_defconfig: enable pstore configs (2017-02-16 17:22:18 +0100)

----------------------------------------------------------------
ARM: SoC defconfig updates for v4.11

Defconfig additions, removals, etc. Almost all of them just turn on
drivers that we want on some platform, usually after the driver
has been merged into mainline.

There is now a new defconfig file for tango4.

----------------------------------------------------------------
Amelie Delaunay (1):
      ARM: configs: stm32: Add RTC support in STM32 defconfig

Andy Gross (1):
      ARM: multi_v7_defconfig: enable Qualcomm RPMCC

Ard Biesheuvel (1):
      ARM: multi_v7_defconfig: enable some newly added crypto modules

Arnd Bergmann (2):
      Merge tag 'sunxi-defconfig-for-4.11' of https://git.kernel.org/.../mripard/linux into next/defconfig
      Merge tag 'davinci-for-v4.11/defconfig-2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig

Bartosz Golaszewski (2):
      ARM: davinci_all_defconfig: enable dumb vga-dac drm bridge
      ARM: davinci_all_defconfig: enable SATA modules

Brian Norris (1):
      ARM: multi_v7_defconfig: enable pstore configs

David Lechner (4):
      ARM: davinci_all_defconfig: enable pwm-beeper
      ARM: davinci_all_defconfig: enable DA8xx pinconf
      ARM: davinci_all_defconfig: Enable PWM modules
      ARM: davinci_all_defconfig: enable iio

Dinh Nguyen (1):
      ARM: socfpga_defconfig: update defconfig for SoCFPGA

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Select wireless extensions option

Fabrice GASNIER (1):
      ARM: configs: stm32: enable ADC driver

Georgi Djakov (1):
      ARM: qcom_defconfig: Enable RPM/RPM-SMD clocks

Joel Stanley (1):
      ARM: configs: Update Aspeed with new drivers

Kefeng Wang (1):
      arm64: defconfig: Enable NUMA and NUMA_BALANCING

Kevin Hilman (1):
      ARM: davinci_all_defconfig: enable video capture as modules

Krzysztof Kozlowski (1):
      ARM: s5pv210_defconfig: Remove old MACHs

Linus Walleij (5):
      ARM: defconfig: omap2plus: switch LIS3LV02DL driver
      ARM: defconfig: replace MPU3050 driver on multi_v7
      ARM: defconfig: tegra: switch to MPU3050 IIO driver
      ARM: defconfig: pxa: cut MPU3050 input driver
      ARM: defconfig: qcom: add APQ8060 DragonBoard devices

Marc Gonzalez (1):
      ARM: Import tango4_defconfig

Masahiro Yamada (2):
      arm64: defconfig: enable CONFIG_MTD_BLOCK
      arm64: defconfig: enable CONFIG_MTD_NAND and CONFIG_MTD_NAND_DENALI_DT

Niklas S?derlund (2):
      ARM: shmobile: defconfig: Enable CONFIG_VIDEO_ADV7604
      ARM: shmobile: defconfig: Enable CMA for DMA

Olof Johansson (12):
      Merge tag 'renesas-defconfig-for-v4.11' of https://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'socfpga_defconfig_updates_for_v4.11' of git://git.kernel.org/.../dinguyen/linux into next/defconfig
      Merge tag 'samsung-defconfig-4.11' of git://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'at91-ab-4.11-defconfig' of git://git.kernel.org/.../abelloni/linux into next/defconfig
      Merge tag 'aspeed-4.11-defconfig' of git://git.kernel.org/.../joel/aspeed into next/defconfig
      Merge tag 'keystone_config_for_4.11' of git://git.kernel.org/.../ssantosh/linux-keystone into next/defconfig
      Merge tag 'qcom-defconfig-for-4.11' of git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'davinci-for-v4.11/defconfig' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'omap-for-v4.11/defconfig-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig
      Merge tag 'hisi-defconfig-for-4.11' of git://github.com/hisilicon/linux-hisi into next/defconfig
      Merge tag 'stm32-defconfig-for-v4.11-1' of git://git.kernel.org/.../atorgue/stm32 into next/defconfig
      Merge tag 'imx-defconfig-4.11' of git://git.kernel.org/.../shawnguo/linux into next/defconfig

Peter Rosin (1):
      ARM: sama5_defconfig: add support for the Axentia TSE-850 board

Quentin Schulz (1):
      ARM: sunxi: Add CONFIG_THERMAL_OF

Robie Basak (1):
      ARM: exynos_defconfig: Enable IP multicast

Simon Horman (2):
      ARM: shmobile: defconfig: Enable r8a774[35] SoCs
      ARM: multi_v7_defconfig: Enable r8a774[35] SoCs

Srinivas Kandagatla (4):
      ARM: qcom_defconfig: add usb related configs
      ARM: qcom_defconfig: add pcie and atl1c ethernet configs
      ARM: qcom_defconfig: add ahci configs
      ARM: qcom_defconfig: enable thermal sensors

Suman Anna (2):
      ARM: configs: keystone: Enable Generic on-chip SRAM driver
      ARM: Keystone: Enable ARCH_HAS_RESET_CONTROLLER

Teresa Remmet (2):
      ARM: omap2plus_defconfig: Enable support for micrell phys
      ARM: omap2plus_defconfig: Enable support for RTC M41T80

Tony Lindgren (1):
      ARM: omap2plus_defconfig: Fix probe errors on UARTs 5 and 6

Zhou Wang (1):
      arm64: defconfig: enable SMMUv3 config

afzal mohammed (1):
      ARM: vf610m4: defconfig: enable EXT4 filesystem

 arch/arm/configs/aspeed_g4_defconfig   | 38 ++++++++++++--
 arch/arm/configs/aspeed_g5_defconfig   | 38 +++++++++++++-
 arch/arm/configs/davinci_all_defconfig | 23 +++++++++
 arch/arm/configs/exynos_defconfig      |  1 +
 arch/arm/configs/imx_v6_v7_defconfig   |  4 +-
 arch/arm/configs/keystone_defconfig    |  1 +
 arch/arm/configs/multi_v7_defconfig    | 14 ++++-
 arch/arm/configs/omap2plus_defconfig   |  7 ++-
 arch/arm/configs/pxa_defconfig         |  1 -
 arch/arm/configs/qcom_defconfig        | 34 ++++++++++++
 arch/arm/configs/s5pv210_defconfig     |  4 --
 arch/arm/configs/sama5_defconfig       |  7 ++-
 arch/arm/configs/shmobile_defconfig    |  6 +++
 arch/arm/configs/socfpga_defconfig     | 28 +++++++++-
 arch/arm/configs/stm32_defconfig       |  7 +++
 arch/arm/configs/sunxi_defconfig       |  1 +
 arch/arm/configs/tango4_defconfig      | 94 ++++++++++++++++++++++++++++++++++
 arch/arm/configs/tegra_defconfig       |  2 +-
 arch/arm/configs/vf610m4_defconfig     |  3 +-
 arch/arm/mach-keystone/Kconfig         |  1 +
 arch/arm64/configs/defconfig           |  6 +++
 21 files changed, 300 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/configs/tango4_defconfig
