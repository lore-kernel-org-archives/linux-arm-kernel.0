From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 09:22:48 +0200
Subject: [PATCH v2 2/7] pinctrl: UniPhier: add UniPhier PH1-LD4 pinctrl
 driver
In-Reply-To: <1436841607-7556-3-git-send-email-yamada.masahiro@socionext.com>
References: <1436841607-7556-1-git-send-email-yamada.masahiro@socionext.com>
 <1436841607-7556-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYb+f1OnH5Tdy62gw=0g_3+S0Un0NTTGj1Jodv+wE5jKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 4:40 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Add pin configuration and pinmux support for UniPhier PH1-LD4 SoC.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - sort groups and funcs alphabetically
>   - add missing "emmc_dat8" group
>   - add i2c pin-mux settings
>   - sort members of platform_driver
>   - change to tristate
>   - add THIS_MODULE to pinctrl_desc
>   - use module_platform_driver

Patch applied.

> +static const struct of_device_id ph1_ld4_pinctrl_match[] = {
> +       { .compatible = "socionext,ph1-ld4-pinctrl" },
> +       { /* sentinel */ }
> +};

I didn't see any device tree bindings in this patch series.

That is OK, send them separate, I see only compatible strings
and standard bindings.

Yours,
Linus Walleij
