From: aaro.koskinen@nokia.com (aaro.koskinen at nokia.com)
Date: Thu, 9 Dec 2010 22:18:48 +0000
Subject: [PATCH v2 1/2] I2C: i2c-omap: Change device name: i2c_omap ->
	omap_i2c
In-Reply-To: <87wrni7jys.fsf@deeprootsystems.com>
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com>
	<1291904657-32729-2-git-send-email-b-cousson@ti.com>
	<878vzydgxr.fsf@deeprootsystems.com>
	<20101209190110.GR20097@trinity.fluff.org>,
	<87wrni7jys.fsf@deeprootsystems.com>
Message-ID: <BC214410FD04D84F9079A6242365970707D4FA@008-AM1MPN1-001.mgdnok.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Kevin Hilman [khilman at deeprootsystems.com]:
> Ben Dooks <ben-i2c@fluff.org> writes:
> > Renaming stuff like this is going to have an impact on the userspace
> > as anyone looking through /sys's driver heirarchy is going to miss the
> > old name...
> >
> > It all depends if you really want to go ahead with this...
>
> Yes, we are aware of the userspace impact, but this name change makes
> all devices on OMAP have consistent names and actually improves the
> ability to have userspace tools have consistent naming as well.

So there are no imporant users, or if there is, they are prepared for this change?

>> >  drivers/i2c/busses/i2c-omap.c        |    4 ++--

What about the .c / .ko file name?

A.
