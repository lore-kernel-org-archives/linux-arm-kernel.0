From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 21 Nov 2016 15:59:05 -0500
Subject: [PATCH] ARM: lpc32xx: drop duplicate header device.h
In-Reply-To: <31c0875cedae8fe20211b209c85b6e012fa9f6a5.1479457940.git.geliangtang@gmail.com>
References: <319a5803aac795e175306d4978134f0247cf87bc.1479457751.git.geliangtang@gmail.com>
 <31c0875cedae8fe20211b209c85b6e012fa9f6a5.1479457940.git.geliangtang@gmail.com>
Message-ID: <1479761945.1477.0.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-11-18 at 22:21 +0800, Geliang Tang wrote:
> Drop duplicate header device.h from phy3250.c.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  arch/arm/mach-lpc32xx/phy3250.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
> index 0e4cbbe..6c52bd3 100644
> --- a/arch/arm/mach-lpc32xx/phy3250.c
> +++ b/arch/arm/mach-lpc32xx/phy3250.c
> @@ -23,7 +23,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/device.h>
>  #include <linux/gpio.h>
>  #include <linux/amba/bus.h>
>  #include <linux/amba/clcd.h>

Reviewed-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
