From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 20 Nov 2012 10:52:55 +0100
Subject: [PATCH] fix compilation error in cm_common.c
In-Reply-To: <1353403553-13525-1-git-send-email-const@MakeLinux.com>
References: <1353403553-13525-1-git-send-email-const@MakeLinux.com>
Message-ID: <50AB52F7.9000301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 10:25 AM, Constantine Shulyupin wrote:
> From: Constantine Shulyupin <const@MakeLinux.com>
> 
> Added required linux/errno.h
> 
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

This supposed to be already fixed:
https://patchwork.kernel.org/patch/1728521/

> ---
>  arch/arm/mach-omap2/cm_common.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
> index 3246cef..3fafc27 100644
> --- a/arch/arm/mach-omap2/cm_common.c
> +++ b/arch/arm/mach-omap2/cm_common.c
> @@ -13,6 +13,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/errno.h>
>  
>  #include "cm2xxx.h"
>  #include "cm3xxx.h"
> 


-- 
P?ter
