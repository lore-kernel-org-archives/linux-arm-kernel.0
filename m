From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 19 Jun 2017 11:17:30 +0000
Subject: [PATCH] gpio: rcar: Add R8A7743 (RZ/G1M) support
In-Reply-To: <d7242a3b-bf30-1683-29e0-90c847ce8eaf@cogentembedded.com>
References: <1497619944-61410-1-git-send-email-biju.das@bp.renesas.com>
 <d7242a3b-bf30-1683-29e0-90c847ce8eaf@cogentembedded.com>
Message-ID: <KL1PR06MB170245DC49AB2DF041FC97E9B8C40@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH] gpio: rcar: Add R8A7743 (RZ/G1M) support
>
> Hello!
>
> On 06/16/2017 04:32 PM, Biju Das wrote:
>
> > Renesas RZ/G1M (R8A7743 SoC) GPIO blocks are identical to the R-Car
> Gen2
>
>     SoC should be outside the parens.

Thanks. I will correct it.

>
> > family. Add support for its GPIO controllers.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
> >  drivers/gpio/gpio-rcar.c                                     | 4 ++++
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> > index 7c1ab3b..1cc3cfe 100644
> > --- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> > +++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> > @@ -3,6 +3,7 @@
> >  Required Properties:
> >
> >    - compatible: should contain one of the following.
> > +    - "renesas,gpio-r8a7743": for R8A7743 (RZ-G1M) compatible GPIO
> controller.
>
>     Not RZ/G1M?

I will change this to RZ/G1M and will push V2.

Regards,
Biju



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
