From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 6 Oct 2017 09:06:14 +0000
Subject: [PATCH 2/2] ARM: dts: iwg20d-q7-dbcm-ca: Add device trees for
 camera DB
In-Reply-To: <CAMuHMdU-zOogwOKS_s8-r_fsUfXxu38WKkaoryuuuGGJzmBkSw@mail.gmail.com>
References: <1507108713-10686-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1507108713-10686-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdU-zOogwOKS_s8-r_fsUfXxu38WKkaoryuuuGGJzmBkSw@mail.gmail.com>
Message-ID: <TY1PR06MB0895E77A6CC9BF8B042E9553C0710@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

> Hi Fabrizio,
>
> On Wed, Oct 4, 2017 at 11:18 AM, Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
> > This patch adds a .dtsi that describes the camera daughter board
> > and a .dts to describe the HW made of iWave's RZ/G1M SoM, iWave's
> > RZ/G1M/G1N Qseven carrier board, and the camera daughter board.
> > The camera daughter board .dtsi adds support for ttySC[14].
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
>
> > +/ {
> > +       aliases {
> > +               serial1 = &scif1;
> > +               serial4 = &hscif1;
>
> BTW, what's the reason you picked serial4 for the third serial port?

Because it matches the configuration iWave had in their official release based on
kernel 3.10. We decided to keep the same numbering scheme as a precaution to
avoid breaking existing code.

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



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
