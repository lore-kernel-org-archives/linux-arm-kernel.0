From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Jan 2016 11:31:34 +0100
Subject: [PATCH] pinctrl: sunxi: guard sub-directory with
 CONFIG_PINCTRL_SUNXI
In-Reply-To: <1453563129-30332-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453563129-30332-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdad53bcBEOzKK=dTLmDSzr-rZuiFmh6XWnBqzi+NebuHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 23, 2016 at 4:32 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> CONFIG_PINCTRL_SUNXI is more suitable than CONFIG_ARCH_SUNXI
> to guard the drivers/pinctrl/sunxi/ directory.
> (I renamed CONFIG_PINCTRL_SUNXI_COMMON to CONFIG_PINCTRL_SUNXI.)
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

This patch does not apply on linux v4.5-rc1, please rebase, add
Maxime's ACK and resend.

Yours,
Linus Walleij
