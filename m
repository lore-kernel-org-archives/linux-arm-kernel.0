From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 4 Jul 2018 23:10:15 +0200
Subject: [PATCH 2/3] ARM: dts: Att Vitesse G5e switch to the Gemini SQ201
In-Reply-To: <20180704191759.12577-2-linus.walleij@linaro.org>
References: <20180704191759.12577-1-linus.walleij@linaro.org>
 <20180704191759.12577-2-linus.walleij@linaro.org>
Message-ID: <CAMuHMdWPasK_Xu7ap-UoHOTGhZ3N5X1jUpBDdzVpYzhe8RfZ+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Jul 4, 2018 at 9:21 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> This adds the Vitesse G5e ethernet switch to the Square
> One Itian SQ201 router device tree.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for your patch!

> --- a/arch/arm/boot/dts/gemini-sq201.dts
> +++ b/arch/arm/boot/dts/gemini-sq201.dts
> @@ -20,7 +20,7 @@
>         };
>
>         chosen {
> -               bootargs = "console=ttyS0,115200n8";
> +               bootargs = "console=ttyS0,115200n8 root=/dev/sda1 rw rootwait";
>                 stdout-path = &uart0;
>         };

The above hunk looks unrelated.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
