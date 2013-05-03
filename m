From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 4 May 2013 00:39:15 +0200 (CEST)
Subject: [RFC patch 4/8] genirq: generic chip: Cache per irq bit mask
In-Reply-To: <20130503222406.GG18614@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1305031514230.2886@ionos>
 <20130503212258.385818955@linutronix.de>
 <20130503214629.599155322@linutronix.de>
 <20130503222406.GG18614@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1305040038510.2990@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 May 2013, Russell King - ARM Linux wrote:

> On Fri, May 03, 2013 at 09:50:50PM -0000, Thomas Gleixner wrote:
> > -	u32 mask = ~(1 << (d->irq - gc->irq_base));
> > +	u32 mask = ~(d->mask);
> 
> I suspect the above changes are all a result of a search-and-replace
> which results in the cosmetic parens remaining.  Would be nice to get
> rid of them too as they're completely unnecessary.

Fair enough.

Thanks,

	tglx 
