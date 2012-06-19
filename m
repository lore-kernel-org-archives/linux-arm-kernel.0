From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 19 Jun 2012 17:50:11 +0900
Subject: [PATCH 1/2] ARM: S3C64XX: Add module identification for Balblair
 Cragganmore module
In-Reply-To: <1338398378-18268-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1338398378-18268-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <019701cd4df8$89387860$9ba96920$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-
> s3c64xx/mach-crag6410-module.c
> index dbd5771..985e255 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
> @@ -219,6 +219,7 @@ static __devinitdata const struct {
>  	  .spi_devs = wm1253_devs, .num_spi_devs =
> ARRAY_SIZE(wm1253_devs) },
>  	{ .id = 0x32, .name = "XXXX-EV1 Caol Illa" },
>  	{ .id = 0x33, .name = "XXXX-EV1 Oban" },
> +	{ .id = 0x34, .name = "WM0010-6320-CS42 Balblair" },
>  	{ .id = 0x39, .name = "1254-EV1 Dallas Dhu",
>  	  .i2c_devs = wm1254_devs, .num_i2c_devs =
> ARRAY_SIZE(wm1254_devs) },
>  	{ .id = 0x3a, .name = "1259-EV1 Tobermory",
> --
> 1.7.10

OK, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
