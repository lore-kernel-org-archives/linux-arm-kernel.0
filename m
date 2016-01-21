From: olof@lixom.net (Olof Johansson)
Date: Wed, 20 Jan 2016 17:14:40 -0800
Subject: [GIT PULL 7/9] ARM: SoC defconfig updates for v4.5
In-Reply-To: <1453338882-31300-1-git-send-email-olof@lixom.net>
References: <1453338882-31300-1-git-send-email-olof@lixom.net>
Message-ID: <1453338882-31300-8-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As usual, a bunch of commits, mostly adding drivers and other options to
defconfigs because it makes sense to have them enabled on various development
or product boards. Too much to enumerate each here.

There's an introduction of a pxa_defconfig, since PXA finally will allow
building a shared kernel for all boards. With this, we can hopefully
remove a bunch of individual defconfigs down the road but it requires
a bit of real life testing and transition period.

----------------------------------------------------------------

The following changes since commit 5804c94bd04867f721c63f65326b5617bf176b43:

  Merge branch 'next/dt64' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to 2f6b99ef1322e49aa05b16f4a7413f32631fb8fa:

  ARM: Add CONFIG_DEPRECATED_PARAM_STRUCT to netwinder_defconfig

----------------------------------------------------------------

Afzal Mohammed (1):
      ARM: multi_v7_defconfig: enable TPS65217 regulator

Alison Wang (1):
      ARM: multi_v7_defconfig: Enable some drivers for LS1021A

Andre Przywara (1):
      arm: multi_v7_defconfig: Add virtio drivers

Andrew Lunn (5):
      ARM: config: Regenerate multi_v5_defconfig
      ARM: config: Reenable DSA in multi_v5_defconfig
      ARM: config: Add orion5x to multi_v5_defconfig
      ARM: mvebu: Reenable DSA in mvebu_v5_defconfig
      ARM: mvebu: update v5 defconfig for Orion5x machines

Andy Gross (1):
      ARM: multi_v7_defconfig: Enable required QCOM SPMI/PMIC drivers

Ariel D'Alessandro (1):
      ARM: configs: lpc18xx: enable EEPROM NVMEM driver

Arnd Bergmann (6):
      Merge tag 'mvebu-defconfig-4.5-1' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'sunxi-defconfig-for-4.5' of https://git.kernel.org/.../mripard/linux into next/defconfig
      Merge tag 'mvebu-defconfig-4.5-2' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'socfpga_defconfig_for_v4.5' of git://git.kernel.org/.../dinguyen/linux into next/defconfig
      ARM: default to multi_v7_defconfig
      Merge Rockchip pmdomain fix into next/defconfig

Bjorn Andersson (2):
      ARM: defconfig: multi_v7: Enable Qualcomm options for Honami
      ARM: defconfig: Update qcom_defconfig

Chen-Yu Tsai (2):
      ARM: sunxi_defconfig: Update MFD_AXP20X symbol and enable MFD_AXP20X_RSB
      ARM: multi_v7_defconfig: Enable RSB and AXP20X related drivers as modules

Dinh Nguyen (1):
      arm: socfpga_defconfig: enable USB dual-role and cleanup

Enric Balletbo i Serra (1):
      ARM: multi_v7_defconfig: Enable Rockchip generic power domain.

Fabio Estevam (3):
      ARM: imx_v6_v7_defconfig: Remove CONFIG_SOC_LS1021A
      ARM: imx_v6_v7_defconfig: Select VF610_ADC
      ARM: imx_v6_v7_defconfig: Select HDMI audio support

Geert Uytterhoeven (7):
      ARM: shmobile: defconfig: Enable CONFIG_PRINTK_TIME
      ARM: shmobile: defconfig: Drop useless CONFIG_USB_RCAR_PHY=y
      ARM: shmobile: defconfig: Enable missing support based on DTSes
      ARM: shmobile: defconfig: Enable frame buffer console for armadillo800eva
      ARM: multi_v7_defconfig: Drop useless CONFIG_USB_RCAR_PHY=y
      ARM: multi_v7_defconfig: Enable missing Renesas ARM support based on DTSes
      ARM: multi_v7_defconfig: Enable frame buffer console for armadillo800eva

Heiko St?bner (3):
      ARM: multi_v7_defconfig: enable Rockchip io-domain driver
      ARM: multi_v7_defconfig: enable rockchip crypto module
      ARM: multi_v7_defconfig: enable rk808 clkout module

Javier Martinez Canillas (1):
      ARM: multi_v7_defconfig: Build ChromeOS EC drivers as modules

Joachim Eastwood (1):
      ARM: configs: lpc18xx: enable mma7455 IIO driver

