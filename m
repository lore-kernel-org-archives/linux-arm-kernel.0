From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 19 Jan 2018 09:57:44 +0100
Subject: [PATCH v2 14/16] ARM: dts: r8a7794: add soc node
In-Reply-To: <20180117161717.14589-15-horms+renesas@verge.net.au>
References: <20180117161717.14589-1-horms+renesas@verge.net.au>
 <20180117161717.14589-15-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVF+wj+xhRHufR=--AYBqC3m=cYiF_S7zqex6qRE4E=jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 5:17 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add soc node to represent the bus and move all nodes with a base address
> into this node. This is consistent with handling of R-Car Gen3, RZ/G1, and
> R-Car V2H (R8A77920) SoCs upstream. It is intended to migrate other R-Car
> Gen2 SoCs to this scheme.
>
> The ordering is derived from simply moving each node with an address up to
> before any nodes without a base address that occur before the soc node.  To
> improve maintainability follow-up patches will sort subnodes of both the
> new soc node and the root node.
>
> This patch should not introduce any functional change.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
