From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 23 Aug 2018 06:58:49 +0000
Subject: [PATCH] ARM: dts: imx6ull: correct machine model name
In-Reply-To: <20180823065717.ibntomnnamkdbyyq@pengutronix.de>
References: <1535005849-14046-1-git-send-email-Anson.Huang@nxp.com>
 <20180823065717.ibntomnnamkdbyyq@pengutronix.de>
Message-ID: <DB3PR0402MB3916F5B4C327E4F08125C4DAF5370@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Sacha

Anson Huang
Best Regards!


> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Thursday, August 23, 2018 2:57 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: shawnguo at kernel.org; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] ARM: dts: imx6ull: correct machine model name
> 
> Hi Anson,
> 
> The board name should be in the subject to let the reader know this is no
> generic i.MX6ull change.
 
Thanks for comment, will fix it in V2 patch.

Anson.

> 
> Sascha
> 
> On Thu, Aug 23, 2018 at 02:30:49PM +0800, Anson Huang wrote:
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
> > --
> > 2.7.4
> >
> >
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Canson.huang%40nxp.com%7C59
> 4938583dae4ac0ab1208d608c5af45%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C636706042476455956&amp;sdata=bMBKPPTa17ALKbCF8jvTtIj
> dviMwKxXMW%2F%2F02xkzWO8%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
