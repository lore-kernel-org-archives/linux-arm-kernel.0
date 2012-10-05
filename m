From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Oct 2012 20:47:05 -0700
Subject: [GIT PULL] ARM: soc: defconfig updates
Message-ID: <20121005034705.GA19927@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/defconfig

for you to fetch changes up to 3536c27c0fbe41f731ab6f61217ef95d0bdf2e05:

  Merge branch 'next/defconfig-samsung' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into next/defconfig (2012-09-20 16:49:54 -0700)

----------------------------------------------------------------

ARM: soc: defconfig updates

This might be the last time we do a standalone defconfig branch,
since we now prefer to get them with the rest of the subarch updates
instead. These add a handful of useful options on various platforms,
enable new boards and SoCs, etc.

----------------------------------------------------------------
Fabio Estevam (6):
      ARM: mxs_defconfig: Enable USB host
      ARM: mxs_defconfig: Add LED, PWM and MTD_CHAR support
      ARM: mxs_defconfig: Add framebuffer support
      ARM: imx_v6_v7_defconfig: Add Chipidea USB driver support
      ARM: imx_v6_v7_defconfig: Remove CONFIG_DEFAULT_MMAP_MIN_ADDR
      ARM: mxs_defconfig: Add SPI and LRADC support

Kukjin Kim (1):
      ARM: s3c6400_defconfig: enable more boards in defconfig

Olof Johansson (6):
      Merge branch 'defconfig' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge branch 'lpc32xx/defconfig' of git://git.antcom.de/linux-2.6 into next/defconfig
      Merge tag 'mxs-defconfig-3.7' of git://git.linaro.org/people/shawnguo/linux-2.6 into next/defconfig
      Merge tag 'imx-defconfig' of git://git.pengutronix.de/git/imx/linux-2.6 into next/defconfig
      Merge tag 'tegra-for-3.7-defconfig' of git://git.kernel.org/.../swarren/linux-tegra into next/defconfig
      Merge branch 'next/defconfig-samsung' of git://git.kernel.org/.../kgene/linux-samsung into next/defconfig

Roland Stigge (1):
      ARM: LPC32xx: Defconfig update

Simon Horman (1):
      ARM: mach-shmobile: marzen: defconfig update

Stephen Warren (1):
      ARM: tegra: defconfig updates

 arch/arm/configs/imx_v6_v7_defconfig |  4 +++-
 arch/arm/configs/lpc32xx_defconfig   |  7 +++++--
 arch/arm/configs/marzen_defconfig    | 15 ++++++++++-----
 arch/arm/configs/mxs_defconfig       | 36 +++++++++++++++++++++++++++++++++++-
 arch/arm/configs/s3c6400_defconfig   |  3 +++
 arch/arm/configs/tegra_defconfig     | 51 ++++++++++++++++++++++++++++++++++++++++++---------
 6 files changed, 98 insertions(+), 18 deletions(-)
