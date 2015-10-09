From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 9 Oct 2015 11:05:15 +0200
Subject: [PATCH v4 3/6] arm64: berlin: add the pinctrl dependency for
 Marvell Berlin SoCs
In-Reply-To: <1444378629-3057-4-git-send-email-jszhang@marvell.com>
References: <1444378629-3057-1-git-send-email-jszhang@marvell.com>
 <1444378629-3057-4-git-send-email-jszhang@marvell.com>
Message-ID: <20151009090515.GC2842@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 04:17:06PM +0800, Jisheng Zhang wrote:
> This is to add the pinctrl dependency for Marvell Berlin SoCs.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index c6e2c75..3d17ee2 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -9,6 +9,7 @@ config ARCH_BERLIN
>  	bool "Marvell Berlin SoC Family"
>  	select ARCH_REQUIRE_GPIOLIB
>  	select DW_APB_ICTL
> +	select PINCTRL
>  	help
>  	  This enables support for Marvell Berlin SoC Family
>  
> -- 
> 2.6.1
> 

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
