From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jul 2012 23:42:14 +0200
Subject: [PATCH 05/11] gpio/gpio-omap.c: add a const qualifier
In-Reply-To: <50001a32.e50f320a.6348.fffff4bcSMTPIN_ADDED@mx.google.com>
References: <50001a32.e50f320a.6348.fffff4bcSMTPIN_ADDED@mx.google.com>
Message-ID: <CACRpkdYXZ_--FG5sSFu0iLOz24uWF0i7D1Za-Az9peyHRvKJJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 2:32 PM,  <y@pengutronix.de> wrote:

> From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>
> This prepares of_device_id.data becoming const. Without this change
> the following warning would occur:
>
>         drivers/gpio/gpio-omap.c: In function 'omap_gpio_probe':
>         drivers/gpio/gpio-omap.c:1060: warning: assignment discards qualifiers from pointer target type
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Linus Walleij <linus.walleij@stericsson.com>

Pls run all OMAP-related patches by Kevin Hilman, I need his ACK on
this and the other patch to move on.

Yours,
Linus Walleij
