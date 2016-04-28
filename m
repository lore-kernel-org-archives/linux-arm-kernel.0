From: tony@atomide.com (Tony Lindgren)
Date: Thu, 28 Apr 2016 10:25:08 -0700
Subject: [GIT PULL 2/3] omap defconfig changes for v4.7 merge window
In-Reply-To: <pull-1461856674-976179>
References: <pull-1461856674-976179>
Message-ID: <pull-1461856674-976179-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7/defconfig-signed

for you to fetch changes up to 714749313da9800ecc10bfc2bfab87540a349e97:

  ARM: omap2plus_defconfig: Enable PWM and ir-rx51 as loadable modules (2016-04-27 09:40:09 -0700)

----------------------------------------------------------------
Defconfig changes for omap2plus_defconfig for v4.7 merge window.
Mostly enable drivers used on various boards as loadable modules
where possible. Also one warning fix related to RXKAD changes
heading to v4.7. And run make save_defconfig to shrink down the
size a bit.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: omap2plus_defconfig: Fix warning due invalid RXKAD symbol value

Lokesh Vutla (1):
      ARM: omap2plus_defconfig: Enable GPIO_TPIC2810

Nishanth Menon (1):
      ARM: omap2plus_defconfig: Enable DP83867 support

Tony Lindgren (3):
      ARM: omap2plus_defconfig: Update with make savedefconfig
      ARM: omap2plus_defconfig: Enable twl6030 USB phy as loadable module
      ARM: omap2plus_defconfig: Enable PWM and ir-rx51 as loadable modules

Yegor Yefremov (1):
      ARM: omap2plus_defconfig: Enable MDIO Bus/PHY emulation support

 arch/arm/configs/omap2plus_defconfig | 66 ++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 36 deletions(-)
