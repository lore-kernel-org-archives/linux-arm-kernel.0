From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 08:40:46 +0200
Subject: [PATCH 3/3] ARM: integrator: use __iomem pointers for MMIO, part 2
In-Reply-To: <1349796861-31164-4-git-send-email-arnd@arndb.de>
References: <1349796861-31164-1-git-send-email-arnd@arndb.de>
 <1349796861-31164-4-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdb7rTBwhKDJxuP00h29zx8HAnB4ptHHHs9ht4yBZovfRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 5:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Due to some interesting merges in the integrator code, not
> all users of mmio pointers were converted before, this
> fixes all warnings that got introduced as a consequence.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>

Yeah I told you it was gonna collide ;-)

Thanks a lot for fixing it up and following through
on this!

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
