From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 14 May 2012 11:03:38 +0200
Subject: [GIT PULL] i.MX21 fix for 3.4
Message-ID: <20120514090338.GD30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd

One small fix for the i.MX21 board. If possible for 3.4, otherwise for
next.

Thanks
  Sascha

The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx21-fixes

for you to fetch changes up to 78d32656aa727fbd864390714638a35ae75d28c9:

  ARM i.MX imx21ads: Fix overlapping static i/o mappings (2012-05-09 09:28:01 +0200)

----------------------------------------------------------------
ARM i.MX21 SoC fixes

----------------------------------------------------------------
Jaccon Bastiaansen (1):
      ARM i.MX imx21ads: Fix overlapping static i/o mappings

 arch/arm/mach-imx/mach-mx21ads.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
