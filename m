From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 29 Jul 2012 18:13:11 +0200
Subject: [PATCH 07/25] gpio/gpio-omap.c: add a const qualifier
In-Reply-To: <1343034810-3386-8-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-8-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdY4ETndgh4=c1teFVhMkZeF4t4=uFmCKodry2gxK1cEGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 11:13 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
>
>         drivers/gpio/gpio-omap.c: In function 'omap_gpio_probe':
>         drivers/gpio/gpio-omap.c:1060: warning: assignment discards qualifiers from pointer target type
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
