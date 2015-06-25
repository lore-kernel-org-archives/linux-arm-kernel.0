From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 25 Jun 2015 15:31:04 -0700
Subject: [GIT PULL 5/5] ARM: SoC: defconfig updates for v4.2
In-Reply-To: <1435271464-11455-1-git-send-email-khilman@kernel.org>
References: <1435271464-11455-1-git-send-email-khilman@kernel.org>
Message-ID: <1435271464-11455-6-git-send-email-khilman@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We keep collecting defconfig updates in a separate branch mostly to encourage
people to handle them separately and avoid conflicts between different topics.

Most of these are enablement of new SoCs, boards or drivers that have
come in, or minor config refreshes due to reorderings in Kconfig
files, etc. I.e. mostly minor churn of various kinds.

Conflicts: None

----------------------------------------------------------------

The following changes since commit 32270e805a1e0baf39aa040177ef1896f03b7266:

  Merge tag 'armsoc-drivers' into test-merge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to dec36f6ab89db2ae80a0a61f26e1ca1f6a61b651:

  ARM: multi_v7_defconfig: remove duplicate CONFIG_COMMON_CLK_QCOM=y

----------------------------------------------------------------

Alexandre Belloni (1):
      ARM: multi_v7_defconfig: Add Atmel SAMA5 family

Anand Moon (2):
      ARM: exynos_defconfig: Enable CONFIG_SENSORS_PWM_FAN for Odroid-XU3
      ARM: exynos_defconfig: Enable CONFIG_SENSORS_INA2XX for Odroid-XU3

Anthoine Bourgeois (1):
      ARM: omap2plus_defconifg: Enable DM9000 in omap2plus_defconfig

Ard Biesheuvel (1):
      ARM: multi_v7_defconfig: enable asm and NEON accelerated crypto modules

Arnd Bergmann (10):
      Merge tag 'sti-defconfig-for-v4.2-1' of git://git.kernel.org/.../mcoquelin/sti into next/defconfig
      Merge tag 'hip04-config-for-4.2' of git://github.com/hisilicon/linux-hisi into next/defconfig
      Merge tag 'tegra-for-4.2-defconfig' of git://git.kernel.org/.../tegra/linux into next/defconfig
      Merge tag 'renesas-defconfig-for-v4.2' of git://git.kernel.org/.../horms/renesas into next/defconfig
      ARM: xz: do not try to use a ramdisk in defconfig
      ARM: stm32: do not try to use a ramdisk in defconfig
      Merge tag 'at91-defconfig' of git://git.kernel.org/.../nferre/linux-at91 into next/defconfig
      Merge tag 'qcom-defconfig-for-4.2' of git://git.kernel.org/.../galak/linux-qcom into next/defconfig
      Merge tag 'renesas-defconfig2-for-v4.2' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'imx-defconfig-4.2' of git://git.kernel.org/.../shawnguo/linux into next/defconfig

Baruch Siach (1):
      ARM: multi_v7_defconfig: enable Conexant Digicolor platform

Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Enable RTC PCF8523 support
      ARM: imx_v6_v7_defconfig: Select LS1021A

Fathi Boudra (1):
      ARM: defconfig: hisi: enable HiSilicon hip04 ethernet controller

Frank Li (1):
      ARM: config: imx_v6_v7_defconfig add imx7d support

Geert Uytterhoeven (5):
      ARM: shmobile: defconfig: Replace USB_RCAR_GEN2_PHY by PHY_RCAR_GEN2
      ARM: multi_v7_defconfig: Replace USB_RCAR_GEN2_PHY by PHY_RCAR_GEN2
      ARM: multi_v7_defconfig: Enable shmobile r8a7778/bockw platform
      ARM: multi_v7_defconfig: Make sound support modular
      ARM: multi_v7_defconfig: Make media support modular

Javier Martinez Canillas (9):
      ARM: multi_v7_defconfig: Enable support for Samsung S3C64XX SPI
      ARM: multi_v7_defconfig: Enable max77802 regulator, rtc and clock drivers
      ARM: multi_v7_defconfig: Enable Exynos USB PHY drivers support
      ARM: multi_v7_defconfig: Enable support for missing ChromeOS EC drivers
      ARM: multi_v7_defconfig: Enable Samsung PWM support
      ARM: multi_v7_defconfig: Enable Samsung S3C SoC RTC
      ARM: multi_v7_defconfig: Enable options for Exynos display support
      ARM: multi_v7_defconfig: Enable GPIO-based I2C arbitration support
      ARM: multi_v7_defconfig: Enable Cypress APA I2C Trackpad support

