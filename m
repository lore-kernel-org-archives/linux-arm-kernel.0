From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Sep 2015 16:37:51 +0200
Subject: [PATCH] ARM: at91: remove useless includes in
 platform_data/atmel.h
In-Reply-To: <1439217705-13960-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439217705-13960-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55FC21BF.1090201@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/08/2015 16:41, Alexandre Belloni a ?crit :
> include/linux/platform_data/atmel.h has a lot of useless includes, remove
> them.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And I take it in at91-4.4-soc branch.

Thanks, bye.


> ---
>  include/linux/platform_data/atmel.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
> index 527a85c61924..4d67a5e82c83 100644
> --- a/include/linux/platform_data/atmel.h
> +++ b/include/linux/platform_data/atmel.h
> @@ -9,15 +9,7 @@
>  
>  #include <linux/mtd/nand.h>
>  #include <linux/mtd/partitions.h>
> -#include <linux/device.h>
> -#include <linux/i2c.h>
> -#include <linux/leds.h>
> -#include <linux/spi/spi.h>
> -#include <linux/usb/atmel_usba_udc.h>
> -#include <linux/atmel-mci.h>
> -#include <sound/atmel-ac97c.h>
>  #include <linux/serial.h>
> -#include <linux/platform_data/macb.h>
>  
>  /*
>   * at91: 6 USARTs and one DBGU port (SAM9260)
> 


-- 
Nicolas Ferre
