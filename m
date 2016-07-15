From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 15 Jul 2016 05:19:07 +0200
Subject: [PATCH 1/3] ARM: dts: r8a7792: add CAN clocks
In-Reply-To: <2649698.YI9UQEvgG8@wasted.cogentembedded.com>
References: <34968644.DhifNderY8@wasted.cogentembedded.com>
 <2649698.YI9UQEvgG8@wasted.cogentembedded.com>
Message-ID: <CAMuHMdVUqt=CyKeaudR2vo3tbB0K-iugyshT2mNEMkn6WRJi1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 10:19 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The R-Car CAN controllers can derive  the CAN  bus  clock not only from
> their peripheral  clock input (clkp1) but also from the other internal
> clock (clkp2) and the external clock fed on the CAN_CLK pin.  Describe
> those  clocks in  the R8A7792 device tree.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
