From: chanho61.park@samsung.com (Chanho Park)
Date: Sat, 28 Jul 2012 13:26:43 +0900
Subject: [PATCHv2 3/3] ARM: EXYNOS: Enable PMUs for exynos4/5
In-Reply-To: <20120727090201.GD559@mudshark.cambridge.arm.com>
References: <1343376509-5881-1-git-send-email-chanho61.park@samsung.com>
 <1343376509-5881-4-git-send-email-chanho61.park@samsung.com>
 <20120727090201.GD559@mudshark.cambridge.arm.com>
Message-ID: <01c601cd6c79$30f508e0$92df1aa0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Friday, July 27, 2012 6:02 PM
> To: Chanho Park
> Cc: kgene.kim at samsung.com; linux-arm-kernel at lists.infradead.org; linux-
> samsung-soc at vger.kernel.org; sachin.kamat at linaro.org;
> linux at arm.linux.org.uk; Kyungmin Park
> Subject: Re: [PATCHv2 3/3] ARM: EXYNOS: Enable PMUs for exynos4/5
> 
> On Fri, Jul 27, 2012 at 09:08:29AM +0100, Chanho Park wrote:
> > This patch define irq numbers of ARM performance monitoring unit for
> exynos4/5.
> > The number of CPU cores and PMU irq numbers are vary according to soc
> types.
> > So we need to identify each soc type using soc_is_xxx function and
> > define the pmu irqs dynamically. In case of exynos4412, there are 4 cpu
> cores and pmus.
> 
> We have devicetree bindings for the PMU -- why can't you use those instead
> of probing the SoC all the time?

Hi Will,
Exynos4 isn't fully supported the DT yet. Thus, we should support legacy probing.
I'll support the DT for PMU after applied this patch.
Thank you

Best regards,
Chanho Park

> 
> Will
