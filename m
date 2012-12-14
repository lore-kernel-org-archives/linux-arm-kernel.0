From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Dec 2012 10:45:59 -0800
Subject: [PATCH] ARM: OMAP2+: PMU: Remove unused header
In-Reply-To: <1355508506-21448-1-git-send-email-jon-hunter@ti.com>
References: <1355508506-21448-1-git-send-email-jon-hunter@ti.com>
Message-ID: <20121214184557.GG4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [121214 10:10]:
> Commit 2ac29a1 (ARM: PMU: fix runtime PM enable) moved the call to
> pm_runtime_enable() from the OMAP2+ PMU code into the ARM PERF core
> code. However, header for pm_runtime which should have been removed
> from the OMAP2+ PMU code was not. It is no longer necessary to include
> this header in the OMAP2+ PMU code and so remove it.

Thanks applying into omap-for-v3.8/fixes-for-merge-window.

Regards,

Tony
 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap2/pmu.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pmu.c b/arch/arm/mach-omap2/pmu.c
> index 250d909..eb78ae7 100644
> --- a/arch/arm/mach-omap2/pmu.c
> +++ b/arch/arm/mach-omap2/pmu.c
> @@ -11,8 +11,6 @@
>   * the Free Software Foundation; either version 2 of the License, or
>   * (at your option) any later version.
>   */
> -#include <linux/pm_runtime.h>
> -
>  #include <asm/pmu.h>
>  
>  #include "soc.h"
> -- 
> 1.7.10.4
> 
