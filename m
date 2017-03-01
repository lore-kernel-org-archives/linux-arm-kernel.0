From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 1 Mar 2017 11:21:12 +0100
Subject: [PATCH] ARM: oxnas: remove redundant select CPU_V6K
In-Reply-To: <1488078421-3751-1-git-send-email-yamada.masahiro@socionext.com>
References: <1488078421-3751-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <2f82de69-5e7e-1138-9a54-18f45f754834@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2017 04:07 AM, Masahiro Yamada wrote:
> MACH_OX820 depends on ARCH_MULTI_V6, which already selects CPU_V6K.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/mach-oxnas/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-oxnas/Kconfig b/arch/arm/mach-oxnas/Kconfig
> index 8fa4557..e3610c5 100644
> --- a/arch/arm/mach-oxnas/Kconfig
> +++ b/arch/arm/mach-oxnas/Kconfig
> @@ -28,7 +28,6 @@ config MACH_OX820
>  	depends on ARCH_MULTI_V6
>  	select ARM_GIC
>  	select DMA_CACHE_RWFO if SMP
> -	select CPU_V6K
>  	select HAVE_SMP
>  	select HAVE_ARM_SCU if SMP
>  	select HAVE_ARM_TWD if SMP
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied in oxnas-for-next.

Thanks,
Neil
