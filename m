From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 18 Dec 2015 15:03:59 +0900
Subject: [PATCH] ARM: uniphier: select PINCTRL
In-Reply-To: <1446706075-7348-1-git-send-email-yamada.masahiro@socionext.com>
References: <1446706075-7348-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNATtUC+5TU7eyuoOQ3W1ZbPwkX_1zY9rqC80_j1VZOsWgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please let me gently ping in case the maintainers might be away from keyboard
during the Christmas days.

I want this trivial one for the next merge window.

Thanks!


2015-11-05 15:47 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The UniPhier SoCs support pinctrl drivers.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/mach-uniphier/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
> index b640458..82dddee 100644
> --- a/arch/arm/mach-uniphier/Kconfig
> +++ b/arch/arm/mach-uniphier/Kconfig
> @@ -6,6 +6,7 @@ config ARCH_UNIPHIER
>         select ARM_GIC
>         select HAVE_ARM_SCU
>         select HAVE_ARM_TWD if SMP
> +       select PINCTRL
>         help
>           Support for UniPhier SoC family developed by Socionext Inc.
>           (formerly, System LSI Business Division of Panasonic Corporation)
> --


-- 
Best Regards
Masahiro Yamada
