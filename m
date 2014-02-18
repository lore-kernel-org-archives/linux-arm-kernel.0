From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 18 Feb 2014 21:23:29 +0100 (CET)
Subject: [GIT PULL] irqchip: mvebu fixes for v3.14
In-Reply-To: <20140218162210.GU7862@titan.lakedaemon.net>
References: <20140218162210.GU7862@titan.lakedaemon.net>
Message-ID: <alpine.DEB.2.02.1402182122010.4468@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Feb 2014, Jason Cooper wrote:

> Thomas,
> 
> Here is a small round of fixes for irq-orion.c.  They've been in -next
> for over a week.  Please pull.
> 
> We have a set of watchdog changes depending on this that are going
> through mvebu/arm-soc.  So please don't rebase, just let me know if
> there's something that isn't right.  I'll fix it up and resend.

Just a nit:

12bd4f7: IRQ: Orion: Fix getting generic chip pointer.
e0318ec: irqchip: orion: clear stale interrupts in irq_startup
5f40067: irqchip: orion: use handle_edge_irq on bridge irqs
7b119fd: irqchip: orion: clear bridge cause register on init

Can you see it ?

Thanks,

	tglx
