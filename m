From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 18 Sep 2015 13:14:57 +0900
Subject: [PATCH v2 1/3] ARM: uniphier: add outer cache support
In-Reply-To: <1442211992-13177-2-git-send-email-yamada.masahiro@socionext.com>
References: <1442211992-13177-1-git-send-email-yamada.masahiro@socionext.com>
 <1442211992-13177-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQv2igf1XWeBp2FntvyfDieOFUmxovx5NMSmRB8Doramw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-09-14 15:26 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:

> diff --git a/arch/arm/mach-uniphier/uniphier.c b/arch/arm/mach-uniphier/uniphier.c
> index 9be10ef..26042e3 100644
> --- a/arch/arm/mach-uniphier/uniphier.c
> +++ b/arch/arm/mach-uniphier/uniphier.c
> @@ -12,6 +12,10 @@
>   * GNU General Public License for more details.
>   */
>
> +#define pr_fmt(fmt)            "uniphier: " fmt
> +
> +#include <linux/of_platform.h>
> +#include <asm/hardware/cache-uniphier.h>
>  #include <asm/mach/arch.h>
>
>  static const char * const uniphier_dt_compat[] __initconst = {



This change is unnecessary.   I will fix it in v3.





-- 
Best Regards
Masahiro Yamada
