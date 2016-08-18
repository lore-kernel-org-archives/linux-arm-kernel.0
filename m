From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 18 Aug 2016 16:31:59 +0900
Subject: [PATCH v2] MAINTAINERS: add myself as Samsung SPI maintainer
In-Reply-To: <20160818072555.9208-1-andi.shyti@samsung.com>
References: <CGME20160818072717epcas1p12f8d3416d3d70f403022c9cb91a890f2@epcas1p1.samsung.com>
 <20160818072555.9208-1-andi.shyti@samsung.com>
Message-ID: <20160818073159.y4fsqod63gjvezvs@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 04:25:55PM +0900, Andi Shyti wrote:
> Create a new entry for the Samsung SPI driver supported by the
> drivers/spi/spi-s3c* and remove it from its original place under
> "ARM/SAMSUNG EXYNOS ARM ARCHITECTURES".
> 
> The original maintainership inherited from the Samsung Exynos
> ARM Architecture is kept as it was (i.e. Kukjin and Krzysztof), I
> will help and co-maintain the driver.
> 
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Mark Brown <broonie@kernel.org>
> CC: linux-samsung-soc at vger.kernel.org
> CC: linux-spi at vger.kernel.org
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>

Krzysztof (before you write it), sorry I forgot your Acked-by.

Please consider this patch to be:

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Andi

> ---
> Hi,
> 
> as Krzysztof pointed out, in the first version of this patch I
> forgot some files related to the Samsung's SPI drivers. In this
> version I added them.
> 
> Thanks,
> Andi
> 
>  MAINTAINERS | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c9cd8d3..fa71cea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1633,7 +1633,6 @@ F:	drivers/*/*s3c64xx*
>  F:	drivers/*/*s5pv210*
>  F:	drivers/memory/samsung/*
>  F:	drivers/soc/samsung/*
> -F:	drivers/spi/spi-s3c*
>  F:	Documentation/arm/Samsung/
>  F:	Documentation/devicetree/bindings/arm/samsung/
>  F:	Documentation/devicetree/bindings/sram/samsung-sram.txt
> @@ -10240,6 +10239,17 @@ S:	Supported
>  L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
>  F:	drivers/clk/samsung/
>  
> +SAMSUNG SPI DRIVERS
> +M:	Kukjin Kim <kgene@kernel.org>
> +M:	Krzysztof Kozlowski <krzk@kernel.org>
> +M:	Andi Shyti <andi.shyti@samsung.com>
> +L:	linux-spi at vger.kernel.org
> +L:	linux-samsung-soc at vger.kernel.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/spi/spi-samsung.txt
> +F:	drivers/spi/spi-s3c*
> +F:	include/linux/platform_data/spi-s3c64xx.h
> +
>  SAMSUNG SXGBE DRIVERS
>  M:	Byungho An <bh74.an@samsung.com>
>  M:	Girish K S <ks.giri@samsung.com>
> -- 
> 2.8.1
> 
