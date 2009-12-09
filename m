From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 9 Dec 2009 21:59:27 +0800
Subject: [PATCH 2/3] ARM: MX3: remove duplicated #include
In-Reply-To: <1260364135-2320-1-git-send-email-weiyi.huang@gmail.com>
References: <1260364135-2320-1-git-send-email-weiyi.huang@gmail.com>
Message-ID: <20091209135927.GH28375@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2009 at 09:08:55PM +0800, Huang Weiyi wrote:
> Remove duplicated #include('s) in
>   arch/arm/mach-mx3/mx31lite-db.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Acked-by: Daniel Mack <daniel@caiaq.de>


> ---
>  arch/arm/mach-mx3/mx31lite-db.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
> index 694611d..ccef689 100644
> --- a/arch/arm/mach-mx3/mx31lite-db.c
> +++ b/arch/arm/mach-mx3/mx31lite-db.c
> @@ -30,7 +30,6 @@
>  #include <linux/gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/leds.h>
> -#include <linux/platform_device.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> -- 
> 1.6.1.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
