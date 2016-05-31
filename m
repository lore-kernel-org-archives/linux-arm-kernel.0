From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 May 2016 12:38:56 +0200
Subject: [PATCH 04/17] pinctrl: uniphier: set pinctrl_desc owner in common
 probe function
In-Reply-To: <1464681923-7469-5-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
 <1464681923-7469-5-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdbBE09Y6tDyx9VEwSxJF=4b1501ZZ49R=ia-HpZsjwj2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 10:05 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The owner of the struct pinctrl_desc matches that of platform_driver.
> Set it in the common probe function.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
