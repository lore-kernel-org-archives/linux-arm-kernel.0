From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Dec 2010 17:55:07 -0800
Subject: [PATCH v2 1/2] I2C: i2c-omap: Change device name: i2c_omap ->
	omap_i2c
In-Reply-To: <4D01E4B5.1010703@ti.com>
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com>
	<1291904657-32729-2-git-send-email-b-cousson@ti.com>
	<878vzydgxr.fsf@deeprootsystems.com>
	<20101209190110.GR20097@trinity.fluff.org>
	<87wrni7jys.fsf@deeprootsystems.com>
	<BC214410FD04D84F9079A6242365970707D4FA@008-AM1MPN1-001.mgdnok.nokia.com>
	<4D01E4B5.1010703@ti.com>
Message-ID: <20101218015507.GL5941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [101210 00:29]:
> On 12/9/2010 11:18 PM, aaro.koskinen at nokia.com wrote:
> >Hi,
> >
> >Kevin Hilman [khilman at deeprootsystems.com]:
> >>Ben Dooks<ben-i2c@fluff.org>  writes:
> >>>Renaming stuff like this is going to have an impact on the userspace
> >>>as anyone looking through /sys's driver heirarchy is going to miss the
> >>>old name...
> >>>
> >>>It all depends if you really want to go ahead with this...
> >>
> >>Yes, we are aware of the userspace impact, but this name change makes
> >>all devices on OMAP have consistent names and actually improves the
> >>ability to have userspace tools have consistent naming as well.
> >
> >So there are no imporant users, or if there is, they are prepared for this change?
> 
> Well, I do not know any user of that today. Do you have some in mind?

Sounds like it's safe for me to take these two.

Tony
