From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 03 Aug 2010 14:09:16 +0900
Subject: [PATCH 2/3] ARM: Samsung: Don't use the mach/gpio.h directly
In-Reply-To: <20100802002511.GA32261@july>
References: <20100802002511.GA32261@july>
Message-ID: <00f101cb32ca$0852fc70$18f8f550$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> Use the linux/gpio.h. also fix the build error since new C preprocessor
directives.

Cc'ed Ben Dooks.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-samsung/gpiolib.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/gpiolib.c
b/arch/arm/plat-samsung/gpiolib.c
> index 8a8ba8b..c354089 100644
> --- a/arch/arm/plat-samsung/gpiolib.c
> +++ b/arch/arm/plat-samsung/gpiolib.c
> @@ -18,7 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/irq.h>
>  #include <linux/io.h>
> -#include <mach/gpio.h>
> +#include <linux/gpio.h>

Only here?

If required, should be fixed all.
And...as I said, then I will fix...

>  #include <plat/gpio-core.h>
>  #include <plat/gpio-cfg.h>
>  #include <plat/gpio-cfg-helpers.h>
> --

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
