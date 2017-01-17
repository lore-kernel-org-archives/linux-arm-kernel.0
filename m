From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 18 Jan 2017 00:06:07 +0100
Subject: [PATCH 1/2] ARM64: dts: meson-gxm: Add R-Box Pro
In-Reply-To: <20170117030611.23827-2-afaerber@suse.de>
References: <20170117030611.23827-1-afaerber@suse.de>
 <20170117030611.23827-2-afaerber@suse.de>
Message-ID: <3005a457-b7cf-393b-42ff-4149e080321c@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 17.01.2017 um 04:06 schrieb Andreas F?rber:
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 0d7bfbf7d922..66bc809a5eae 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-nexbox-a95x.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-q200.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-q201.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb

What is the logic behind meson-gxm-s912-q201 vs. meson-gxm-nexbox-a1?
Should it be renamed to include -s912 for consistency?

> +dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb

Should this new board use meson-gxm-s912-?

>  
>  always		:= $(dtb-y)
>  subdir-y	:= $(dts-dirs)

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
