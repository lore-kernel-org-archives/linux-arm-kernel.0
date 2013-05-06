From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 May 2013 23:24:16 +0200
Subject: dw_apb_timer_of.c: remove parts that were picoxcell-specific
In-Reply-To: <20130506155304.GA6645@amd.pavel.ucw.cz>
References: <20130426121433.GA16249@amd.pavel.ucw.cz>
 <201305061545.22587.arnd@arndb.de> <20130506155304.GA6645@amd.pavel.ucw.cz>
Message-ID: <201305062324.17080.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 May 2013, Pavel Machek wrote:
> On Mon 2013-05-06 15:45:22, Arnd Bergmann wrote:
> > On Monday 06 May 2013, Pavel Machek wrote:
> > > 
> > > Hi!
> > > 
> > > Ping? Previous version was tested by Dinh, and this one is based on
> > > Jamie's updates, so I assume it is acceptable for him, too.
> > > 
> > > It brings two platforms closer together, and makes time actually work
> > > on socfpga. It would be good to get it applied.
> > 
> > Who should apply it? I guess it needs to go through arm-soc with all the
> > other clocksource changes already queued up there. Can we have an Ack
> > from Jamie and from the clocksource maintainers?
> 
> Well, changes to arch/arm/mach-picoxcell are single line (and that's a
> cleanup of duplicate include). 

The point is that Jamie had comments on the earlier version, so it would
be good to see his Ack on the current one.

> So I guess it should go through the timekeeping tree...?

I would prefer that, but we can also take it through arm-soc, it doesn't
really matter.

	Arnd
