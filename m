From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Sep 2012 07:48:50 +0200
Subject: [PATCH 2/2] gpio: samsung: Fix input mode setting function for
 GPIO int
In-Reply-To: <000101cd9c63$ecb606a0$c62213e0$@com>
References: <000101cd9c63$ecb606a0$c62213e0$@com>
Message-ID: <CACRpkdZuED59F2FfewXNxBeYauZEaXUxUiY5GHJDxdQvzxGtZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 5:55 AM, Eunki Kim <eunki_kim@samsung.com> wrote:

> This patch makes GPIO pin to INTERRUPT mode or INPUT mode according
> to bitmap_gpio_int. When the related bit of bitmap_gpio_int is set,
> it makes GPIO pin to INTERRUPT mode instrad of INPUT mode in the
> samsung_gpiolib_4bit_input function.
>
> Signed-off-by: Eunki Kim <eunki_kim@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Are you taking this into the Samsung tree or shall I merge it
into my GPIO tree? In the latter case I need an ACK from
some Samsung maintainer.

Yours,
Linus Walleij
