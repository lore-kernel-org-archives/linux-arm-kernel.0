From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 09:31:45 +0200
Subject: [PATCH v2 5/7] pinctrl: UniPhier: add UniPhier PH1-Pro5 pinctrl
 driver
In-Reply-To: <1436841607-7556-6-git-send-email-yamada.masahiro@socionext.com>
References: <1436841607-7556-1-git-send-email-yamada.masahiro@socionext.com>
 <1436841607-7556-6-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdb6Mu59-EXsu3AEck9O7yt_npUXt-zHUT6srJUC+Avu=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 4:40 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Add pin configuration and pinmux support for UniPhier PH1-Pro5 SoC.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - sort groups and funcs alphabetically
>   - add i2c pin-mux settings
>   - sort members of platform_driver
>   - change to tristate
>   - add THIS_MODULE to pinctrl_desc
>   - use module_platform_driver

Patch applied.

Yours,
Linus Walleij
