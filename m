From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Mon, 4 Apr 2011 17:21:21 +0200
Subject: [PATCH] plat-mxc: Provide irq_chip name for GPIO IRQs
In-Reply-To: <20110404143408.GD22480@n2100.arm.linux.org.uk>
References: <1296489624-21355-1-git-send-email-alexander.stein@systec-electronic.com>
	<20110404142936.GF30938@pengutronix.de>
	<20110404143408.GD22480@n2100.arm.linux.org.uk>
Message-ID: <201104041721.22158.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 April 2011, 16:34:08 Russell King - ARM Linux wrote:
> On Mon, Apr 04, 2011 at 04:29:36PM +0200, Uwe Kleine-K?nig wrote:
> > On Tue, Mar 01, 2011 at 09:34:15AM +0100, Wolfram Sang wrote:
> > > Hi,
> > > 
> > > > >  static struct irq_chip gpio_irq_chip = {
> > > > > 
> > > > > +	.name = "GPIO",
> > > 
> > > I'd suggest a more specific name, e.g. "i.MX GPIO"? You can then also
> > > add my
> > > 
> > > Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> > 
> > This comment wasn't addressed. Does someone care to follow up?
> 
> And if we consolidate the GPIO implementations (I hope *someone* is
> working on that) then this doesn't matter one ounce because platforms
> won't be identifying that its an 'i.MX GPIO'.

The benefit from this patch is that it gets shown at /proc/interrupts. But I 
personally don't care if it's "GPIO" as in mainline now or "i.MX GPIO"

Alexander
