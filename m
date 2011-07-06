From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 06 Jul 2011 15:32:59 +0900
Subject: [PATCH] ARM: S5PC100: Fix for compilation error
In-Reply-To: <1309801312-27377-1-git-send-email-padma.v@samsung.com>
References: <1309801312-27377-1-git-send-email-padma.v@samsung.com>
Message-ID: <00c201cc3ba6$901a62c0$b04f2840$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi Venna wrote:
> 
> From: padmavathi venna <padma.v@samsung.com>
> 
> S5PC100 Compilation fails without this patch
> 
> Signed-off-by: padmavathi venna <padma.v@samsung.com>
> ---
>  arch/arm/mach-s5pc100/dev-spi.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pc100/dev-spi.c
b/arch/arm/mach-s5pc100/dev-spi.c
> index 2b58c9a..e5d6c4d 100644
> --- a/arch/arm/mach-s5pc100/dev-spi.c
> +++ b/arch/arm/mach-s5pc100/dev-spi.c
> @@ -15,6 +15,7 @@
>  #include <mach/dma.h>
>  #include <mach/map.h>
>  #include <mach/spi-clocks.h>
> +#include <mach/irqs.h>
> 
>  #include <plat/s3c64xx-spi.h>
>  #include <plat/gpio-cfg.h>
> --
> 1.7.0.4

Ok, will apply in -fix tree.

But, I'm not sure you really need to use your name ' padmavathi venna'
here...you used "Padmavathi Venna" in other patch.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
