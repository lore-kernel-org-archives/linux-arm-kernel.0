From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 05 Sep 2011 19:28:06 +0900
Subject: [PATCH] ARM: S3C64XX: Register Lowland audio device on Cragganmore
In-Reply-To: <1314991378-28351-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1314991378-28351-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <002a01cc6bb6$802cc7a0$808656e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> The Lowland system is a combination of the Cragganmore CPU module and the
> Tomatin and Kilchomin audio modules on Glenfarclas.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-
> s3c64xx/mach-crag6410.c
> index 174dd0c..917acf7 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -284,6 +284,11 @@ static struct platform_device speyside_device = {
>  	.id		= -1,
>  };
> 
> +static struct platform_device lowland_device = {
> +	.name		= "lowland",
> +	.id		= -1,
> +};
> +
>  static struct platform_device speyside_wm8962_device = {
>  	.name		= "speyside-wm8962",
>  	.id		= -1,
> @@ -341,6 +346,7 @@ static struct platform_device *crag6410_devices[]
> __initdata = {
>  	&crag6410_backlight_device,
>  	&speyside_device,
>  	&speyside_wm8962_device,
> +	&lowland_device,
>  	&wallvdd_device,
>  };
> 
> --
> 1.7.5.4

OK, Applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
