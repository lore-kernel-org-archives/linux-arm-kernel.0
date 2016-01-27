From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Jan 2016 13:33:23 +0100
Subject: [PATCH] pinctrl: pxa: export pxa2xx_pinctrl_init()
In-Reply-To: <1453577113-14423-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453577113-14423-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdai_HysVqroBz-NcupxRF_2PPyHQnj8e8Ani6+04xre0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 23, 2016 at 8:25 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Building pinctrl-pxa27x.c as a module causes a link error:
>
> ERROR: "pxa2xx_pinctrl_init" [drivers/pinctrl/pxa/pinctrl-pxa27x.ko] undefined!
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied with Robert's ACK.

Yours,
Linus Walleij
