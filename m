From: horms@verge.net.au (Simon Horman)
Date: Fri, 29 Jun 2018 16:47:36 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77965: Add second port to
 rcar_sound placeholder
In-Reply-To: <CAMuHMdVBbQ-rHHcdkw=3_+Dng-sOdnV4uyQ7bGXT_FNWte67Fw@mail.gmail.com>
References: <20180628124259.12760-1-horms+renesas@verge.net.au>
 <CAMuHMdVBbQ-rHHcdkw=3_+Dng-sOdnV4uyQ7bGXT_FNWte67Fw@mail.gmail.com>
Message-ID: <20180629144734.23zhak4uhxr4sgdk@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 03:33:59PM +0200, Geert Uytterhoeven wrote:
> On Thu, Jun 28, 2018 at 2:43 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> > This node is just a placeholder but fills that function better if it does
> > not trigger build warnings. This update satisfies the requirement that
> > nodes with #address-cells/#size-cells properties have more than one child
> > node.
> >
> > This is flagged by dtc as follows:
> >  # make dtbs W=1
> >  arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb: Warning (graph_child_address): /soc/sound at ec500000/ports: graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
> >  arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dtb: Warning (graph_child_address): /soc/sound at ec500000/ports: graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.
