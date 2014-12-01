From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 01 Dec 2014 13:57:39 +0000
Subject: [PATCH v2] MAINTAINERS: ARM Versatile Express platform
In-Reply-To: <1417197395.4305.5.camel@perches.com>
References: <1416939455-1814-2-git-send-email-pawel.moll@arm.com>
 <1417003985-21564-1-git-send-email-pawel.moll@arm.com>
 <1417197395.4305.5.camel@perches.com>
Message-ID: <1417442259.4058.5.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-11-28 at 17:56 +0000, Joe Perches wrote:
> On Wed, 2014-11-26 at 12:13 +0000, Pawel Moll wrote:
> > This patch adds a separate section for the ARM
> > Versatile Express platform maintainers, listing
> > all different bits and bobs used by it.
> > 
> > Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > Acked-by: Michael Turquette <mturquette@linaro.org>
> > ---
> >  MAINTAINERS | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0ff630d..924454f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1503,6 +1503,18 @@ S:	Maintained
> >  F:	drivers/clk/ux500/
> >  F:	include/linux/platform_data/clk-ux500.h
> >  
> > +ARM/VERSATILE EXPRESS PLATFORM
> > +M:	Liviu Dudau <liviu.dudau@arm.com>
> > +M:	Sudeep Holla <sudeep.holla@arm.com>
> > +M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	arch/arm/boot/dts/vexpress*
> > +F:	arch/arm/mach-vexpress/
> > +F:	*/*/vexpress*
> > +F:	drivers/clk/versatile/clk-vexpress-osc.c
> > +F:	drivers/clocksource/versatile.c
> 
> Your original submission had:
> 
> F:     drivers/power/reset/vexpress-poweroff.c
> 
> This file is not matched by:
> 
> F:	*/*/vexpress*

Oh boy, of course. I'll send fix in a second.

Pawel
