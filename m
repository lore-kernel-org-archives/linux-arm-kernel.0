From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 5 Oct 2016 09:46:30 +0200
Subject: [PATCH RFC v2 11/12] ARM: dts: sk-rzg1m: initial device tree
In-Reply-To: <2785627.2cnnnPXLS1@wasted.cogentembedded.com>
References: <1987532.PE2ex6PrJ5@wasted.cogentembedded.com>
 <2785627.2cnnnPXLS1@wasted.cogentembedded.com>
Message-ID: <CAMuHMdXU-EhbZSJ4Jz9Qs+2rFAEgX2xoJ6ntOMpBhcgzuxrqKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2016 at 12:34 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the initial device  tree for the R8A7743 SoC based SK-RZG1M board.
> The board has one debug serial port (SCIF0); include support for it, so
> that  the serial  console  can work.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
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
