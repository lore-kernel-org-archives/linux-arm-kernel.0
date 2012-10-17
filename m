From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Thu, 18 Oct 2012 00:21:12 +0300
Subject: [PATCH] Nokia N9/N900/N950 -- mention product names
In-Reply-To: <20121017210300.GB12560@elf.ucw.cz>
References: <1330967337-9634-1-git-send-email-aaro.koskinen@nokia.com>
 <20120501104801.GA23559@elf.ucw.cz>
 <20120504181105.GL5613@atomide.com>
 <20121017183307.GA12560@elf.ucw.cz>
 <20121017192525.GD1613@blackmetal.musicnaut.iki.fi>
 <20121017210300.GB12560@elf.ucw.cz>
Message-ID: <20121017212112.GG1613@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 11:03:00PM +0200, Pavel Machek wrote:
> 
> This adds product names (that most users know) to Kconfig and board
> comments.
>  
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 346fd26..f03f19a 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -263,14 +263,14 @@ config MACH_NOKIA_N8X0
>  	select MACH_NOKIA_N810_WIMAX
>  
>  config MACH_NOKIA_RM680
> -	bool "Nokia RM-680/696 board"
> +	bool "Nokia N950 (RM-680) / N9 (RM-696) phones"
>  	depends on ARCH_OMAP3
>  	default y
>  	select OMAP_PACKAGE_CBB
>  	select MACH_NOKIA_RM696
>  
>  config MACH_NOKIA_RX51
> -	bool "Nokia RX-51 board"
> +	bool "Nokia N900 (RX-51) phone"
>  	depends on ARCH_OMAP3
>  	default y
>  	select OMAP_PACKAGE_CBB
> diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
> index 0ad1bb3b..96f8757 100644
> --- a/arch/arm/mach-omap2/board-rm680.c
> +++ b/arch/arm/mach-omap2/board-rm680.c
> @@ -1,5 +1,5 @@
>  /*
> - * Board support file for Nokia RM-680/696.
> + * Board support file for Nokia N950 (RM-680) / N9 (RM-696).
>   *
>   * Copyright (C) 2010 Nokia
>   *
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index 345dd93..b60ca9d 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/arch/arm/mach-omap2/board-rx51.c
> + * Board support file for Nokia N900 (aka RX-51).
>   *
>   * Copyright (C) 2007, 2008 Nokia
>   *
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
