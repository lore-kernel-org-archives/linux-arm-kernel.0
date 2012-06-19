From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 19 Jun 2012 17:50:01 +0900
Subject: [PATCH] ARM: S3C64XX: Add IRQ mapping for wm0010 on Cragganmore
In-Reply-To: <1339775065-13211-1-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1339775065-13211-1-git-send-email-dp@opensource.wolfsonmicro.com>
Message-ID: <019601cd4df8$83b33380$8b199a80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dimitris Papastamos wrote:
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-
> s3c64xx/mach-crag6410-module.c
> index f347336..7c8ea3c 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> @@ -47,6 +47,7 @@ static struct spi_board_info wm1253_devs[] = {
>  		.bus_num	= 0,
>  		.chip_select	= 0,
>  		.mode		= SPI_MODE_0,
> +		.irq            = S3C_EINT(5),
>  		.controller_data = &wm0010_spi_csinfo,
>  		.platform_data = &wm0010_crag_pdata,
>  	},
> --
> 1.7.10.4

OK, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
