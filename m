From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 2 Nov 2017 09:20:14 +0000
Subject: [PATCH] ARM: dts: iwg20d-q7: Add support for ttySC3
In-Reply-To: <20171102080412.n3wfabxt2ayswxzp@verge.net.au>
References: <1507539981-4193-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdUprE7QuXF_sX47JyrvuZXhXnQFufy4OHeJ5ExwwoogKw@mail.gmail.com>
 <TY1PR06MB0895612044D5E21BCBFEF46BC0740@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <20171102080412.n3wfabxt2ayswxzp@verge.net.au>
Message-ID: <TY1PR06MB0895FCBA06AF6FF82E1CF939C05C0@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH] ARM: dts: iwg20d-q7: Add support for ttySC3
>
> On Mon, Oct 09, 2017 at 01:45:07PM +0000, Fabrizio Castro wrote:
> > Hello Geert,
> >
> > thank you for your feedback!
> >
> > >
> > > Hi Fabrizio, Chris,
> > >
> > > On Mon, Oct 9, 2017 at 11:06 AM, Fabrizio Castro
> > > <fabrizio.castro@bp.renesas.com> wrote:
> > > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > > --- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
> > > > +++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
> > > > @@ -11,6 +11,7 @@
> > > >  / {
> > > >         aliases {
> > > >                 serial0 = &scif0;
> > > > +               serial3 = &scifb1;
> > >
> > > Given this port is not labeled "serial3", but called "data uart", you may want
> > > to add a comment to avoid confusion:
> >
> > It's a little bit confusing, isn't it? The lines related to such
> > interface are named as UART0_x on the carrier board schematic, the
> > section of the schematic that contains the header is named "data uart
> > header", and the board documentation names it explicitly as "UART 3 -
> > /dev/ttySC3 (SCIFB1)".
> >
> > I don't think there is anything we can do to make this easier for the
> > user really, is there? :D If we decide to add a comment to serial 3, I
> > guess we need to be consistent and add comments for the other serial
> > interfaces too.  If you still prefer having a comment there I'll send a
> > v2 and patch(es) for adding comments to the other interfaces, just let me
> > know.
>
> I have applied this patch. If a comment is subsequently decided on
> then please send a follow-up patch.

Thank you Simon.

Cheers,
Fab



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
