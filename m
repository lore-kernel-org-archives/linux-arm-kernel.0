From: pavel@denx.de (Pavel Machek)
Date: Mon, 6 May 2013 17:53:04 +0200
Subject: dw_apb_timer_of.c: remove parts that were picoxcell-specific
In-Reply-To: <201305061545.22587.arnd@arndb.de>
References: <20130426121433.GA16249@amd.pavel.ucw.cz>
 <20130426214313.GB24891@amd.pavel.ucw.cz>
 <20130506124814.GA28259@amd.pavel.ucw.cz>
 <201305061545.22587.arnd@arndb.de>
Message-ID: <20130506155304.GA6645@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2013-05-06 15:45:22, Arnd Bergmann wrote:
> On Monday 06 May 2013, Pavel Machek wrote:
> > 
> > Hi!
> > 
> > Ping? Previous version was tested by Dinh, and this one is based on
> > Jamie's updates, so I assume it is acceptable for him, too.
> > 
> > It brings two platforms closer together, and makes time actually work
> > on socfpga. It would be good to get it applied.
> 
> Who should apply it? I guess it needs to go through arm-soc with all the
> other clocksource changes already queued up there. Can we have an Ack
> from Jamie and from the clocksource maintainers?

Well, changes to arch/arm/mach-picoxcell are single line (and that's a
cleanup of duplicate include). 

So I guess it should go through the timekeeping tree...?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
