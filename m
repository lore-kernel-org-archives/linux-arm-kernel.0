From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 19 Feb 2014 10:35:44 -0500
Subject: [GIT PULL] irqchip: mvebu fixes for v3.14
In-Reply-To: <alpine.DEB.2.02.1402182122010.4468@ionos.tec.linutronix.de>
References: <20140218162210.GU7862@titan.lakedaemon.net>
 <alpine.DEB.2.02.1402182122010.4468@ionos.tec.linutronix.de>
Message-ID: <20140219153544.GI7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 09:23:29PM +0100, Thomas Gleixner wrote:
> On Tue, 18 Feb 2014, Jason Cooper wrote:
> 
> > Thomas,
> > 
> > Here is a small round of fixes for irq-orion.c.  They've been in -next
> > for over a week.  Please pull.
> > 
> > We have a set of watchdog changes depending on this that are going
> > through mvebu/arm-soc.  So please don't rebase, just let me know if
> > there's something that isn't right.  I'll fix it up and resend.
> 
> Just a nit:
> 
> 12bd4f7: IRQ: Orion: Fix getting generic chip pointer.
> e0318ec: irqchip: orion: clear stale interrupts in irq_startup
> 5f40067: irqchip: orion: use handle_edge_irq on bridge irqs
> 7b119fd: irqchip: orion: clear bridge cause register on init

<looks@feet, kicks stones>

v2 on it's way.

thx,

Jason.
