From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 18 Jun 2016 10:03:37 +0200
Subject: [PATCH 2/2] pinctrl: uniphier: fix meaningless drive control
 offsets
In-Reply-To: <1465978686-28578-3-git-send-email-yamada.masahiro@socionext.com>
References: <1465978686-28578-1-git-send-email-yamada.masahiro@socionext.com>
 <1465978686-28578-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZ+iVxW25Vsp6F8gXsKJ7crdVwZKVHFrWAt2rZ3WR+tng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 10:18 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> These are input-only pins.  They do not support drive controlling
> in the first place.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
