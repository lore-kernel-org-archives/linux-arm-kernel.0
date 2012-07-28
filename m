From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 Jul 2012 19:14:24 +0800
Subject: [PATCH] ARM: mxc: Include missing irqs.h header
In-Reply-To: <1343029278-11654-1-git-send-email-festevam@gmail.com>
References: <1343029278-11654-1-git-send-email-festevam@gmail.com>
Message-ID: <20120728111422.GD2128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 04:41:18AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Include irqs.h in order to fix the following build error:
> 
> arch/arm/plat-mxc/tzic.c:195:11: error: 'FIQ_START' undeclared (first use in this function)
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks for the patch.  Will send it to arm-soc shortly.

Regards,
Shawn

> ---
>  arch/arm/plat-mxc/tzic.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
> index c219317..3ed1adb 100644
> --- a/arch/arm/plat-mxc/tzic.c
> +++ b/arch/arm/plat-mxc/tzic.c
> @@ -23,6 +23,7 @@
>  
>  #include <mach/hardware.h>
>  #include <mach/common.h>
> +#include <mach/irqs.h>
>  
>  #include "irq-common.h"
>  
> -- 
> 1.7.1
> 
