From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Nov 2017 10:18:08 +0100
Subject: [PATCH v4 04/15] arm64: dts: renesas: r8a7795: Tie Audio-DMAC to
 IPMMU-MP0/1
In-Reply-To: <20171101103452.7491-5-horms+renesas@verge.net.au>
References: <20171101103452.7491-1-horms+renesas@verge.net.au>
 <20171101103452.7491-5-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUDUdgusRGEk_6ghqoifmioJ2xVmzsdL=Oz3Rq=r+RyFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 11:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Hook up r8a7795 ES2.0 Audio-DMAC nodes to the IPMMU-MP0.
> Hook up r8a7795 ES1.x Audio-DMAC nodes to the IPMMU-MP1.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
