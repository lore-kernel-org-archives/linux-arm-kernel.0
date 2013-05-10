From: horms@verge.net.au (Simon Horman)
Date: Fri, 10 May 2013 17:20:55 +0900
Subject: [PATCH] ARM: shmobile: r8a7778: correct model name in Kconfig
In-Reply-To: <201305090405.41053.sergei.shtylyov@cogentembedded.com>
References: <201305090405.41053.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130510082055.GB27435@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 04:05:40AM +0400, Sergei Shtylyov wrote:
> The correct model name is R-Car M1A or R8A77781; R8A77780 corresponds to R-Car
> M1S which is a SH based SoC.  
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Morimoto-san,

please review this change.

> 
> ---
> The patch is against the current Linus' tree.
> 
>  arch/arm/mach-shmobile/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux/arch/arm/mach-shmobile/Kconfig
> ===================================================================
> --- linux.orig/arch/arm/mach-shmobile/Kconfig
> +++ linux/arch/arm/mach-shmobile/Kconfig
> @@ -36,7 +36,7 @@ config ARCH_R8A7740
>  	select RENESAS_INTC_IRQPIN
>  
>  config ARCH_R8A7778
> -	bool "R-Car M1 (R8A77780)"
> +	bool "R-Car M1A (R8A77781)"
>  	select CPU_V7
>  	select SH_CLK_CPG
>  	select ARM_GIC
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
