From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 15:43:39 +0100
Subject: [PATCH 0/2] gpio: dt: add gpio-export support
In-Reply-To: <20121121101259.GQ4398@game.jcrosoft.org>
References: <20121121101259.GQ4398@game.jcrosoft.org>
Message-ID: <CACRpkdZN12bsx_YgXFfOPZzebjNG6fbwF9y=vNhzzyye-jsQUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 11:12 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> HI,
>
>         This patch serie add the support of gpio-export to DT
>
>         This also extend to gpio_export with the possibility to specify a name
>         for the gpio.
>         When you support different hardware you do not need to knwon which gpio
>         is used at application level just you have it
>
>         based on next-20121115 tested on AT91 Animeo IP
>
>   gpiolib-of: ad gpio-export support (2012-11-19 20:36:03 +0800)

OK so this is definately Grant territory, I'm just a novice in DT land...
Grant can you look at this?

Yours,
Linus Walleij
