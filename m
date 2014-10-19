From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 19 Oct 2014 10:19:09 +0800
Subject: [PATCHv5 6/6] ARM: imx: Add Freescale LS1021A SMP support
In-Reply-To: <1413192963-11153-7-git-send-email-jingchang.lu@freescale.com>
References: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
 <1413192963-11153-7-git-send-email-jingchang.lu@freescale.com>
Message-ID: <20141019021908.GF7869@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 13, 2014 at 05:36:03PM +0800, Jingchang Lu wrote:
> diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> index 771bd25..69b87ca 100644
> --- a/arch/arm/mach-imx/platsmp.c
> +++ b/arch/arm/mach-imx/platsmp.c
> @@ -16,6 +16,8 @@
>  #include <asm/page.h>
>  #include <asm/smp_scu.h>
>  #include <asm/mach/map.h>
> +#include <linux/of_address.h>
> +#include <linux/of.h>

Please group the headers into <linux/*> and sort them alphabetically.

Shawn

>  
>  #include "common.h"
>  #include "hardware.h"
