From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 20 Sep 2014 21:00:46 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBCQ001MzAxWDogc2VsZWN0IEdQSU9MSUIgYXMg?=
 =?UTF-8?B?b3B0aW9uYWw=?=
In-Reply-To: <1411231282-7180-1-git-send-email-zajec5@gmail.com>
References: <1411231282-7180-1-git-send-email-zajec5@gmail.com>
Message-ID: <1411232446.828292358@f282.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sat, 20 Sep 2014 18:41:22 +0200 ?? Rafa? Mi?ecki <zajec5@gmail.com>:
> All routers (or 99% of them) based on BCM5301X use GPIOs to control LEDs
> and buttons.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
>  arch/arm/mach-bcm/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index fc93800..d967c98 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -80,8 +80,10 @@ config ARCH_BCM2835
>  
>  config ARCH_BCM_5301X
>  	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select ARM_GIC
>  	select CACHE_L2X0
> +	select GPIOLIB
...

GPIOLIB is selected automatically by ARCH_WANT_OPTIONAL_GPIOLIB.

---
