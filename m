From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 24 Aug 2009 23:06:13 +0100
Subject: [alsa-devel] [RFC][PATCH 1/3 v2] ARM: OMAP: DMA: Add support
	for DMA channel self linking on OMAP1510
In-Reply-To: <20090824124902.GH7069@atomide.com>
References: <200908101050.02530.jkrzyszt@tis.icnet.pl>
	<200908231945.40187.jkrzyszt@tis.icnet.pl>
	<20090823180543.GA6167@opensource.wolfsonmicro.com>
	<200908232038.05593.jkrzyszt@tis.icnet.pl>
	<20090823184943.GA6994@opensource.wolfsonmicro.com>
	<20090824084920.c99c561a.jhnikula@gmail.com>
	<20090824124902.GH7069@atomide.com>
Message-ID: <20090824220612.GB4338@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2009 at 03:49:03PM +0300, Tony Lindgren wrote:

> > We should remember that arch/arm/plat-omap/mcbsp.c changes done via
> > ALSA tree has been an exception and that's only for simpler procedure.
> > McBSP is not so critical if sources goes out-of-sync but DMA is.

> Sorry for the delay in replying. I'm OK for these to go in via the alsa
> tree as there are not currently other patches pending in the mcbsp or
> dma area for omap. So I think it's better merge all the audio related
> patches together in this case.

Applied, thanks.
