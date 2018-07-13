From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Jul 2018 09:26:11 +0200
Subject: [PATCH 1/2] gpio: mt7621: add OF_GPIO dependency
In-Reply-To: <20180710151915.2282622-1-arnd@arndb.de>
References: <20180710151915.2282622-1-arnd@arndb.de>
Message-ID: <CACRpkdbD6D3xtR6n3oOj4wWv5AZGar71Gwiyiv8Fu89UvX_9RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 5:19 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Compile-testing the driver fails unless OF_GPIO is enabled:
>
> drivers/gpio/gpio-mt7621.c: In function 'mediatek_gpio_bank_probe':
> drivers/gpio/gpio-mt7621.c:228:10: error: 'struct gpio_chip' has no member named 'of_node'
>
> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied. Sorry for taking some days.

Yours,
Linus Walleij
