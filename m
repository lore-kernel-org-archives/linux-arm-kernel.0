From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Sep 2015 16:37:15 +0200
Subject: [PATCH] usb: gadget: atmel: remove useless include
In-Reply-To: <1439216973-12150-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439216973-12150-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55FC219B.5080100@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/08/2015 16:29, Alexandre Belloni a ?crit :
> Definitions from linux/platform_data/atmel.h are not used, remove the
> include.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 4095cce05e6a..548192f77dcb 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -22,7 +22,6 @@
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/atmel_usba_udc.h>
>  #include <linux/delay.h>
> -#include <linux/platform_data/atmel.h>
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
>  
> 


-- 
Nicolas Ferre
