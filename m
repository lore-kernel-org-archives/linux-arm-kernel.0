From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Mar 2013 15:20:41 +0100
Subject: [PATCH v8 08/12] gpio: palmas: Enable DT support for palmas gpio.
In-Reply-To: <1362662276-20792-8-git-send-email-ian@slimlogic.co.uk>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
 <1362662276-20792-8-git-send-email-ian@slimlogic.co.uk>
Message-ID: <CACRpkdbG-aXsCDgrLStHGPJFUO=T62DQyhjkhhiTkG8H9OhLGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 7, 2013 at 2:17 PM, Ian Lartey <ian@slimlogic.co.uk> wrote:

> From: J Keerthy <j-keerthy@ti.com>
>
> Enable DT support for palmas gpio.
>
> Signed-off-by: J Keerthy <j-keerthy@ti.com>

This needs to be CC: to devicetree-discuss.

> +static struct of_device_id of_palmas_match_tbl[] = {
> +       { .compatible = "ti,palmas-gpio", },
> +       { .compatible = "ti,palmas-charger-gpio", },
> +       { .compatible = "ti,twl6035-gpio", },
> +       { .compatible = "ti,twl6036-gpio", },
> +       { .compatible = "ti,twl6037-gpio", },
> +       { .compatible = "ti,tps65913-gpio", },
> +       { .compatible = "ti,tps65914-gpio", },
> +       { .compatible = "ti,tps80036-gpio", },
> +       { /* end */ }
> +};

I can see that the binding came in a previous patch in this series, OK.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
