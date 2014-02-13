From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 Feb 2014 07:23:59 +0900
Subject: [PATCH] clocksource: exynos_mct: remove unwanted header file
 inclusion
In-Reply-To: <1389314025-2890-1-git-send-email-pankaj.dubey@samsung.com>
References: <1389314025-2890-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <52FD45FF.7030100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/14 09:33, Pankaj Dubey wrote:
> remove unwanted header file inclusion "asm/mach/time.h" from exynos_mct.c
>
> Signed-off-by: Pankaj Dubey<pankaj.dubey@samsung.com>
> ---
>   drivers/clocksource/exynos_mct.c |    2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 48f76bc..ed49b25 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -25,8 +25,6 @@
>   #include<linux/of_address.h>
>   #include<linux/clocksource.h>
>
> -#include<asm/mach/time.h>
> -
>   #define EXYNOS4_MCTREG(x)		(x)
>   #define EXYNOS4_MCT_G_CNT_L		EXYNOS4_MCTREG(0x100)
>   #define EXYNOS4_MCT_G_CNT_U		EXYNOS4_MCTREG(0x104)

Looks good, applied.

Thanks,
Kukjin
