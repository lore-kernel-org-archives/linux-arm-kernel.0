From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Dec 2011 15:17:27 +0100
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Select SMSC911X driver by
 default.
In-Reply-To: <1323696242-5902-1-git-send-email-fabio.estevam@freescale.com>
References: <1323696242-5902-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20111212141727.GX27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio, Arnd,

On Mon, Dec 12, 2011 at 11:24:02AM -0200, Fabio Estevam wrote:
> Select SMSC911X driver by default.  
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

The patch is ok.

Arnd,

On which base should I apply this patch? It needs the i.MX5 -> imx
merge which shows up in your for-next branch, but all other i.MX
topic branches in your tree seem to be empty.

Sascha

> ---
>  arch/arm/configs/imx_v4_v5_defconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
> index 11a4192..a51e282 100644
> --- a/arch/arm/configs/imx_v4_v5_defconfig
> +++ b/arch/arm/configs/imx_v4_v5_defconfig
> @@ -50,6 +50,7 @@ CONFIG_INET=y
>  CONFIG_IP_MULTICAST=y
>  CONFIG_IP_PNP=y
>  CONFIG_IP_PNP_DHCP=y
> +CONFIG_SMSC911X=y
>  # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
>  # CONFIG_INET_XFRM_MODE_TUNNEL is not set
>  # CONFIG_INET_XFRM_MODE_BEET is not set
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
