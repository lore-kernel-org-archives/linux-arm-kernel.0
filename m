From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 4 Nov 2013 11:35:48 +0100
Subject: [PATCH] ARM: orion5x: drop unused include from common.c
In-Reply-To: <1383557043-18891-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1383557043-18891-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131104103548.GD6051@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 10:24:03AM +0100, Uwe Kleine-K?nig wrote:
> asm/times.h only defines CLOCK_TICK_RATE, cycles_t and get_cycles. All
> three are not used in this file.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-orion5x/common.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
> index 91a5852..afa6b08 100644
> --- a/arch/arm/mach-orion5x/common.c
> +++ b/arch/arm/mach-orion5x/common.c
> @@ -24,7 +24,6 @@
>  #include <asm/page.h>
>  #include <asm/setup.h>
>  #include <asm/system_misc.h>
> -#include <asm/timex.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/time.h>
> -- 
> 1.8.4.rc3
 
Hi Uwe

I build tested this patch.

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
