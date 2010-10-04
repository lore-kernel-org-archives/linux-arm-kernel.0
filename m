From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 4 Oct 2010 13:15:25 -0600 (MDT)
Subject: [PATCH 08/10] OMAP: split plat-omap/common.c
In-Reply-To: <4CA999AA.4030608@ti.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
	<20101001213532.1408.55832.stgit@twilight.localdomain>
	<4CA999AA.4030608@ti.com>
Message-ID: <alpine.DEB.2.00.1010041314170.13816@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Oct 2010, Cousson, Benoit wrote:

> > --- /dev/null
> > +++ b/arch/arm/plat-omap/32ksynctimer.c
> > @@ -0,0 +1,184 @@
> > +/*
> > + * linux/arch/arm/plat-omap/clocksource.c
> 
> What name do you want to use? 32ksynctimer.c or clocksource.c?

Thanks, that's a bug.

> If this file is dedicated for the 32k sync timer, maybe we should now use the
> new OMAP4 name: "counter_32k".
> 
> Noboby knows what the sync stand for, and at the end this is just a 32k
> counter. Hence the new name :-)

Yep, let's use counter_32k.c.


- Paul
