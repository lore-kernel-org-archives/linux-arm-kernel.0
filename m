From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Jun 2013 15:44:42 +0800
Subject: [PATCH 1/6] ARM: dts: imx27: Add SAHARA2 devicetree node
In-Reply-To: <20130623190448.GB26397@pengutronix.de>
References: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
 <20130623190448.GB26397@pengutronix.de>
Message-ID: <20130624074440.GI26254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 23, 2013 at 09:04:48PM +0200, Sascha Hauer wrote:
> On Sun, Jun 23, 2013 at 10:54:45AM +0400, Alexander Shiyan wrote:
> > From: Alexander Shiyan <shc_work@mail.ru>
> > 
> > This patch adds the missing (Symmetric/Asymmetric Hashing and Random
> > Accelerator) SAHARA2 devicetree node for i.MX27 CPUs.
> > 
> > Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
> > ---
> >  arch/arm/boot/dts/imx27.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> > index 0695264..04f9154 100644
> > --- a/arch/arm/boot/dts/imx27.dtsi
> > +++ b/arch/arm/boot/dts/imx27.dtsi
> > @@ -351,6 +351,14 @@
> >  				iram = <&iram>;
> >  			};
> >  
> > +			sahara2: sahara at 10025000 {
> > +				compatible = "fsl,imx27-sahara";
> > +				reg = <0x10025000 0x0800>;
> 
> I think we should use the whole register space here which would be
> 0x1000.

I just fixed it up and applied the series.

Shawn
