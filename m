From: horms@verge.net.au (Simon Horman)
Date: Fri, 30 Jun 2017 13:51:08 +0200
Subject: [PATCH] arm64: dts: renesas: Move CPG_AUDIO_CLK_I from board to
 soc files
In-Reply-To: <1587046.f3YfXb5MdT@avalon>
References: <1498810948-17910-1-git-send-email-geert+renesas@glider.be>
 <1587046.f3YfXb5MdT@avalon>
Message-ID: <20170630115107.GJ26710@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 12:10:52PM +0300, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Friday 30 Jun 2017 10:22:28 Geert Uytterhoeven wrote:
> > The definition of CPG_AUDIO_CLK_I is SoC-specific, not board-specific.
> > Hence move it from the board-specific .dts files to the SoC-specific
> > .dtsi files.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > ---
> > I don't think it's worth adding Fixes tags.
> > 
> > If you disagree, feel free to add:
> > 
> > Fixes: 79e3b5cf035e4734 ("arm64: dts: renesas: Add support for Salvator-XS
> > with R-Car H3 ES2.0") Fixes: fb5202dbebfd8fbf ("arm64: dts: r8a7795:
> > h3ulcb: Add support for R-Car H3 ES2.0") Fixes: 0b03c32db03d63de ("arm64:
> > dts: r8a7795: salvator-x: Add support for R-Car H3 ES2.0") Fixes:
> > 253ed045a34d16d9 ("arm64: dts: renesas: Extract common ULCB board support")
> > Fixes: d25e8ff0d5aaf8b1 ("arm64: dts: renesas: Extract common Salvator-X
> > board support") ---

I agree. I've applied this for v4.14 without the fixes tags.
