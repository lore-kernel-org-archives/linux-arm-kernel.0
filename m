From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 May 2016 10:56:46 +0200
Subject: [PATCH] pinctrl: uniphier: fix .pin_dbg_show() callback
In-Reply-To: <1464676210-16508-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464676210-16508-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdbwD5Kb+HG+T2Geo4fN272CD2iAgDH4qSkgo8HgA4U3SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 8:30 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Without this, reading the "pins" in the debugfs causes kernel BUG.
>
> Fixes: 6e9088920258 ("pinctrl: UniPhier: add UniPhier pinctrl core support")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
