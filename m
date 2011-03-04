From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 4 Mar 2011 22:18:10 +0530
Subject: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of
	individual hwmods
In-Reply-To: <4D7115BF.7000009@ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
	<4D651998.3040002@ti.com>
	<alpine.DEB.2.00.1102271928550.505@utopia.booyaka.com>
	<4D6B845A.9000900@ti.com> <20110302175422.GY20560@atomide.com>
	<4D6F7723.5040001@ti.com> <4D70FC5B.9040701@ti.com>
	<20110304161933.GV20560@atomide.com> <4D7115BF.7000009@ti.com>
Message-ID: <d0a7ba9bd56a8522eca446a4a1ebaa74@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Cousson, Benoit [mailto:b-cousson at ti.com]
> Sent: Friday, March 04, 2011 10:09 PM
> To: Tony Lindgren
> Cc: Paul Walmsley; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Hilman, Kevin; Shilimkar, Santosh;
> Gopinath, Thara; DebBarma, Tarun Kanti; Nayak, Rajendra
> Subject: Re: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init
> of individual hwmods
>
> On 3/4/2011 5:19 PM, Tony Lindgren wrote:
> > * Cousson, Benoit<b-cousson@ti.com>  [110304 06:49]:
> >>
> >> Tony,
> >> Do you plan to re-merge this branch or should I just send a
> revert
> >> on top of it?
> >
> > Please just provide a patch.
> >
> > Regards,
> >
> > Tony
>
> I posted it with the one from Rajendra to fix the regression with
> Santosh's series, but I do need Santosh to rebase and re-test the
> second one.
>
I just replied on another thread Benoit. I still see an issue with MPU
OFF.

Regards,
Santosh
