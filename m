From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 May 2013 13:21:24 +0800
Subject: [PATCH] ARM: imx: Enable mx6 solo-lite support
In-Reply-To: <1369352508-12177-1-git-send-email-festevam@gmail.com>
References: <1369352508-12177-1-git-send-email-festevam@gmail.com>
Message-ID: <20130524052121.GD2704@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 08:41:48PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 6ec010f..88e24ed 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -37,6 +37,7 @@ CONFIG_MACH_IMX51_DT=y
>  CONFIG_MACH_EUKREA_CPUIMX51SD=y
>  CONFIG_SOC_IMX53=y
>  CONFIG_SOC_IMX6Q=y
> +CONFIG_SOC_IMX6SL=y
>  CONFIG_MXC_PWM=y
>  CONFIG_SMP=y
>  CONFIG_VMSPLIT_2G=y
> -- 
> 1.8.1.2
> 
