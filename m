From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Oct 2009 15:54:56 -0700
Subject: [PATCH 1/6] omap: headers: Add mach patch to include files
In-Reply-To: <20091014214845.30227.51419.stgit@kaulin.muru.com>
References: <20091014213748.30227.71513.stgit@kaulin.muru.com>
	<20091014214845.30227.51419.stgit@kaulin.muru.com>
Message-ID: <20091014225455.GA14531@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [091014 14:55]:
> This is to prepare for moving hardware.h to live under plat
> instead of mach.

The subject should say "add mach path" instead of "add mach patch"..
 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
>  arch/arm/plat-omap/include/mach/hardware.h |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
> index 26c1fbf..f746c9d 100644
> --- a/arch/arm/plat-omap/include/mach/hardware.h
> +++ b/arch/arm/plat-omap/include/mach/hardware.h
> @@ -280,11 +280,11 @@
>   * ---------------------------------------------------------------------------
>   */
>  
> -#include "omap730.h"
> -#include "omap1510.h"
> -#include "omap16xx.h"
> -#include "omap24xx.h"
> -#include "omap34xx.h"
> -#include "omap44xx.h"
> +#include <mach/omap730.h>
> +#include <mach/omap1510.h>
> +#include <mach/omap16xx.h>
> +#include <mach/omap24xx.h>
> +#include <mach/omap34xx.h>
> +#include <mach/omap44xx.h>
>  
>  #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
> 
