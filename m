From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 3 Mar 2011 21:44:23 +0530
Subject: [PATCH 04/17] omap4: pm: Add CPUx OFF mode support
In-Reply-To: <87wrkh5fz4.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-5-git-send-email-santosh.shilimkar@ti.com>
	<87wrkh5fz4.fsf@ti.com>
Message-ID: <f53cb17bd85faa93de4367e6db88e1e2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Thursday, March 03, 2011 3:43 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 04/17] omap4: pm: Add CPUx OFF mode support
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > This patch adds the CPU0 and CPU1 off mode support. CPUX close
> switch
>
> s/CPUX/CPUx/
>
> > retention (CSWR) is not supported by hardware design.
> >
> > The CPUx OFF mode isn't supported on OMAP4430 ES1.0
> >
> > CPUx sleep code is common for hotplug, suspend and cpuilde.
>
> s/cpuilde/CPUidle/
>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
>
> > ---
Fixed all the comments on this patch.

[....]

> > +++ b/arch/arm/mach-omap2/sleep44xx.S
[....]

>
> I didn't do a detailed review of the below assembly since you're
> much more knowlegable there than me.
>
> However, will the assembly code here work in Thumb-2 mode?  Dave
> Martin
> has been working on that for OMAP3, but we should make sure the
> OMAP4 stuff is Thumb-2 ready out of the box.
>
The code as such builds for THUMB2 as I tried last time. At least
I have tried not to break it for THUMB2 anywhere.

Regards,
Santosh
