From: pavel@denx.de (Pavel Machek)
Date: Tue, 7 May 2013 15:57:52 +0200
Subject: dw_apb_timer_of.c: remove parts that were picoxcell-specific
In-Reply-To: <201305062324.17080.arnd@arndb.de>
References: <20130426121433.GA16249@amd.pavel.ucw.cz>
 <201305061545.22587.arnd@arndb.de>
 <20130506155304.GA6645@amd.pavel.ucw.cz>
 <201305062324.17080.arnd@arndb.de>
Message-ID: <20130507135752.GA3500@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2013-05-06 23:24:16, Arnd Bergmann wrote:
> On Monday 06 May 2013, Pavel Machek wrote:
> > On Mon 2013-05-06 15:45:22, Arnd Bergmann wrote:
> > > On Monday 06 May 2013, Pavel Machek wrote:
> > > > 
> > > > Hi!
> > > > 
> > > > Ping? Previous version was tested by Dinh, and this one is based on
> > > > Jamie's updates, so I assume it is acceptable for him, too.
> > > > 
> > > > It brings two platforms closer together, and makes time actually work
> > > > on socfpga. It would be good to get it applied.
> > > 
> > > Who should apply it? I guess it needs to go through arm-soc with all the
> > > other clocksource changes already queued up there. Can we have an Ack
> > > from Jamie and from the clocksource maintainers?
> > 
> > Well, changes to arch/arm/mach-picoxcell are single line (and that's a
> > cleanup of duplicate include). 
> 
> The point is that Jamie had comments on the earlier version, so it would
> be good to see his Ack on the current one.

He sent his Ack this morning.

> > So I guess it should go through the timekeeping tree...?
> 
> I would prefer that, but we can also take it through arm-soc, it doesn't
> really matter.

I see no response from timekeeping people... so if you could take it,
that would be great.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
