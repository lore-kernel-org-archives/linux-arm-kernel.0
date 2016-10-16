From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 16 Oct 2016 20:25:14 +0900
Subject: [PATCH] arm64: uniphier: select ARCH_HAS_RESET_CONTROLLER
In-Reply-To: <1475893534-12198-1-git-send-email-yamada.masahiro@socionext.com>
References: <1475893534-12198-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQvjnwh351eWLUYLykZfo1qKKr-5rAVT190Z5TJku2p4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-08 11:25 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The UniPhier reset driver (drivers/reset/reset-uniphier.c) has been
> merged.  Select ARCH_HAS_RESET_CONTROLLER from the SoC Kconfig.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> This is a counter-part of the following ARM-32bit variant:
> https://patchwork.kernel.org/patch/9341021/
>
> As discussed with Philipp, we go ARCH_HAS_RESET_CONTROLLER for now.
>

Patch applied.



-- 
Best Regards
Masahiro Yamada
