From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 17 Aug 2011 23:12:36 -0400 (EDT)
Subject: [PATCH 06/12] ARM: mxc: Setup consistent dma size at boot time
In-Reply-To: <20110808164731.GP31404@pengutronix.de>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
	<1312813712-22808-7-git-send-email-tixy@yxit.co.uk>
	<20110808164731.GP31404@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1108172309450.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Aug 2011, Sascha Hauer wrote:

> Hi Jon,
> 
> On Mon, Aug 08, 2011 at 03:28:26PM +0100, Jon Medhurst wrote:
> > Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
> > CC: Sascha Hauer <kernel@pengutronix.de>
> > CC: Amit Kucheria <amit.kucheria@canonical.com>
> > ---
> >  arch/arm/plat-mxc/include/mach/common.h |    1 +
> >  arch/arm/plat-mxc/include/mach/memory.h |   15 ---------------
> >  arch/arm/mach-imx/mm-imx1.c             |    1 +
> >  arch/arm/mach-imx/mm-imx21.c            |    1 +
> >  arch/arm/mach-imx/mm-imx25.c            |    1 +
> >  arch/arm/mach-imx/mm-imx27.c            |    1 +
> >  arch/arm/mach-imx/mm-imx31.c            |    1 +
> >  arch/arm/mach-imx/mm-imx35.c            |    1 +
> >  arch/arm/mach-mx5/mm-mx50.c             |    1 +
> >  arch/arm/mach-mx5/mm.c                  |    2 ++
> >  arch/arm/plat-mxc/system.c              |   16 ++++++++++++++++
> >  11 files changed, 26 insertions(+), 15 deletions(-)
> 
> Should the base patch be ok I'd like to rework this one. I want to
> call init_consistent_dma_size on a per board base instead in a global
> function with ifdeffery.

Hello Sascha,

Did you manage to work on this?  Ideally it would be nice to have a 
reworked patch from you that could be used in this series as some later 
patches depend on this series.

Thanks.


Nicolas
