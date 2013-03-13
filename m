From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 13 Mar 2013 14:10:22 +0900
Subject: [PATCH -next] ARM: EXYNOS: remove duplicated include from common.c
In-Reply-To: <CAPgLHd9eSiAne_f_8ctbXt8x+ET3v_1o=-gdO1D_11kxx2jo3g@mail.gmail.com>
References: <CAPgLHd9eSiAne_f_8ctbXt8x+ET3v_1o=-gdO1D_11kxx2jo3g@mail.gmail.com>
Message-ID: <093201ce1fa9$109a12f0$31ce38d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wei Yongjun wrote:
> 
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-exynos/common.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index d63d399..01e4089 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -23,7 +23,6 @@
>  #include <linux/of_irq.h>
>  #include <linux/export.h>
>  #include <linux/irqdomain.h>
> -#include <linux/irqchip.h>
>  #include <linux/of_address.h>
>  #include <linux/irqchip/arm-gic.h>
> 
Applied, thanks.

- Kukjin
