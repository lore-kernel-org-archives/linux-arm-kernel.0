From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Nov 2011 16:12:15 -0800
Subject: [PATCH] ARM: OMAP3: CPUidle: include <linux/export.h>
In-Reply-To: <1320710320-8279-1-git-send-email-khilman@ti.com>
References: <1320710320-8279-1-git-send-email-khilman@ti.com>
Message-ID: <20111108001214.GE31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [111107 15:23]:
> The CPUidle use THIS_MODULE, so needs <linux/export.h>
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Tony, one more for omap/fixes.   This one applies to Linus' master branch,
> but also applies to your current omap/fixes.

Thanks, applying into fixes. Looks like I did not grep for THIS_MODULE..

Tony
 
>  arch/arm/mach-omap2/cpuidle34xx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 4bf6e6e..2e0fa5a 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -24,6 +24,7 @@
>  
>  #include <linux/sched.h>
>  #include <linux/cpuidle.h>
> +#include <linux/export.h>
>  
>  #include <plat/prcm.h>
>  #include <plat/irqs.h>
> -- 
> 1.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
