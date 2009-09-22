From: jaswinder@kernel.org (Jaswinder Singh Rajput)
Date: Tue, 22 Sep 2009 18:41:40 +0530
Subject: [PATCH] ARM: includecheck fix: mach-bcmring, core.c
In-Reply-To: <1253623861.3784.4.camel@ht.satnam>
References: <1253623861.3784.4.camel@ht.satnam>
Message-ID: <1253625100.3784.10.camel@ht.satnam>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc to linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue, 2009-09-22 at 18:21 +0530, Jaswinder Singh Rajput wrote:
> fix the following 'make includecheck' warning:
> 
>   arch/arm/mach-bcmring/core.c: linux/amba/bus.h is included more than once.
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> ---
>  arch/arm/mach-bcmring/core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
> index 492c649..d3bf29b 100644
> --- a/arch/arm/mach-bcmring/core.c
> +++ b/arch/arm/mach-bcmring/core.c
> @@ -31,7 +31,6 @@
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
>  
> -#include <linux/amba/bus.h>
>  #include <mach/csp/mm_addr.h>
>  #include <mach/hardware.h>
>  #include <asm/clkdev.h>
