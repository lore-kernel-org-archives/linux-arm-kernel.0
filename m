From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Feb 2015 00:33:27 -0800
Subject: [GIT PULL 6/7] ARM: SoC defconfig changes
In-Reply-To: <1424162008-23768-1-git-send-email-olof@lixom.net>
References: <1424162008-23768-1-git-send-email-olof@lixom.net>
Message-ID: <1424162008-23768-7-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of these changes are to enable new drivers that have been merged, or
various additions to make defconfigs more useful. There's also a set of patches
trimming down omap2plus kernel size a bit since it is quite large.


Conflicts:

arch/arm/configs/omap2plus_defconfig: change/change conflict, keep CPUFREQ_DT
arch/arm/configs/shmobile_defconfig: change/change, keep SH73A0, remove LAGER

----------------------------------------------------------------

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/defconfig-for-linus

for you to fetch changes up to 0f01f9588d7b2e5f90335e2bf74c1e8d10177b56:

  Merge tag 'samsung-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into next/defconfig

----------------------------------------------------------------

Anand Moon (1):
      ARM: exynos_defconfig: Enable CONFIG_LOCKUP_DETECTOR

Andreas Faerber (1):
      ARM: exynos_defconfig: Enable LM90 driver

Carlo Caione (2):
      ARM: sunxi: Add AXP20x support in defconfig
      ARM: sunxi: Add AXP20x support multi_v7_defconfig

Chen-Yu Tsai (2):
      ARM: sunxi_defconfig: Enable TOUCHSCREEN_SUN4I, CPUFREQ_DT, CPU_THERMAL
      ARM: multi_v7_defconfig: Enable TOUCHSCREEN_SUN4I, CPU_THERMAL

Eddie Huang (1):
      ARM: Add mediatek SoC UART support in defconfig

Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Select SPI_FSL_QUADSPI by default
      ARM: imx_v6_v7_defconfig: Select CONFIG_FB_MXS

Felipe Balbi (2):
      ARM: omap2plus_defconfig: reduce zImage size on omap2plus_defconfig
      ARM: omap2plus_defconfig: enable TPS65218 power button

Gabriel FERNANDEZ (1):
      ARM: multi_v7_defconfig: Enable MiPHY28lp - ST's Generic (SATA, PCIe & USB3) PHY

Geert Uytterhoeven (4):
      ARM: shmobile: kzm9g_defconfig: Update AK8975 config option
      ARM: shmobile: Enable MICREL_PHY in shmobile_defconfig
      ARM: shmobile: Enable DA9063 watchdog in multiplatform defconfig
      ARM: shmobile: Enable kzm9g board in multiplatform defconfig

Grygorii Strashko (1):
      ARM: config: multi_v7: Update it for Keystone defconfig

Javier Martinez Canillas (1):
      ARM: multi_v7_defconfig: Enable Exynos5420 Multi-Cluster PM support

Josh Wu (1):
      ARM: at91: sama5: enable atmel-isi and ov2640 in defconfig

Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Enable PMIC and MUIC drivers for Gears and Trats2

Kuninori Morimoto (3):
      ARM: shmobile: defconfig: cleanup by savedefconfig
      ARM: shmobile: defconfig: add MTD_BLOCK
      ARM: shmobile: Select CONFIG_REGULATOR in defconfig once again

Maxime Ripard (1):
      ARM: at91/config: sama5: Remove DEBUG_LL

Murali Karicheri (1):
      ARM: config: add DEVTMPFS option by default to keystone config

Nishanth Menon (1):
      ARM: omap2plus_defconfig: Enable misc options for BeagleBoard-X15 platform

Olof Johansson (13):
      Merge tag 'renesas-defconfig-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'v3.20-next-defconfig' of https://github.com/mbgg/linux-mediatek into next/defconfig
      Merge tag 'mvebu-defconfig-3.20' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'at91-defconfig' of git://git.kernel.org/.../nferre/linux-at91 into next/defconfig
      Merge tag 'renesas-defconfig2-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'sti-defconfig-for-v3.20-1' of git://git.stlinux.com/devel/kernel/linux-sti into next/defconfig
      Merge tag 'omap-for-v3.20/defconfig-modular' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig
      Merge tag 'imx-defconfig-3.20' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'tegra-for-3.20-defconfig' of git://git.kernel.org/.../tegra/linux into next/defconfig
      Merge tag 'sunxi-defconfig-for-3.20' of https://git.kernel.org/.../mripard/linux into next/defconfig
      Merge tag 'renesas-defconfig-fixes-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'keystone-soc' of git://git.kernel.org/.../ssantosh/linux-keystone into next/defconfig
      Merge tag 'samsung-defconfig' of git://git.kernel.org/.../kgene/linux-samsung into next/defconfig

Peter Chen (1):
      ARM: imx_v6_v7_defconfig: enable more USB functions

Peter Griffin (1):
      ARM: multi_v7_defconfig: Enable stih407 usb picophy

Sjoerd Simons (2):
      ARM: omap2plus_defconfig: Enable OHCI & EHCI HCD support
      ARM: exynos_defconfig: Enable CONFIG_FHANDLE

Stefan Agner (1):
      ARM: imx_v6_v7_defconfig: add POWER_RESET_SYSCON

Thierry Reding (1):
      ARM: tegra: Regenerate defconfig based on v3.19-rc1

Thomas Petazzoni (1):
      ARM: mvebu: enable CPUFREQ_DT in mvebu_v7_defconfig

Tony Lindgren (3):
      ARM: omap2plus_defconfig: Enable support for davinci_emac
      ARM: omap2plus_defconfig: Add NOR flash support
      ARM: omap2plus_defconfig: Enable pcf857x

Uwe Kleine-K?nig (1):
      ARM: efm32: update defconfig

Wang Long (2):
      ARM: multi_v7_defconfig: Enable Hip01 platform
      ARM: config: enable ARCH_HIP01


 arch/arm/configs/efm32_defconfig     |   5 +-
 arch/arm/configs/exynos_defconfig    |  11 +++
 arch/arm/configs/hisi_defconfig      |   1 +
 arch/arm/configs/imx_v6_v7_defconfig |  39 ++++++++-
 arch/arm/configs/keystone_defconfig  |   1 +
 arch/arm/configs/kzm9g_defconfig     |   2 +-
 arch/arm/configs/multi_v7_defconfig  |  21 +++++
 arch/arm/configs/mvebu_v7_defconfig  |   1 +
 arch/arm/configs/omap2plus_defconfig | 127 ++++++++++++++++++++----------
 arch/arm/configs/sama5_defconfig     |   8 +-
 arch/arm/configs/shmobile_defconfig  |  48 ++++++-----
 arch/arm/configs/sunxi_defconfig     |  10 ++-
 arch/arm/configs/tegra_defconfig     |   2 -
 13 files changed, 203 insertions(+), 73 deletions(-)
