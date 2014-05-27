From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 May 2014 15:19:42 +0200
Subject: [PATCH] pinctrl: sunxi: depend on RESET_CONTROLLER
In-Reply-To: <1400871043-16409-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1400871043-16409-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdZ89CQNC2=cgKLLbxHaxfDMLLNKfpcJu6B1yG43xvxRaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 8:50 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The A31 R_PIO driver depends on the reset framework in a mandatory way. Express
> this by adding a depends on the reset framework in Kconfig
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
