From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 13 Apr 2012 16:41:19 +0200
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Add support for
 CONFIG_REGULATOR_FIXED_VOLTAGE
In-Reply-To: <1334186679-22925-1-git-send-email-festevam@gmail.com>
References: <1334186679-22925-1-git-send-email-festevam@gmail.com>
Message-ID: <20120413144119.GQ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 08:24:39PM -0300, Fabio Estevam wrote:
> Add support for CONFIG_REGULATOR_FIXED_VOLTAGE.
> 
> Without this option the mx27_3ds cannot have the external Ethernet functional
> due to the need of smsc regulators.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  arch/arm/configs/imx_v4_v5_defconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
> index b5ac644..6b31cb6 100644
> --- a/arch/arm/configs/imx_v4_v5_defconfig
> +++ b/arch/arm/configs/imx_v4_v5_defconfig
> @@ -112,6 +112,7 @@ CONFIG_WATCHDOG=y
>  CONFIG_IMX2_WDT=y
>  CONFIG_MFD_MC13XXX=y
>  CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_REGULATOR_MC13783=y
>  CONFIG_REGULATOR_MC13892=y
>  CONFIG_FB=y
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
