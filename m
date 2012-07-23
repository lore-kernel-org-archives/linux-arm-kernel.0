From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Jul 2012 20:33:35 -0000
Subject: [GIT PULL 10/15] arm-soc: defconfig updates
In-Reply-To: <1343075561-17446-1-git-send-email-arnd@arndb.de>
References: <1343075561-17446-1-git-send-email-arnd@arndb.de>
Message-ID: <1343075561-17446-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:

  Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git next/defconfig

for you to fetch changes up to 2d05bf6ef7391ac3642ab62bc3a649fdb32731fe:

  Merge branch 'samsung/defconfig' into next/defconfig (2012-07-21 23:22:35 +0200)

----------------------------------------------------------------

arm-soc: defconfig updates

These are changes to the default configuration files, to account for
kernel changes and new hardware.

----------------------------------------------------------------

Arnd Bergmann (6):
      Merge branch 'lpc32xx/defconfig' of git://git.antcom.de/linux-2.6 into next/defconfig
      Merge branch 'mxs/defconfig-for-3.6' of git://git.linaro.org/people/shawnguo/linux-2.6 into next/defconfig
      Merge branch 'for-3.6/defconfig' of git://git.kernel.org/.../swarren/linux-tegra into next/defconfig
      Merge tag 'imx-defconfig' of git://git.pengutronix.de/git/imx/linux-2.6 into next/defconfig
      Merge branch 'samsung/defconfig' into next/defconfig
      Merge branch 'next/defconfig' into for-next

Fabio Estevam (5):
      ARM: mxs: Let GPMI driver be built by default
      ARM: mxs: Enable MACH_APX4DEVKIT
      ARM: mxs_defconfig: Let AUART driver be built by default
      ARM: mxs_defconfig: Enable RTC driver
      ARM: mxs: defconfig: Enable CONFIG_COMMON_CLK_DEBUG

Olof Johansson (1):
      ARM: exynos_defconfig: enable more platforms in defconfig

Roland Stigge (1):
      ARM: LPC32xx: Defconfig update

Sascha Hauer (2):
      ARM: imx_v6_v7_defconfig: update features
      ARM: imx_v4_v5_defconfig: update features

Stephen Warren (1):
      ARM: tegra: defconfig updates

 arch/arm/configs/exynos_defconfig    |   92 ++++++++++++++++++++++++++++++++++
 arch/arm/configs/imx_v4_v5_defconfig |   51 +++++++++----------
 arch/arm/configs/imx_v6_v7_defconfig |   61 +++++++++++++---------
 arch/arm/configs/lpc32xx_defconfig   |    2 +
 arch/arm/configs/mxs_defconfig       |    7 +++
 arch/arm/configs/tegra_defconfig     |   13 +++--
 6 files changed, 170 insertions(+), 56 deletions(-)
