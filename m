From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 11 May 2011 15:45:59 +0200 (CEST)
Subject: [PATCH 08/13] clocksource: convert ARM 32-bit down counting
	clocksources
In-Reply-To: <20110511075316.GC15120@n2100.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhPM-0000yq-ED@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1105100838530.15037@xanadu.home>
	<20110511075316.GC15120@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1105111544480.21845@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 May 2011, Russell King - ARM Linux wrote:

> On Tue, May 10, 2011 at 08:39:58AM -0400, Nicolas Pitre wrote:
> > On Tue, 10 May 2011, Russell King - ARM Linux wrote:
> > 
> > > Convert MXC, Nomadik and Orion 32-bit down-counting clocksources to
> > > generic mmio clocksource infrastructure.
> > > 
> > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > Cc: Alessandro Rubini <rubini@unipv.it>
> > > Cc: Linus Walleij <linus.walleij@stericsson.com>
> > > Cc: Lennert Buytenhek <kernel@wantstofly.org>
> > > Cc: Nicolas Pitre <nico@fluxnic.net>
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Acked-by: Nicolas Pitre <nico@fluxnic.net>
> 
> Does that apply to patch 6 too?

y
Yes, you can add my ACK to patch 6.


Nicolas
