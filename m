From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Dec 2017 00:09:13 +0100
Subject: [PATCH] ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR register
In-Reply-To: <E1eOTFj-0008MB-Fj@rmk-PC.armlinux.org.uk>
References: <E1eOTFj-0008MB-Fj@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkdar4sE5nYFfzGh9C2dtSTHqAuXeNX-a5dvNK=wk-Jcy8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 7:56 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> Add a gpio driver for the lubbock miscellaneous write IO register so we
> can take advantage of subsystems modelled around gpiolib, rather than
> having to provide platform specific callbacks.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
