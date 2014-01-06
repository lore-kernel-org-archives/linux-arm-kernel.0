From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Jan 2014 14:09:36 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select PCI support
In-Reply-To: <1388409121-25133-1-git-send-email-festevam@gmail.com>
References: <1388409121-25133-1-git-send-email-festevam@gmail.com>
Message-ID: <20140106060933.GD27227@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 11:12:01AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Let PCI driver be enabled by default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 53e82c2..00746d5 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -39,6 +39,8 @@ CONFIG_SOC_IMX53=y
>  CONFIG_SOC_IMX6Q=y
>  CONFIG_SOC_IMX6SL=y
>  CONFIG_SOC_VF610=y
> +CONFIG_PCI=y
> +CONFIG_PCI_IMX6=y
>  CONFIG_SMP=y
>  CONFIG_VMSPLIT_2G=y
>  CONFIG_PREEMPT_VOLUNTARY=y
> -- 
> 1.8.1.2
> 
