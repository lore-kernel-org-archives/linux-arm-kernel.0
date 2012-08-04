From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 5 Aug 2012 01:20:04 +0200
Subject: [PATCH 1/2] GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and
 pxa_irq_to_chip()
In-Reply-To: <201207251910.19088.arnd@arndb.de>
References: <1343230539-7196-1-git-send-email-zonque@gmail.com>
 <201207251617.21735.arnd@arndb.de> <501036E1.5010309@gmail.com>
 <201207251910.19088.arnd@arndb.de>
Message-ID: <CACRpkdZBzFVmXZZQboe0Thd-7qEZi5iKds4iV7kcVyhD=CX+Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 9:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 25 July 2012, Daniel Mack wrote:
>>
>> Thanks. I somehow lost track about the upstream pathes recently. Who
>> would queue them up now?
>
> Haojian Zhuang is usually the person who picks up PXA patches these days.
> If he prefers, you can also prepare a series and send them directly to
> arm at kernel.org (that's Olof and me, for all practical purposes) for
> integration into the arm-soc tree.

Since these two are in drivers/gpio I can take them through the GPIO
tree if desired, but still need some PXA maintainer to ACK them,
however they haven't really listed themselves as maintainers for the
GPIO driver in MAINTAINERS which would be preferable.

Yours,
Linus Walleij
