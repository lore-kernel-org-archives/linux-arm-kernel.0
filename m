From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 18:18:15 +0100
Subject: [PATCH 12/13] clocksource: convert MXS timrotv2 to 32-bit down
	counting clocksource
In-Reply-To: <20110516151609.GB24880@S2100-06.ap.freescale.net>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhSC-0000z6-H6@rmk-PC.arm.linux.org.uk>
	<20110516143124.GA24880@S2100-06.ap.freescale.net>
	<20110516151609.GB24880@S2100-06.ap.freescale.net>
Message-ID: <20110516171815.GB13659@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 11:16:10PM +0800, Shawn Guo wrote:
> > > +		clocksource_mmio_init(mxs_timrot_base + HW_TIMROT_RUNNING_COUNTn(1)),
> >                                                                                    ^
> > Mismatched parenthesis

Fixed.

> Other than that,
> 
> Acked-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Tested on both i.MX23 and i.MX28.

Thanks.
