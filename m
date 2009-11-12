From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Nov 2009 14:04:18 +0100
Subject: [PATCH 8/9] MXC: Add a digital audio multiplexer (DAM) driver
In-Reply-To: <20091112124706.GB11656@sirena.org.uk>
References: <1258022525-21078-9-git-send-email-s.hauer@pengutronix.de>
	<20091112124706.GB11656@sirena.org.uk>
Message-ID: <20091112130418.GY30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Nov 12, 2009 at 12:47:07PM +0000, Mark Brown wrote:
> On Thu, Nov 12, 2009 at 11:42:04AM +0100, Sascha Hauer wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/mach-mx2/Kconfig            |    2 +
> >  arch/arm/mach-mx3/Kconfig            |    2 +
> >  arch/arm/plat-mxc/Kconfig            |    7 ++++
> >  arch/arm/plat-mxc/Makefile           |    2 +
> >  arch/arm/plat-mxc/dam-v1.c           |   33 ++++++++++++++++++++
> >  arch/arm/plat-mxc/dam-v2.c           |   56 ++++++++++++++++++++++++++++++++++
> 
> Is there any great reason to use the DAM name rather than AUDMUX?  I've
> never heard it called anything except AUDMUX before, though I may have
> been missing something.

I don't know who invented this name, but audmux seems better to me, too.
Will change this.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
