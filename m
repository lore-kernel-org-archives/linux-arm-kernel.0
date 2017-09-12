From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Sep 2017 09:35:21 +0200
Subject: [PATCH] pinctrl: uniphier: include <linux/build_bug.h> instead of
 <linux/bug.h>
In-Reply-To: <1504373178-1022-1-git-send-email-yamada.masahiro@socionext.com>
References: <1504373178-1022-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZjbaAEjUGmA0Auk_auMPQaaHrOu8rYAjVyCwPt_eRg-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 2, 2017 at 7:26 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The #includes <linux/bug.h> is here to use BUILD_BUG_ON_ZERO().
>
> Thanks to commit bc6245e5efd7 ("bug: split BUILD_BUG stuff out into
> <linux/build_bug.h>"), it is now possible to reduce the number of
> headers pulled in.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied for fixes.

Yours,
Linus Walleij
