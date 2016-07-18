From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 18 Jul 2016 11:13:30 +0100
Subject: [PATCH] ARM: mps2: fix typo
In-Reply-To: <f607bbd274fe705955116ba590d31ac788f402bf.1468744529.git.baruch@tkos.co.il>
References: <f607bbd274fe705955116ba590d31ac788f402bf.1468744529.git.baruch@tkos.co.il>
Message-ID: <578CABCA.4020803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/16 09:35, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 90542db1220d..8ebe5d86b707 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -901,7 +901,7 @@ config MACH_STM32F429
>  	default y
>  
>  config ARCH_MPS2
> -	bool "ARM MPS2 paltform"
> +	bool "ARM MPS2 platform"
>  	depends on ARM_SINGLE_ARMV7M
>  	select ARM_AMBA
>  	select CLKSRC_MPS2
> 

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Thanks!

Vladimir
