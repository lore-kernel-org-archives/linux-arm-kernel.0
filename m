From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Aug 2017 10:10:30 +0200
Subject: [PATCH 1/6] pinctrl: uniphier: remove unneeded EXPORT_SYMBOL_GPL()
In-Reply-To: <1501482071-9819-2-git-send-email-yamada.masahiro@socionext.com>
References: <1501482071-9819-1-git-send-email-yamada.masahiro@socionext.com>
 <1501482071-9819-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZP42gui618JdQWCapU4M8qy3ok7ej1qnM+7=x9m8BG1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 8:21 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> All UniPhier pinctrl drivers are built-in.  Exporting the symbol
> is meaningless.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
