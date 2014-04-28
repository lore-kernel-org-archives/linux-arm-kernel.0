From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Apr 2014 13:17:04 +0100
Subject: [RESUBMIT RFC PATCH v2 2/3] ARM: EXYNOS: Move pmu specific
 header files under "linux/mfd/samsung"
In-Reply-To: <1398687607-4554-3-git-send-email-pankaj.dubey@samsung.com>
References: <1398687607-4554-1-git-send-email-pankaj.dubey@samsung.com>
 <1398687607-4554-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20140428121704.GD21279@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Moving Exynos PMU specific header file into "include/linux/mfd/samsung"
> thus updated affected files under "mach-exynos" to use new location of
> these header files.
> 
> CC: Sangbeom Kim <sbkim73@samsung.com>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> CC: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/cpuidle.c                                    |    4 ++--
>  arch/arm/mach-exynos/exynos.c                                     |    2 +-
>  arch/arm/mach-exynos/hotplug.c                                    |    2 +-
>  arch/arm/mach-exynos/platsmp.c                                    |    2 +-
>  arch/arm/mach-exynos/pm.c                                         |    4 ++--
>  arch/arm/mach-exynos/pmu.c                                        |    5 ++---
>  {arch/arm/mach-exynos => include/linux/mfd/samsung}/exynos-pmu.h  |    0
>  .../regs-pmu.h => include/linux/mfd/samsung/exynos-regs-pmu.h     |    0
>  8 files changed, 9 insertions(+), 10 deletions(-)
>  rename {arch/arm/mach-exynos => include/linux/mfd/samsung}/exynos-pmu.h (100%)
>  rename arch/arm/mach-exynos/regs-pmu.h => include/linux/mfd/samsung/exynos-regs-pmu.h (100%)

Patch looks okay to me.

With an Exynos Ack I'd like to take it through the MFD tree.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
