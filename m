From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Oct 2015 21:51:52 +0100
Subject: [PATCH v2] pinctrl: uniphier: guard uniphier directory with
 CONFIG_PINCTRL_UNIPHIER
In-Reply-To: <1446200895-29592-1-git-send-email-yamada.masahiro@socionext.com>
References: <1446200895-29592-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdY3Edj5=0Pn6tXYyj2fpb4GqhFKMCWT5EF3R79yzX6EqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 11:28 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> CONFIG_PINCTRL_UNIPHIER is more suitable than CONFIG_ARCH_UNIPHIER
> to guard the drivers/pinctrl/uniphier directory.
>
> The current CONFIG_PINCTRL_UNIPHIER_CORE is a bit long
> (it would break the indentation in drivers/pinctrl/Makefile),
> so rename it into CONFIG_PINCTRL_UNIPHIER.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

BR,
Linus Walleij
