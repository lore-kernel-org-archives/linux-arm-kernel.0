From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Dec 2017 10:10:24 +0100
Subject: [PATCH v2 2/4] ARM: dts: r8a7745: Add PWM SoC support
In-Reply-To: <CAMuHMdUi953N1J+vfJWJo0GMKO4tBZV9HnX7haG0fvyNHfOvOA@mail.gmail.com>
References: <1513620411-17478-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513620411-17478-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdUi953N1J+vfJWJo0GMKO4tBZV9HnX7haG0fvyNHfOvOA@mail.gmail.com>
Message-ID: <20171220091023.vp4zss33w2tc2ppe@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 12:25:54PM +0100, Geert Uytterhoeven wrote:
> On Mon, Dec 18, 2017 at 7:06 PM, Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
> > Add the definitions for pwm[0123456] to the SoC .dtsi.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/arch/arm/boot/dts/r8a7745.dtsi
> > +++ b/arch/arm/boot/dts/r8a7745.dtsi
> > @@ -968,6 +968,83 @@
> >                         status = "disabled";
> >                 };
> >
> > +               pwm0: pwm at e6e30000 {
> > +                       compatible = "renesas,pwm-r8a7745",
> > +                                    "renesas,pwm-rcar";
> 
> I think this can fit on one line.

No need. I have fixed this when applying the patch.
