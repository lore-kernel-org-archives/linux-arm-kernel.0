From: ben@simtec.co.uk (Ben Dooks)
Date: Wed, 04 Aug 2010 15:11:15 +0100
Subject: [PATCH 2/3] ARM: Samsung: Don't use the mach/gpio.h directly
In-Reply-To: <20100802002511.GA32261@july>
References: <20100802002511.GA32261@july>
Message-ID: <4C597503.3030809@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/10 01:25, Kyungmin Park wrote:
> Use the linux/gpio.h. also fix the build error since new C preprocessor directives.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/plat-samsung/gpiolib.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/gpiolib.c b/arch/arm/plat-samsung/gpiolib.c
> index 8a8ba8b..c354089 100644
> --- a/arch/arm/plat-samsung/gpiolib.c
> +++ b/arch/arm/plat-samsung/gpiolib.c
> @@ -18,7 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/irq.h>
>  #include <linux/io.h>
> -#include <mach/gpio.h>
> +#include <linux/gpio.h>
>  #include <plat/gpio-core.h>
>  #include <plat/gpio-cfg.h>
>  #include <plat/gpio-cfg-helpers.h>
