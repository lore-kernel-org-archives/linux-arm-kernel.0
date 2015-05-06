From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 May 2015 16:20:19 +0200
Subject: [PATCH v2 14/17] ARM: pxa: poodle: use new LoCoMo driver
In-Reply-To: <1430178954-11138-15-git-send-email-dbaryshkov@gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-15-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkda65fOP_xkCKb+nbzDU+bQ8oV9LtOL88RiemHeyLJdOXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 1:55 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> Convert poodle to use new mfd-based LoCoMo driver.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

This:

> +static struct gpiod_lookup_table poodle_audio_gpios_table = {
> +       .dev_id = "poodle-audio",
> +       .table = {
> +               GPIO_LOOKUP("locomo-gpio", 10, "mute-l", GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP("locomo-gpio", 11, "mute-r", GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP("locomo-gpio", 8, "amp-on", GPIO_ACTIVE_LOW),
> +               { },
> +       },
> +},

Is very nice to see.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
