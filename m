From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 12 Feb 2013 09:59:16 +0100
Subject: [GIT PULL] i.MX defconfig updates
Message-ID: <20130212085916.GT1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Two small defconfig updates for v3.9.

Sascha

The following changes since commit 836dc9e3fbbab0c30aa6e664417225f5c1fb1c39:

  Linux 3.8-rc7 (2013-02-09 08:20:39 +1100)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/arm-imx-defconfig

for you to fetch changes up to 09de7ee1695f182886360faf9cf66702b5342199:

  ARM: imx_v4_v5_defconfig: Add VPU support (2013-02-12 09:08:56 +0100)

----------------------------------------------------------------
ARM i.MX defconfig updates for v3.9

- enable VPU support in imx_v4_v5_defconfig to get compile coverage
- enable netfilter support

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: imx_v4_v5_defconfig: Add VPU support

Javier Martinez Canillas (1):
      ARM: imx: configs: enable netfilter support

 arch/arm/configs/imx_v4_v5_defconfig |    3 +++
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 2 files changed, 4 insertions(+)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
