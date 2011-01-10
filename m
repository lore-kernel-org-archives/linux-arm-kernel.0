From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 10 Jan 2011 23:31:49 +0100
Subject: [PATCH 1/1] ARM i.MX50: Rename devices-mx50.h
In-Reply-To: <1294695869-6653-1-git-send-email-r64343@freescale.com>
References: <1294695869-6653-1-git-send-email-r64343@freescale.com>
Message-ID: <20110110223149.GK24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 05:44:29AM +0800, Jason Liu wrote:
> There are devices-imx51.h and devices-imx53.h under
> arch/arm/mach-mx5 directory. So, had better rename
> devices-mx50.h to devices-imx50.h to follow the same
> naming convention with imx51 and imx53 part.
> 
> Signed-off-by: Jason Liu <r64343@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-mx5/board-mx50_rdp.c                 |    2 +-
>  .../mach-mx5/{devices-mx50.h => devices-imx50.h}   |    0
>  2 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
> index fd32e4c..e5bb600 100644
> --- a/arch/arm/mach-mx5/board-mx50_rdp.c
> +++ b/arch/arm/mach-mx5/board-mx50_rdp.c
> @@ -35,7 +35,7 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
>  
> -#include "devices-mx50.h"
> +#include "devices-imx50.h"
>  
>  static iomux_v3_cfg_t mx50_rdp_pads[] __initdata = {
>  	/* SD1 */
> diff --git a/arch/arm/mach-mx5/devices-mx50.h b/arch/arm/mach-mx5/devices-imx50.h
> similarity index 100%
> rename from arch/arm/mach-mx5/devices-mx50.h
> rename to arch/arm/mach-mx5/devices-imx50.h
> -- 
> 1.7.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
