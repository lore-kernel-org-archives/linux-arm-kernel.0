From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 01 Jul 2013 10:59:15 +0200
Subject: [PATCH] ARM: dts: add sram for imx53 and imx6q
In-Reply-To: <20130701084323.GC13206@S2101-09.ap.freescale.net>
References: <1372416798-2828-1-git-send-email-p.zabel@pengutronix.de>
 <20130701084323.GC13206@S2101-09.ap.freescale.net>
Message-ID: <1372669155.4971.23.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 01.07.2013, 16:43 +0800 schrieb Shawn Guo:
> On Fri, Jun 28, 2013 at 12:53:18PM +0200, Philipp Zabel wrote:
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/boot/dts/imx53.dtsi   | 5 +++++
> >  arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> > index d437bfb..3def46f 100644
> > --- a/arch/arm/boot/dts/imx53.dtsi
> > +++ b/arch/arm/boot/dts/imx53.dtsi
> > @@ -1087,5 +1087,10 @@
> >  				status = "disabled";
> >  			};
> >  		};
> > +
> > +		ocram: ocram at f8000000 {
> > +			compatible = "fsl,imx-ocram", "mmio-sram";
> 
> I think we agreed to drop this custom compatible "fsl,imx-ocram" for
> now [1]?
> 
> Shawn
> 
> [1] http://thread.gmane.org/gmane.linux.kernel/1460369/focus=1465840

Sorry, my bad. I'll also rename the ocram node to sram.

regards
Philipp
