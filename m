From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Sep 2014 15:07:55 +0200
Subject: [PATCH] pinctrl: make of_device_ids const
In-Reply-To: <1410380437-17960-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1410380437-17960-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkda1h_GOYh6dJeJJF5pnwLmn5UYCtk-v=b0k56zKy9m8=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 10:20 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> of_device_ids (i.e. compatible strings and the respective data) are not
> supposed to change at runtime. All functions working with of_device_ids
> provided by <linux/of.h> work with const of_device_ids. This allows to
> mark all struct of_device_id below drivers/pinctrl const, too.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Sorry! This low-hanging fruit was already picked by Kiran by an
identical patch (split across sevaral sub-patches, that I squashed
into one), check linux-next to see if there are any leftovers for you to pick...

Yours,
Linus Walleij
