From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Sun, 27 Jul 2014 14:25:31 +0200
Subject: [PATCH 0/3] ARM: EXYNOS: Fix Exynos5410 boot
In-Reply-To: <1406463725-4208-1-git-send-email-afaerber@suse.de>
References: <1406463725-4208-1-git-send-email-afaerber@suse.de>
Message-ID: <53D4EFBB.6000404@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.07.2014 14:22, schrieb Andreas F?rber:
> Hello,
> 
> This mini-series unbreaks booting on 5410 based ODROID-XU.
> 
> Since I do not have access to a TRM, the address is a guess based on 
> 5250 and 5410. Such a node was not present in the 3.14 downstream tree.

s/5410/5420/

> 
> Regards,
> Andreas
> 
> Andreas F?rber (3):
>   Documentation: devicetree: Document exynos5410 PMU
>   ARM: dts: exynos: Add PMU to Exynos5410
>   ARM: EXYNOS: Add support for Exynos5410 PMU
> 
>  Documentation/devicetree/bindings/arm/samsung/pmu.txt | 1 +
>  arch/arm/boot/dts/exynos5410.dtsi                     | 5 +++++
>  arch/arm/mach-exynos/exynos.c                         | 1 +
>  3 files changed, 7 insertions(+)

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
