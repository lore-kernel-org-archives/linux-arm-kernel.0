From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Mar 2013 12:04:49 +0100
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_PERF_EVENTS
In-Reply-To: <1360949521-16034-1-git-send-email-fabio.estevam@freescale.com>
References: <1360949521-16034-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130305110449.GW1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 03:32:01PM -0200, Fabio Estevam wrote:
> Select CONFIG_PERF_EVENTS so that oprofile can be used.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  arch/arm/configs/imx_v6_v7_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index e36b010..12f50c7 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -9,6 +9,7 @@ CONFIG_CGROUPS=y
>  CONFIG_RELAY=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
> +CONFIG_PERF_EVENTS=y
>  # CONFIG_SLUB_DEBUG is not set
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_MODULES=y
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
