From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 5 Aug 2015 19:59:50 +0800
Subject: [PATCH v2] ARM: dts: vf-colibri: define stdout-path property
In-Reply-To: <0af90d47043467591155c16f621cc1da@agner.ch>
References: <1436971817-28523-1-git-send-email-stefan@agner.ch>
 <0af90d47043467591155c16f621cc1da@agner.ch>
Message-ID: <20150805115950.GJ12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 06:43:29PM +0200, Stefan Agner wrote:
> Hi Shawn,
> 
> Did you notice this change? Just asking since you applied some other
> changes already...

Just applied.  Sorry for the delay.

Shawn

> 
> --
> Stefan
> 
> On 2015-07-15 16:50, Stefan Agner wrote:
> > Define Vybrid's UART0, connected to the Colibri pinout UART_A, as
> > standard output.
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> > b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> > index 77e1a45..2ce6fe5 100644
> > --- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> > +++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> > @@ -9,7 +9,7 @@
> >  
> >  / {
> >  	chosen {
> > -		bootargs = "console=ttyLP0,115200";
> > +		stdout-path = "serial0:115200n8";
> >  	};
> >  
> >  	clk16m: clk16m {
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
