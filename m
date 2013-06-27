From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 27 Jun 2013 22:55:40 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable FSL_LPUART support
In-Reply-To: <1372337321-8068-1-git-send-email-fabio.estevam@freescale.com>
References: <1372337321-8068-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130627145539.GF2695@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 09:48:41AM -0300, Fabio Estevam wrote:
> Enable the FSL_LPUART driver as it is used by the VF610 family.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

Shawn

> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 0837aae..2353bde 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -133,6 +133,8 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
>  # CONFIG_DEVKMEM is not set
>  CONFIG_SERIAL_IMX=y
>  CONFIG_SERIAL_IMX_CONSOLE=y
> +CONFIG_SERIAL_FSL_LPUART=y
> +CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_MXC_RNGA=y
>  CONFIG_I2C=y
> -- 
> 1.8.1.2
> 
> 
