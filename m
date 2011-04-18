From: alexey.zaytsev@gmail.com (Alexey Zaytsev)
Date: Mon, 18 Apr 2011 19:17:35 +0400
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110414094447.GA1611@n2100.arm.linux.org.uk>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
Message-ID: <BANLkTindYL9RHsc0MtY76RSr05qD0AU5Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear, Lunus.

Could you please just apologize for the pointless diffstat complain,
so we could go on?

Dear Russel.

Please don't take the offense. Linus might be a dickhead at times, and
sometimes he's wrong, but I'm sure he did not mean to hurt you.

(And who the fuck is this guy? No one.)

On Thu, Apr 14, 2011 at 13:44, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This morning, I looked at linux-next to find out how arch/arm is doing
> for the next merge window.
>
> $ git diff -C --cumulative v2.6.39-rc1... arch
> ?19.7% arch/arm/mach-imx/
> ?19.2% arch/arm/mach-mx3/
> ? 3.4% arch/arm/mach-mxc91231/
> ?18.1% arch/arm/mach-ux500/
> ?74.1% arch/arm/
> ? 3.2% arch/m68k/
> ? 4.0% arch/mips/lantiq/
> ? 6.9% arch/mips/
> ? 3.1% arch/x86/kvm/
> ? 7.6% arch/x86/
> ?100.0% arch/
> $ git diff -C --cumulative v2.6.39-rc1... arch/arm
> ? 4.7% arch/arm/mach-imx/
> ? 5.9% arch/arm/mach-msm/
> ? 6.3% arch/arm/mach-mx3/
> ? 8.8% arch/arm/mach-mxc91231/
> ? 7.6% arch/arm/mach-ux500/include/mach/
> ?46.1% arch/arm/mach-ux500/
> ? 3.6% arch/arm/mach-zynq/
> ? 5.9% arch/arm/plat-mxc/include/mach/
> ? 7.3% arch/arm/plat-mxc/
> ?100.0% arch/arm/
> $ git diff -C --shortstat v2.6.39-rc1... arch/arm
> ?450 files changed, 11973 insertions(+), 5736 deletions(-)
>
> Note that with --cumulative, the %age given includes all child directories
> (so the 74% for arch/arm includes everything below it).
>
> So, almost 75% of changes in arch are down to arch/arm. ?For arch/arm,
> there's 6k new lines introduced - so there's a significant amount of new
> work there.
>
> Folk may want to consider that we're three weeks from Linus' rant, and
> there's little sign of the situation changing. ?It looks to me from
> these statistics that it's business as usual.
>
> Please take a moment to consider how Linus will react to this at the
> next merge window.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
