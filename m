From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2018 10:26:15 +0100
Subject: [PATCH] pinctrl: mediatek: Fix dependencies for EINT_MTK
In-Reply-To: <20181102025728.963-1-olof@lixom.net>
References: <20181102025728.963-1-olof@lixom.net>
Message-ID: <CACRpkdbRZGxQoi7Pe=-unjHC4ToyOR1MJjKQqySs1Hunhs+TYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 2, 2018 at 3:57 AM Olof Johansson <olof@lixom.net> wrote:

> Fixes the following config-time warning:
>
> WARNING: unmet direct dependencies detected for EINT_MTK
>   Depends on [n]: PINCTRL [=y] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n]) && (PINCTRL_MTK [=n] || PINCTRL_MTK_MOORE [=n] || COMPILE_TEST [=n])
>   Selected by [y]:
>   - PINCTRL_MTK_PARIS [=y] && PINCTRL [=y] && OF [=y] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n])
>
> Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
> Signed-off-by: Olof Johansson <olof@lixom.net>

Patch applied with Sean's ACK!

Yours,
Linus Walleij
