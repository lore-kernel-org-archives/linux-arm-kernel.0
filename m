From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Apr 2015 11:09:57 +0200
Subject: [PATCH v2] pinctrl: make of_device_ids const
In-Reply-To: <1427407231-2253-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1427407231-2253-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdbWm3TJc_oHdZccT73qUH7jwpu2Q4BR2gn2gz-tizn0wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 11:00 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> of_device_ids (i.e. compatible strings and the respective data) are not
> supposed to change at runtime. All functions working with of_device_ids
> provided by <linux/of.h> work with const of_device_ids. This allows to
> mark all struct of_device_id below drivers/pinctrl const, too.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

I already have a patch like this from Fabian Frederick in my
devel branch.

If some instances were missed by that patch please correct these
and send a patch on top of my devel branch.

Yours,
Linus Walleij
