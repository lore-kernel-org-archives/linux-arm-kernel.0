From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Apr 2018 10:26:23 +0200
Subject: [PATCH] dt-bindings: arm: consistently name r8a77965 as M3-N
In-Reply-To: <CAMuHMdWZoXSJnuEiD4e9SpP+ASFgDCcwy16UFOeSEq5sNnsMSA@mail.gmail.com>
References: <20180424055442.19710-1-horms+renesas@verge.net.au>
 <CAMuHMdWZoXSJnuEiD4e9SpP+ASFgDCcwy16UFOeSEq5sNnsMSA@mail.gmail.com>
Message-ID: <20180424082623.y6d2unyo45wktkx2@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 09:16:17AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Apr 24, 2018 at 7:54 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > There is an inconsistency between the use of M3N and M3-N.
> > This patch resolves this by consistently using the latter.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Note that this is for a custom Salvator-X board where the M3-W SiP was
> replaced by an M3-N SiP.  So I have no idea what's on the sticker, if it was
> replaced at all, and thus kept the text from the BSP.

Understood. But I think we should make the naming consistent regardless.

> 
> > --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> > +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> > @@ -116,7 +116,7 @@ Boards:
> >      compatible = "renesas,salvator-x", "renesas,r8a7795"
> >    - Salvator-X (RTP0RC7796SIPB0011S)
> >      compatible = "renesas,salvator-x", "renesas,r8a7796"
> > -  - Salvator-X (RTP0RC7796SIPB0011S (M3N))
> > +  - Salvator-X (RTP0RC7796SIPB0011S (M3-N))
> >      compatible = "renesas,salvator-x", "renesas,r8a77965"
> >    - Salvator-XS (Salvator-X 2nd version, RTP0RC7795SIPB0012S)
> >      compatible = "renesas,salvator-xs", "renesas,r8a7795"
> \
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
