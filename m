From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 10:33:42 +0200
Subject: [GIT PULL] i.MX board feature patches
Message-ID: <20120411083342.GM3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following board feature patches for i.MX

Thanks
 Sascha

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-features-board-20120411

for you to fetch changes up to e7259f7ca3a0c7a269fecb61156224ddd3edb92c:

  Visstrim_M10: Add board version detection. (2012-04-11 10:16:03 +0200)

----------------------------------------------------------------
misc i.MX board specific features

----------------------------------------------------------------
Alex Gershgorin (1):
      ARM: regulator: i.MX35-PDK Add regulator support

Javier Martin (1):
      Visstrim_M10: Add board version detection.

Uwe Kleine-K?nig (1):
      ARM: imx_v4_v5_defconfig: enable adc and touch driver of mc13783

 arch/arm/configs/imx_v4_v5_defconfig        |    4 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   55 ++++++++
 arch/arm/mach-imx/mach-mx35_3ds.c           |  193 +++++++++++++++++++++++++++
 3 files changed, 251 insertions(+), 1 deletion(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
