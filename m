From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 23 Aug 2018 06:55:11 +0000
Subject: [PATCH] ARM: dts: imx6ull: correct machine model name
In-Reply-To: <69b53468-ce73-9eeb-e11a-b6fa012a7ea6@i2se.com>
References: <1535005849-14046-1-git-send-email-Anson.Huang@nxp.com>
 <69b53468-ce73-9eeb-e11a-b6fa012a7ea6@i2se.com>
Message-ID: <DB3PR0402MB3916A1EF40BBFE0B52E8F059F5370@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stefan

Anson Huang
Best Regards!


> -----Original Message-----
> From: Stefan Wahren <stefan.wahren@i2se.com>
> Sent: Thursday, August 23, 2018 2:53 PM
> To: Anson Huang <anson.huang@nxp.com>; shawnguo at kernel.org;
> s.hauer at pengutronix.de; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] ARM: dts: imx6ull: correct machine model name
> 
> Hi Anson,
> 
> 
> Am 23.08.2018 um 08:30 schrieb Anson Huang:
> > i.MX6ULL is a lite version of i.MX6UL, its full name is i.MX6
> > UltraLiteLite, NOT UlltraLite.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx6ull-14x14-evk.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> > b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> > index 30ef603..0ba6454 100644
> > --- a/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> > +++ b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> > @@ -45,7 +45,7 @@
> >  #include "imx6ul-14x14-evk.dtsi"
> >
> >  / {
> > -	model = "Freescale i.MX6 UlltraLite 14x14 EVK Board";
> > +	model = "Freescale i.MX6 UltraLiteLite 14x14 EVK Board";
> >  	compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";  };
> >
> 
> looks good, but this compatible should be documented in
> Documentation/devicetree/bindings/arm/fsl.txt (should be a separate patch).

Thanks for reminder, I will update the documentation as well in V2 patch. And looks
like we missed many i.MX6 platforms there, I will update them in separate patch as well.

Anson.

> 
> Regards
> Stefan
