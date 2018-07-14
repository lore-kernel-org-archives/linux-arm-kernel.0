From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jul 2018 12:28:47 +0200
Subject: [PATCH] ARM: tcm: ensure inline stub functions are marked static
In-Reply-To: <E1fdvDC-0004xH-Vj@rmk-PC.armlinux.org.uk>
References: <E1fdvDC-0004xH-Vj@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkdZRunyRmuH9QfJfBKCmd2m4=nQirg5RD0BKrBz4agWX_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 12:22 PM Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> Ensure that the stubbed out tcm_init() is marked static, so we don't
> end up emitting the stub each time the header is included.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
