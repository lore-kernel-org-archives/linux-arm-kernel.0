From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 01 Jun 2016 22:51:04 +0200
Subject: [PATCH] ARM: nspire: Fix Kconfig dependency
In-Reply-To: <1464807997-3804-1-git-send-email-shc_work@mail.ru>
References: <1464807997-3804-1-git-send-email-shc_work@mail.ru>
Message-ID: <8460879.2UeHqDeEbb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 1, 2016 10:06:37 PM CEST Alexander Shiyan wrote:
> ARM926T-based machine should depend on the ARCH_MULTI_V5 option.
> The ARCH_MULTI_V4_V5 is selected automatically by basic ARM configuration.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

The patch looks good, but I don't think bcm-kernel-feedback-list
is the right recipient.

Daniel added the code initially, so I'm adding him on Cc, but I can
also put the patch into arm-soc directly if he doesn't want to forward
it to me.

>  arch/arm/mach-nspire/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-nspire/Kconfig b/arch/arm/mach-nspire/Kconfig
> index bc41f26..a22e99c6 100644
> --- a/arch/arm/mach-nspire/Kconfig
> +++ b/arch/arm/mach-nspire/Kconfig
> @@ -1,6 +1,6 @@
>  config ARCH_NSPIRE
>  	bool "TI-NSPIRE based"
> -	depends on ARCH_MULTI_V4_V5
> +	depends on ARCH_MULTI_V5
>  	depends on MMU
>  	select CPU_ARM926T
>  	select GENERIC_IRQ_CHIP
> 
