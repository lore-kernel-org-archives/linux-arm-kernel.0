From: ben-i2c@fluff.org (Ben Dooks)
Date: Thu, 9 Dec 2010 23:39:30 +0000
Subject: [PATCH v2 1/2] I2C: i2c-omap: Change device name: i2c_omap ->
	omap_i2c
In-Reply-To: <BC214410FD04D84F9079A6242365970707D4FA@008-AM1MPN1-001.mgdnok.nokia.com>
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com>
	<1291904657-32729-2-git-send-email-b-cousson@ti.com>
	<878vzydgxr.fsf@deeprootsystems.com>
	<BC214410FD04D84F9079A6242365970707D4FA@008-AM1MPN1-001.mgdnok.nokia.com>
Message-ID: <20101209233930.GV20097@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 10:18:48PM +0000, aaro.koskinen at nokia.com wrote:
> Hi,
> 
> Kevin Hilman [khilman at deeprootsystems.com]:
> > Ben Dooks <ben-i2c@fluff.org> writes:
> > > Renaming stuff like this is going to have an impact on the userspace
> > > as anyone looking through /sys's driver heirarchy is going to miss the
> > > old name...
> > >
> > > It all depends if you really want to go ahead with this...
> >
> > Yes, we are aware of the userspace impact, but this name change makes
> > all devices on OMAP have consistent names and actually improves the
> > ability to have userspace tools have consistent naming as well.
> 
> So there are no imporant users, or if there is, they are prepared for this change?
> 
> >> >  drivers/i2c/busses/i2c-omap.c        |    4 ++--
> 
> What about the .c / .ko file name?

Pretty much everything in the drivers/i2c/busses directory is named
i2c-<something>.c, and I would like to keep it that way.

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
