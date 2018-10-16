From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Oct 2018 10:03:09 +0200
Subject: [PATCH] gpio: uniphier: include <linux/bits.h> instead of
 <linux/bitops.h>
In-Reply-To: <1539663093-15923-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539663093-15923-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkda-0nM1BHRza91=4tG5cKA7qL4H8wC3Syn9g37OJ0dUHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 6:12 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The reason of including <linux/bitops.h> here is just for BIT() and
> GENMASK macros.
>
> Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
> macros from <linux/bitops.h> to a new <linux/bits.h> file"),
> <linux/bits.h> is enough for such compile-time macros.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
