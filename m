From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 29 Mar 2011 09:46:05 +0200
Subject: [patch 03/29] arm: at91: at572d940hf: Fix SDRAMC define
In-Reply-To: <20110328170651.094859296@linutronix.de>
References: <20110328170219.059141076@linutronix.de>
	<20110328170651.094859296@linutronix.de>
Message-ID: <4D918E3D.4020409@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/03/2011 19:12, Thomas Gleixner :
> That wants to be AT91_SDRAMC0
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/mach-at91/include/mach/at572d940hf.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6-tip/arch/arm/mach-at91/include/mach/at572d940hf.h
> ===================================================================
> --- linux-2.6-tip.orig/arch/arm/mach-at91/include/mach/at572d940hf.h
> +++ linux-2.6-tip/arch/arm/mach-at91/include/mach/at572d940hf.h
> @@ -89,7 +89,7 @@
>  /*
>   * System Peripherals (offset from AT91_BASE_SYS)
>   */
> -#define AT91_SDRAMC	(0xffffea00 - AT91_BASE_SYS)
> +#define AT91_SDRAMC0	(0xffffea00 - AT91_BASE_SYS)
>  #define AT91_SMC	(0xffffec00 - AT91_BASE_SYS)
>  #define AT91_MATRIX	(0xffffee00 - AT91_BASE_SYS)
>  #define AT91_AIC	(0xfffff000 - AT91_BASE_SYS)
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Nicolas Ferre
