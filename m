From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Nov 2013 14:13:54 +0900
Subject: [PATCH RFC v2 02/17] clk: shmobile: r8a7779: Add MSTP clock
 support
In-Reply-To: <4636149.Zfz60YsUpd@avalon>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
 <1385451139-29686-3-git-send-email-horms+renesas@verge.net.au>
 <4636149.Zfz60YsUpd@avalon>
Message-ID: <20131127051353.GF27704@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 03:36:02PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thank you for the patch.
> 
> On Tuesday 26 November 2013 16:32:04 Simon Horman wrote:
> > Add MSTP clock support for the r8a7779 SoC
> > 
> > The only change required appears to be to note a new
> > compatibility string in the bindings.
> > 
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt index
> > 126b17e..f0a4b83 100644
> > --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > @@ -12,6 +12,7 @@ Required Properties:
> >    - compatible: Must be one of the following
> >      - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
> >      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
> > +    - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP gate clocks
> 
> Alphabetical order ? :-)

Sure, I'll fix that up.

> 
> >      - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
> >    - reg: Base address and length of the memory resource used by the MSTP
> >      clocks
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
