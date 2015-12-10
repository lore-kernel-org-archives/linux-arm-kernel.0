From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Dec 2015 00:17:28 +0100
Subject: [PATCH 03/10] ARM: debug-ll: rework ep93xx handling
In-Reply-To: <1449268242-808553-4-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
 <1449268242-808553-4-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdb5QjPJTXh1R1-V04ydQbMkCteY6TCesnUpg8TicLW83Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 4, 2015 at 11:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> This makes ep93xx debug-ll handling more consistent with the other
> platforms, by adding a separate Kconfig symbol for it that
> in turn selects the standard DEBUG_UART_PL01X symbol.
>
> We still have to pick a physical address even if DEBUG_LL is disabled
> here, because the EP93xx uncompress output code uses
> CONFIG_DEBUG_UART_PHYS. If we ever move to multiplatform support,
> this can go away.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks correct.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
