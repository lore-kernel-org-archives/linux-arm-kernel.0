From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 Jan 2012 14:20:00 +0900
Subject: [PATCH] ARM: S3C64XX: Add a SPKVDD supply for CODECs on
 Cragganmore
In-Reply-To: <1326812866-27271-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1326812866-27271-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <01a101ccdcb3$510376e0$f30a64a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Hook up a SPKVDD supply for CODECs that can use it.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-
> s3c64xx/mach-crag6410.c
> index 202f724..d5a7982 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -300,6 +300,7 @@ static struct platform_device littlemill_device = {
>  };
> 
>  static struct regulator_consumer_supply wallvdd_consumers[] = {
> +	REGULATOR_SUPPLY("SPKVDD", "1-001a"),
>  	REGULATOR_SUPPLY("SPKVDD1", "1-001a"),
>  	REGULATOR_SUPPLY("SPKVDD2", "1-001a"),
>  	REGULATOR_SUPPLY("SPKVDDL", "1-001a"),
> --
> 1.7.7.3

OK, will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
