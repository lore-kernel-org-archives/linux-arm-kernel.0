From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 May 2011 16:54:42 +0200
Subject: [PATCH] gpio: rename VIA local config struct
In-Reply-To: <1303973940-13296-1-git-send-email-linus.walleij@stericsson.com>
References: <1303973940-13296-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <BANLkTi==T3MGumCAhrEyf4ipZo80eNiciA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/28 Linus Walleij <linus.walleij@stericsson.com>:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> The local VIA GPIO config struct "gpio_config" collides with my
> extension to the gpio_chip struct, so rename it to via_gpio_config
> so we don't get this clash.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Even if we're not merging anything like my configuration API for
2.6.40 IMHO this patch makes sense anyway, so please consider
applying it for bringing clarity to the source code.

Yours,
Linus Walleij
