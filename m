From: B39297@freescale.com (Wu Guoxing-B39297)
Date: Fri, 11 Nov 2011 09:31:23 +0000
Subject: [GIT PULL] arm/mx35/3ds: GPIO : add mc9s08dz60 gpio function
In-Reply-To: <20111111092539.GK16886@pengutronix.de>
References: <3D55990BDF4852409EA769663F22E54AC19541@039-SN1MPN1-006.039d.mgd.msft.net>
 <20111111092539.GK16886@pengutronix.de>
Message-ID: <3D55990BDF4852409EA769663F22E54AC19736@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  And I found that my pull request mail to Linux-arm-kernel maillist is blocked, don't know why, so I sent the request message again as bellow:

  Thanks!

Best Regards
Wu Guoxing


The following changes since commit a59024f1ecb52972b9be5ee91b5ef38a6b263d1b:

  Merge branch 'for_3.2/gpio-cleanup' of git://gitorious.org/khilman/linux-omap-pm into gpio/merge (2011-11-08 12:48:27 -0700)

are available in the git repository at:

  git://git.linaro.org/people/riczhao/linux-2.6.git for-gpio

wu guoxing (1):
      ARM/mx35/3ds: gpio: add mc9s08dz60 gpio function

drivers/gpio/Kconfig           |    6 ++
drivers/gpio/Makefile          |    1 +
drivers/gpio/gpio-mc9s08dz60.c |  174 ++++++++++++++++++++++++++++++++++++++++
3 files changed, 181 insertions(+), 0 deletions(-)
create mode 100644 drivers/gpio/gpio-mc9s08dz60.c




-----Original Message-----
From: s.hauer@pengutronix.de [mailto:s.hauer at pengutronix.de] 
Sent: Friday, November 11, 2011 5:26 PM
To: Wu Guoxing-B39297
Cc: grant.likely at secretlab.ca; linux-arm-kernel at lists.infradead.org; Marc Kleine-Budde; shawn.guo at linaro.org; Linus Walleij
Subject: Re: [GIT PULL] arm/mx35/3ds: GPIO : add mc9s08dz60 gpio function

On Fri, Nov 11, 2011 at 02:35:00AM +0000, Wu Guoxing-B39297 wrote:
> Hi Grant:
> 
> Please help to pull the following GPIO patch for mc9s08dz60 that on imx mx35 pdk board.

Grant is not available atm. Added Linus Walleij to Cc instead.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
