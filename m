From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 May 2015 22:30:59 +0200
Subject: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
In-Reply-To: <20150529201804.GT30984@atomide.com>
References: <20150527132545.GA23434@amd> <20150527133311.GJ30798@pali>
 <20150527143722.GA28108@amd> <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd> <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529200306.GB17267@lukather>
 <20150529201804.GT30984@atomide.com>
Message-ID: <20150529203059.GB22083@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > So, because this has been wrongly documented for so long, we should
> > > support both bindings. Sure, deprecate touchscreen-max-[xy], but they
> > > must still be supported, IMO.
> > 
> > This property has never been anything but a typo in a documentation of
> > a single driver.
> > 
> > Feel free to fix that in that driver, but I don't see why the core
> > code should handle that isolated typo.
> 
> OK thanks for confirming. Will apply this into omap-for-v4.1/fixes.

Thanks!
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
