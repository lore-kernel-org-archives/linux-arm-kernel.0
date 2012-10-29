From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 29 Oct 2012 22:00:07 +0100
Subject: [PATCH 1/2] rtc-imxdi: Support for i.MX53
In-Reply-To: <1350576370-29098-1-git-send-email-stigge@antcom.de>
References: <1350576370-29098-1-git-send-email-stigge@antcom.de>
Message-ID: <20121029210007.GU1641@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 06:06:08PM +0200, Roland Stigge wrote:
> This patch enables support for i.MX53 in addition to i.MX25 by enabling the
> driver on ARCH_MXC generally.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  drivers/rtc/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.orig/drivers/rtc/Kconfig
> +++ linux-2.6/drivers/rtc/Kconfig
> @@ -768,7 +768,7 @@ config RTC_DRV_DAVINCI
>  
>  config RTC_DRV_IMXDI
>  	tristate "Freescale IMX DryIce Real Time Clock"
> -	depends on SOC_IMX25
> +	depends on ARCH_MXC
>  	help
>  	   Support for Freescale IMX DryIce RTC
>  
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
