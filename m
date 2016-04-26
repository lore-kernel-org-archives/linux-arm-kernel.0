From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Apr 2016 09:08:31 -0700
Subject: [PATCH 04/14] ARM: dts: OMAP36xx: : DT spelling
 s/#address-cell/#address-cells/
In-Reply-To: <CAL_JsqKSbGPKNZdZnowGpdF8zxXbh6g-wkq96+KmBNLwp7n=HQ@mail.gmail.com>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
 <1461166339-11109-5-git-send-email-geert+renesas@glider.be>
 <CAL_JsqKSbGPKNZdZnowGpdF8zxXbh6g-wkq96+KmBNLwp7n=HQ@mail.gmail.com>
Message-ID: <20160426160831.GT5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh+dt@kernel.org> [160420 16:48]:
> On Wed, Apr 20, 2016 at 10:32 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  arch/arm/boot/dts/omap36xx.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
> > index ce1e242d4dc07ea8..8b797915300894d8 100644
> > --- a/arch/arm/boot/dts/omap36xx.dtsi
> > +++ b/arch/arm/boot/dts/omap36xx.dtsi
> > @@ -44,7 +44,7 @@
> >                 abb_mpu_iva: regulator-abb-mpu {
> >                         compatible = "ti,abb-v1";
> >                         regulator-name = "abb_mpu_iva";
> > -                       #address-cell = <0>;
> > +                       #address-cells = <0>;
> 
> dtc should flag this if it was really needed. However, it looks like
> it isn't as there are no child nodes (unless the board files add
> them).
> 
> A nice dtc check would be to flag unnecessary #address-cells or
> #size-cells. That would only help here after your fix though.

Yeah. Applying patches 2 - 4 into omap-for-v4.7/dt thanks.

Tony
