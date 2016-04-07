From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 7 Apr 2016 22:59:48 +0900
Subject: [PATCH] bus: uniphier-system-bus: fix condition of overlap check
In-Reply-To: <20160401193242.F963.4A936039@socionext.com>
References: <20160401193242.F963.4A936039@socionext.com>
Message-ID: <CAK7LNASZY9UVeCH-k9uZzEEsKbEQs1MWAKU+dxfyNRU+0Yq7Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-04-01 19:32 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> This patch fixes condition whether the specified address ranges
> overlap each other.
>
> Fixes: 4b7f48d395a7 ("bus: uniphier-system-bus: add UniPhier System Bus driver")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Arnd, Olof,

Could you pick up this bug-fix for v4.6, please?


-- 
Best Regards
Masahiro Yamada
