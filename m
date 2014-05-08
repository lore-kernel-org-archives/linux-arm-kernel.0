From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 8 May 2014 16:24:07 +0800
Subject: [PATCH 1/6] ARM: dts: i.MX25: Add mmc aliases
In-Reply-To: <20140508080402.GN5858@pengutronix.de>
References: <1399469489-22788-1-git-send-email-s.hauer@pengutronix.de>
 <1399469489-22788-2-git-send-email-s.hauer@pengutronix.de>
 <CAOMZO5DFnw_m+NLnGsworx_Pe4mQ+QZo+oX9+V3hGMSwuxiCxg@mail.gmail.com>
 <20140508080402.GN5858@pengutronix.de>
Message-ID: <20140508082405.GD2870@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 10:04:02AM +0200, Sascha Hauer wrote:
> On Wed, May 07, 2014 at 11:46:19AM -0300, Fabio Estevam wrote:
> > On Wed, May 7, 2014 at 10:31 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  arch/arm/boot/dts/imx25.dtsi | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> > > index ea323f0..680486a 100644
> > > --- a/arch/arm/boot/dts/imx25.dtsi
> > > +++ b/arch/arm/boot/dts/imx25.dtsi
> > > @@ -21,6 +21,8 @@
> > >                 i2c0 = &i2c1;
> > >                 i2c1 = &i2c2;
> > >                 i2c2 = &i2c3;
> > > +               mmc0 = &esdhc1;
> > > +               mmc2 = &esdhc2;
> > 
> > Shouldn't this be:
> >                    mmc1 = &esdhc2;
> > 
> > instead?
> 
> Yes, sure.
> 
> Shawn, Lothar, is this series otherwise ok?

I'm fine with the series, and can fix above typo, if this is the only
comment from people.

Shawn
