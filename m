From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Apr 2011 15:34:08 +0100
Subject: [PATCH] plat-mxc: Provide irq_chip name for GPIO IRQs
In-Reply-To: <20110404142936.GF30938@pengutronix.de>
References: <1296489624-21355-1-git-send-email-alexander.stein@systec-electronic.com>
	<201103010838.37197.alexander.stein@systec-electronic.com>
	<20110301083415.GA2212@pengutronix.de>
	<20110404142936.GF30938@pengutronix.de>
Message-ID: <20110404143408.GD22480@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 04:29:36PM +0200, Uwe Kleine-K?nig wrote:
> On Tue, Mar 01, 2011 at 09:34:15AM +0100, Wolfram Sang wrote:
> > Hi,
> > 
> > > >  static struct irq_chip gpio_irq_chip = {
> > > > +	.name = "GPIO",
> > 
> > I'd suggest a more specific name, e.g. "i.MX GPIO"? You can then also
> > add my
> > 
> > Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> This comment wasn't addressed. Does someone care to follow up?

And if we consolidate the GPIO implementations (I hope *someone* is
working on that) then this doesn't matter one ounce because platforms
won't be identifying that its an 'i.MX GPIO'.
