From: horms@verge.net.au (Simon Horman)
Date: Wed, 28 Feb 2018 07:52:16 +0100
Subject: [PATCH 4/4] dt-bindings: arm: Document Renesas R-Car M3-N-based
 Salvator-XS board
In-Reply-To: <TY1PR06MB0702A5B4087711A3EF947893B7C00@TY1PR06MB0702.apcprd06.prod.outlook.com>
References: <1519668225-12548-1-git-send-email-geert+renesas@glider.be>
 <1519668225-12548-5-git-send-email-geert+renesas@glider.be>
 <20180227082514.h2pfc7a5qpceb2mb@verge.net.au>
 <TY1PR06MB0702A5B4087711A3EF947893B7C00@TY1PR06MB0702.apcprd06.prod.outlook.com>
Message-ID: <20180228065215.a3gzcwjsgvdcblu4@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 08:41:13AM +0000, Chris Paterson wrote:
> Hello Simon,
> 
> > From: devicetree-owner at vger.kernel.org [mailto:devicetree-
> > owner at vger.kernel.org] On Behalf Of Simon Horman
> > Sent: 27 February 2018 08:25
> > 
> > On Mon, Feb 26, 2018 at 07:03:45PM +0100, Geert Uytterhoeven wrote:
> > > The Renesas Salvator-XS development board can be equipped with an
> > > R-Car H3, M3-W, or M3-N SiP, which are pin-compatible.
> > >
> > > Document board part number and compatible values for the version with
> > > R-Car M3-N.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt
> > > b/Documentation/devicetree/bindings/arm/shmobile.txt
> > > index 51e4428856be4557..303f04e639431837 100644
> > > --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> > > +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> > > @@ -114,6 +114,8 @@ Boards:
> > >      compatible = "renesas,salvator-xs", "renesas,r8a7795"
> > >    - Salvator-XS (Salvator-X 2nd version, RTP0RC7796SIPB0012S)
> > >      compatible = "renesas,salvator-xs", "renesas,r8a7796"
> > > +  - Salvator-XS (Salvator-X 2nd version, RTP0RC77965SIPB012S)
> > > +    compatible = "renesas,salvator-xs", "renesas,r8a77965"
> > 
> > I am unsure how to verify this part number, can anyone help?
> 
> This matches the label on the board.

Thanks, applied.
