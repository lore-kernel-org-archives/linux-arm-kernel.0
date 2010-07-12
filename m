From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Jul 2010 09:12:10 -0400 (EDT)
Subject: [RFC PATCH 1/2] allow each machine to specify it's own IRQ
	handlers at run-time
In-Reply-To: <20100712130222.GA14425@pengutronix.de>
References: <AANLkTin9OHUGtKSg7554ucVhufQ3PiKXALmD0Lh7A-yt@mail.gmail.com>
	<20100712081106.GB1532@pengutronix.de>
	<20100712081245.GC22138@n2100.arm.linux.org.uk>
	<20100712130222.GA14425@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1007120911110.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jul 2010, Uwe Kleine-K?nig wrote:

> On Mon, Jul 12, 2010 at 09:12:45AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Jul 12, 2010 at 10:11:06AM +0200, Uwe Kleine-K?nig wrote:
> > > I didn't thought it would be that easy.  Nice.
> > > Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > 
> > It isn't - if you enable this, your platform will break because
> > there's no implementations of it.  That makes this patch rather
> > hard to ack on its own.
> Well, I didn't test the patch but still noticed that additional code is
> needed to make use of it.  And what I saw looked reasonable.  As the
> Kconfig symbol isn't selected (until now) it doesn't seem to break
> anything.
> 
> Does I need more to give my Ack?

FYI, I'm NAKing the patch for the moment.  Please see the comment I'm 
about to post.


Nicolas
