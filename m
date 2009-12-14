From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 14 Dec 2009 22:22:57 +0100
Subject: [POWER] battery calibration parameters from sysfs
In-Reply-To: <20091214121247.GB22388@rakim.wolfsonmicro.main>
References: <A6D19A13FE030A409EC4362C172E091F0E0495F6@eseldmw101.eemea.ericsson.se>
	<20091204104930.GA28625@sirena.org.uk>
	<A6D19A13FE030A409EC4362C172E091F0E071EB9@eseldmw101.eemea.ericsson.se>
	<20091207114825.GA26965@rakim.wolfsonmicro.main>
	<A6D19A13FE030A409EC4362C172E091F0E0A1FA1@eseldmw101.eemea.ericsson.se>
	<20091207165628.GA24981@rakim.wolfsonmicro.main>
	<20091213132413.GB1437@ucw.cz>
	<20091214121247.GB22388@rakim.wolfsonmicro.main>
Message-ID: <20091214212257.GA9213@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > I'm not sure how familiar you are with the issues surrounding trying to
> > > do a voltage to charge mapping for a battery but it's much more complex
> > > than a simple table if you want to get it accurate.  There's a lot
> > > of
> 
> > Well... current zaurus kernels use _huge_ table that maps voltage to
> > battery %... and that table is linear function :-(.
> 
> > Do you have some papers on that?
> 
> Something like "Measure Battery Capacity Precisely in Medical Design"
> by Bernd Krafthoefer in Power Electronics Technology Jan 2005 might be
> useful here.

Well, that would really require extensive hardware modifications: it
needs _way_ more accurate ADCs on battery for a start, and a way to
generate huge load.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
