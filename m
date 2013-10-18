From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 18 Oct 2013 16:23:03 +0800
Subject: [Patch v2][ 28/37] ARM: imx_v6_v7_defconfig: Enable i.MX35 DT
 support.
In-Reply-To: <1382022155-21954-29-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-29-git-send-email-denis@eukrea.com>
Message-ID: <20131018082300.GA6043@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 05:02:26PM +0200, Denis Carikli wrote:
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig |    1 +

It's a little overkilled to have 10 patches in the series updating
defconfig.  We do not need to be so verbose on defconfig changes.
Please squash them into one.

Shawn

>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 5d488c2..7065419 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -28,6 +28,7 @@ CONFIG_MACH_QONG=y
>  CONFIG_MACH_ARMADILLO5X0=y
>  CONFIG_MACH_KZM_ARM11_01=y
>  CONFIG_MACH_IMX31_DT=y
> +CONFIG_MACH_IMX35_DT=y
>  CONFIG_MACH_PCM043=y
>  CONFIG_MACH_MX35_3DS=y
>  CONFIG_MACH_VPR200=y
> -- 
> 1.7.9.5
> 
