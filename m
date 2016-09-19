From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 19 Sep 2016 10:42:53 +0200
Subject: [PATCH RFC 8/8] ARM: dts: sk-rzg1m: initial device tree
In-Reply-To: <2097453.1xPZsJcFmC@wasted.cogentembedded.com>
References: <3533019.Wim1Kuh1ic@wasted.cogentembedded.com>
 <2097453.1xPZsJcFmC@wasted.cogentembedded.com>
Message-ID: <CAMuHMdU8qb8P9p3dHRwSJY4ZUgnEjcdfGfte2naQ+WA3XyEiAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 3:38 PM, Sergei Shtylyov
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

> --- /dev/null
> +++ renesas/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
> @@ -0,0 +1,44 @@

> +       compatible = "renesas,sk-rzg1m", "renesas,r8a7743";

To be documented in Documentation/devicetree/bindings/arm/shmobile.txt

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
