From: olof@lixom.net (Olof Johansson)
Date: Mon, 31 Aug 2015 17:07:09 -0700
Subject: [GIT PULL 6/7] ARM: SoC defconfig updates for v4.3
In-Reply-To: <1441066030-23225-1-git-send-email-olof@lixom.net>
References: <1441066030-23225-1-git-send-email-olof@lixom.net>
Message-ID: <1441066030-23225-7-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We mostly keep defconfigs updates on a separate branch due to their tendency
to conflict between platforms and this encourages more careful separation of
code changes and config changes.

Most updates here are minor tweaks, enabling new drivers for various platforms,
and so on. Renesas also removed one defconfig (marzen_defconfig).

----------------------------------------------------------------

The following changes since commit 64e21c2bcc7dcc916c5cdcd9e612fc23891f8e23:

  Merge branch 'next/dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to ba5d183bced6cb60b2838a0bf04665c1c1e4bff1:

  Merge tag 'tegra-for-4.3-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into next/defconfig

----------------------------------------------------------------

Alexandre Belloni (1):
      ARM: at91/defconfig: at91_dt: remove ARM_AT91_ETHER

Barry Song (5):
      ARM: prima2_defconfig: fix the outdated defconfig
      ARM: prima2_defconfig: enable build for SiRFSoC SDHC host
      ARM: prima2_defconfig: enable build for misc input
      ARM: prima2_defconfig: enable build for RTC
      ARM: prima2_defconfig: enable build for hwspinlock

Baruch Siach (1):
      ARM: multi_v7_defconfig: enable Conexant Digicolor watchdog

Chen-Yu Tsai (2):
      ARM: sunxi_defconfig: Enable DMA_SUN6I, P2WI, PWM, cryptodev, EXTCON, FHANDLE
      ARM: multi_v7_defconfig: Enable Allwinner P2WI, PWM, DMA_SUN6I, cryptodev

Fabio Estevam (4):
      ARM: imx_v6_v7_defconfig: Enable kexec support
      ARM: imx_v6_v7_defconfig: Select HCIUART_H4
      ARM: imx_v6_v7_defconfig: Select CONFIG_IKCONFIG_PROC
      ARM: multi_v7_defconfig: Select MX6UL and MX7D

Frank Li (2):
      ARM: imx_v6_v7_defconfig: enable powerkey and syscon power off
      ARM: imx: imx_v6_v7_defconfig enable imx6ul support

Josh Wu (2):
      ARM: at91: at91_dt_defconfig: enable ISI and ov2640 support
      ARM: at91/defconfig: at91_dt: enable DRM hlcdc support

Kuninori Morimoto (2):
      ARM: shmobile: defconfig: add Renesas DPCM Sound Card
      ARM: multi_v7_defconfig: add Renesas DPCM Sound Card

Lee Jones (2):
      ARM: multi_v7_defconfig: Enable ST's PWM driver
      ARM: multi_v7_defconfig: Enable support for PWM Regulators

Linus Walleij (7):
      ARM: ep93xx: activate NO_HZ and high-res timers
      ARM: ep93xx: enable all boards in the EP93xx defconfig
      ARM: ep93xx: enable SIM.ONE MMC/SD hardware
      ARM: ep93xx: add LEDs and triggers to defconfig
      ARM: ep93xx: add GPIO I2C to defconfig
      ARM: ep93xx: add DMA engine to the defconfig
      ARM: ep93xx: add framebuffer to the defconfig

Magnus Damm (1):
      ARM: shmobile: Remove marzen_defconfig

Masahiro Yamada (1):
      ARM: multi_v7_defconfig: enable UniPhier UART driver

Nicolas Pitre (1):
      ARM: add TC2 PM support to multi_v7_defconfig

Olof Johansson (12):
      Merge tag 'mvebu-config-4.3-1' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'ep93xx-defconfig' of git://git.kernel.org/.../linusw/linux-integrator into next/defconfig
      Merge tag 'omap-for-v4.3/defconfig-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig
      Merge tag 'sti-defconfig-for-v4.3-1' of https://git.kernel.org/.../mcoquelin/sti into next/defconfig
      Merge tag 'renesas-defconfig-for-v4.3' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'prima2-defconfig-for-4.2' of git://git.kernel.org/.../baohua/linux into next/defconfig
      Merge tag 'renesas-defconfig2-for-v4.3' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'qcom-defconfig-for-4.3' of git://codeaurora.org/quic/kernel/agross-msm into next/defconfig
      Merge tag 'mvebu-config-4.3-2' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'sunxi-defconfig-for-4.3' of https://git.kernel.org/.../mripard/linux into next/defconfig
      Merge tag 'imx-defconfig-4.3' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'tegra-for-4.3-defconfig' of git://git.kernel.org/.../tegra/linux into next/defconfig

Roger Shimizu (1):
      ARM: defconfig: orion5x: add DT support

Sekhar Nori (4):
      ARM: omap2plus_defconfig: enable support for TI ADC
      ARM: omap2plus_defconfig: enable support for TI touchscreen
      ARM: omap2plus_defconfig: enable support for TI CPTS
      ARM: omap2plus_defconfig: enable support for M25P80 SPI NOR

Shengjiu Wang (1):
      ARM: imx_v6_v7_defconfig: build in audio driver

Simon Horman (3):
      ARM: shmobile: Enable gose board in multiplatform defconfig
      ARM: multi_v7_defconfig: Enable shmobile r8a7793/gose platform
      ARM: shmobile: Enable fixed voltage regulator in shmobile_defconfig

Stephen Boyd (1):
      ARM: qcom_defconfig: Enable options for KS8851 ethernet

Thierry Reding (1):
      ARM: tegra: Update multi_v7_defconfig

Thomas Petazzoni (1):
      ARM: mvebu: update mvebu_v7_defconfig with features needed for Armada 388 GP

Tuomas Tynkkynen (1):
      ARM: tegra: Update default configuration


 arch/arm/configs/at91_dt_defconfig   |  13 +++-
 arch/arm/configs/ep93xx_defconfig    |  29 ++++++-
 arch/arm/configs/imx_v6_v7_defconfig |  31 ++++----
 arch/arm/configs/marzen_defconfig    | 124 ------------------------------
 arch/arm/configs/multi_v7_defconfig  |  23 ++++++
 arch/arm/configs/mvebu_v7_defconfig  |   4 +
 arch/arm/configs/omap2plus_defconfig |   7 ++
 arch/arm/configs/orion5x_defconfig   |   3 +
 arch/arm/configs/prima2_defconfig    |  12 +--
 arch/arm/configs/qcom_defconfig      |   3 +
 arch/arm/configs/shmobile_defconfig  |   3 +
 arch/arm/configs/sunxi_defconfig     |  10 ++-
 arch/arm/configs/tegra_defconfig     |   9 +--
 13 files changed, 118 insertions(+), 153 deletions(-)
 delete mode 100644 arch/arm/configs/marzen_defconfig