Joachim Eastwood (2):
      ARM: lpc18xx: add kernel config
      ARM: lpc18xx: remove DEBUG_LL_UART_8250 from defconfig

Jun Nie (1):
      ARM: zx: Add basic defconfig support for ZX296702

Kevin Hilman (3):
      Merge tag 'samsung-defconfig-2' of git://git.kernel.org/.../kgene/linux-samsung into next/defconfig
      Merge tag 'omap-for-v4.2/o2_dc' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig
      ARM: multi_v7_defconfig: remove duplicate CONFIG_COMMON_CLK_QCOM=y

Krzysztof Kozlowski (6):
      ARM: multi_v7_defconfig: Enable CPU idle for exynos SoCs
      ARM: multi_v7_defconfig: Enable PMIC and MUIC drivers for exynos
      ARM: multi_v7_defconfig: Enable TMU for exynos SoCs
      ARM: multi_v7_defconfig: Enable OHCI on exynos SoCs
      ARM: exynos_defconfig: Enable display on Trats2 board
      ARM: multi_v7_defconfig: Enable display on Trats2 board

Kukjin Kim (1):
      ARM: exynos_defconfig: savedefconfig

Lee Jones (2):
      ARM: multi_v7_defconfig: Enable support for ST's LPC Watchdog
      ARM: multi_v7_defconfig: Enable support for ST's LPC RTC

Lina Iyer (2):
      ARM: config: Update qcom_defconfig to enable cpuidle
      ARM: config: multi_v7: Update to enable cpuidle for QCOM SoCs

Linus Walleij (3):
      ARM: ux500: add PERF_EVENTS to defconfig
      ARM: ux500: enable CoreSight in defconfig
      ARM64: add GPIO keys to the defconfig

Masahiro Yamada (1):
      ARM: multi_v7_defconfig: enable UniPhier SoC family

Maxime Coquelin (1):
      ARM: configs: Add STM32 defconfig

Murali Karicheri (1):
      ARM: keystone: defconfig: enable netcp driver by default

Nicolas Ferre (1):
      ARM: at91/defconfig: add CONFIG_REGULATOR_FIXED_VOLTAGE for mmc driver

Roger Quadros (1):
      ARM: omap2plus_defconfig: Enable TOUCHSCREEN_PIXCIR

Stefan Agner (2):
      ARM: vf610m4: add defconfig for Linux on Vybrids Cortex-M4
      ARM: add ARM_SINGLE_ARMV7M in ARMv7-M defconfigs

S?bastien Szymanski (1):
      ARM: imx_v6_v7_defconfig: updates for Armadeus Systems APF6 boards

Thierry Reding (1):
      ARM: tegra: Update default configuration

Tony Lindgren (1):
      ARM: omap2plus_defconfig: Add dm816x USB PHY as a loadable module

Zhou Wang (1):
      ARM: hip04: add GPIO configure in hisi_defconfig


 arch/arm/configs/at91_dt_defconfig   |   2 +
 arch/arm/configs/efm32_defconfig     |   1 -
 arch/arm/configs/exynos_defconfig    |  50 ++++------
 arch/arm/configs/hisi_defconfig      |   2 +
 arch/arm/configs/imx_v6_v7_defconfig |   9 ++
 arch/arm/configs/keystone_defconfig  |   6 ++
 arch/arm/configs/lpc18xx_defconfig   | 151 ++++++++++++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig  | 110 +++++++++++++++++++---
 arch/arm/configs/omap2plus_defconfig |   3 +
 arch/arm/configs/qcom_defconfig      |   2 +
 arch/arm/configs/sama5_defconfig     |   1 +
 arch/arm/configs/shmobile_defconfig  |   4 +-
 arch/arm/configs/stm32_defconfig     |  70 ++++++++++++++
 arch/arm/configs/tegra_defconfig     |  10 ++
 arch/arm/configs/u8500_defconfig     |   5 +
 arch/arm/configs/vf610m4_defconfig   |  42 +++++++++
 arch/arm64/configs/defconfig         |   1 +
 17 files changed, 419 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/configs/lpc18xx_defconfig
 create mode 100644 arch/arm/configs/stm32_defconfig
 create mode 100644 arch/arm/configs/vf610m4_defconfig
