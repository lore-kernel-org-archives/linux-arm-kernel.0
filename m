From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Jan 2011 09:23:31 +0000
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
In-Reply-To: <AANLkTik-MApg7khsUDHuvmfEy0NRnmJQ7ZP-o8+mQpOw@mail.gmail.com>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<AANLkTik-MApg7khsUDHuvmfEy0NRnmJQ7ZP-o8+mQpOw@mail.gmail.com>
Message-ID: <20110108092330.GX1198@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 08, 2011 at 05:05:53PM +0800, Wan ZongShun wrote:
> 2010/12/17 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > Here is the entire set of clocksource and sched_clock patches which
> > have been previously posted. ?There's a couple of small tweaks in a
> > few of the patches (such as adding notrace to OMAP clocksource read
> > functions), and this also shows the proper ordering of these patches.
> >
> > Still looking for acks or tested-by's for these patches.
> >
> 
> Acked-By: Wan Zongshun <mcuos.com@gmail.com>

I'm afraid you're too late - it's already in mainline so your ack can't
be added.
