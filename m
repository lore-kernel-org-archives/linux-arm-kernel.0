From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Sep 2012 00:19:11 +0200
Subject: [PATCH 06/24] ARM: integrator: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-7-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-7-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYsv7LJj=aJj3y-GhpAMD8PTKdLsYO8KATWevMM4F5MaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 11:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> ARM is moving to stricter checks on readl/write functions,
> so we need to use the correct types everywhere.
>
> This patch has a few small conflicts with stuff in linux-next, which
> we have to sort out in arm-soc.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

However if Russell applies some of the stuff that is pending
in his tracker (was pending uncertain acceptance of
CONFIG_ATAGS, which is merged now) this will likely
conflict.

Yours,
Linus Walleij
