From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 29 Sep 2015 15:20:18 +0200
Subject: [PATCH] ARM: exynos_defconfig: Enable WiFi-Ex as a module instead
 built-in
In-Reply-To: <1443530546-3066-1-git-send-email-javier@osg.samsung.com>
References: <1443530546-3066-1-git-send-email-javier@osg.samsung.com>
Message-ID: <560A9012.2090802@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 29.09.2015 um 14:42 schrieb Javier Martinez Canillas:
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index d4f6063d8a72..5aad617f02c7 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -64,8 +64,8 @@ CONFIG_SMSC911X=y
>  CONFIG_USB_USBNET=y
>  CONFIG_USB_NET_SMSC75XX=y
>  CONFIG_USB_NET_SMSC95XX=y
> -CONFIG_MWIFIEX=y
> -CONFIG_MWIFIEX_SDIO=y
> +CONFIG_MWIFIEX=m
> +CONFIG_MWIFIEX_SDIO=m
>  CONFIG_INPUT_EVDEV=y
>  CONFIG_KEYBOARD_GPIO=y
>  CONFIG_KEYBOARD_CROS_EC=y

Makes sense,

Reviewed-by: Andreas F?rber <afaerber@suse.de>

What about multi_v7?

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
