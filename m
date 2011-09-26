From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 Sep 2011 13:34:03 +0900
Subject: [PATCH] ARM: S3C64xx: Add LDOVDD supply for CODEC on Cragganmore
In-Reply-To: <1316714477-19994-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1316714477-19994-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <00d801cc7c05$84e877d0$8eb96770$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-
> s3c64xx/mach-crag6410.c
> index a53b02e..613c165 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -582,6 +582,7 @@ static struct regulator_init_data pvdd_1v2 __initdata
= {
>  };
> 
>  static struct regulator_consumer_supply pvdd_1v8_consumers[] __initdata =
{
> +	REGULATOR_SUPPLY("LDOVDD", "1-001a"),
>  	REGULATOR_SUPPLY("PLLVDD", "1-001a"),
>  	REGULATOR_SUPPLY("DBVDD", "1-001a"),
>  	REGULATOR_SUPPLY("DBVDD1", "1-001a"),
> --
> 1.7.6.3

Applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
