From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Jan 2016 15:11:24 +0100
Subject: [PATCH] pinctrl: mediatek: guard sub-directory with
 CONFIG_PINCTRL_MTK
In-Reply-To: <1453563204-30407-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453563204-30407-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdbrJ5P8Ro4RQUquMOTuXhN+54ZHYGbLqrbwW6tbwCC7Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 23, 2016 at 4:33 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> CONFIG_PINCTRL_MTK is more suitable than CONFIG_ARCH_MEDIATEK
> to guard the drivers/pinctrl/mediatek/ directory.
> (I renamed CONFIG_PINCTRL_MTK_COMMON to CONFIG_PINCTRL_MTK.)
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

This patch does not apply to linux v4.5-rc1, please rebase the
patch and resend.

Yours,
Linus Walleij
