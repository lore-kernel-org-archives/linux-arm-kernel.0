From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Apr 2012 10:44:03 +0200
Subject: [GIT PULL] i.MX cleanup patches for next
Message-ID: <20120411084403.GN3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX cleanup patches for next.

Sascha

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-cleanup-20120411

for you to fetch changes up to b0843e814737756a38003afe663a626653b66f58:

  efikamx: match machine descriptions with legacy (2012-04-02 11:20:38 +0200)

----------------------------------------------------------------
i.MX misc cleanups

----------------------------------------------------------------
Hector Oron (1):
      efikamx: match machine descriptions with legacy

Uwe Kleine-K?nig (1):
      ARM: imx/mx21ads: remove unneeded cast

 arch/arm/mach-imx/mach-mx21ads.c      |    3 +--
 arch/arm/mach-imx/mach-mx51_efikamx.c |    3 +--
 arch/arm/mach-imx/mach-mx51_efikasb.c |    2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
