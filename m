From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Oct 2018 10:02:19 +0200
Subject: [PATCH] pinctrl: uniphier: include <linux/bits.h> instead of
 <linux/bitops.h>
In-Reply-To: <1539662998-15467-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539662998-15467-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZSDyTu3HJ-3MCgsRVizvuUsyLfPg08-Q5tZeZKTovNGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 6:10 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The reason of including <linux/bitops.h> here is just for BIT() macro.
>
> Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
> macros from <linux/bitops.h> to a new <linux/bits.h> file"),
> <linux/bits.h> is enough for such compile-time macros.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
