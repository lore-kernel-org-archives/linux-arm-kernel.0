From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 12 Aug 2011 18:53:28 +0900
Subject: [PATCH] ARM: EXYNOS4: remove duplicated #include
In-Reply-To: <1311860081-996-1-git-send-email-weiyi.huang@gmail.com>
References: <1311860081-996-1-git-send-email-weiyi.huang@gmail.com>
Message-ID: <008701cc58d5$b1095940$131c0bc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Huang Weiyi wrote:
> 
> Remove duplicated #include('s) in
>   arch/arm/mach-exynos4/cpu.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
> ---
>  arch/arm/mach-exynos4/cpu.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
> index 2d8a40c..84032d3 100644
> --- a/arch/arm/mach-exynos4/cpu.c
> +++ b/arch/arm/mach-exynos4/cpu.c
> @@ -24,7 +24,6 @@
>  #include <plat/exynos4.h>
>  #include <plat/adc-core.h>
>  #include <plat/sdhci.h>
> -#include <plat/devs.h>
>  #include <plat/fb-core.h>
>  #include <plat/fimc-core.h>
>  #include <plat/iic-core.h>
> --
> 1.5.6.4

Yes, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
