From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 22 Mar 2017 10:31:38 +0100
Subject: [PATCH 1/2] ARM: dts: r8a7792: add IMR-L[S]X3 clocks
In-Reply-To: <20170321194820.477663240@cogentembedded.com>
References: <20170321194820.477663240@cogentembedded.com>
Message-ID: <CAMuHMdUMqZz4C=a3Je-kNoodUeMu7O8riGjaBM755vH71W0ctA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 1, 1970 at 12:00 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the IMR-L[S]X3 clocks to the R8A7792 device tree.
>
> Based on the original patch by Roman Meshkevich
> <roman.meshkevich@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I can't verify the parent clocks, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
