From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Dec 2014 08:31:16 -0800
Subject: [PATCH] add omap34xx temperature monitoring support
In-Reply-To: <201412261726.35668@pali>
References: <20141226102933.GA28778@amd> <20141226155456.GB12409@atomide.com>
 <20141226161757.GD12409@atomide.com> <201412261726.35668@pali>
Message-ID: <20141226163115.GA2411@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [141226 08:29]:
> On Friday 26 December 2014 17:17:57 Tony Lindgren wrote:
> > > > +
> > > > +#include "../../arch/arm/mach-omap2/control.h"
> > > 
> > > No need to do this, you can use syscon here like
> > > pbias-regulator.c is doing.
> > 
> > Oh looks like you're already using syscon, nice. What defines
> > do you need from control.h?
> > 
> > Those should be in the driver if private to the driver, or
> > else we should have some minimal header in include/linux
> > somewhere if some control.h defines really need to be
> > exposed.
> > 
> > Regards,
> > 
> > Tony
> 
> Hi Tony,
> 
> Sebastian Reichel has already sent new version of temperature 
> driver. See email thread with subject:
> 
> [PATCH 0/3] OMAP3 temperature sensor

Yeah great, looks like I was also reading Sebastian's patch
with the syscon comments above :)

Regards,

Tony
