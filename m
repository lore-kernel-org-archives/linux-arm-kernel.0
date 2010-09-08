From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 08 Sep 2010 20:52:48 +0900
Subject: [PATCH 1/2] ARM: S3C64XX: Fix dev-spi build
In-Reply-To: <1283941539-3892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1283941539-3892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <003201cb4f4c$5e561640$1b0242c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> The irqs.h usage here got missed in the Samsung platform reorganisation.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Maybe Jassi wants to use 'jassi.brar at samsung.com' e-mail...but I'm not sure
;-)

Anyway, this is ok to me...and how about mach-s5pc100/dev-spi.c?
And I think, this should be gone to upstream via Ben's tree...

> ---
>  arch/arm/mach-s3c64xx/dev-spi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/dev-spi.c
b/arch/arm/mach-s3c64xx/dev-spi.c
> index a492b98..bfa3ef7 100644
> --- a/arch/arm/mach-s3c64xx/dev-spi.c
> +++ b/arch/arm/mach-s3c64xx/dev-spi.c
> @@ -18,10 +18,10 @@
>  #include <mach/map.h>
>  #include <mach/gpio-bank-c.h>
>  #include <mach/spi-clocks.h>
> +#include <mach/irqs.h>
> 
>  #include <plat/s3c64xx-spi.h>
>  #include <plat/gpio-cfg.h>
> -#include <plat/irqs.h>
> 
>  static char *spi_src_clks[] = {
>  	[S3C64XX_SPI_SRCCLK_PCLK] = "pclk",
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
