From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 08 Oct 2009 14:14:27 +0200
Subject: [PATCH] mmc: at91_mci: Don't include asm/mach/mmc.h
In-Reply-To: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4ACDD7A3.1040908@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig :
> This fixes a compile bug introduced in
> 
> 	6ef297f (ARM: 5720/1: Move MMCI header to amba include dir)
> 
> That commit moved arch/arm/include/asm/mach/mmc.h to
> include/linux/amba/mmci.h.  Just removing the include was enough.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Pierre Ossman <drzeus@drzeus.cx>
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/mmc/host/at91_mci.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
> index e556d42..63924e0 100644
> --- a/drivers/mmc/host/at91_mci.c
> +++ b/drivers/mmc/host/at91_mci.c
> @@ -72,7 +72,6 @@
>  #include <asm/irq.h>
>  #include <asm/gpio.h>
>  
> -#include <asm/mach/mmc.h>
>  #include <mach/board.h>
>  #include <mach/cpu.h>
>  #include <mach/at91_mci.h>


-- 
Nicolas Ferre