Krzysztof Kozlowski (7):
      ARM: exynos_defconfig: Enable Maxim 8997 family drivers
      ARM: exynos_defconfig: Enable Maxim 77693 LED and haptic drivers
      ARM: multi_v7_defconfig: Enable Maxim 8997 family drivers
      ARM: multi_v7_defconfig: Enable Maxim 77693 LED and haptic drivers
      ARM: exynos_defconfig: Enable NFSv4 client
      ARM: exynos_defconfig: Set recommended options for systemd
      ARM: multi_v7_defconfig: Enable fan, sensors and audio for Odroid XU3

Linus Walleij (9):
      ARM: mvebu: update v5 defconfig
      ARM: mvebu: add Kirkwood cpuidle to defconfig
      ARM: realview: refresh defconfig
      ARM: realview: update SMP defconfig
      ARM: realview: add generic config options
      ARM: realview: add generic config options
      ARM: realview: select apropriate targets
      ARM: versatile: select some defaults in defconfig
      ARM: versatile: enable the right LEDs

Lucas Stach (1):
      ARM: imx_v6_v7_defconfig: enable PCI_MSI

Marc Zyngier (1):
      ARM: Add CONFIG_DEPRECATED_PARAM_STRUCT to netwinder_defconfig

Marek Szyprowski (1):
      ARM: exynos_defconfig: Add drivers for Exynos4210 Universal C210 board

Martin Sperl (1):
      ARM: bcm2835: enable auxiliary spi driver in defconfig

Nishanth Menon (2):
      ARM: multi_v7_defconfig: Enable AM437x PMIC TPS65218
      ARM: multi_v7_defconfig: Enable generic SoC internal OMAP regulators

Olof Johansson (6):
      Merge tag 'samsung-defconfig-4.5' of https://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'at91-defconfig' of git://git.kernel.org/.../nferre/linux-at91 into next/defconfig
      Merge tag 'renesas-defconfig-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'qcom-defconfig-for-4.5' of git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'lpc18xx_defconfig_for_4.5' of https://github.com/manabian/linux-lpc into next/defconfig
      Merge tag 'imx-defconfig-4.5' of git://git.kernel.org/.../shawnguo/linux into next/defconfig

Robert Jarzmik (1):
      ARM: pxa: add defconfig covering all the boards

Shawn Lin (1):
      ARM: zx_defconfig: remove CONFIG_MMC_DW_IDMAC

Sjoerd Simons (1):
      ARM: multi_v7_defconfig: Add rockchip audio support

Stefan Wahren (1):
      ARM: bcm2835: enable all bcm2835-relevant in defconfig

Stephen Boyd (2):
      ARM: qcom_defconfig: Enable HAVE_ARM_ARCH_TIMER
      ARM: defconfig: qcom: Enable SSBI drivers

Timo Sigurdsson (4):
      ARM: sunxi: Re-enable SID driver in multi_v7_defconfig
      ARM: sunxi: Re-enable SID driver in sunxi_defconfig
      ARM: sunxi: Really enable LRADC keys in sunxi_defconfig
      ARM: sunxi: Clean up sunxi_defconfig

Wenyou Yang (1):
      ARM: at91/defconfig: enable watchdog drivers in sama5_defconfig


 arch/arm/Makefile                       |   5 +-
 arch/arm/configs/bcm2835_defconfig      |  29 +-
 arch/arm/configs/exynos_defconfig       |  18 +-
 arch/arm/configs/imx_v6_v7_defconfig    |   5 +-
 arch/arm/configs/lpc18xx_defconfig      |   5 +
 arch/arm/configs/multi_v5_defconfig     |  43 +-
 arch/arm/configs/multi_v7_defconfig     |  95 +++-
 arch/arm/configs/mvebu_v5_defconfig     |  40 +-
 arch/arm/configs/netwinder_defconfig    |   1 +
 arch/arm/configs/pxa_defconfig          | 783 +++++++++++++++++++++++++++
 arch/arm/configs/qcom_defconfig         |  16 +-
 arch/arm/configs/realview-smp_defconfig |  29 +-
 arch/arm/configs/realview_defconfig     |  26 +-
 arch/arm/configs/sama5_defconfig        |   3 +
 arch/arm/configs/shmobile_defconfig     |  12 +-
 arch/arm/configs/socfpga_defconfig      |   6 +-
 arch/arm/configs/sunxi_defconfig        |  14 +-
 arch/arm/configs/versatile_defconfig    |  11 +-
 arch/arm/configs/zx_defconfig           |   1 -
 19 files changed, 1042 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm/configs/pxa_defconfig
