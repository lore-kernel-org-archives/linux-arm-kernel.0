From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Fri, 9 Nov 2012 14:23:48 +0100
Subject: [PATCH] i2c: at91: fix compilation issue due to header move
In-Reply-To: <1352455900-21074-1-git-send-email-ludovic.desroches@atmel.com>
References: <1352455900-21074-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <509D03E4.2040502@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/09/2012 11:11 AM, ludovic.desroches at atmel.com a ?crit :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> arch/arm/mach-at91/include/mach/at_hdmac.h has been move to
> include/linux/platform_data/dma-atmel.h, commit 7cdc39e.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>
> Hi,
>
> This is a fix for 3.7.
>
> Regards
>
> Ludovic

Sorry don't take care about this patch, I'll put it into the dma patch 
I've to update.

I have it into my tree for a while, I've forgotten it is not yet included.

Sorry for the noise.

Regards

Ludovic

>
>   drivers/i2c/busses/i2c-at91.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index a9fbad8..e2e9837 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -32,7 +32,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>
> -#include <mach/at_hdmac.h>
> +#include <linux/platform_data/dma-atmel.h>
>
>   #define TWI_CLK_HZ		100000			/* max 400 Kbits/s */
>   #define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
>
