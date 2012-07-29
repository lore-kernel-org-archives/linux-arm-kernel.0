From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 29 Jul 2012 18:13:29 +0200
Subject: [PATCH 08/25] gpio/mpc8xxx: add a const qualifier
In-Reply-To: <1343034810-3386-9-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-9-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdZqG7E6bsgGFQz_+2aC6FNNV_egOorzKYGtHQJk-fhhqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 11:13 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
>
>         drivers/gpio/gpio-mpc8xxx.c: In function 'mpc8xxx_add_controller':
>         drivers/gpio/gpio-mpc8xxx.c:360:30: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
