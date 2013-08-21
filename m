From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Aug 2013 00:25:06 -0700
Subject: [PATCH] ARM: Kconfig: NR_GPIO AM43x default
In-Reply-To: <1375451651-27173-1-git-send-email-afzal@ti.com>
References: <1375451651-27173-1-git-send-email-afzal@ti.com>
Message-ID: <20130821072506.GS7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [130802 07:01]:
> On an AM43x only config, currently default ARCH_NR_GPIO would be zero.
> Default it to that supported by the SoC.

Looks like this can wait a bit until the am43x patches have been
reviewed and queued. When that's done, I suggest that Afzal
puts this patch into Russell's patch tracking system.

Regards,

Tony
 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 37c0f4e..c5356c5 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1605,6 +1605,7 @@ config ARCH_NR_GPIO
>  	default 352 if ARCH_VT8500
>  	default 288 if ARCH_SUNXI
>  	default 264 if MACH_H4700
> +	default 192 if SOC_AM43XX
>  	default 0
>  	help
>  	  Maximum number of GPIOs in the system.
> -- 
> 1.7.9.5
> 
