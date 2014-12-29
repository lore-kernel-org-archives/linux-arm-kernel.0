From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 29 Dec 2014 21:24:15 +0100
Subject: [PATCH] ARM: shmobile: r8a7791: add ADSP clocks
In-Reply-To: <1937156.Ii2YrGkOFy@wasted.cogentembedded.com>
References: <1937156.Ii2YrGkOFy@wasted.cogentembedded.com>
Message-ID: <CAMuHMdUqC5v-d95Sk2NewSE-EBKS49vn7jPKpixF2djg6NOmVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 29, 2014 at 9:19 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> --- renesas.orig/include/dt-bindings/clock/r8a7791-clock.h
> +++ renesas/include/dt-bindings/clock/r8a7791-clock.h

> -#define R8A7791_CLK_RCAN               9
> +#define R8A7791_CLK_ADSP               9
> +#define R8A7791_CLK_RCAN               10

R8A7791_CLK_RCAN is changed?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
