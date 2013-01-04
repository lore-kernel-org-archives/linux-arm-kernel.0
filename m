From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 04 Jan 2013 14:08:00 +0100
Subject: [PATCH v4 14/19] ARM: remove unneeded vic.h includes
In-Reply-To: <1357235668-9450-15-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-15-git-send-email-robherring2@gmail.com>
Message-ID: <50E6D430.7030709@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/01/2013 18:54, Rob Herring a ?crit :
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 9be910f..b1b5131 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -21,7 +21,6 @@
>  
>  #include <linux/irqchip/sunxi.h>
>  
> -#include <asm/hardware/vic.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>

Just a little nitpick, could you remove the extra line as well?

Other than that, for sunxi,
Acked-By: Maxime Ripard <maxime.ripard@free-electrons.com>

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
