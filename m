From: kbeldan@baylibre.com (Karl Beldan)
Date: Thu, 4 Aug 2016 20:53:34 +0000
Subject: [PATCH] ARM: dt: da850: add nand_cs3 node label in the dtsi
In-Reply-To: <CAJaRCXNB+fC=0H_A4zSgQmeynZJsacY8kS2dLfstX=gfRzzfpA@mail.gmail.com>
References: <20160803162528.2337-1-kbeldan@baylibre.com>
 <CAJaRCXNB+fC=0H_A4zSgQmeynZJsacY8kS2dLfstX=gfRzzfpA@mail.gmail.com>
Message-ID: <20160804205334.GB15013@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 08:43:54PM +0000, Karl Beldan wrote:
> 2016-08-03 16:25 GMT+00:00 Karl Beldan <kbeldan@baylibre.com>:
> 
> > This will allow to adjust the related settings in the board files.
> >
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> > ---
> >  arch/arm/boot/dts/da850.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> > index 25f0f8e..3a00978 100644
> > --- a/arch/arm/boot/dts/da850.dtsi
> > +++ b/arch/arm/boot/dts/da850.dtsi
> > @@ -375,7 +375,7 @@
> >                         dma-names = "tx", "rx";
> >                 };
> >         };
> > -       nand_cs3 at 62000000 {
> > +       nand_cs3: nand_cs3 at 62000000 {
> >                 compatible = "ti,davinci-nand";
> >                 reg = <0x62000000 0x807ff
> >                        0x68000000 0x8000>;
> > --
> > 2.9.0.rc1
> >
Please discard this one, I think I'll move things around for the nand.
 
Karl
