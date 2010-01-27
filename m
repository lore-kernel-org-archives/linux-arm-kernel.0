From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 27 Jan 2010 01:07:48 +0000
Subject: [PATCH 2/2] HWMON: Add s3c64xx support to s3c-hwmon
In-Reply-To: <b2e8f9f71001260316h7fe29effn290648178ff42397@mail.gmail.com>
References: <b2e8f9f71001260316h7fe29effn290648178ff42397@mail.gmail.com>
Message-ID: <20100127010747.GI9153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 12:16:17PM +0100, Maurus Cuelenaere wrote:
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/hwmon/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 68cf877..a8a267c 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -702,7 +702,7 @@ config SENSORS_SHT15
> 
>  config SENSORS_S3C
>  	tristate "S3C24XX/S3C64XX Inbuilt ADC"
> -	depends on ARCH_S3C2410
> +	depends on ARCH_S3C2410 || ARCH_S3C64XX
>  	help
>  	  If you say yes here you get support for the on-board ADCs of
>  	  the Samsung S3C24XX or S3C64XX series of SoC
> -- 
> 1.6.6.1
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
