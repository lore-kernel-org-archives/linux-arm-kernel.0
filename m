From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Dec 2015 10:42:25 +0100
Subject: [PATCH 3/3] pinctrl: spear: guard sub-directory with
 CONFIG_PINCTRL_SPEAR
In-Reply-To: <1448365524-12605-4-git-send-email-yamada.masahiro@socionext.com>
References: <1448365524-12605-1-git-send-email-yamada.masahiro@socionext.com>
 <1448365524-12605-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdbxuRMFwps0Z-K4e=a9KCAxxqtPLXTZ7xKWTQNz--K1ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 12:45 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> CONFIG_PINCTRL_SPEAR is more suitable than CONFIG_PLAT_SPEAR
> to guard the drivers/pinctrl/spear/ directory.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
