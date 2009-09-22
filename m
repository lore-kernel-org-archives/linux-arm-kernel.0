From: jaswinder@kernel.org (Jaswinder Singh Rajput)
Date: Tue, 22 Sep 2009 18:42:06 +0530
Subject: [PATCH] ARM: includecheck fix: mach-at91, board-sam9m10g45ek.c
In-Reply-To: <1253623668.3784.2.camel@ht.satnam>
References: <1253623668.3784.2.camel@ht.satnam>
Message-ID: <1253625126.3784.11.camel@ht.satnam>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc to linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue, 2009-09-22 at 18:17 +0530, Jaswinder Singh Rajput wrote:
> fix the following 'make includecheck' warning:
> 
>   arch/arm/mach-at91/board-sam9m10g45ek.c: mach/hardware.h is included more than once.
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> ---
>  arch/arm/mach-at91/board-sam9m10g45ek.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
> index b8558ea..db12393 100644
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
