From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 11 Aug 2011 16:47:15 +0900
Subject: [PATCH] exynos4: universal: Use the correct regulator names
In-Reply-To: <20110808095126.GA767@july>
References: <20110808095126.GA767@july>
Message-ID: <015a01cc57fa$e4d5a930$ae80fb90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Use the correct regulator names for cpufreq
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-
> exynos4/mach-universal_c210.c
> index 0e280d1..79f0a6f 100644
> --- a/arch/arm/mach-exynos4/mach-universal_c210.c
> +++ b/arch/arm/mach-exynos4/mach-universal_c210.c
> @@ -79,7 +80,7 @@ static struct s3c2410_uartcfg universal_uartcfgs[]
__initdata
> = {
>  };
> 
>  static struct regulator_consumer_supply max8952_consumer =
> -	REGULATOR_SUPPLY("vddarm", NULL);
> +	REGULATOR_SUPPLY("vdd_arm", NULL);
> 
>  static struct max8952_platform_data universal_max8952_pdata __initdata =
{
>  	.gpio_vid0	= EXYNOS4_GPX0(3),
> @@ -105,7 +106,7 @@ static struct max8952_platform_data
> universal_max8952_pdata __initdata = {
>  };
> 
>  static struct regulator_consumer_supply lp3974_buck1_consumer =
> -	REGULATOR_SUPPLY("vddint", NULL);
> +	REGULATOR_SUPPLY("vdd_int", NULL);
> 
>  static struct regulator_consumer_supply lp3974_buck2_consumer =
>  	REGULATOR_SUPPLY("vddg3d", NULL);

OK, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
