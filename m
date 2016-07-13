From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 13 Jul 2016 03:20:49 +0200
Subject: [PATCH 1/2] ARM: dts: r8a7792: add PLL1 divided by 2 clock
In-Reply-To: <40786877.3MNoIeTZcz@wasted.cogentembedded.com>
References: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
 <40786877.3MNoIeTZcz@wasted.cogentembedded.com>
Message-ID: <CAMuHMdVaj=gnPXR4vDzGScRbJf-54=kbAJ4TWEJm7-atmSAg2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 11:51 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Despite the QSPI clock has PLL1/VCOx1/4 clock as a parent, the latter
> hasn't been added to the R8A7792 device tree  -- fix this overlook at
> last...
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
