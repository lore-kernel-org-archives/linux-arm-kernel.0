From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Sep 2010 10:26:19 -0700
Subject: [PATCH] update OMAP Kconfig help texts for all supported SoC
	models
In-Reply-To: <20100922092752.GN27439@mail.wantstofly.org>
References: <20100922092752.GN27439@mail.wantstofly.org>
Message-ID: <20100922172618.GD4211@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lennert Buytenhek <buytenh@wantstofly.org> [100922 02:19]:
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 553b7cf..15b603c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -813,7 +813,7 @@ config ARCH_OMAP
>  	select GENERIC_CLOCKEVENTS
>  	select ARCH_HAS_HOLES_MEMORYMODEL
>  	help
> -	  Support for TI's OMAP platform (OMAP1 and OMAP2).
> +	  Support for TI's OMAP platform (OMAP1/2/3/4).
>  
>  config PLAT_SPEAR
>  	bool "ST SPEAr"
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index e39a417..68435c5 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -19,7 +19,7 @@ config ARCH_OMAP2PLUS
>  	bool "TI OMAP2/3/4"
>  	select COMMON_CLKDEV
>  	help
> -	  "Systems based on omap24xx, omap34xx or omap44xx"
> +	  "Systems based on omap24xx, omap34xx, omap35xx or omap44xx"
>  
>  endchoice

It would be better to also use omap2/3/4 here too. Otherwise we
can easily miss some variants, like 36xx.

Tony
