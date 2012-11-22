From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Nov 2012 15:45:47 +0100
Subject: [GIT PULL] i.MX defconfig updates
Message-ID: <20121122144547.GH10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull the following i.MX defconfig updates for i.MX

Sascha

The following changes since commit a0d271cbfed1dd50278c6b06bead3d00ba0a88f9:

  Linux 3.6 (2012-09-30 16:47:46 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-defconfig

for you to fetch changes up to 5177ae56d1b6dcf4b23f1f89ed3be1c3dc0ad513:

  ARM: imx: configs: Enable CONFIG_MEDIA_CAMERA_SUPPORT (2012-10-10 10:51:00 +0200)

----------------------------------------------------------------
ARM i.MX specific defconfig updates

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Add DA9052 regulator support
      ARM: imx: configs: Enable CONFIG_MEDIA_CAMERA_SUPPORT

 arch/arm/configs/imx_v4_v5_defconfig |    1 +
 arch/arm/configs/imx_v6_v7_defconfig |    3 +++
 2 files changed, 4 insertions(+)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
