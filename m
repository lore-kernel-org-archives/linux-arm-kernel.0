From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 17 Jul 2018 13:45:26 +0200
Subject: [PATCH v4] arm64: dts: r8a77995: Add SCIF {0,1,3,4,5} and all
 HSCIF device nodes
In-Reply-To: <20180717113832.26413-1-horms+renesas@verge.net.au>
References: <20180717113832.26413-1-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXZ_pQaF7BZs_F6MdYsacRDHmNLnUS14n5yhy9+r6Z5Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 1:38 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds the device nodes for SCIF {0,1,3,4,5} and all HSCIF serial
> ports, incl. clocks, power domain and DMAs.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> --
> v3 [Simon Horman]
> * Add DMAs

For the newly added SCIF dmas:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
