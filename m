From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 22 Feb 2014 15:11:52 +0100
Subject: [PATCH v2] ARM: mach-imx: Kconfig: Remove
 IMX_HAVE_PLATFORM_IMX2_WDT from SOC_IMX53
In-Reply-To: <1393021300-5964-1-git-send-email-festevam@gmail.com>
References: <1393021300-5964-1-git-send-email-festevam@gmail.com>
Message-ID: <20140222141152.GQ6988@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 07:21:40PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> SOC_IMX53 is a device-tree only platform, so we don't need 
> IMX_HAVE_PLATFORM_IMX2_WDT at all because this symbol only provides some code 
> to help register imx2-wdt platform devices.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

thanks
Uwe
> ---
> Changes since v1:
> - Improve commit log as per Uwe's suggestion
> 
>  arch/arm/mach-imx/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 04aa1de..d75d168 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -780,7 +780,6 @@ config	SOC_IMX50
>  config	SOC_IMX53
>  	bool "i.MX53 support"
>  	select HAVE_IMX_SRC
> -	select IMX_HAVE_PLATFORM_IMX2_WDT
>  	select PINCTRL_IMX53
>  	select SOC_IMX5
>  
> -- 
> 1.8.1.2
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
