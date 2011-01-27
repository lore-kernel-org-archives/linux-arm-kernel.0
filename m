From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 16:19:19 +0100
Subject: some i.MX23/28 patches
In-Reply-To: <20110127231557.GB14993@S2100-06.ap.freescale.net>
References: <1296128413-20778-1-git-send-email-s.hauer@pengutronix.de>
	<20110127231557.GB14993@S2100-06.ap.freescale.net>
Message-ID: <20110127151919.GA9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 28, 2011 at 07:15:58AM +0800, Shawn Guo wrote:
> Hi Sascha,
> 
> On Thu, Jan 27, 2011 at 12:40:09PM +0100, Sascha Hauer wrote:
> > The following contains some i.MX23/28 cleanup patches.
> > 
> > Sascha
> > 
> > The following changes since commit 376e9c5848abef8c72c09bd89f2f7ee128caa104:
> > 
> >   ARM: mxs: add initial pm support (2011-01-26 08:30:49 +0100)
> > 
> > are available in the git repository at:
> >   none ..BRANCH.NOT.VERIFIED..
> > 
> > Sascha Hauer (4):
> >       ARM i.MX23/28: deobfuscate gpio initialization
> >       ARM i.MX23/28: do not use complicated macros if not necessary
> >       ARM i.MX23: remove reserved register defines
> >       ARM i.MX28: remove reserved register defines
> > 
> >  arch/arm/mach-mxs/gpio.c              |   45 +++++----
> >  arch/arm/mach-mxs/regs-clkctrl-mx23.h |  124 -----------------------
> >  arch/arm/mach-mxs/regs-clkctrl-mx28.h |  177 ---------------------------------
> >  3 files changed, 24 insertions(+), 322 deletions(-)
> > 
> All acked-by: Shawn Guo <shawn.guo@freescale.com>
> 
> I do not understand word "deobfuscate".  Can you help me?

I guess that's not a correct word. Try searching for obfuscate instead.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
