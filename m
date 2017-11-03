From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 Nov 2017 08:46:06 +0100
Subject: [PATCH] pinctrl: armada-37xx: remove unused variable
In-Reply-To: <20171102142932.774199-1-arnd@arndb.de>
References: <20171102142932.774199-1-arnd@arndb.de>
Message-ID: <CACRpkdbAfBXMbgiG3avQ7CUwZdoY1_qGJt-tq-sDLoR4z0zOew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 2, 2017 at 3:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> A cleanup left behind a temporary variable that is now unused:
>
> drivers/pinctrl/mvebu/pinctrl-armada-37xx.c: In function 'armada_37xx_irq_startup':
> drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:693:20: error: unused variable 'chip' [-Werror=unused-variable]
>
> This removes the declarations as well.
>
> Fixes: 3ee9e605caea ("pinctrl: armada-37xx: Stop using struct gpio_chip.irq_base")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

It is used on the head of development, so it's fixed in -next.

Is it such a big issue for v4.14 that you think I should send it
to Torvalds as a fix at this point or can I just leave it?

Yours,
Linus Walleij
