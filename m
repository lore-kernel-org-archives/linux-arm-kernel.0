From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 01 Sep 2016 15:07:03 +0200
Subject: [RESEND PATCH 2/3] ARM: dts: add TOPEET itop elite based board
In-Reply-To: <1472648361-3871-1-git-send-email-ayaka@soulik.info>
References: <750b6941-7d22-971e-84c9-996deab9a7c1@kernel.org>
 <1472648361-3871-1-git-send-email-ayaka@soulik.info>
Message-ID: <6405623.At7R6O470M@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wednesday, August 31, 2016 08:59:21 PM Randy Li wrote:
> The TOPEET itop exynos 4412 have three versions base board. The
> Elite version is the cheap one without too much peripheral devices
> on it.
> 
> Currently supported are serial console, wired networking(USB),
> USB OTG in peripheral mode, USB host, SD storage, GPIO buttons,
> PWM beeper, ADC and LEDs. The WM8960 analog audio codec is also
> enabled.
> 
> The FIMC is not used for camera currently, I enabled it just for a
> colorspace convertor.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>

[...]

> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -135,6 +135,7 @@ dtb-$(CONFIG_ARCH_EXYNOS4) += \
>  	exynos4412-origen.dtb \
>  	exynos4412-smdk4412.dtb \
>  	exynos4412-tiny4412.dtb \
> +	exynos4412-itop-elite.dtb \

Minor nit:

Please keep dtb files in alphabetical order.

>  	exynos4412-trats2.dtb
>  dtb-$(CONFIG_ARCH_EXYNOS5) += \
>  	exynos5250-arndale.dtb \

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
