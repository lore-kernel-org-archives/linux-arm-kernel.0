From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Oct 2015 14:34:29 +0100
Subject: [PATCH 2/2] pinctrl: uniphier: guard uniphier directory with
 CONFIG_PINCTRL_UNIPHIER
In-Reply-To: <1445912911-1292-2-git-send-email-yamada.masahiro@socionext.com>
References: <1445912911-1292-1-git-send-email-yamada.masahiro@socionext.com>
 <1445912911-1292-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZ286dBTvd3EO_GTixnS=Cz-ch-H+AzNOJhZwoB63K6jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 3:28 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> CONFIG_PINCTRL_UNIPHIER is more suitable than CONFIG_ARCH_UNIPHIER
> to guard the drivers/pinctrl/uniphier directory.
>
> The current CONFIG_PINCTRL_UNIPHIER_CORE is a bit long
> (it would break the indentation in drivers/pinctrl/Makefile),
> so rename it into CONFIG_PINCTRL_UNIPHIER.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Holding this back until we know what to do with the first patch
but it looks OK.

Yours,
Linus Walleij
