From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Apr 2011 14:08:54 +0300
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110414094447.GA1611@n2100.arm.linux.org.uk>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
Message-ID: <20110414110854.GF29938@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110414 12:42]:
> This morning, I looked at linux-next to find out how arch/arm is doing
> for the next merge window.
> 
> $ git diff -C --cumulative v2.6.39-rc1... arch
>   19.7% arch/arm/mach-imx/
>   19.2% arch/arm/mach-mx3/
>    3.4% arch/arm/mach-mxc91231/
>   18.1% arch/arm/mach-ux500/
>   74.1% arch/arm/
>    3.2% arch/m68k/
>    4.0% arch/mips/lantiq/
>    6.9% arch/mips/
>    3.1% arch/x86/kvm/
>    7.6% arch/x86/
>  100.0% arch/
> $ git diff -C --cumulative v2.6.39-rc1... arch/arm
>    4.7% arch/arm/mach-imx/
>    5.9% arch/arm/mach-msm/
>    6.3% arch/arm/mach-mx3/
>    8.8% arch/arm/mach-mxc91231/
>    7.6% arch/arm/mach-ux500/include/mach/
>   46.1% arch/arm/mach-ux500/
>    3.6% arch/arm/mach-zynq/
>    5.9% arch/arm/plat-mxc/include/mach/
>    7.3% arch/arm/plat-mxc/
>  100.0% arch/arm/
> $ git diff -C --shortstat v2.6.39-rc1... arch/arm
>  450 files changed, 11973 insertions(+), 5736 deletions(-)
> 
> Note that with --cumulative, the %age given includes all child directories
> (so the 74% for arch/arm includes everything below it).
> 
> So, almost 75% of changes in arch are down to arch/arm.  For arch/arm,
> there's 6k new lines introduced - so there's a significant amount of new
> work there.
> 
> Folk may want to consider that we're three weeks from Linus' rant, and
> there's little sign of the situation changing.  It looks to me from
> these statistics that it's business as usual.
> 
> Please take a moment to consider how Linus will react to this at the
> next merge window.

It's going to take some time before the consolidated code starts
being available.. And until we have something available, we all
should aim for negative diffstat.

Tony
