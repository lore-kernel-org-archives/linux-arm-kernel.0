From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 11 Jul 2013 22:10:23 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select ARM1136 related errata
In-Reply-To: <1373472712-22295-1-git-send-email-fabio.estevam@freescale.com>
References: <1373472712-22295-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130711141021.GB3361@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 01:11:52PM -0300, Fabio Estevam wrote:
> CONFIG_ARM_ERRATA_411920 and CONFIG_ARM_ERRATA_364296 should be selected for
> ARM1136 SoCs.
> 

Should errata be selected in Kconfig rather than defconfig?

Shawn

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index f1662d3..ee84e82 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -40,6 +40,8 @@ CONFIG_SOC_IMX6Q=y
>  CONFIG_SOC_IMX6SL=y
>  CONFIG_SOC_VF610=y
>  CONFIG_MXC_PWM=y
> +CONFIG_ARM_ERRATA_411920=y
> +CONFIG_ARM_ERRATA_364296=y
>  CONFIG_SMP=y
>  CONFIG_VMSPLIT_2G=y
>  CONFIG_PREEMPT_VOLUNTARY=y
> -- 
> 1.8.1.2
> 
> 
