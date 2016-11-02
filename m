From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 2 Nov 2016 11:26:14 +0100
Subject: [PATCH 10/12] ARM: dts: sk-rzg1e: initial device tree
In-Reply-To: <17390303.uDhVlFKVKX@wasted.cogentembedded.com>
References: <4121805.SRTmqJtRfv@wasted.cogentembedded.com>
 <17390303.uDhVlFKVKX@wasted.cogentembedded.com>
Message-ID: <CAMuHMdWtAtALtfpKiVf7sZSd=91v-9gy33apU=gYxT+g66s+GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2016 at 12:29 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the initial  device tree for the R8A7745 SoC based SK-RZG1E board.
> The board has 1  debug  serial  port (SCIF2); include support for it,
> so that the serial console can  work.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Subject is off-by-one (the series has only 11 patches)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
