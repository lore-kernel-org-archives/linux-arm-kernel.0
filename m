From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 28 Jun 2018 15:33:59 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77965: Add second port to
 rcar_sound placeholder
In-Reply-To: <20180628124259.12760-1-horms+renesas@verge.net.au>
References: <20180628124259.12760-1-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVBbQ-rHHcdkw=3_+Dng-sOdnV4uyQ7bGXT_FNWte67Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 2:43 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> This node is just a placeholder but fills that function better if it does
> not trigger build warnings. This update satisfies the requirement that
> nodes with #address-cells/#size-cells properties have more than one child
> node.
>
> This is flagged by dtc as follows:
>  # make dtbs W=1
>  arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning (graph_child_address): /soc/sound at ec500000/ports: graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
>  arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dtb: Warning (graph_child_address): /soc/sound at ec500000/ports: graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
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
