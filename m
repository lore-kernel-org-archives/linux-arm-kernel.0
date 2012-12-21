From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Dec 2012 08:48:49 -0800
Subject: [PATCH 0/8] Flip on multiplatform support for omap2plus for v3.9
In-Reply-To: <CALF0-+Xy+w=4Bs+97WJj76-tAnb56v=hS+zLyr9ue_zBKSQoVg@mail.gmail.com>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
 <20121220155518.GX4989@atomide.com>
 <CALF0-+XspOix_RiNkWN7d1L9uxBZi7Zf5SDaKcx0P7P_Z3anqA@mail.gmail.com>
 <20121221010518.GJ21056@atomide.com>
 <CALF0-+Xy+w=4Bs+97WJj76-tAnb56v=hS+zLyr9ue_zBKSQoVg@mail.gmail.com>
Message-ID: <20121221164849.GL21056@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ezequiel Garcia <elezegarcia@gmail.com> [121221 04:50]:
> Hi Tony,
> 
> On Thu, Dec 20, 2012 at 10:05 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Maybe use Olof's lates pull request for fixes from LAKML +
> > ARM: l2x0: Only set .set_debug on PL310 r3p0 and earlier +
> > ARM: disable errata work-arounds which access secure registers
> > and these patches?
> >
> 
> FYI, I've successfully booted my IGEPv2 board using:
> * arm-soc/for-next

Ah right, sorry this series also needs the omap branch
omap-for-v3.8/cleanup-for-merge-window that's now in
arm-soc/for-next. Specifically it's the "ARM: OMAP: Split
fb.c to remove last remaining cpu_is_omap usage" patch.

> * igep DT patches
> * this multiplatform series
> * the two patches mentioned above
> 
> With this series CONFIG_MACH_IGEP0020 is not needed,
> just CONFIG_MACH_OMAP_GENERIC is selected.
> 
> So I guess this means, for igep v2,
> 
> Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Thanks,

Tony
