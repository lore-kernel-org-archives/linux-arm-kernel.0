From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Mon, 26 Nov 2012 05:45:24 +0000
Subject: [PATCH 1/1] ARM: OMAP2+: enable support for GPIO connected LEDs
In-Reply-To: <1353749642-30255-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1353749642-30255-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA7A476@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 24, 2012 at 15:04:02, Javier Martinez Canillas wrote:
> Many OMAP boards use GPIO LEDs to notify status to the user
> on boot. So, it is good to have by default support for GPIO
> connected LEDs as well as some commonly used triggers.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/configs/omap2plus_defconfig |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 6333e96..7c6cbdf 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -193,6 +193,14 @@ CONFIG_MMC_UNSAFE_RESUME=y
>  CONFIG_SDIO_UART=y
>  CONFIG_MMC_OMAP=y
>  CONFIG_MMC_OMAP_HS=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_LEDS_TRIGGER_BACKLIGHT=y
> +CONFIG_LEDS_TRIGGER_GPIO=y
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

Hi Javier,

Similar patch sent few days back
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/133760.html

Let me know do you have any comments

Thanks
AnilKumar
