From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 12 Oct 2013 15:42:12 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_PROVE_LOCKING
In-Reply-To: <1381362027-26076-1-git-send-email-festevam@gmail.com>
References: <1381362027-26076-1-git-send-email-festevam@gmail.com>
Message-ID: <20131012074210.GF21305@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 08:40:27PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> This is very useful for detecting 'circular locking dependency' issues.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 137fdb0..e735eb2 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -263,6 +263,7 @@ CONFIG_NLS_ISO8859_15=m
>  CONFIG_NLS_UTF8=y
>  CONFIG_MAGIC_SYSRQ=y
>  # CONFIG_SCHED_DEBUG is not set
> +CONFIG_PROVE_LOCKING=y
>  # CONFIG_DEBUG_BUGVERBOSE is not set
>  # CONFIG_FTRACE is not set
>  # CONFIG_ARM_UNWIND is not set
> -- 
> 1.8.1.2
> 
