From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 12 Oct 2013 15:41:51 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable LEDS_GPIO related options
In-Reply-To: <1381352523-3047-1-git-send-email-festevam@gmail.com>
References: <1381352523-3047-1-git-send-email-festevam@gmail.com>
Message-ID: <20131012074149.GE21305@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 06:02:03PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

Shawn

> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 137fdb0..7e4b176 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -207,6 +207,13 @@ CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_ESDHC_IMX=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_TIMER=y
> +CONFIG_LEDS_TRIGGER_ONESHOT=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_LEDS_TRIGGER_BACKLIGHT=y
> +CONFIG_LEDS_TRIGGER_GPIO=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_INTF_DEV_UIE_EMUL=y
>  CONFIG_RTC_DRV_MC13XXX=y
> -- 
> 1.8.1.2
> 
