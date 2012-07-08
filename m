From: jbe@pengutronix.de (Juergen Beisert)
Date: Sun, 8 Jul 2012 20:10:45 +0200
Subject: [PATCH 09/10] MACH/Samsung/Mini2440: enable buzzer
In-Reply-To: <1341767544-17447-10-git-send-email-jbe@pengutronix.de>
References: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
 <1341767544-17447-10-git-send-email-jbe@pengutronix.de>
Message-ID: <201207082010.45503.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Juergen Beisert wrote:
> [...]
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index 18a555a..1cb5abd 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -2,7 +2,7 @@ config SND_SOC_SAMSUNG
>  	tristate "ASoC support for Samsung"
>  	depends on ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_EXYNOS4
>  	select S3C64XX_DMA if ARCH_S3C64XX 
> -	select S3C24Xx_DMA if ARCH_S3C24XX
> +	select S3C24XX_DMA if ARCH_S3C24XX
>  	help
>  	  Say Y or M if you want to add support for codecs attached to
>  	  the Samsung SoCs' Audio interfaces. You will also need to

Ups, something went wrong with my very last 'git rebase'. This one should be
part of the [PATCH 01/10] :(

Will resend.

jbe


-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
