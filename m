From: marex@denx.de (Marek Vasut)
Date: Fri, 3 Jan 2014 00:46:49 +0100
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select PCI support
In-Reply-To: <1388409121-25133-1-git-send-email-festevam@gmail.com>
References: <1388409121-25133-1-git-send-email-festevam@gmail.com>
Message-ID: <201401030046.50025.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 30, 2013 at 02:12:01 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Let PCI driver be enabled by default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig
> b/arch/arm/configs/imx_v6_v7_defconfig index 53e82c2..00746d5 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -39,6 +39,8 @@ CONFIG_SOC_IMX53=y
>  CONFIG_SOC_IMX6Q=y
>  CONFIG_SOC_IMX6SL=y
>  CONFIG_SOC_VF610=y
> +CONFIG_PCI=y
> +CONFIG_PCI_IMX6=y

Sure, let's enable it now that we put so much effort into fixing the PCIe :)

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
