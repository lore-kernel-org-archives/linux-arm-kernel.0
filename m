From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 17:48:37 +0200
Subject: [PATCH 4/5] i2c: gpio: Augment all boardfiles to use open drain
In-Reply-To: <20170910214424.14945-5-linus.walleij@linaro.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-5-linus.walleij@linaro.org>
Message-ID: <CAK8P3a30U3pSEPqQtVN7MwE4dOC+Rj___adSEAebSBuX_2KadA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 10, 2017 at 11:44 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> We now handle the open drain mode internally in the I2C GPIO
> driver, but we will get warnings from the gpiolib that we
> override the default mode of the line so it becomes open
> drain.
>
> We can fix all in-kernel users by simply passing the right
> flag along in the descriptor table, and we already touched
> all of these files in the series so let's just tidy it up.
>
> Cc: arm at kernel.org
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: requesting ACK for Wolfram to take this patch.

Acked-by: Arnd Bergmann <arnd@arndb.de>
