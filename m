From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Jan 2015 16:23:17 -0800
Subject: [PATCH V2 0/2] ARM: l2c: OMAP4/AM437x: Additional register
 programming support.
In-Reply-To: <54A6F5C8.2050008@ti.com>
References: <1420220628-23742-1-git-send-email-nm@ti.com>
 <54A6E79E.7010203@oracle.com> <54A6F5C8.2050008@ti.com>
Message-ID: <20150103002317.GH3298@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [150102 11:50]:
> On 01/02/2015 12:46 PM, santosh.shilimkar at oracle.com wrote:
> > On 1/2/15 9:43 AM, Nishanth Menon wrote:
> >> Hi,
> >> OMAP4 and AM437x ROM code provides services to program PL310's latency
> >> registers and AM437x provides service for programming Address filter
> >> registers.
> >>
> >> Provide support in the kernel for the same.
> >>
> >> V2 of the series contains documentation update and a bug fix due to a
> >> typo introduced during patch split :(
> >>
> >> Nishanth Menon (2):
> >>    ARM: l2c: OMAP4/AM437x: Introduce support for cache latency
> >>      programming
> >>    ARM: l2c: AM437x: Introduce support for cache filter programming
> >>
> > Looks fine to me ...
> > Feel free to add my ack if you need one ...
> > 
> > Minor: The subject looks like I2C though it is L2C ;-)
> > 
> Yeah, the thought did occur to me, but decided instead to go with the
> existing $subject conventions of arch/arm/mach-omap2/omap4-common.c
> ARM: l2c: omap2+: get rid of init call
> ARM: l2c: omap2+: get rid of redundant cache replacement policy setting
> ARM: l2c: omap2: remove explicit non-secure access bits
> ARM: l2c: omap2: remove cache size override
> ARM: l2c: omap2: remove explicit SMI calls to enable L2 cache
> ARM: l2c: omap2: implement new write_sec method
> ARM: l2c: remove platforms/SoCs setting early BRESP
> ARM: l2c: fix register naming
> ARM: l2c: omap2: remove ES1.0 support
> 
> ..
> 
> If folks feel strongly about this, I can capitalize the same and post
> a v3 to help confusing fonts on certain mail clients and terminals.
> let me know if folks want me to.

I guess no need to :)

Looks like these still won't fix the issue we found in the
series posted by Tomasz though. At least I'm still getting errors
on am437x with these and the patches from Tomasz applied.

Regards,

Tony
