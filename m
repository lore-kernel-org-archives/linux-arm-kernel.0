From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 10 Jun 2014 14:33:14 +0200
Subject: [PATCH 2/2] ARM: at91/sama5_defconfig: enable sound support
In-Reply-To: <1402047426-4058-2-git-send-email-voice.shen@atmel.com>
References: <1402047426-4058-1-git-send-email-voice.shen@atmel.com>
 <1402047426-4058-2-git-send-email-voice.shen@atmel.com>
Message-ID: <5396FB0A.6070808@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2014 11:37, Bo Shen :
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Added to at91-3.17-defconfig. Thanks.

> ---
>  arch/arm/configs/sama5_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index dc3881e..c8613f0 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -144,6 +144,11 @@ CONFIG_BACKLIGHT_LCD_SUPPORT=y
>  CONFIG_BACKLIGHT_CLASS_DEVICE=y
>  # CONFIG_BACKLIGHT_GENERIC is not set
>  CONFIG_FRAMEBUFFER_CONSOLE=y
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_SOC=y
> +CONFIG_SND_ATMEL_SOC=y
> +CONFIG_SND_ATMEL_SOC_WM8904=y
>  # CONFIG_HID_GENERIC is not set
>  CONFIG_USB=y
>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 


-- 
Nicolas Ferre
