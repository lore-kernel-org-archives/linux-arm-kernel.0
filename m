From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 01 Mar 2010 09:51:54 +0100
Subject: [PATCH] ARM: includecheck fix for mach-at91/board-sam9m10g45ek.c
In-Reply-To: <1267260450.26906.9.camel@i7.satnam>
References: <1267260450.26906.9.camel@i7.satnam>
Message-ID: <4B8B802A.1090203@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/02/2010 09:47, Jaswinder Singh Rajput :
> 
> Fix the following 'make includecheck' warning:
>   arch/arm/mach-at91/board-sam9m10g45ek.c: mach/hardware.h is included more than once.
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/mach-at91/board-sam9m10g45ek.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
> index 98f9f4b..f2ba9e2 100644
> --- a/arch/arm/mach-at91/board-sam9m10g45ek.c
> +++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
> @@ -36,7 +36,6 @@
>  #include <asm/mach/map.h>
>  #include <asm/mach/irq.h>
>  
> -#include <mach/hardware.h>
>  #include <mach/board.h>
>  #include <mach/gpio.h>
>  #include <mach/at91sam9_smc.h>


-- 
Nicolas Ferre
