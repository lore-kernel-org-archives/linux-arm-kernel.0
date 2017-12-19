From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 19 Dec 2017 11:37:12 +0000
Subject: [PATCH v2 3/6] ARM: dts: r8a7743: Add PWM SoC support
In-Reply-To: <CAMuHMdVEgBq+eZqAeas3kf3ARHegSQK9xyVrTDHRyctyTK87QQ@mail.gmail.com>
References: <1513619528-12060-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513619528-12060-4-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdVEgBq+eZqAeas3kf3ARHegSQK9xyVrTDHRyctyTK87QQ@mail.gmail.com>
Message-ID: <TY1PR06MB089542724CCC3530DD4677F5C00F0@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert,

> Subject: Re: [PATCH v2 3/6] ARM: dts: r8a7743: Add PWM SoC support
>
> On Mon, Dec 18, 2017 at 6:52 PM, Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
> > Add the definitions for pwm[0123456] to the SoC .dtsi.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/arch/arm/boot/dts/r8a7743.dtsi
> > +++ b/arch/arm/boot/dts/r8a7743.dtsi
> > @@ -1082,6 +1082,83 @@
> >                         status = "disabled";
> >                 };
> >
> > +               pwm0: pwm at e6e30000 {
> > +                       compatible = "renesas,pwm-r8a7743",
> > +                                    "renesas,pwm-rcar";
>
> I think the above can fit in one line.

do you think this deserves a v3?

Thanks,
Fab

>
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


[https://www2.renesas.eu/media/email/unicef_2017.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe have decided to support Unicef with a donation. For further details click here<https://www.unicef.org/> to find out about the valuable work they do, helping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
