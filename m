From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jul 2012 10:02:02 +0100
Subject: [PATCHv2 3/3] ARM: EXYNOS: Enable PMUs for exynos4/5
In-Reply-To: <1343376509-5881-4-git-send-email-chanho61.park@samsung.com>
References: <1343376509-5881-1-git-send-email-chanho61.park@samsung.com>
 <1343376509-5881-4-git-send-email-chanho61.park@samsung.com>
Message-ID: <20120727090201.GD559@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 09:08:29AM +0100, Chanho Park wrote:
> This patch define irq numbers of ARM performance monitoring unit for exynos4/5.
> The number of CPU cores and PMU irq numbers are vary according to soc types.
> So we need to identify each soc type using soc_is_xxx function and define the
> pmu irqs dynamically. In case of exynos4412, there are 4 cpu cores and pmus.

We have devicetree bindings for the PMU -- why can't you use those instead
of probing the SoC all the time?

Will
