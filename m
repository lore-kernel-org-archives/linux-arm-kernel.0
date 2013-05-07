From: pavel@denx.de (Pavel Machek)
Date: Tue, 7 May 2013 22:13:39 +0200
Subject: dw_apb_timer_of.c: remove parts that were picoxcell-specific
In-Reply-To: <51892E5E.8090909@linaro.org>
References: <20130426121433.GA16249@amd.pavel.ucw.cz>
 <201305061545.22587.arnd@arndb.de>
 <20130506155304.GA6645@amd.pavel.ucw.cz>
 <201305062324.17080.arnd@arndb.de>
 <20130507135752.GA3500@amd.pavel.ucw.cz>
 <51892E5E.8090909@linaro.org>
Message-ID: <20130507201339.GB8169@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>>So I guess it should go through the timekeeping tree...?
> >>I would prefer that, but we can also take it through arm-soc, it doesn't
> >>really matter.
> >I see no response from timekeeping people... so if you could take it,
> >that would be great.
> 
> I don't think the original patch ever made it to my inbox.

Aha, so for 3.8, 

pavel at amd:/data/l/linux-n900$ scripts/get_maintainer.pl -f
drivers/clocksource/dw_apb_timer.c
John Stultz <johnstul@us.ibm.com> (supporter:TIMEKEEPING, NTP)
Thomas Gleixner <tglx@linutronix.de> (supporter:TIMEKEEPING, NTP)
linux-kernel at vger.kernel.org (open list)

for 3.9, it works ok.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
