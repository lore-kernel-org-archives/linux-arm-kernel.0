From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 2 Jul 2018 17:28:08 +0200
Subject: [PATCH] dma: ste_dma40: Remove VLA usage
In-Reply-To: <CACRpkdYbmu_Y6N1G3M3q3M=3ZaECFdgije6Qgwoo6qra4g06_A@mail.gmail.com>
References: <20180629185107.GA37488@beast>
 <CAK8P3a30Q1ezvCWfudUY=z1q3NHdrkbwRsmSDso4s7TifQAmNQ@mail.gmail.com>
 <CACRpkdYbmu_Y6N1G3M3q3M=3ZaECFdgije6Qgwoo6qra4g06_A@mail.gmail.com>
Message-ID: <CAMuHMdUWATshtf8PX+QxwrOHaXt60j2e_GYx=L-UbWjYVL80yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2018 at 4:22 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jun 29, 2018 at 11:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > - Nobody uses this driver in practice, as the hardware platform
> >   was a dead end
>
> Depends what you mean with dead end.
>
> The hardware was deployed in a few million handsets from Samsung
> and Sony.
>
> Some have been picked up as targets for PostmarketOS:
> https://wiki.postmarketos.org/wiki/Samsung_Galaxy_S_Advance_(samsung-i9070)
> https://wiki.postmarketos.org/wiki/Samsung_Galaxy_SIII_mini_(samsung-i8190)
>
> So it is no more dead end than anything else discontinued, and it
> has a living community who want it suppored by the mainline
> kernel if possible.

Mixup with SuperH-based ST40?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
