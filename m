From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Aug 2017 15:10:50 +0200
Subject: [PATCH] pinctrl: uniphier: widen all pinconf-derived arguments to
 u32
In-Reply-To: <1501819285-12827-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501819285-12827-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYvZwQaoHEi0rC+OgSrk2gLjp4ibJvOBCVT0Ss2KVCLyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 4, 2017 at 6:01 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Since commit 58957d2edfa1 ("pinctrl: Widen the generic pinconf argument
> from 16 to 24 bits"), the generic pinconf arguments are handled by u32.
>
> UniPhier pinctrl drivers do not support debouncing, so u16 is working,
> but align the argument type to u32 for consistency.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
