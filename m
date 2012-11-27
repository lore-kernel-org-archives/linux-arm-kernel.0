From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Nov 2012 08:31:19 +0900
Subject: [PATCH] ARM: S3C64XX: Add dummy supplies for Glenfarclas LDOs
In-Reply-To: <1354030486-26742-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1354030486-26742-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <50B54D47.1040301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/12 00:34, Mark Brown wrote:
> These are not actually connected but it saves them going through probe
> deferral.
>
> Signed-off-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
> ---
>   arch/arm/mach-s3c64xx/mach-crag6410.c |   10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
> index c06bcfa..701f421 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -333,6 +333,16 @@ static struct regulator_consumer_supply wallvdd_consumers[] = {
>   	REGULATOR_SUPPLY("DC1VDD", "1-0034"),
>   	REGULATOR_SUPPLY("DC2VDD", "1-0034"),
>   	REGULATOR_SUPPLY("DC3VDD", "1-0034"),
> +	REGULATOR_SUPPLY("LDO1VDD", "1-0034"),
> +	REGULATOR_SUPPLY("LDO2VDD", "1-0034"),
> +	REGULATOR_SUPPLY("LDO4VDD", "1-0034"),
> +	REGULATOR_SUPPLY("LDO5VDD", "1-0034"),
> +	REGULATOR_SUPPLY("LDO6VDD", "1-0034"),
> +	REGULATOR_SUPPLY("LDO7VDD", "1-0034"),
> +	REGULATOR_SUPPLY("LDO8VDD", "1-0034"),
> +	REGULATOR_SUPPLY("LDO9VDD", "1-0034"),
> +	REGULATOR_SUPPLY("LDO10VDD", "1-0034"),
> +	REGULATOR_SUPPLY("LDO11VDD", "1-0034"),
>   };
>
>   static struct regulator_init_data wallvdd_data = {

Applied, thanks.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
