From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 2 May 2012 10:34:42 +0200
Subject: [GIT PULL] defconfig updates for 3.5
Message-ID: <20120502083442.GV4141@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX defconfig updates for 3.5


The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-defconfig

for you to fetch changes up to d86a3480543941344625d1c71aa70510d01f7b11:

  ARM: imx_v6_v7_defconfig: Add SPI NOR support (2012-04-27 12:17:50 +0200)

----------------------------------------------------------------
ARM i.MX defconfig updates for 3.5

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: imx_v4_v5_defconfig: Let CONFIG_MACH_IMX27_DT be built by default
      ARM: imx_v6_v7_defconfig: Add SPI NOR support

 arch/arm/configs/imx_v4_v5_defconfig |    1 +
 arch/arm/configs/imx_v6_v7_defconfig |    6 ++++++
 2 files changed, 7 insertions(+)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
