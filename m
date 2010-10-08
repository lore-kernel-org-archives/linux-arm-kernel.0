From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 8 Oct 2010 15:14:16 +0200
Subject: i.MX pull request for -rc
Message-ID: <20101008131416.GR28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[sent again, forgot to cc the list]

Hi Russell,

Please pull the following if we still have time for 2.6.36.

Sascha

The following changes since commit 7c6d45e665d5322401e4439060bbf758b08422d4:

  powerpc: remove unused variable (2010-10-05 17:27:54 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Eric B?nard (2):
      cpuimx27: fix compile when ULPI is selected
      cpuimx27: fix i2c bus selection

 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-cpuimx27.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
