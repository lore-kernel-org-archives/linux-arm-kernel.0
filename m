From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 27 Feb 2018 08:41:13 +0000
Subject: [PATCH 4/4] dt-bindings: arm: Document Renesas R-Car M3-N-based
 Salvator-XS board
In-Reply-To: <20180227082514.h2pfc7a5qpceb2mb@verge.net.au>
References: <1519668225-12548-1-git-send-email-geert+renesas@glider.be>
 <1519668225-12548-5-git-send-email-geert+renesas@glider.be>
 <20180227082514.h2pfc7a5qpceb2mb@verge.net.au>
Message-ID: <TY1PR06MB0702A5B4087711A3EF947893B7C00@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon,

> From: devicetree-owner at vger.kernel.org [mailto:devicetree-
> owner at vger.kernel.org] On Behalf Of Simon Horman
> Sent: 27 February 2018 08:25
> 
> On Mon, Feb 26, 2018 at 07:03:45PM +0100, Geert Uytterhoeven wrote:
> > The Renesas Salvator-XS development board can be equipped with an
> > R-Car H3, M3-W, or M3-N SiP, which are pin-compatible.
> >
> > Document board part number and compatible values for the version with
> > R-Car M3-N.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt
> > b/Documentation/devicetree/bindings/arm/shmobile.txt
> > index 51e4428856be4557..303f04e639431837 100644
> > --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> > +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> > @@ -114,6 +114,8 @@ Boards:
> >      compatible = "renesas,salvator-xs", "renesas,r8a7795"
> >    - Salvator-XS (Salvator-X 2nd version, RTP0RC7796SIPB0012S)
> >      compatible = "renesas,salvator-xs", "renesas,r8a7796"
> > +  - Salvator-XS (Salvator-X 2nd version, RTP0RC77965SIPB012S)
> > +    compatible = "renesas,salvator-xs", "renesas,r8a77965"
> 
> I am unsure how to verify this part number, can anyone help?

This matches the label on the board.

Kind regards, Chris


> Also, the syntax seems inconsistent with that of patch 3/4.
> 
> >    - SILK (RTP0RC7794LCB00011S)
> >      compatible = "renesas,silk", "renesas,r8a7794"
> >    - SK-RZG1E (YR8A77450S000BE)
> > --
> > 2.7.4
> >
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in the
> body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
