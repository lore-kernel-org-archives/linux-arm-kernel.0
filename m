From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 24 Jul 2013 10:35:01 +0200
Subject: [PATCH 4/4] ARM: exynos: cpuidle: Remove useless headers
In-Reply-To: <1374152070-21008-4-git-send-email-daniel.lezcano@linaro.org>
References: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org>
 <1374152070-21008-4-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <4079574.R74GCppML0@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 of July 2013 14:54:30 Daniel Lezcano wrote:
> The headers:
> 
> #include <linux/kernel.h>
> #include <linux/export.h>
> #include <linux/time.h>
> #include <asm/unified.h>
> 
> are not needed. Removed them.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/cpuidle.c
> b/arch/arm/mach-exynos/cpuidle.c index 8d06128..027f5e7 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -8,18 +8,14 @@
>   * published by the Free Software Foundation.
>  */
> 
> -#include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/io.h>
> -#include <linux/export.h>
> -#include <linux/time.h>
> 
>  #include <asm/proc-fns.h>
>  #include <asm/smp_scu.h>
>  #include <asm/suspend.h>
> -#include <asm/unified.h>
>  #include <asm/cpuidle.h>
>  #include <mach/regs-clock.h>
>  #include <mach/regs-pmu.h>

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
