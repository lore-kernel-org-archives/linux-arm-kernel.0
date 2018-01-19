From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 19 Jan 2018 09:59:02 +0100
Subject: [PATCH v2 15/16] ARM: dts: r8a7794: sort subnodes of soc node
In-Reply-To: <20180117161717.14589-16-horms+renesas@verge.net.au>
References: <20180117161717.14589-1-horms+renesas@verge.net.au>
 <20180117161717.14589-16-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUTvP4Qwfe12EZtxOZh0QOD07tMgytK9NaJpfZqd4L9TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 5:17 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Sort the subnodes of the soc node to improve maintainability.
> The sort key is the address on the bus with instances of the same
> IP block grouped together.
>
> This patch should not introduce any functional change.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

SCIF sort order?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
