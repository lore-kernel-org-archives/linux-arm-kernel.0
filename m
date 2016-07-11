From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jul 2016 18:19:48 +0200
Subject: [PATCH 04/11] mfd: db8500 stop passing around platform data
In-Reply-To: <1467722710-1577-4-git-send-email-linus.walleij@linaro.org>
References: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
 <1467722710-1577-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkda-L-UPOO6Da+UsH=AsrU955WUSA7e1oonJ0PBBkaVqpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2016 at 2:45 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Except for the constant DB8500_PRCMU_FW_VERSION_OFFSET number, nothing
> is ever passed through the platform data and used in a driver, so we
> can simply stop passing it around.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Lee, Arnd probably wants to pull this in for v4.8 so your
> ACK would be appreciated so it can be funneled through ARM SoC.
> I don't think it could possibly collide with anything in your
> tree: I checked with git log on these files in linux-next
> and it seems clear.

Lee is this something you could ACK?

Yours,
Linus Walleij
