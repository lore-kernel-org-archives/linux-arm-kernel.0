From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Apr 2014 12:21:01 +0100
Subject: [RFC PATCH v2 2/3] ARM: EXYNOS: Move pmu specific header files
 under "linux/mfd/samsung"
In-Reply-To: <1398431131-5946-3-git-send-email-pankaj.dubey@samsung.com>
References: <1396427085-4696-1-git-send-email-pankaj.dubey@samsung.com>
 <1398431131-5946-1-git-send-email-pankaj.dubey@samsung.com>
 <1398431131-5946-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20140428112101.GS21279@lee--X1>
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
>  arch/arm/mach-exynos/cpuidle.c              |    4 +-
>  arch/arm/mach-exynos/exynos-pmu.h           |   31 ---
>  arch/arm/mach-exynos/exynos.c               |    2 +-
>  arch/arm/mach-exynos/hotplug.c              |    2 +-
>  arch/arm/mach-exynos/platsmp.c              |    2 +-
>  arch/arm/mach-exynos/pm.c                   |    4 +-
>  arch/arm/mach-exynos/pmu.c                  |    5 +-
>  arch/arm/mach-exynos/regs-pmu.h             |  308 ---------------------------
>  include/linux/mfd/samsung/exynos-pmu.h      |   31 +++
>  include/linux/mfd/samsung/exynos-regs-pmu.h |  308 +++++++++++++++++++++++++++
>  10 files changed, 348 insertions(+), 349 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/exynos-pmu.h
>  delete mode 100644 arch/arm/mach-exynos/regs-pmu.h
>  create mode 100644 include/linux/mfd/samsung/exynos-pmu.h
>  create mode 100644 include/linux/mfd/samsung/exynos-regs-pmu.h

Can you resubmit this using the -M option for format-patch please?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
