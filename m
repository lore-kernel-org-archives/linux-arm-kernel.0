From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 3 May 2010 12:28:32 +0200
Subject: Fix build error for i.MX51 (mx51_defconfig)
In-Reply-To: <20100501101811.GI12172@n2100.arm.linux.org.uk>
References: <20100421211707.GC2951@matterhorn.lan>
	<20100501101811.GI12172@n2100.arm.linux.org.uk>
Message-ID: <20100503102832.GA31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 01, 2010 at 11:18:11AM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 22, 2010 at 12:17:07AM +0300, Amit Kucheria wrote:
> > Please apply the following patch to fix build failure for i.MX51 in
> > 2.6.34-rc5.
> 
> It would be preferable to have an acked-by from Sascha, but given this
> is a build error I'll take it via the patch system; thanks.
> 

I sent the following pull request you probably missed while being
offline. It contains the same patch from Dinh Nguyen.

Sascha


The following changes since commit 2ba3abd8186f24c7fb418927025b4e2120e3a362:
  Linus Torvalds (1):
        Merge branch 'pm-fixes' of
git://git.kernel.org/.../rafael/suspend-2.6

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Dinh Nguyen (1):
      mx5: Fix build error for mx51_defconfig

 arch/arm/mach-mx5/clock-mx51.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
