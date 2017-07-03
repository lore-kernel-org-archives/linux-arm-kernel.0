From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Jul 2017 14:50:43 +0200
Subject: [PATCH 1/8] ARM: l2c: move cache-aurora-l2.h to asm/hardware
In-Reply-To: <20170630145106.29820-2-jlu@pengutronix.de> (Jan Luebbe's message
 of "Fri, 30 Jun 2017 16:50:59 +0200")
References: <20170630145106.29820-1-jlu@pengutronix.de>
 <20170630145106.29820-2-jlu@pengutronix.de>
Message-ID: <87o9t1vg4c.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,
 
 On ven., juin 30 2017, Jan Luebbe <jlu@pengutronix.de> wrote:

> This include file will be used by the AURORA EDAC code.
>
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> ---
>  arch/arm/{mm => include/asm/hardware}/cache-aurora-l2.h | 0
>  arch/arm/mm/cache-l2x0.c                                | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename arch/arm/{mm => include/asm/hardware}/cache-aurora-l2.h (100%)
>
> diff --git a/arch/arm/mm/cache-aurora-l2.h b/arch/arm/include/asm/hardware/cache-aurora-l2.h
> similarity index 100%
> rename from arch/arm/mm/cache-aurora-l2.h
> rename to arch/arm/include/asm/hardware/cache-aurora-l2.h
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 808efbb89b88..a00d6f7fd34c 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -30,8 +30,8 @@
>  #include <asm/cp15.h>
>  #include <asm/cputype.h>
>  #include <asm/hardware/cache-l2x0.h>
> +#include <asm/hardware/cache-aurora-l2.h>
>  #include "cache-tauros3.h"
> -#include "cache-aurora-l2.h"
>  
>  struct l2c_init_data {
>  	const char *type;
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
