From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Jul 2010 08:33:19 -0400 (EDT)
Subject: [RFC PATCH 1/2] allow each machine to specify it's own IRQ
	handlers at run-time
In-Reply-To: <20100712081245.GC22138@n2100.arm.linux.org.uk>
References: <AANLkTin9OHUGtKSg7554ucVhufQ3PiKXALmD0Lh7A-yt@mail.gmail.com>
	<20100712081106.GB1532@pengutronix.de>
	<20100712081245.GC22138@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1007120832170.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jul 2010, Russell King - ARM Linux wrote:

> On Mon, Jul 12, 2010 at 10:11:06AM +0200, Uwe Kleine-K?nig wrote:
> > I didn't thought it would be that easy.  Nice.
> > Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> It isn't - if you enable this, your platform will break because
> there's no implementations of it.  That makes this patch rather
> hard to ack on its own.

I think Eric posted additional patches to enable this on PXA in his 
series.


Nicolas
